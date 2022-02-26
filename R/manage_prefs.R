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
  if (is_url(path)) {
    cli::cli_abort("Cannot write to a URL, please provide a local {.code path}")
  }

  if (is.null(path)) {
    path <- rs_prefs_user_path_default()
    cli::cli_process_start(
      path,
      msg_done = path,
      msg_failed = "Could not save RStudio user preferences to {.path {path}}"
    )
    fs::dir_create(fs::path_dir(path), recurse = TRUE)
  }

  checkmate::assert_character(path, len = 1, any.missing = FALSE)

  jsonlite::write_json(prefs, path, null = "null", auto_unbox = TRUE, pretty = 2)
  invisible(path)
}

rs_prefs_user_read <- function(path = NULL) {
  path <- path %||% rs_prefs_user_path_default()

  checkmate::assert_character(path, len = 1, any.missing = FALSE)
  if (!is_url(path) && !fs::file_exists(path)) {
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

  if (is_url(path)) {
    cli::cli_abort("Cannot snapshot to a URL, please provide a local {.code path}")
  }

  path <- path %||% rs_prefs_user_path_default()

  snaps_all <- if (fs::file_exists(path)) rs_prefs_user_read(path)
  snaps_all <- snaps_all %||% list()

  if (name %in% names(snaps_all) && !isTRUE(overwrite)) {
    cli::cli_abort("Snapshot {.field {name}} exists and {.code overwrite} is not {.code TRUE}")
  }

  prefs_snap <- rs_prefs_rstudio_read(include, exclude, include_os_settings)
  prefs_snap[["$rstudio_version"]] <- as.character(rstudioapi::versionInfo()$version)

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

  snap <- snaps[[name]]
  this_version <- as.character(rstudioapi::versionInfo()$version)
  snap_version <- snap[["$rstudio_version"]] %||% "unknown version"
  if (!identical(snap_version, this_version)) {
    cli::cli_warn(c(
      "Snapshot {.field {name}} is for a different version of RStudio",
      "*" = "Snapshot: {snap_version}",
      "*" = "Current: {this_version}"
    ))
  }

  snap <- snap[!grepl("^[$]", names(snap))]

  rs_prefs_rstudio_write(snap, verbose = verbose)
}

rs_prefs_restore_defaults <- function(verbose = FALSE) {
  requires_rstudioapi(has_fun = "writeRStudioPreference")

  old <- rs_prefs_rstudio_read(include_os_settings = FALSE)

  defaults <- purrr::map(
    purrr::set_names(names(old)),
    ~ rs_prefs_schema()[[.x]]$default
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

  all_pref_names <- names(rs_prefs_schema())
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
    if (!'default' %in% names(rs_prefs_schema()[[name]])) {
      return(FALSE)
    }
    isTRUE(all.equal(rs_prefs_schema()[[name]]$default, pref))
  })

  all_prefs[!is_default]
}

rs_prefs_rstudio_write <- function(prefs, verbose = FALSE) {
  requires_rstudioapi(has_fun = "writeRStudioPreference")

  old <- rs_prefs_rstudio_read(include = names(prefs), include_os_settings = TRUE)

  updated <- 0
  for (name in names(prefs)) {
    if (!name %in% names(rs_prefs_schema())) {
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
    type %||% rs_prefs_schema()[[name]][["type"]],
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

rs_prefs_schema <- function(version = NULL) {
  rs_version <- rstudioapi::versionInfo()
  version <- version %||% rs_version$long_version %||% as.character(rs_version$version)

  cache_dir <- rappdirs::user_data_dir("rsthemes")
  path <- fs::path(cache_dir, version, ext = "rds")
  if (fs::file_exists(path)) {
    return(readRDS(path))
  }

  url <- sprintf(
    "https://github.com/rstudio/rstudio/raw/v%s/src/cpp/session/resources/schema/user-prefs-schema.json",
    URLencode(version, reserved = TRUE)
  )

  success <- FALSE
  schema <- NULL
  tryCatch({
    schema <- rs_prefs_schema_prepare(url)
    success <- TRUE
  }, error = function(err) {
    cli::cli_inform(
      "Could not download RStudio preference schema for version v{version}, defaulting to {.pkg rsthemes}' built-in version.",
      parent = err
    )
    schema <<- rstudio_prefs_schema_default
  })


  if (success) {
    fs::dir_create(fs::path_dir(path), recurse = TRUE)
    saveRDS(schema, path)
  }
  schema
}

rs_prefs_schema_prepare <- function(url) {
  cli::cli_process_start("Downloading preferences from: {.url {url}}")
  rsp_schema <- jsonlite::read_json(url)

  prep_properties <- function(x, name, parent = NULL) {
    x[["name"]] <- name
    if ("properties" %in% names(x)) {
      x[["properties"]] <- purrr::imap(x[["properties"]], prep_properties, parent = x)
    }
    if (!is.null(parent)) {
      x[["parent"]] <- c(x[["parent"]], parent[["name"]])
      x[["default"]] <- parent[["default"]][[name]]
    }
    as_rsp_pref(x[union("name", names(x))])
  }

  rsp_schema <- purrr::pluck(rsp_schema, "properties")
  purrr::imap(rsp_schema, prep_properties)
}

as_rsp_pref <- function(x) {
  structure(x, class = "rsthemes_rstudio_pref")
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

gist <- function(id, file = "user-prefs.json") {
  structure(
    list(id = id, file = file),
    class = "rsthemes_user_prefs_gist"
  )
}

gist_url_html <- function(gist) {
  stopifnot(inherits(gist, "rsthemes_user_prefs_gist"))
  sprintf("https://gist.github.com/%s", gist$id)
}

#' @export
print.rsthemes_user_prefs_gist <- function(x, ...) {
  url <- gist_url_html(x)
  cli::cli_inform("{.url {url}}")
}

gist_get <- function(gist) {
  stopifnot(inherits(gist, "rsthemes_user_prefs_gist"))
  tryCatch(
    gh::gh("/gists/{gist_id}", gist_id = gist$id),
    error = function(err) {
      cli::cli_abort(
        c(
          "Could not get gist {.field {gist$id}}. Does that gist exist?",
          "*" = "{.url {gist_url_html(gist)}}"
        ),
        parent = err
      )
    }
  )
}

gist_get_prefs <- function(gist) {
  stopifnot(inherits(gist, "rsthemes_user_prefs_gist"))
  x <- gist_get(gist)

  if (!gist$file %in% names(x[["files"]])) {
    cli::cli_abort("{.file {gist$file}} is not a file in gist {.field {gist$id}}")
  }

  if (!identical(x[["files"]][[gist$file]][["type"]], "application/json")) {
    cli::cli_abort("{.file {gist$file}} is not a JSON file in gist {.field {gist$id}}")
  }

  contents <- x[["files"]][[gist$file]][["content"]]
  tmpfile <- fs::file_temp(ext = "json")
  on.exit(fs::file_delete(tmpfile))
  writeLines(contents, tmpfile)

  jsonlite::read_json(tmpfile)
}

gist_set_prefs <- function(gist, prefs) {
  stopifnot(inherits(gist, "rsthemes_user_prefs_gist"))
  x <- gist_get(gist)

  files <- list()
  files[[gist[["file"]]]] <- jsonlite::toJSON(prefs, null = "null", auto_unbox = TRUE)

  gh::gh(
    "PATCH /gists/{gist_id}",
    gist_id = gist$id,
    .params = list(files = files)
  )
}
