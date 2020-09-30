`%||%` <- function(x, y) if (is.null(x)) y else x

requires_rstudioapi <- function(..., has_fun = "getThemes", version = "1.2.1335") {
  if (!requireNamespace("rstudioapi", quietly = TRUE)) {
    stop("The {rstudioapi} package is required")
  }
  rstudio_version <- rstudioapi::versionInfo()$version
  if (rstudio_version < version) {
    stop("RStudio version ", version, " is required, but ",
         rstudio_version, " is installed.")
  }

  if (!rstudioapi::hasFun(has_fun, ...)) {
    stop("{rstudioapi} function ", has_fun,
         " is required. Please update {rstudioapi}.")
  }
}

in_rstudio <- function(has_fun = "getThemes") {
  rstudioapi::hasFun(has_fun)
}

package_theme <- function(...) {
  system.file("themes", ..., package = "rsthemes", mustWork = TRUE)
}

package_template <- function(...) {
  system.file("templates", ..., package = "rsthemes", mustWork = TRUE)
}

rstudio_theme_home <- function(...) {
  if (rstudioapi::versionInfo()$version >= "1.3.555") {
    fs::path_home_r(".config", "rstudio", "themes", ...)
  } else {
    fs::path_home_r(".R", "rstudio", "themes", ...)
  }
}

cp_to_rstudio <- function(file, overwrite = TRUE) {
  fs::file_copy(file, rstudio_theme_home(), overwrite = overwrite)
}

ls_theme_templates <- function(path_templates = NULL, base16 = FALSE) {
  path_templates <- path_templates %||% package_template()
  if (base16) {
    ls_sass(fs::path(path_templates, "palettes", "base16"))
  } else {
    ls_sass(path_templates)
  }
}

ls_theme_palettes <- function(path_palettes = NULL, base16 = FALSE) {
  path_palettes <- path_palettes %||% package_template("palettes")
  if (base16) {
    ls_sass(fs::path("base16"))
  } else {
    ls_sass(path_palettes)
  }
}

ls_sass <- function(...) fs::dir_ls(..., regexp = "[.]s[ca]ss$")
ls_rstheme <- function(...) fs::dir_ls(..., regexp = "[.]rstheme$")
