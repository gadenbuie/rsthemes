#' Full RStudio Themes
#'
#' This package provides a set of complete RStudio themes that restyle the
#' IDE and the editor syntax. The themes are built from
#' [sass](https://sass-lang.org) templates into `.rstheme` files that,
#' ultimately, contain the CSS files that provide the themes. The sass templates
#' provide an easy-to-extend framework for customizing the look of RStudio. See
#' [rstheme()] for more information about creating your own theme. I've done
#' my best to avoid hacky CSS rules wherever possible, and the themes are tested
#' against the current production release of RStudio (version 1.2.1335 through
#' 1.4+ as of April 01, 2021). Please report any issues you encounter here:
#' [github.com/gadenbuie/rsthemes/issues](https://github.com/gadenbuie/rsthemes/issues).
#'
#' @section Palettes: \pkg{rsthemes} includes RStudio themes based on the
#'   following colors palettes.
#'
#'   - _[base16]_ (Various Authors)
#'   - _[Fairyfloss]_ ([Amy Wibowo (sailorhg)](https://github.com/sailorhg))
#'   - _[Flat White][flat-white]_ ([Dmitry Biletskyy](https://github.com/biletskyy))
#'   - _[Nord]_ ([Sven Greb](https://www.svengreb.de/))
#'   - _[Oceanic Plus][oceanic-plus]_ ([Marco Scannadinari](https://github.com/marcoms))
#'   - _[Atom One Dark][one-dark]_
#'   - _[Atom One Light][one-light]_
#'   - _[Solarized]_ (Ethan Schoonover)
#'   - _[Horizon Dark][horizon]_ (Jonathan Olaleye)
#'   - _[a11y-syntax-highlighting][a11y-syntax]_ ([Eric Bailey](https://ericwbailey.design/))
#'   - _[Night Owl][night-owl]_ ([Sarah Drasner](https://sarah.dev/))
#'   - _[Material Themes][material]_
#'
#'   [base16]: https://github.com/chriskempson/base16
#'   [fairyfloss]: https://github.com/sailorhg/fairyfloss
#'   [flat-white]: https://github.com/biletskyy/flatwhite-syntax
#'   [nord]: https://github.com/arcticicestudio/nord
#'   [oceanic-plus]: https://github.com/marcoms/oceanic-plus
#'   [one-light]: https://github.com/atom/atom/tree/master/packages/one-light-syntax
#'   [one-dark]: https://github.com/atom/atom/tree/master/packages/one-dark-syntax
#'   [solarized]: https://ethanschoonover.com/solarized
#'   [horizon]: https://horizontheme.netlify.app/
#'   [a11y-syntax]: https://github.com/ericwbailey/a11y-syntax-highlighting
#'   [night-owl]: https://github.com/sdras/night-owl-vscode-theme
#'   [material]: https://material-theme.site/
#'
#' @name rsthemes
NULL

#' @describeIn rsthemes Install RStudio themes
#' @param style Limit to a subgroup of themes, chosen from the options returned
#'   by [rsthemes_styles()].
#' @param include_base16 Should the `base16` themes be included?
#' @param destdir The destination directory for the `.rstheme` files. By default
#'   uses [rstudioapi::addTheme()] to install themes, but this argument lets
#'   users install themes to non-standard directories, or in case the location
#'   of the RStudio theme directory has changed.
#' @export
install_rsthemes <- function(style = "all", include_base16 = FALSE, destdir = NULL) {
  theme_files <- list_pkg_rsthemes(style, include_base16)
  theme_files <- unname(theme_files)

  theme_rstudio_files <- paste0("rsthemes_", fs::path_file(theme_files))

  if (!is.null(destdir)) {
    cli::cli_alert("Installing themes to {.file {destdir}}")
    destdir <- fs::path_abs(destdir)
    fs::dir_create(destdir)

    fs::file_copy(
      theme_files,
      fs::path(destdir, theme_rstudio_files),
      overwrite = TRUE
    )
  } else {
    for (theme in theme_files) {
      suppressWarnings(rstudioapi::addTheme(theme, force = TRUE))
    }
  }
  cli::cli_alert_success(
    "Installed {length(theme_files)} themes"
  )
  cli::cli_alert_info("Use {.code rsthemes::list_rsthemes()} to list installed themes")
  cli::cli_alert_info("Use {.code rsthemes::try_rsthemes()} to try all installed themes")
}

#' @describeIn rsthemes Remove rsthemes from RStudio
#' @export
remove_rsthemes <- function(style = rsthemes_styles(), include_base16 = TRUE) {
  requires_rstudioapi()
  style <- rsthemes_styles(validate = style)

  themes <- list_rsthemes(style, include_base16)
  if (length(themes) == 0) {
    return(invisible())
  }

  for (theme in themes) {
    rstudioapi::removeTheme(theme)
  }

  cli::cli_alert_success("Uninstalled {length(themes)} themes")
}

cli_how2install <- function() {
  cli::cli_alert_danger("No {.pkg rsthemes} themes are installed.")
  cli::cli_alert_info(
    "Use {.code rsthemes::install_rsthemes()} to install {.pkg rsthemes} RStudio themes"
  )
}

