#' Create a New Theme
#'
#' Writes the template files required to create a new RStudio theme. In general,
#' arguments with the prefix `theme_` refer to global settings for the built
#' theme. Arguments with `ui_rstudio_` refer to RStudio chrome such as tabs,
#' scroll bars, search boxes, and tool bars. Arguments starting with `ui_` refer
#' to UI elements inside the coding area, such as the cursor, selection
#' highlighting, etc. Arguments starting with `code_` refer to code syntax
#' colors and those starting with `rmd_` are specific to R Markdown syntax. The
#' arguments naming conventions may not be perfectly consistent (sorry!).
#'
#' @param theme_name Name of the theme
#' @param ui_background General background color in RStudio panes, e.g. Source pane.
#' @param ui_foreground General foreground (text) color in RStudio panes
#' @param code_string,code_function,code_value,code_variable,code_message
#'   Color of code tokens in R code.
#' @param ... Raw SCSS text strings or \pkg{rstheme} partial themes:
#'
#'   - [rstheme_command_palette()]
#'   - [rstheme_rainbow_parentheses()]
#'   - [rstheme_large_tabs()]
#'   - [rstheme_dialog_options()]
#'   - [rstheme_terminal_colors()]
#' @param theme_path Path for output theme
#' @param theme_dark `TRUE` if the theme is a darke theme, `FALSE` otherwise
#'   (default)
#' @param theme_flat Use additional classes to make the theme a "flat" theme.
#'   Default is `FALSE`.
#' @param theme_palette A list of named colors for use in the theme palette.
#'   Color names should not include the `$` prefix, e.g. `red`, but can be
#'   referenced in any other color-setting variable in `rstheme()` as
#'   `$<color>`, e.g. `$red`.
#' @param theme_as_sass If `TRUE`, the theme is returned as an SCSS file.
#'   Otherwise, the compiled `.rstheme` file is returned (default)
#' @param theme_apply If `TRUE` (default), the theme will be installed and
#'   applied immediately.
#' @param ui_rstudio_background Default: `darken($ui_background, 2%)`
#' @param ui_rstudio_foreground Default: `$ui_foreground`
#' @param ui_rstudio_border Default: `$ui_background`
#' @param ui_rstudio_tabs_inactive_background Default: `lighten($ui_rstudio_background, 2%)`
#' @param ui_rstudio_tabs_inactive_foreground Default: `transparentize($ui_foreground, 0.4)`
#' @param rmd_chunk_background Default: `darken($ui_background, 5%)`
#' @param ui_rstudio_tabs_active_background Default: `$rmd_chunk_background`
#' @param ui_rstudio_tabs_active_foreground Default: `$ui_foreground`
#' @param ui_rstudio_tabs_inactive_hover_background Default: `$ui_rstudio_tabs_inactive_background`
#' @param ui_rstudio_toolbar_background Default: `$ui_rstudio_tabs_active_background`
#' @param ui_rstudio_toolbar_foreground Default: `$ui_foreground`
#' @param ui_rstudio_search Default: `$ui_rstudio_toolbar_background`
#' @param ui_rstudio_scrollbar_background Default: `$ui_background`
#' @param ui_rstudio_scrollbar_handle Default: `$rmd_chunk_background`
#' @param ui_cursor Default: `#FF0000`
#' @param ui_cursor_normal_mode Default: `$ui_cursor`
#' @param ui_margin_line Default: `lighten($ui_selection, 5%)`
#' @param ui_gutter_foreground Default: `transparentize($ui_foreground, 0.75)`
#' @param ui_gutter_background Default: `$ui_background`
#' @param ui_line_active Default: `transparentize($rmd_chunk_background, 0.6)`
#' @param ui_line_active_gutter Default: `$ui_background`
#' @param ui_line_active_selection Default: `opacify($ui_selection, 1)`
#' @param ui_selection Default: `transparentize($rmd_chunk_background, 0.6)`
#' @param ui_bracket Highlight on paired bracket Default: `transparentize($ui_cursor, 0.6)`
#' @param ui_invisible Default: `transparentize($ui_foreground, 0.7)`
#' @param ui_indent_guide Default: `$ui_invisible`
#' @param ui_debug_background Default: `lighten($ui_background, 10%)`
#' @param ui_fold_arrows_foreground Default: `$ui_cursor`
#' @param ui_fold_arrows_background Default: `transparentize($ui_fold_arrows_foreground, 0.5)`
#' @param ui_line_find Default: `$ui_selection`
#' @param ui_console_selection Default: `$ui_selection`
#' @param ui_completions_background Default: `$ui_background`
#' @param ui_completions_foreground Default: `$ui_foreground`
#' @param ui_completions_border Default: `$ui_bracket`
#' @param ui_completions_selected_background Default: `$ui_line_active_selection`
#' @param ui_completions_selected_foreground Default: `$ui_foreground`
#' @param ui_rstudio_job_progress_bar Default: `opacify($ui_selection, 1)`
#' @param code_comment Default: `transparentize($ui_foreground, 0.5)`
#' @param code_namespace_font_style Default: `italic`
#' @param code_reserved Default: `$code_string`
#' @param code_operator Default: `$code_value`
#' @param code_bracket Default: `$code_function`
#' @param code_namespace Default: `$code_variable`
#' @param code_identifier Default: `$ui_foreground`
#' @param code_string_background Default: `inherit`
#' @param code_function_background Default: `inherit`
#' @param code_value_background Default: `inherit`
#' @param code_variable_background Default: `inherit`
#' @param code_message_background Default: `inherit`
#' @param code_comment_background Default: `inherit`
#' @param code_reserved_background Default: `inherit`
#' @param code_operator_background Default: `inherit`
#' @param code_bracket_background Default: `inherit`
#' @param code_namespace_background Default: `inherit`
#' @param code_identifier_background Default: `inherit`
#' @param code_other Default: `$code_string`
#' @param rmd_heading_weight Default: `600`
#' @param rmd_heading_foreground Default: `$code_string`
#' @param rmd_heading_background Default: `$code_string_background`
#' @param rmd_chunk_header Default: `$code_function`
#' @param rmd_chunk_header_background Default: `$code_function_background`
#' @param rmd_href Default: `$code_reserved`
#' @param rmd_href_background Default: `$code_reserved_background`
#'
#' @return Returns the CSS or SCSS (if `theme_as_sass` is `TRUE`). If
#'   `theme_path` is provided, the CSS or SCSS is written to the file and the
#'   source is returned invisibly. If `theme_apply` is `TRUE`, the theme is also
#'   installed and applied to the current RStudio session.
#'
#' @export
rstheme <- function(
  theme_name,
  ui_background,
  ui_foreground,
  code_string,
  code_function,
  code_value,
  code_variable,
  code_message,
  ...,
  theme_path = NULL,
  theme_dark = FALSE,
  theme_flat = FALSE,
  theme_palette = NULL,
  theme_as_sass = FALSE,
  theme_apply = TRUE,
  ui_rstudio_background = "darken($ui_background, 2%)",
  ui_rstudio_foreground = "$ui_foreground",
  ui_rstudio_border = "$ui_background",
  rmd_chunk_background = "darken($ui_background, 5%)",
  ui_rstudio_tabs_inactive_background = "lighten($ui_rstudio_background, 2%)",
  ui_rstudio_tabs_inactive_foreground = "transparentize($ui_foreground, 0.4)",
  ui_rstudio_tabs_inactive_hover_background = "$ui_rstudio_tabs_inactive_background",
  ui_rstudio_tabs_active_background = "$rmd_chunk_background",
  ui_rstudio_tabs_active_foreground = "$ui_foreground",
  ui_rstudio_toolbar_background = "$ui_rstudio_tabs_active_background",
  ui_rstudio_toolbar_foreground = "$ui_foreground",
  ui_rstudio_search = "$ui_rstudio_toolbar_background",
  ui_rstudio_scrollbar_background = "$ui_background",
  ui_rstudio_scrollbar_handle = "$rmd_chunk_background",
  ui_cursor = "#FF0000",
  ui_cursor_normal_mode = "$ui_cursor",
  ui_gutter_foreground = "transparentize($ui_foreground, 0.75)",
  ui_gutter_background = "$ui_background",
  ui_line_active = "transparentize($rmd_chunk_background, 0.6)",
  ui_selection = "transparentize($rmd_chunk_background, 0.6)",
  ui_line_active_selection = "opacify($ui_selection, 1)",
  ui_line_active_gutter = "$ui_background",
  ui_bracket = "transparentize($ui_cursor, 0.6)",
  ui_invisible = "transparentize($ui_foreground, 0.7)",
  ui_indent_guide = "$ui_invisible",
  ui_margin_line = "lighten($ui_selection, 5%)",
  ui_debug_background = "lighten($ui_background, 10%)",
  ui_fold_arrows_foreground = "$ui_cursor",
  ui_fold_arrows_background = "transparentize($ui_fold_arrows_foreground, 0.5)",
  ui_line_find = "$ui_selection",
  ui_console_selection = "$ui_selection",
  ui_completions_background = "$ui_background",
  ui_completions_foreground = "$ui_foreground",
  ui_completions_border = "$ui_bracket",
  ui_completions_selected_background = "$ui_line_active_selection",
  ui_completions_selected_foreground = "$ui_foreground",
  ui_rstudio_job_progress_bar = "opacify($ui_selection, 1)",
  code_comment = "transparentize($ui_foreground, 0.5)",
  code_namespace_font_style = "italic",
  code_reserved = "$code_string",
  code_operator = "$code_value",
  code_bracket = "$code_function",
  code_namespace = "$code_variable",
  code_identifier = "$ui_foreground",
  code_string_background = "inherit",
  code_function_background = "inherit",
  code_value_background = "inherit",
  code_variable_background = "inherit",
  code_message_background = "inherit",
  code_comment_background = "inherit",
  code_reserved_background = "inherit",
  code_operator_background = "inherit",
  code_bracket_background = "inherit",
  code_namespace_background = "inherit",
  code_identifier_background = "inherit",
  code_other = "$code_string",
  rmd_heading_weight = "600",
  rmd_heading_foreground = "$code_string",
  rmd_heading_background = "$code_string_background",
  rmd_chunk_header = "$code_function",
  rmd_chunk_header_background = "$code_function_background",
  rmd_href = "$code_reserved",
  rmd_href_background = "$code_reserved_background"
) {
  check_sass_variable_list(theme_palette, "theme_palette")

  call_values <- as.list(match.call(expand.dots = FALSE))[-1]
  call_values <- utils::modifyList(as.list(formals()), call_values, keep.null = TRUE)
  fn_args_not_theme <- grep("^theme_", names(formals()), value = TRUE)
  fn_args_not_theme <- c(fn_args_not_theme, "...")
  theme_variables <- call_values[setdiff(names(call_values), fn_args_not_theme)]
  # force evaluatation of all theme_variables now
  theme_variables <- lapply(theme_variables, eval, envir = new.env())

  path_rel_theme <- function(path) {
    if (!theme_as_sass || is.null(theme_path)) return(path)
    fs::path_rel(path, fs::path_dir(theme_path))
  }

  theme_rstudio <- if (theme_dark) "_rstudio-dark" else "_rstudio-light"

  dots <- list(...)
  templates <- list()
  templates_variables <- list()
  idx_rm <- c()
  for (i in seq_along(dots)) {
    if (inherits(dots[[i]], "rstheme_template")) {
      templates <- c(templates, sass::sass_import(
        path_rel_theme(package_template("rstudio", paste0(class(dots[[i]])[1], ".scss")))
      ))
      templates_variables <- c(templates_variables, dots[i])
      idx_rm <- c(idx_rm, i)
    }
    if (inherits(dots[[i]], "sass_file")) {
      templates <- c(templates, dots[[i]])
      idx_rm <- c(idx_rm, i)
    }
  }
  if (length(idx_rm)) dots[idx_rm] <- NULL

  # If ... have names, then we separate into two lists: named and unnamed entries
  dots_vars <- NULL
  if (!is.null(names(dots))) {
    has_name <- purrr::map_lgl(names(dots), nzchar)
    dots_vars <- dots[has_name]
    check_sass_variable_list(dots_vars, "...")
    dots_sass <- dots[!has_name]
  } else {
    dots_sass <- dots
  }

  theme_name <- list(sprintf(
    "/* rs-theme-name: %s {rsthemes} */\n/* rs-theme-is-dark: %s */",
    theme_name, theme_dark
  ))

  sass_stack <- list(theme_name, theme_palette, dots_vars)

  sass_stack <- c(
    sass_stack,
    list(theme_variables),
    sass::sass_import(
      path_rel_theme(package_template("rstudio", paste0(theme_rstudio, ".scss")))
    ),
    if (theme_flat) sass::sass_import(
      path_rel_theme(package_template("rstudio", paste0(theme_rstudio, "-flatter.scss")))
    ),
    list(paste(unlist(dots_sass), collapse = "\n")),
    sass::sass_import(
      path_rel_theme(package_template("rstudio", "_terminal.scss"))
    )
  )

  if (length(templates_variables)) {
    sass_stack <- c(sass_stack, templates_variables)
  }

  if (length(templates)) {
    sass_stack <- c(sass_stack, templates)
  }

  names(sass_stack) <- NULL
  sass_stack <- purrr::compact(sass_stack)

  if (isTRUE(theme_as_sass) && isTRUE(theme_apply)) {
    warning(
      "The theme will not be applied because the sass source was requested.",
      immediate. = FALSE,
      call. = FALSE
    )
    theme_apply <- FALSE
  }

  if (is.null(theme_path) && isTRUE(theme_apply)) {
    filename <- gsub(" ", "_", theme_name)
    filename <- paste0(filename, ".rstheme")

    theme_path <- fs::path_temp(fs::path_sanitize(filename))
  }

  if (isTRUE(theme_as_sass)) {
    x <- sass::as_sass(sass_stack)
    # themes are all scss
    theme_path <- sub("sass$", "scss", theme_path)
    writeLines(x, theme_path)
  } else {
    x <- sass::sass(sass_stack, output = theme_path, cache = NULL)
  }

  if (isTRUE(theme_apply)) {
    hotload_rstheme(theme_path)
    return(invisible(x))
  }

  x
}

