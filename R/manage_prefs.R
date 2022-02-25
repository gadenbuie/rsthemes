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

rs_prefs_rstudio_read <- function(include_os_settings = FALSE) {
  requires_rstudioapi(has_fun = "readRStudioPreference")

  missing_pref <- structure(NA, class = "missing_pref")

  all_pref_names <- names(rstudio_prefs_schema)
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

  updated <- 0
  for (name in names(prefs)) {
    if (!name %in% names(rstudio_prefs_schema)) {
      cli::cli_alert_warning("{.strong {name}} is not a known RStudio preference")
    }
    if (verbose) id <- cli::cli_process_start("{name}")
    tryCatch({
      rstudioapi::writeRStudioPreference(name, prefs[[name]])
      updated <- updated + 1
    }, error = function(err) {
        if (verbose) cli::cli_process_failed(id, "{.strong {name}} could not update preference")
        cli::cli_alert_danger(err$message)
      }
    )
    if (verbose) cli::cli_process_done(id, "+ {name}", done_class = "")
  }

  if (length(prefs) == updated) {
    cli::cli_alert_success("Updated {.strong {updated}} preference{?s}")
  } else {
    cli::cli_alert_info("Updated {.strong {updated}} of {length(prefs)} preference{?s}")
  }
  invisible(prefs)
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
