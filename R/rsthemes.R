#' Full RStudio Themes
#'
#' This package provides a set of complete RStudio themes that restyle the
#' IDE and the editor syntax. The themes are built from
#' [sass](https://sass-lang.org) templates into `.rstheme` files that,
#' ultimately, contain the CSS files that provide the themes. The sass templates
#' provide an easy-to-extend framework for customizing the look of RStudio. See
#' [new_rstheme()] for more information about creating your own theme. I've done
#' my best to avoid hacky CSS rules wherever possible, and the themes are tested
#' against the current production release of RStudio (verision 1.2.1335 as of
#' June 11, 2019). Please report any issues you encounter here:
#' [github.com/gadenbuie/rsthemes/issues](https://github.com/gadenbuie/rsthemes/issues).
#'
#' @name rsthemes
NULL

#' @describeIn rsthemes Install RStudio themes
#' @param style Limit to a subgroup of themes, chosen from the options returned
#'   by [rsthemes_styles()].
#' @param include_base16 Should the `base16` themes be included?
#' @export
install_rsthemes <- function(style = "all", include_base16 = FALSE) {
  theme_files <- list_pkg_rsthemes(style, include_base16)
  theme_files <- unname(theme_files)

  theme_rstudio_files <- paste0("rsthemes_", fs::path_file(theme_files))

  fs::dir_create(rstudio_theme_home())
  fs::file_copy(
    theme_files,
    fs::path(rstudio_theme_home(), theme_rstudio_files),
    overwrite = TRUE
  )
  message("Installed ", length(theme_files), " themes, ",
          "use `rsthemes::list_rsthemes()` to list themes and ",
          "`rstudioapi::applyTheme()` to enable.")
}

#' @describeIn rsthemes Remove rsthemes from RStudio
#' @export
remove_rsthemes <- function(style = rsthemes_styles(), include_base16 = TRUE) {
  requires_rstudioapi()
  style <- rsthemes_styles(validate = style)

  themes <- list_rsthemes(style, include_base16)
  if (length(themes) == 0) {
    message("No {rsthemes} themes are installed.")
    return(invisible())
  }

  for (theme in themes) {
    rstudioapi::removeTheme(theme)
  }

  message("Uninstalled ", length(themes), " themes")
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
#' @param delay Number of seconds to wait bewtween themes. Set to 0 to be
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
  for (theme in themes) {
    cat("\u2022", theme, "\n")
    rstudioapi::applyTheme(theme)
    if (delay > 0) {
      Sys.sleep(delay)
    } else {
      res <- if (theme != themes[length(themes)]) {
        readline("Enter [blank] for next, [k] to keep, [q] to quit: ")
      } else {
        readline("Enter [blank] or [q] to quit, [k] to keep: ")
      }
      if (tolower(res) == "k") return(invisible())
      if (tolower(res) == "q") break
    }
  }
  message("Restoring \"", current_theme$editor, "\"")
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

# base16 filters ----
keep_base16_themes  <- function(theme_list) {
  purrr::keep(theme_list, ~ grepl("base16", .$name, fixed = TRUE))
}

discard_base16_themes <- function(theme_list) {
  purrr::discard(theme_list, ~ grepl("base16", .$name, fixed = TRUE))
}