#' @describeIn rsthemes List installed themes (default) or available themes
#' @param list_installed Should the installed \pkg{rsthemes} themes be listed
#'   (default). If `FALSE`, the available themes in the \pkg{rsthemes} package
#'   are listed instead.
#' @export
list_rsthemes <- function(
  style = "all",
  include_base16 = TRUE,
  list_installed = TRUE
) {
  if (!list_installed) {
    return(names(list_pkg_rsthemes(style, include_base16)))
  }
  requires_rstudioapi()
  themes <- rstudioapi::getThemes()
  themes <- switch(
    rsthemes_styles(validate = style),
    light = purrr::discard(themes, "isDark"),
    dark = purrr::keep(themes, "isDark"),
    base16 = keep_base16_themes(themes),
    themes
  )
  if (style != "base16" && !include_base16) {
    themes <- discard_base16_themes(themes)
  }
  themes <- purrr::map_chr(themes, "name")
  themes <- themes[grepl("\\{rsthemes\\}", themes)]
  if (list_installed && !length(themes)) {
    cli_how2install()
    return(invisible())
  }
  unname(themes)
}

list_pkg_rsthemes <- function(style = "all", include_base16 = TRUE) {
  rsthemes_styles(validate = style)
  theme_files <- ls_rstheme(package_theme())
  base16_files <- ls_rstheme(package_theme("base16"))
  if (style != "base16") {
    if (include_base16) theme_files <- c(theme_files, base16_files)
  } else {
    theme_files <- base16_files
  }

  if (style == "dark") {
    theme_files <- purrr::keep(theme_files, theme_is_dark)
  } else if (style == "light") {
    theme_files <- purrr::keep(theme_files, purrr::negate(theme_is_dark))
  }

  theme_names <- unname(purrr::map_chr(theme_files, get_theme_name))
  names(theme_files) <- theme_names
  theme_files
}

#' @describeIn rsthemes Try each rsthemes RStudio theme
#' @param delay Number of seconds to wait between themes. Set to 0 to be
#'   prompted to continue after each theme.
#' @export
try_rsthemes <- function(
  style = "all",
  include_base16 = TRUE,
  delay = 0
) {
  requires_rstudioapi()
  style <- rsthemes_styles(validate = style)
  current_theme <- rstudioapi::getThemeInfo()
  themes <- list_rsthemes(style, include_base16)
  favorites <- c()
  for (theme in themes) {
    cat("\u2022", theme, "\n")
    rstudioapi::applyTheme(theme)
    if (delay > 0) {
      Sys.sleep(delay)
    } else {
      res <- if (theme != themes[length(themes)]) {
        readline("Enter [blank] for next, [k] to keep, [f] to favorite, [q] to quit: ")
      } else {
        readline("Enter [blank] or [q] to quit, [k] to keep, [f] to favorite: ")
      }
      if (tolower(res) == "k") {
        instruct_favorites(favorites)
        return(invisible())
      }
      if (tolower(res) == "f") favorites <- c(favorites, theme)
      if (tolower(res) == "q") break
    }
  }
  instruct_favorites(favorites)
  cli::cli_alert_success("Restoring \"{.strong {current_theme$editor}}\"")
  rstudioapi::applyTheme(current_theme$editor)
}

#' @describeIn rsthemes List style options
#' @param validate If provided to `rsthemes_styles()`, checks that the
#'   specified style is valid.
#' @param ... Ignored.
#' @export
rsthemes_styles <- function(..., validate = NULL) {
  style_options = c("all", "light", "dark", "base16")
  if (is.null(validate)) return(style_options)
  match.arg(validate, style_options, several.ok = FALSE)
}

instruct_favorites <- function(favorites = c()) {
  if (!length(favorites)) return(invisible())
  old_favorites <- get_theme_option("favorite")
  favorites <- c(favorites, old_favorites)
  favorites <- gsub(" ", "\u200b", favorites)
  favorites <- paste0('"', favorites, '"', collapse = ", ")
  favorites <- strwrap(favorites, width = 76, indent = 4, exdent = 4)
  favorites <- paste(favorites, collapse = "\n")
  favorites <- gsub("\u200b", " ", favorites)
  cli::cli_alert_info("Add your favorite themes to your .Rprofile")
  cli::cli_alert_info("Use {.code rsthemes::use_theme_favorite()} to cycle through your favorite themes")
  cli::cli_rule(left = fs::path_home_r(".Rprofile"))
  cli::cli_code(paste(
    sep = "\n",
    'if (interactive() && requireNamespace("rsthemes", quietly = TRUE)) {',
    '  rsthemes::set_theme_favorite(c(',
    favorites,
    '  ))',
    '}'
  ))
}

# base16 filters ----
keep_base16_themes  <- function(theme_list) {
  purrr::keep(theme_list, ~ grepl("base16", .$name, fixed = TRUE))
}

discard_base16_themes <- function(theme_list) {
  purrr::discard(theme_list, ~ grepl("base16", .$name, fixed = TRUE))
}