#' RStudio Partial Themes
#'
#' Partial themes for RStudio to be included as desired in [rstheme()].
#'
#' @name rstheme_partial
NULL

#' @describeIn rstheme_partial Theme the RStudio Command Palette
#' @param foreground,background Foreground (text) or background color
#' @param border Border color
#' @param search_background,item_background,item_color,item_hover_background,item_selected_background
#'   Additional color options for the command palette.
#' @export
rstheme_command_palette <- function(
  background = "$ui_background",
  search_background = "$ui_command_palette_background",
  border = "$ui_command_palette_background",
  item_background = "$ui_command_palette_background",
  item_color = "$ui_foreground",
  item_hover_background = "if($ui_rstudio_is_dark, lighten($ui_command_palette_item_background, 5%), darken($ui_command_palette_item_background, 5%))",
  item_selected_background = "if($ui_rstudio_is_dark, lighten($ui_command_palette_item_background, 10%), darken($ui_command_palette_item_background, 10%))"
) {
  structure(list(
    ui_command_palette_background               = background,
    ui_command_palette_search_background        = search_background,
    ui_command_palette_border                   = border,
    ui_command_palette_item_background          = item_background,
    ui_command_palette_item_color               = item_color,
    ui_command_palette_item_hover_background    = item_hover_background,
    ui_command_palette_item_selected_background = item_selected_background
  ), class = c("_command-palette", "rstheme_template", "list"))
}

