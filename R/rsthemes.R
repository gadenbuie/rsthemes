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
#' @param include_base16 Should the `base16` theme set be installed?
#' @export
install_rsthemes <- function(include_base16 = TRUE) {
  # install themes, optionally exclude base16 themes
  theme_files <- ls_rstheme(package_theme())
  if (include_base16) {
    theme_files <- c(
      theme_files,
      ls_rstheme(package_theme("base16"))
    )
  }
  fs::dir_create(rstudio_theme_home())
  fs::file_copy(theme_files, rstudio_theme_home())
}

#' @describeIn rsthemes Remove rsthemes from RStudio
#' @export
remove_rsthemes <- function(style = rsthemes_styles()) {
  requires_rstudioapi()
  style <- rsthemes_styles(validate = style)

  themes <- list_rsthemes(style = style)
  if (length(themes) == 0) {
    message("No {rsthemes} themes are installed.")
    return(invisible())
  }

  for (theme in themes) {
    rstudioapi::removeTheme(theme)
  }

  message("Uninstalled ", length(themes), " themes")
}

#' @describeIn rsthemes List installed rsthemes
#' @param style List a subgroup of themes, one of the options returned by
#'   [rsthemes_styles()].
#' @export
list_rsthemes <- function(style = rsthemes_styles()) {
  requires_rstudioapi()
  themes <- rstudioapi::getThemes()
  themes <- switch(
    rsthemes_styles(validate = style),
    light = purrr::discard(themes, "isDark"),
    dark = purrr::keep(themes, "isDark"),
    base16 = purrr::keep(themes, ~ grepl("base16", .$name)),
    themes
  )
  themes <- purrr::map_chr(themes, "name")
  themes <- themes[grepl("\\{rsthemes\\}", themes)]
  unname(themes)
}

#' @describeIn rsthemes Try each rsthemes RStudio theme
#' @param delay Number of seconds to wait bewtween themes. Set to 0 to be
#'   prompted to continue after each theme.
#' @export
try_rsthemes <- function(
  style = rsthemes_styles(),
  delay = 0
) {
  requires_rstudioapi()
  style <- rsthemes_styles(validate = style)
  current_theme <- rstudioapi::getThemeInfo()
  themes <- list_rsthemes(style)
  for (theme in themes) {
    cat("\u2022", theme, "\n")
    rstudioapi::applyTheme(theme)
    if (delay > 0) {
      Sys.sleep(delay)
    } else if (theme != themes[length(themes)]) {
      res <- readline("Press [enter] for next, [k] to keep, [q] to quit...")
      if (tolower(res) == "k") return(invisible())
      if (tolower(res) == "q") {
        message("Restoring \"", current_theme$editor, "\"")
        rstudioapi::applyTheme(current_theme$editor)
        return(invisible())
      }
    }
  }
}

#' @describeIn rsthemes List style options
#' @export
rsthemes_styles <- function(..., validate = NULL) {
  style_options = c("all", "light", "dark", "base16")
  if (is.null(validate)) return(style_options)
  match.arg(validate, style_options, several.ok = FALSE)
}
