#' Automatically or manually toggle light and dark themes
#'
#' These functions help manage switching between preferred dark and light
#' themes. Use `rsthemes::set_theme_light()` and `rsthemes::set_theme_dark()` to
#' declare your preferred light/dark themes. Set the preferred theme in your
#' `~/.Rprofile` (see the section below) for ease of switching. Then use the
#' `use_theme_light()` or `use_theme_dark()` to switch to your preferred theme.
#' Switch between dark and light themes with `use_theme_toggle()` or
#' automatically set your theme to dark mode using `use_theme_auto()`.
#'
#' @section Set preferred theme in `.Rprofile`:
#'
#' Add the following to your `~/.Rprofile` (see [usethis::edit_r_profile()]) to
#' declare your default themes:
#'
#' ```
#' if (interactive() && requireNamespace(c("rsthemes", "later"), quietly = TRUE)) {
#'   # Use later to delay until RStudio is ready
#'   later::later(function() {
#'     rsthemes::set_theme_light("One Light {rsthemes}") # light theme
#'     rsthemes::set_theme_dark("One Dark {rsthemes}") # dark theme
#'
#'     # To automatically choose theme based on time of day
#'     rsthemes::use_theme_auto(dark_start = "18:00", dark_end = "6:00")
#'   }, delay = 1)
#' }
#' ```
#'
#' Note that \pkg{later} is required to add a slight delay to allow RStudio to
#' start up. If you'd rather not use this approach, you can simply declare the
#' global options that declare the default themes, but you won't be able to use
#' [use_theme_auto()] at startup.
#'
#' ```
#' options(
#'   rsthemes.theme_light = "One Light {rsthemes}",
#'   rsthemes.theme_dark = "One Dark {rsthemes}"
#' )
#' ```
#'
#' @section RStudio Addins:
#'
#' \pkg{rsthemes} includes four RStudio addins to help you easily switch between
#' light and dark modes. You can set the default dark or light theme to the
#' current theme. You can also toggle between light and dark mode or switch
#' to the automatically chosen light/dark theme based on time of day. You can
#' set a keyboard shortcut to **Toggle Dark Mode** or
#' **Auto Choose Dark or Light Theme** from the _Modify Keyboard Shortcuts..._
#' window under the RSTudio _Tools_ menu.
#'
#' @param theme The name of the theme, or `NULL` to use current theme.
#' @param quietly Suppress confirmation messages
#' @param dark_start Start time of dark mode, in 24-hour `"HH:MM"` format.
#' @param dark_end End time of dark mode, in 24-hour `"HH:MM"` format.
#' @name auto_dark_light_theme
NULL

#' @describeIn auto_dark_light_theme Set default light theme
#' @export
set_theme_light <- function(theme = NULL) {
  set_theme(theme, "light")
}

#' @describeIn auto_dark_light_theme Set default dark theme
#' @export
set_theme_dark <- function(theme = NULL) {
  set_theme(theme, "dark")
}

set_theme <- function(theme = NULL, style = c("light", "dark")) {
  theme <- theme %||% get_current_theme_name()
  theme <- stop_if_theme_not_valid(theme)
  style <- match.arg(style)
  theme <- warn_theme_style_mismatch(theme, style)

  switch(
    style,
    "light" = options("rsthemes.theme_light" = theme),
    "dark" = options("rsthemes.theme_dark" = theme)
  )
  invisible(theme)
}

#' @describeIn auto_dark_light_theme Use default light theme
#' @export
use_theme_light <- function(quietly = FALSE) use_theme("light", quietly)

#' @describeIn auto_dark_light_theme Use default dark theme
#' @export
use_theme_dark <- function(quietly = FALSE) use_theme("dark", quietly)

use_theme <- function(style = c("light", "dark"), quietly = FALSE) {
  theme <- switch(
    match.arg(style),
    "light" = getOption("rsthemes.theme_light", NULL),
    "dark" = getOption("rsthemes.theme_dark", NULL)
  )
  theme <- stop_if_theme_not_set(theme)
  if (theme == get_current_theme_name()) {
    return(invisible())
  }
  if (!quietly) {
    message("Switching to ", style, " theme: '", theme, "'")
  }
  rstudioapi::applyTheme(theme)
  invisible(theme)
}

#' @describeIn auto_dark_light_theme Toggle between dark and light themes
#' @export
use_theme_toggle <- function(quietly = FALSE) {
  theme_current <- rstudioapi::getThemeInfo()
  if (isTRUE(theme_current$dark)) {
    use_theme_light(quietly)
  } else {
    use_theme_dark(quietly)
  }
}

#' @describeIn auto_dark_light_theme Auto switch between dark and light themes
#' @export
use_theme_auto <- function(dark_start = "18:00", dark_end = "6:00", quietly = FALSE) {
  dark_start <- hms::parse_hm(dark_start)
  dark_end <- hms::parse_hm(dark_end)
  now <- hms::as_hms(Sys.time())

  pre_start <- use_theme_dark

  if (dark_end > dark_start) {
    # if light mode overnight, swap dark start/end
    .dark_start <- dark_start
    dark_start <- dark_end
    dark_end <- .dark_start
    pre_start <- use_theme_light
  }

  if (now > dark_start) {
    use_theme_dark(quietly)
  } else if (now > dark_end) {
    use_theme_light(quietly)
  } else {
    pre_start(quietly)
  }
}

get_theme_option <- function(style = c("light", "dark")) {
  switch(
    match.arg(style),
    "light" = getOption("rsthemes.theme_light", NULL),
    "dark" = getOption("rsthemes.theme_dark", NULL),
    stop("Unkown theme style: '", style, "'", call. = FALSE)
  )
}

get_current_theme_name <- function() {
  rstudioapi::getThemeInfo()$editor
}

stop_if_theme_not_set <- function(theme_opt = NULL, style = c("light", "dark")) {
  if (!is.null(theme_opt)) {
    return(theme_opt)
  }
  style <- match.arg(style)
  stop(
    "Default ", style, " theme not set, please use `rsthemes::",
    switch(
      style,
      "light" = "set_theme_light()",
      "dark" = "set_theme_dark()"
    ),
    "`` to set the default theme.",
    call. = FALSE
  )
}

stop_if_theme_not_valid <- function(theme) {
  if (theme %in% get_theme_names()) return(theme)
  stop("'", theme, '" is not the name of an installed theme.', call. = FALSE)
}

get_theme_names <- function() {
  unname(sapply(rstudioapi::getThemes(), function(x) x$name))
}

get_theme_info <- function(theme) {
  stop_if_theme_not_valid(theme)

  theme <- Filter(function(x) x$name == theme, rstudioapi::getThemes())
  if (length(theme) == 1) {
    theme[[1]]
  } else {
    theme
  }
}

warn_theme_style_mismatch <- function(theme, style = c("light", "dark")) {
  style <- match.arg(style)
  stopifnot(length(theme) == 1)
  theme_info <- get_theme_info(theme)
  if (theme_info$isDark != (style == "dark")) {
    warning(
      "You are setting the default ", style, " theme, but ",
      "'", theme_info$name, "' is a ",
      if (theme_info$isDark) "dark" else "light",
      " style theme.",
      call. = FALSE
    )
  }
  theme
}