#' @describeIn rstheme_partial Theme the rainbow parentheses colors
#' @param ui_paren_0,ui_paren_1,ui_paren_2,ui_paren_3,ui_paren_4,ui_paren_5,ui_paren_6
#'   Parentheses colors 0 through 6.
#' @export
rstheme_rainbow_parentheses <- function(
  ui_paren_0 = "rgb(255, 124, 124)",
  ui_paren_1 = "rgb(255, 187, 0)",
  ui_paren_2 = "#00ff1f",
  ui_paren_3 = "#2bcf2b",
  ui_paren_4 = "lightskyblue",
  ui_paren_5 = "rgb(150, 94, 255)",
  ui_paren_6 = "violet"
) {
  structure(list(
    "ui_paren_0" = ui_paren_0,
    "ui_paren_1" = ui_paren_1,
    "ui_paren_2" = ui_paren_2,
    "ui_paren_3" = ui_paren_3,
    "ui_paren_4" = ui_paren_4,
    "ui_paren_5" = ui_paren_5,
    "ui_paren_6" = ui_paren_6
  ), class = c("_rainbow-parens", "rstheme_template", "list"))
}

#' @describeIn rstheme_partial Enlarges the tabs
#' @export
rstheme_large_tabs <- function() {
  structure(list(), class = c("_large-tabs", "rstheme_template", "list"))
}

