#' Automatically or manually toggle light, dark, or favorite themes
#'
#' These functions help manage switching between preferred themes. Use
#' `set_theme_light()` and `set_theme_dark()` to declare your preferred
#' light/dark themes that can be toggled or selected automatically with
#' `use_theme_toggle()` or `use_theme_auto()` or their corresponding RStudio
#' addins. Alternatively, you can create a list of favorite themes with
#' `set_theme_favorite()`. You can then cycle through this list with
#' `use_theme_favorite()` or by using the RStudio addin.
#'
#' For best results, set your preferred themes in your `~/.Rprofile` using the
#' instructions in the section below.
#'
#' @section Set preferred theme in `.Rprofile`:
#'
#' Add the following to your `~/.Rprofile` (see [usethis::edit_r_profile()]) to
#' declare your default themes:
#'
#' ```
#' if (interactive() && requireNamespace("rsthemes", quietly = TRUE)) {
#'   # Set preferred themes if not handled elsewhere..
#'   rsthemes::set_theme_light("One Light {rsthemes}")  # light theme
#'   rsthemes::set_theme_dark("One Dark {rsthemes}") # dark theme
#'   rsthemes::set_theme_favorite(c(
#'     "GitHub {rsthemes}", "Solarized Dark {rsthemes}", "Fairyfloss {rsthemes}"
#'   ))
#'
#'
#'   # Whenever the R session restarts inside RStudio...
#'   setHook("rstudio.sessionInit", function(isNewSession) {
#'     # Automatically choose the correct theme based on time of day
#'     rsthemes::use_theme_auto(dark_start = "18:00", dark_end = "6:00")
#'
#'     # Alternatively use a dynamic solution based on your location
#'     # rsthemes::use_theme_auto(lat = 50.30, lon = 9.40)
#'
#'     # Or alternatively use {ipapi} to determine your location automatically
#'     # rsthemes::use_theme_auto()
#'   }, action = "append")
#' }
#' ```
#'
#' Note that the fully automated approach will use
#' [ip-api.com](https://ip-api.com/) to look up your current location using your
#' IP address (if the \pkg{ipapi} package is available). If you'd like to use
#' geolocation but without pinging an external server, you can call
#' `rsthemes:::geolocate()` once to determine your approximate latitude and
#' longitude, which you can provide to [use_theme_auto()]. Your location
#' coordinates are cached on a per-project basis and only checked once per day
#' (per project).
#'
#' Here are two other approaches that you can use. Both set the global
#' options that declare the default themes, but rely on you manually calling
#' [use_theme_auto()] or the Auto Dark/Light addin.
#'
#' ```
#' # ~/.Rprofile
#' rsthemes::set_theme_light("One Light {rsthemes}")
#' rsthemes::set_theme_dark("One Dark {rsthemes}")
#' rsthemes::set_theme_favorite(c(
#'   "GitHub {rsthemes}", "Solarized Dark {rsthemes}", "Fairyfloss {rsthemes}"
#' ))
#' ```
#'
#' ```
#' # ~/.Rprofile
#' options(
#'   rsthemes.theme_light = "One Light {rsthemes}",
#'   rsthemes.theme_dark = "One Dark {rsthemes}"
#'   rsthemes.theme_favorite = c("GitHub {rsthemes}", "One Light {rsthemes}")
#' )
#' ```
#'
#' @section RStudio Addins:
#'
#' \pkg{rsthemes} includes five RStudio addins to help you easily switch between
#' light and dark modes. You can set the default dark or light theme to the
#' current theme. You can also toggle between light and dark mode or switch
#' to the automatically chosen light/dark theme based on time of day. You can
#' set a keyboard shortcut to **Toggle Dark Mode**, **Next Favorite Theme**, or
#' **Auto Choose Dark or Light Theme** from the _Modify Keyboard Shortcuts..._
#' window under the RStudio _Tools_ menu.
#'
#' @param theme The name of the theme, or `NULL` to use current theme.
#' @param quietly Suppress confirmation messages
#' @param dark_start Start time of dark mode, in 24-hour `"HH:MM"` format.
#' @param dark_end End time of dark mode, in 24-hour `"HH:MM"` format.
#' @param lat Latitude of your current location.
#' @param lon Longitude of your current location.
#' @name auto_theme
NULL

#' @describeIn auto_theme Set default light theme
#' @export
set_theme_light <- function(theme = NULL) {
  set_theme_light_dark(theme, "light")
}

#' @describeIn auto_theme Set default dark theme
#' @export
set_theme_dark <- function(theme = NULL) {
  set_theme_light_dark(theme, "dark")
}

