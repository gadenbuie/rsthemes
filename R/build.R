make_rsthemes <- function(
  path_out = fs::path("inst", "themes"),
  path_template = NULL
) {
  fs::dir_create(fs::path(path_out, "base16"), recurse = TRUE)
  path_out <- fs::path_abs(path_out)
  path_template <- path_template %||% package_template()
  owd <- setwd(as.character(path_template))
  on.exit(setwd(owd))

  base16_palettes <- ls_theme_templates(path_template, base16 = TRUE)
  for (base16_pal in base16_palettes) {
    base16_sass <- base16_prep_theme(base16_pal)
    base16_outfile <- sub("_base16", "base16", base16_pal)
    base16_outfile <- rstheme_outfile(base16_outfile)
    render_sass(base16_sass, base16_outfile, fs::path(path_out, "base16"))
  }

  for (theme_file in ls_theme_templates(path_template, base16 = FALSE)) {
    render_sass(theme_file, outdir = path_out)
  }

  invisible(TRUE)
}

render_sass <- function(
  file,
  outfile = NULL,
  outdir = fs::path("inst", "themes")
){
  require_sass()

  input_is_text <- length(file) > 1 || grepl("\n", file)

  if (input_is_text & is.null(outfile)) {
    stop("`outfile` must be specified if input is SASS text")
  }

  if (!input_is_text && is.null(outfile)) {
    outfile <- rstheme_outfile(file)
  }

  outfile <- fs::path(outdir, outfile)
  if (input_is_text) {
    sass::sass(file, output = outfile)
  } else {
    sass::sass(sass::sass_file(file), output = outfile, cache = NULL)
  }
  invisible(TRUE)
}

theme_is_dark <- function(file) {
  x <- readLines(file, warn = FALSE)
  any(grepl("rs-theme-is-dark:\\s*TRUE", x))
}

get_theme_name <- function(file) {
  x <- readLines(file, warn = FALSE)
  x <- grep("rs-theme-name", x, value = TRUE)
  if (!length(x)) return("")
  x <- sub("^\\s*/\\*\\s*rs-theme-name:\\s", "", x)
  x <- sub("\\s*\\*/\\s*$", "", x)
  x
}

rstheme_outfile <- function(path) {
  path <- fs::path_file(path)
  fs::path_ext(path) <- "rstheme"
  path
}

require_sass <- function() {
  if (!requireNamespace("sass", quietly = TRUE)) {
    stop("The package {sass} is required: install.packages('sass')")
  }
}


# base16 ------------------------------------------------------------------
require_whisker <- function() {
  if (!requireNamespace("whisker", quietly = TRUE)) {
    stop("The package {whisker} is required: install.packages('whisker')")
  }
}

base16_prep_theme <- function(palette_file) {
  base16_palette <- fs::path_file(palette_file)
  base16_info          <- base16_get_theme_info(palette_file)
  base16_attribution   <- base16_info$attribution
  base16_name          <- base16_info$name
  base16_rstudio_style <- base16_info$rstudio_style

  base16_template <- if (base16_info$isDark) {
    "base16-dark_template.scss"
  } else {
    "base16-light_template.scss"
  }

  whisker::whisker.render(
    readLines(package_template("base16", base16_template), warn = FALSE)
  )
}

base16_get_theme_info <- function(palette_file) {
  # First and second comment lines of the palette_file must be
  # the base16 theme attribution (1) and the studio light/dark style (2)

  info <- list()
  base16_meta <- readLines(palette_file)
  base16_meta <- base16_meta[grepl("^\\s*/\\*", base16_meta)]
  info$attribution <- base16_meta[1]
  info$rstudio_style <- base16_meta[2]
  info$isDark <- grepl("is-dark: TRUE", info$rstudio_style, fixed = TRUE)
  if (info$rstudio_style == "") {
    info$isDark <- TRUE
    info$rstudio_style <- "/* rs-theme-is-dark: TRUE */"
  }
  rgx_name <- "/\\*\\s*([[:alpha:][:digit:][:punct:] ]+) by"
  info$name <- str_match(info$attribution, rgx_name)[[1]][2]
  info
}

str_match <- function(text, pattern) {
  m <- regexec(pattern, text)
  regmatches(text, m)
}