#' @describeIn rstheme_partial Themes dialog windows, e.g. _Global Options_
#' @param selected_background,selected_foreground,heading_foreground,help_foreground,button_foreground,button_background,button_border,button_hover_foreground,button_hover_background,button_hover_border,input_foreground,input_background,input_border,checkbox_background,checkbox_foreground,select_background,select_foreground
#'   Additional colors for RStudio dialog boxes, setting SCSS variables prefixed
#'   with `$ui_rstudio_dialog_<argument>`.
#' @export
rstheme_dialog_options <- function(
  background = "$ui_rstudio_background",
  foreground = "$ui_rstudio_foreground",
  border = "if($ui_rstudio_is_dark, lighten($ui_rstudio_dialog_background, 5%), darken($ui_rstudio_dialog_background, 5%))",
  selected_background = "$ui_rstudio_dialog_border",
  selected_foreground = "$ui_rstudio_dialog_foreground",
  heading_foreground = "$code_function",
  help_foreground = "$code_value",
  button_foreground = "$ui_rstudio_dialog_foreground",
  button_background = "$ui_rstudio_dialog_background",
  button_border = "$ui_rstudio_dialog_border",
  button_hover_foreground = "lighten($ui_rstudio_dialog_button_foreground, 10%)",
  button_hover_background = "lighten($ui_rstudio_dialog_button_background, 10%)",
  button_hover_border = "$ui_rstudio_dialog_border",
  input_foreground = "$ui_rstudio_dialog_foreground",
  input_background = "$ui_rstudio_dialog_background",
  input_border = "$ui_rstudio_dialog_border",
  checkbox_background = "lighten($ui_rstudio_dialog_background, 5%)",
  checkbox_foreground = "$ui_rstudio_dialog_foreground",
  select_background = "lighten($ui_rstudio_dialog_background, 5%)",
  select_foreground = "$ui_rstudio_dialog_foreground"
) {
  structure(list(
    ui_rstudio_dialog_background = background,
    ui_rstudio_dialog_foreground = foreground,
    ui_rstudio_dialog_border = border,
    ui_rstudio_dialog_selected_background = selected_background,
    ui_rstudio_dialog_selected_foreground = selected_foreground,
    ui_rstudio_dialog_heading_foreground = heading_foreground,
    ui_rstudio_dialog_help_foreground = help_foreground,
    ui_rstudio_dialog_button_foreground = button_foreground,
    ui_rstudio_dialog_button_background = button_background,
    ui_rstudio_dialog_button_border = button_border,
    ui_rstudio_dialog_button_hover_foreground = button_hover_foreground,
    ui_rstudio_dialog_button_hover_background = button_hover_background,
    ui_rstudio_dialog_button_hover_border = button_hover_border,
    ui_rstudio_dialog_input_foreground = input_foreground,
    ui_rstudio_dialog_input_background = input_background,
    ui_rstudio_dialog_input_border = input_border,
    ui_rstudio_dialog_checkbox_foreground = checkbox_foreground,
    ui_rstudio_dialog_checkbox_background = checkbox_background,
    ui_rstudio_dialog_select_background = select_background,
    ui_rstudio_dialog_select_foreground = select_foreground
  ), class = c("_dialog-options", "rstheme_template", "list"))
}