#' @describeIn auto_theme Set favorite themes
#' @param append \[set_theme_favorite\] Should the theme be appended to the list
#'   of favorite themes? If `FALSE`, then `theme` replaces the current list of
#'   favorite themes.
#' @export
set_theme_favorite <- function(theme = NULL, append = TRUE) {
  for (i in seq_along(theme)) {
    theme[i] <- get_or_check_theme(theme[i])
  }
  favorite_themes <- if (isTRUE(append)) get_theme_option("favorite") else c()
  favorite_already <- intersect(theme, favorite_themes)
  if (length(favorite_already)) {
    favorite_already <- gsub(" ", "\u00a0", favorite_already)
    cli::cli_alert_warning("{.emph {favorite_already}} already {?is a/are} favorite theme{?s}")
    return(invisible())
  }
  theme <- setdiff(theme, favorite_already)
  options(rsthemes.theme_favorite = c(favorite_themes, theme))
  invisible(theme)
}

get_or_check_theme <- function(theme = NULL, style = NULL) {
  if (is.null(theme)) {
    if (!in_rstudio()) {
      return(NULL)
    }
    theme <- get_current_theme_name()
  }
  if (in_rstudio()) {
    theme <- stop_if_theme_not_valid(theme)
    if (!is.null(style)) {
      warn_theme_style_mismatch(theme, style)
    }
  }
  theme
}

set_theme_light_dark <- function(theme = NULL, style = c("light", "dark")) {
  style <- match.arg(style)
  theme <- get_or_check_theme(theme, style)

  switch(
    style,
    "light" = options("rsthemes.theme_light" = theme),
    "dark" = options("rsthemes.theme_dark" = theme),
  )
  invisible(theme)
}

#' @describeIn auto_theme Use default light theme
#' @export
use_theme_light <- function(quietly = FALSE) use_theme("light", quietly)

#' @describeIn auto_theme Use default dark theme
#' @export
use_theme_dark <- function(quietly = FALSE) use_theme("dark", quietly)

use_theme <- function(style = c("light", "dark"), quietly = FALSE) {
  if (!in_rstudio()) {
    return(invisible())
  }

  theme <- switch(
    match.arg(style),
    "light" = getOption("rsthemes.theme_light", NULL),
    "dark" = getOption("rsthemes.theme_dark", NULL)
  )
  apply_theme(theme, quietly, style)
}

apply_theme <- function(theme, quietly = FALSE, style = NULL) {
  stop_if_theme_not_set(theme)
  if (theme == get_current_theme_name()) {
    return(invisible())
  }
  if (!quietly) {
    if (!is.null(style)) {
      cli::cli_alert("Switching to {style} theme: {.emph {theme}}")
    } else {
      cli::cli_alert("{.emph {theme}}")
    }
  }
  if (!theme %in% get_theme_names()) {
    cli::cli_alert_danger("{.emph {theme}} is not installed")
    return(invisible())
  }
  rstudioapi::applyTheme(theme)
  invisible(theme)
}

#' @describeIn auto_theme Toggle between dark and light themes
#' @export
use_theme_toggle <- function(quietly = FALSE) {
  theme_current <- rstudioapi::getThemeInfo()
  if (isTRUE(theme_current$dark)) {
    use_theme_light(quietly)
  } else {
    use_theme_dark(quietly)
  }
}

#' @describeIn auto_theme Auto switch between dark and light themes
#' @export
use_theme_auto <- function(
  dark_start = NULL,
  dark_end = NULL,
  lat = NULL,
  lon = NULL,
  quietly = FALSE
) {

  dark_times <- list(start = dark_start, end = dark_end)
  coords <- list(lat = lat, lon = lon)

  n_times <- sum(is_null(dark_times))
  n_coords <- sum(is_null(coords))

  has_times <- n_times == 0

  if (n_times == 1) {
    cli::cli_alert_warning(
      "[rsthemes] {.fn use_theme_auto} requires both {.code dark_start} and {.code dark_end} or neither"
    )
  }
  if (n_coords == 1) {
    cli::cli_alert_warning(
      "[rsthemes] {.fn use_theme_auto} requires both {.code lat} and {.code lot} or neither"
    )
    coords <- list(lat = NULL, lon = NULL)
  }

  if (!has_times) {
    dark_times <- local_daylight_hours(coords$lat, coords$lon, quietly = quietly)
  }

  if (any(is_null(dark_times))) {
    dark_times <- list(
      end   = dark_end   %||% dark_times$end   %||% "18:00",
      start = dark_start %||% dark_times$start %||% "6:00"
    )
  }

  dark_times <- lapply(dark_times, hms::as_hms)
  now <- hms::as_hms(Sys.time())

  pre_start <- use_theme_dark

  if (dark_times$end > dark_times$start) {
    # if light mode overnight, swap dark start/end
    .dark_start <- dark_times$start
    dark_times$start <- dark_times$end
    dark_times$end <- .dark_start
    pre_start <- use_theme_light
  }

  if (now > dark_times$start) {
    use_theme_dark(quietly)
  } else if (now > dark_times$end) {
    use_theme_light(quietly)
  } else {
    pre_start(quietly)
  }
}

