rs_prefs_user_path_default <- function() {
  fs::path(
    rappdirs::user_config_dir("rsthemes"),
    "user-prefs.json"
  )
}

rs_prefs_user_write <- function(
  prefs = rs_prefs_user_read(),
  path = NULL
) {
  if (is.null(path)) {
    path <- rs_prefs_user_path_default()
    cli::cli_process_start(
      path,
      msg_done = path,
      msg_failed = "Could not save RStudio user preferences to {.path {path}}"
    )
    fs::dir_create(fs::path_dir(path), recurse = TRUE)
  }

  jsonlite::write_json(prefs, path, null = "null", auto_unbox = TRUE)
  invisible(path)
}

rs_prefs_user_read <- function(path = NULL) {
  path <- path %||% rs_prefs_user_path_default()
  if (!fs::file_exists(path)) {
    cli::cli_abort("{.path {path}} does not exist")
  }
  jsonlite::read_json(path)
}

rs_prefs_snapshot <- function(
  name,
  path = NULL,
  include = NULL,
  exclude = NULL,
  include_os_settings = FALSE,
  overwrite = FALSE
) {
  requires_rstudioapi(has_fun = "readRStudioPreference")
  checkmate::assert_character(name, len = 1, any.missing = FALSE)

  path <- path %||% rs_prefs_user_path_default()

  snaps_all <- if (fs::file_exists(path)) rs_prefs_user_read(path)
  snaps_all <- snaps_all %||% list()

  if (name %in% names(snaps_all) && !isTRUE(overwrite)) {
    cli::cli_abort("Snapshot {.field {name}} exists and {.code overwrite} is not {.code TRUE}")
  }

  prefs_snap <- rs_prefs_rstudio_read(include, exclude, include_os_settings)

  snaps_all[[name]] <- prefs_snap
  rs_prefs_user_write(snaps_all, path = path)
}

rs_prefs_restore <- function(name = NULL, path = NULL, verbose = FALSE) {
  requires_rstudioapi(has_fun = "writeRStudioPreference")
  snaps <- rs_prefs_user_read(path)

  if (is.null(name)) {
    cli::cli_alert_info("Available snapshots: {names(snaps)}")
    return(invisible(names(snaps)))
  }

  checkmate::assert_character(name, len = 1, any.missing = FALSE)

  if (!name %in% names(snaps)) {
    cli::cli_abort(c(
      "Snapshot {.field {name}} isn't the name of an available snapshot.",
      "*" = "Snapshots: {names(snaps)}"
    ))
  }

  rs_prefs_rstudio_write(snaps[[name]], verbose = verbose)
}

rs_prefs_restore_defaults <- function(verbose = FALSE) {
  requires_rstudioapi(has_fun = "writeRStudioPreference")

  old <- rs_prefs_rstudio_read(include_os_settings = FALSE)

  defaults <- purrr::map(
    purrr::set_names(names(old)),
    ~ rstudio_prefs_schema[[.x]]$default
  )

  defaults <- purrr::compact(defaults)

  rs_prefs_rstudio_write(defaults, verbose = verbose)

  invisible(old)
}

rs_prefs_rstudio_read <- function(
  include = NULL,
  exclude = NULL,
  include_os_settings = FALSE
) {
  requires_rstudioapi(has_fun = "readRStudioPreference")

  missing_pref <- structure(NA, class = "missing_pref")

  all_pref_names <- names(rstudio_prefs_schema)
  if (!is.null(include)) {
    checkmate::assert_character(include, min.len = 1, any.missing = FALSE)
    all_pref_names <- intersect(all_pref_names, include)
  }
  if (!is.null(exclude)) {
    checkmate::assert_character(exclude, min.len = 1, any.missing = FALSE)
    all_pref_names <- setdiff(all_pref_names, exclude)
  }
  if (!isTRUE(include_os_settings)) {
    all_pref_names <- rs_prefs_remove_os_settings(all_pref_names)
  }

  all_prefs <- purrr::map(
    purrr::set_names(all_pref_names),
    rstudioapi::readRStudioPreference,
    default = missing_pref
  )
  all_prefs <- purrr::keep(all_prefs, function(x) !identical(x, missing_pref))

  is_default <- purrr::imap_lgl(all_prefs, function(pref, name) {
    if (!'default' %in% names(rstudio_prefs_schema[[name]])) {
      return(FALSE)
    }
    isTRUE(all.equal(rstudio_prefs_schema[[name]]$default, pref))
  })

  all_prefs[!is_default]
}