#' @describeIn rstheme_partial Theme the terminal colors
#' @param black,black_bright,red,red_bright,green,green_bright,yellow,yellow_bright,blue,blue_bright,magenta,magenta_bright,cyan,cyan_bright,white,white_bright
#'   Terminal colors, 8 normal and 8 bright.
#' @export
rstheme_terminal_colors <- function(
  red     = NULL,
  green   = NULL,
  yellow  = NULL,
  blue    = NULL,
  magenta = NULL,
  cyan    = NULL,
  theme_dark = TRUE,
  black = if (theme_dark) "darken($ui_background, 5%)" else "darken($ui_foreground, 5%)",
  white = if (theme_dark) "darken($ui_foreground, 5%)" else "darken($ui_background, 5%)",
  red_bright     = red,
  green_bright   = green,
  yellow_bright  = yellow,
  blue_bright    = blue,
  magenta_bright = magenta,
  cyan_bright    = cyan,
  black_bright   = "lighten($terminal_color_black, 10%)",
  white_bright   = "lighten($terminal_color_white, 10%)"
) {
  terminal_colors <- list(
    terminal_color_black = black,
    terminal_color_black_bright = black_bright,
    terminal_color_red = red,
    terminal_color_red_bright = red_bright,
    terminal_color_green = green,
    terminal_color_green_bright = green_bright,
    terminal_color_yellow = yellow,
    terminal_color_yellow_bright = yellow_bright,
    terminal_color_blue = blue,
    terminal_color_blue_bright = blue_bright,
    terminal_color_magenta = magenta,
    terminal_color_magenta_bright = magenta_bright,
    terminal_color_cyan = cyan,
    termianl_color_cyan_bright = cyan_bright,
    terminal_color_white = white,
    terminal_color_white_bright = white_bright
  )

  terminal_colors <- purrr::compact(terminal_colors)

  if (length(terminal_colors)) {
    # the _terminal.scss partial is always included in the RStudio theme,
    # so we only need to return the SASS variables set in this function.
    sass::as_sass(terminal_colors)
  }
}