local_daylight_hours <- function(lat = NULL, lon = NULL, quietly = FALSE) {

  if (!requireNamespace("suncalc", quietly = TRUE)) {
    cli::cli_alert_warning("{.fun rsthemes::use_theme_auto}: To use automatic
      theme switching based on location, please install package
      {.pkg suncalc}.", wrap = TRUE)
  }

  coords <- list(lat = lat, lon = lon)
  null_times <- list(end = NULL, start = NULL)
  if (any(is_null(coords))) {
    coords <- purrr::possibly(geolocate, null_times)(quietly = quietly)
  }
  if (all(is_null(coords))) {
    return(null_times)
  }
  if (!requireNamespace("suncalc", quietly = TRUE)) {
    stop("`suncalc` is required: install.packages('suncalc')")
  }
  times <- suncalc::getSunlightTimes(
    lat = coords$lat,
    lon = coords$lon,
    date = Sys.Date(),
    tz = coords$tz %||% Sys.getenv("TZ")
  )
  list(
    end = times$sunrise,
    start = times$sunset
  )
}

geolocate <- function(quietly = FALSE) {
  if (!requireNamespace("ipapi", quietly = TRUE)) {
    stop("`ipapi` is required: devtools::install_github('hrbrmstr/ipapi')")
  }

  cache <- geolocate_get_cache()

  if (!is.null(cache)) {
    return(cache)
  }

  if (!quietly) cli::cli_process_start("[rsthemes] Determining your location from you IP via {.pkg ipapi}")
  x <- ipapi::geolocate(NA, .progress = FALSE)
  if (!quietly) cli::cli_process_done()

  if (identical(x$status, "success")) {
    geolocate_set_cache(x$lat, x$lon, tz = x$timezone)
    list(lat = x$lat, lon = x$lon, tz = x$timezone)
  }
}

geolocate_get_cache <- function() {
  cache_time <- rstudioapi::getPersistentValue("rsthemes.geolocate.time")
  cache_invalid <- is.null(cache_time) || identical(cache_time, "")

  if (!cache_invalid) {
    cache_invalid <- (Sys.time() - as.integer(cache_time)) > 60 * 60 * 24
  }

  if (cache_invalid) {
    geolocate_clear_cache()
    return(NULL)
  }

  list(
    lat = as.numeric(rstudioapi::getPersistentValue("rsthemes.geolocate.lat")),
    lon = as.numeric(rstudioapi::getPersistentValue("rsthemes.geolocate.lon")),
    tz = rstudioapi::getPersistentValue("rsthemes.geolocate.tz")
  )
}

geolocate_set_cache <- function(lat, lon, tz) {
  rstudioapi::setPersistentValue("rsthemes.geolocate.time", Sys.time())
  rstudioapi::setPersistentValue("rsthemes.geolocate.lat", lat)
  rstudioapi::setPersistentValue("rsthemes.geolocate.lon", lon)
  rstudioapi::setPersistentValue("rsthemes.geolocate.tz",  tz)
}

geolocate_clear_cache <- function() {
  rstudioapi::setPersistentValue("rsthemes.geolocate.time", NULL)
  rstudioapi::setPersistentValue("rsthemes.geolocate.lat", NULL)
  rstudioapi::setPersistentValue("rsthemes.geolocate.lon", NULL)
  rstudioapi::setPersistentValue("rsthemes.geolocate.tz", NULL)
}

#' @describeIn auto_theme Walk through a list of favorite themes
#' @export
use_theme_favorite <- function(quietly = FALSE) {
  themes <- get_theme_option("favorite")
  if (!length(themes)) {
    cli::cli_alert_warning("No favorite themes are set")
    cli::cli_alert_info("Use {.code rsthemes::set_theme_favorite()} to set your favorite theme list")
    return(invisible())
  }
  current <- get_current_theme_name()
  idx <- which(current == themes)
  if (!length(idx)) idx <- 0
  if (length(idx) > 1) idx <- idx[1]
  idx <- idx + 1
  if (idx > length(themes)) idx <- 1
  apply_theme(themes[idx], quietly)
}

get_theme_option <- function(style = c("light", "dark", "favorite")) {
  switch(
    match.arg(style),
    "light" = getOption("rsthemes.theme_light", NULL),
    "dark" = getOption("rsthemes.theme_dark", NULL),
    "favorite" = getOption("rsthemes.theme_favorite", NULL),
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
  if (!in_rstudio()) {
    return(theme)
  }
  if (theme %in% get_theme_names()) {
    return(theme)
  }
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
