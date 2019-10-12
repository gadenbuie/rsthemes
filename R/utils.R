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
  fs::path_home_r(".R", "rstudio", "themes", ...)
}

cp_to_rstudio <- function(file, overwrite = TRUE) {
  fs::file_copy(file, rstudio_theme_home(), overwrite = overwrite)
}

ls_theme_templates <- function(base16 = FALSE) {
  if (base16) {
    ls_sass(package_template("palettes", "base16"))
  } else {
    ls_sass(package_template())
  }
}

ls_theme_palettes <- function(base16 = FALSE) {
  if (base16) {
    ls_sass(package_template("palettes", "base16"))
  } else {
    ls_sass(package_template("palettes"))
  }
}

ls_sass <- function(...) fs::dir_ls(..., regexp = "[.]s[ca]ss$")
ls_rstheme <- function(...) fs::dir_ls(..., regexp = "[.]rstheme$")
