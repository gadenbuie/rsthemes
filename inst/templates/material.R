material_accents <- list(
  base = list(
    purple = "#C792EA",
    blue   = "#81AAFF",
    sky    = "#89DDFF",
    aqua   = "#84FFFF",
    teal   = "#80CBC4",
    green  = "#C3E88D",
    gold   = "#FFCB6B",
    orange = "#F78C6C",
    red    = "#F07178"
  ),
  lighter = list(
    purple = "#7C4DFF",
    blue   = "#6182b8",
    sky    = "#80CBC4",
    teal   = "#39ADB5",
    green  = "#91B859",
    gold   = "#FFB62C",
    orange = "#F76D47",
    red    = "#E53935",
    pink   = "#FF5370"
  )
)

material_base <- list(
  base = list(
    base00 = "#263238",
    base01 = "#303C41",
    base02 = "#37474F",
    base03 = "#546E7A",
    base04 = "#607A86",
    base05 = "#B2CCD6",
    base06 = "#EEFFFF"
  ),
  darker = list(
    base00 = "#212121",
    base01 = "#2b2b2b",
    base02 = "#424242",
    base03 = "#545454",
    base04 = "#616161",
    base05 = "#65737E",
    base06 = "#EEFFFF"
  ),
  lighter = list(
    base00 = "#FAFAFA",
    base01 = "#E7EAEC",
    base02 = "#CFD8DC",
    base03 = "#B0BEC5",
    base04 = "#90A4AE",
    base05 = "#7E939E",
    base06 = "#272727",
    base07 = "#DAF3F0"
  ),
  ocean = list(
    base00 = "#0F111A",
    base01 = "#1A1C25",
    base02 = "#3B3F51",
    base03 = "#464B5D",
    base04 = "#4B526D",
    base05 = "#8F93A2",
    base06 = "#ffffff"
  ),
  palenight = list(
    base00 = "#222736",
    base01 = "#282E3F",
    base02 = "#232530",
    base03 = "#6C6F93",
    base04 = "#A5ABD0",
    base05 = "#ffffff",
    base06 = "#ffffff"
  )
)

material_rstheme <- function(
  style = NULL,
  base = material_base$base,
  accents = material_accents$base,
  dialog_foreground = "$ui_foreground",
  dialog_heading_foreground = "$teal",
  ...
) {
  name <- paste0("Material", if (!is.null(style)) " ", style)
  path <- paste0("material", if (!is.null(style)) "-", tolower(style), ".scss")
  theme_args <- list(
    theme_name      = name,
    theme_dark      = !identical(style, "Lighter"),
    theme_flat      = TRUE,
    theme_path      = here::here("inst", "templates", path),
    theme_apply     = TRUE,
    theme_as_sass   = TRUE,
    theme_palette   = c(base, accents),
    ui_background   = "$base00",
    ui_foreground   = "$base06",
    code_string     = "$green",
    code_function   = "$blue",
    code_value      = "$orange",
    code_comment    = "$base04",
    code_variable   = "$gold",
    code_message    = "$aqua",
    code_reserved   = "$purple",
    code_operator   = "$sky",
    code_bracket    = "$teal",
    code_namespace  = "$red",
    code_identifier = "$base06",
    ui_rstudio_background               = "$base00",
    ui_rstudio_foreground               = "$base06",
    ui_rstudio_toolbar_foreground       = "$base03",
    ui_rstudio_tabs_active_background   = "$base00",
    ui_rstudio_tabs_active_foreground   = "$base06",
    ui_rstudio_tabs_inactive_background = "$base00",
    ui_rstudio_tabs_inactive_foreground = "$base04",
    ui_rstudio_job_progress_bar         = "$teal",
    ui_completions_background           = "$base01",
    ui_completions_border               = "$base00",
    ui_completions_foreground           = "$base06",
    ui_completions_selected_foreground  = "$base06",
    ui_console_selection     = "$base00",
    ui_selection             = "mix($base04, $base01, 10%)",
    ui_line_active           = "darken($base00, 5%)",
    ui_line_active_selection = "$base02",
    ui_margin_line           = "$base01",
    ui_cursor                = "$gold",
    ui_gutter_foreground     = "$base03",
    ui_debug_background      = "$base02",
    rmd_chunk_background     = "darken($base00, 2%)",
    rmd_chunk_header         = "$teal",
    rmd_heading_foreground   = "$gold",
    rmd_href                 = "$red",
    rstheme_command_palette(),
    rstheme_large_tabs(),
    rstheme_dialog_options(
      foreground              = dialog_foreground,
      heading_foreground      = dialog_heading_foreground,
      help_foreground         = "$base05",
      selected_foreground     = "$base05",
      input_foreground        = "$gold",
      button_hover_foreground = "$base05"
    ),
    rstheme_rainbow_parentheses(
      "$blue",
      "$gold",
      "$red",
      "$purple",
      "$green",
      "$orange",
      "$teal"
    ),
    sprintf(".rstudio-themes-flat .gwt-TabLayoutPanelTab-selected {
    .gwt-TabLayoutPanelTabInner .rstheme_tabLayoutCenter {
      box-shadow: 0 -2px 0 %s inset;
      border-radius: 0 !important;
    }
  }
  ", dialog_heading_foreground),
    "/* remove border from panes */
    .rstudio-themes-flat
    :-webkit-any(.windowframe, .rstheme_minimizedWindowObject)
    > div:last-child {
      border-color: $ui_rstudio_background !important;
    }
    "
  )

  theme_args <- modifyList(theme_args, list(...))
  do.call(rstheme, theme_args)
}

# Base
material_rstheme()

material_rstheme(
  "Darker",
  material_base$darker,
  dialog_heading_foreground = "$aqua",
  ui_rstudio_job_progress_bar = "$orange"
)

material_rstheme(
  "Lighter",
  material_base$lighter,
  material_accents$lighter,
  dialog_heading_foreground = "$sky",
  code_message = "$pink",
  code_operator = "$base05"
)

material_rstheme(
  "Ocean",
  material_base$ocean,
  material_accents$base,
  dialog_foreground = "$ui_rstudio_foreground",
  dialog_heading_foreground = "$aqua",
  ui_foreground = "$base05",
  ui_rstudio_job_progress_bar = "$purple"
  # ui_rstudio_tabs_inactive_foreground = "$base04"
)

material_rstheme(
  "Palenight",
  material_base$palenight,
  material_accents$base,
  ui_rstudio_job_progress_bar = "$blue",
  dialog_foreground = "$ui_rstudio_foreground",
  dialog_heading_foreground = "$purple",
  ui_foreground = "$base04",
  ui_rstudio_tabs_inactive_foreground = "$base04",
  code_identifier = "$base04"
)