rs_prefs_rstudio_write <- function(prefs, verbose = FALSE) {
  requires_rstudioapi(has_fun = "writeRStudioPreference")

  old <- rs_prefs_rstudio_read(include = names(prefs), include_os_settings = TRUE)

  updated <- 0
  for (name in names(prefs)) {
    if (!name %in% names(rstudio_prefs_schema)) {
      cli::cli_alert_warning("{.strong {name}} is not a known RStudio preference")
    }
    if (verbose) id <- cli::cli_process_start("{name}")
    tryCatch({
      rs_write_rstudio_preference(name, prefs[[name]])
      updated <- updated + 1
    }, error = function(err) {
        if (verbose) cli::cli_process_failed(id, "{.strong {name}} could not update preference")
        cli::cli_alert_danger("Could not update {.strong {name}}: {err$message}")
      }
    )
    if (verbose) cli::cli_process_done(id, "+ {name}", done_class = "")
  }

  if (length(prefs) == updated) {
    cli::cli_alert_success("Updated {.strong {updated}} preference{?s}")
  } else {
    cli::cli_alert_info("Updated {.strong {updated}} of {length(prefs)} preference{?s}")
  }

  invisible(old)
}

rs_write_rstudio_preference <- function(name, value, type = NULL) {
  cast <- switch(
    type %||% rstudio_prefs_schema[[name]][["type"]],
    integer = as.integer,
    real = ,
    number = as.double,
    string = as.character,
    boolean = as.logical,
    identity
  )
  if (identical(name, "editor_theme")) {
    rstudioapi::applyTheme(value)
    return()
  }
  tryCatch(
    rstudioapi::writeRStudioPreference(name, cast(value)),
    error = function(err) {
      is_type_mismatch <- grepl("type mismatch", tolower(err$message))
      if (!is.null(type) || !is_type_mismatch) {
        rlang::abort(err$message)
      }
      expected <- sub("^.+expected <(.+?)>.+$", "\\1", tolower(err$message))
      rs_write_rstudio_preference(name, value, type = expected)
    }
  )
}

rs_prefs_remove_os_settings <- function(pref_names) {
  # We might want to exclude preferences that are generally system-specific
  ignored <- c(
    "initial_working_directory",
    "posix_terminal_shell",
    "custom_shell_command",
    "default_project_location",
    "rmd_preferred_template_path",
    "knit_working_dir",
    "git_exe_path",
    "svn_exe_path",
    "terminal_path",
    "rsa_key_path",
    "terminal_initial_directory",
    "file_monitor_ignored_components",
    "python_path"
  )
  setdiff(pref_names, ignored)
}

#' @export
print.rsthemes_rstudio_pref <- function(x, ...) {
  parent <- if (!is.null(x$parent)) {
    paste0(paste(x$parent, collapse = "$"), "$")
  } else ""

  cli::cli_text("<{parent}{.strong {x$name}}>")
  cli::cli_text("{.emph {x$description}}")
  cli::cli_div(theme = list(
    span.dt = list(color = "yellow"),
    ".default span.dt" = list(color = "blue"),
    ".current span.dt" = list(color = "cyan"),
    ".type" = list(color = "silver"),
    ".type span.dd" = list("font-style" = "italic")
  ))
  cli::cli_dl()
  if ("type" %in% names(x)) {
    cli::cli_li(c(Type = x$type), class = "type")
  }
  if ("enum" %in% names(x)) {
    cli::cli_li(c(Options = "{jsonlite::toJSON(x$enum, auto_unbox = TRUE)}"))
  }
  if ("properties" %in% names(x)) {
    cli::cli_li(c(Properties = "{.pkg {names(x$properties)}}"))
  }
  default <- jsonlite::toJSON(x$default, auto_unbox = TRUE)
  default <- cli::ansi_strtrim(default, width = cli::console_width() - 14)
  cli::cli_li(
    c(Default = "{default}"),
    class = "default"
  )

  if (in_rstudio(has_fun = "readRStudioPreference")) {
    missing <- structure(list(), class = "missing")
    current <- rstudioapi::readRStudioPreference(x$name, missing)
    if (!identical(current, missing)) {
      current <- jsonlite::toJSON(current, auto_unbox = TRUE)
      current <- cli::ansi_strtrim(current, width = cli::console_width() - 14)
      cli::cli_li(c(Current = "{current}"), class = "current")
    }
  }

  invisible(x)
}