hotload_rstheme <- function(path) {
  if(theme_is_dark(path)) {
    rstudioapi::applyTheme("Tomorrow Night")
  } else {
    rstudioapi::applyTheme("Textmate (default)")
  }
  theme_name <- get_theme_name(path)
  if (theme_name %in% get_theme_names()) {
    cli::cli_alert("Replacing existing theme {.file {theme_name}}")
    rstudioapi::removeTheme(theme_name)
  }
  rstudioapi::addTheme(path)
  rstudioapi::applyTheme(theme_name)
}

check_sass_variable_list <- function(x, variable) {
  if (is.null(x)) return(x)
  if (
    !is.list(x) ||
    is.null(names(x)) ||
    !all(nzchar(names(x))) ||
    !all(purrr::map_int(x, length) == 1) ||
    !all(purrr::map_lgl(x, is.character))
  ) {
    stop("`", variable, "` must be a named list of sass variables")
  }
}

sass2formals <- function(path = package_template("rstudio", "_defaults.scss")) {
  defaults <- readLines(path)
  defaults <- grep("^/?/?\\$", defaults, value = TRUE)
  defaults <- sub("^/?/?\\$", "", defaults)
  defaults <- sub("(\\s*!default)?;$", "", defaults)
  defaults <- strsplit(defaults, "\\s*:\\s*")
  defaults <- purrr::map_chr(defaults, function(f) {
    if (length(f) == 1) return(gsub("-", "_", f))
    sprintf('%s = "%s"', gsub("-", "_", f[1]), f[2])
  })
  paste(defaults, collapse = ",\n")
}
