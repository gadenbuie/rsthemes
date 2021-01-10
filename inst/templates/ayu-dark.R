rstheme(
  "Ayu Dark",
  theme_dark    = TRUE,
  theme_flat    = TRUE,
  theme_path    = here::here("inst/templates/ayu-dark.scss"),
  theme_apply   = TRUE,
  theme_as_sass = TRUE,
  theme_palette = list(
    base00 = "#0D1016",
    base01 = "#0A0E14",
    base02 = "#4D5566",
    base03 = "#4D5566B3",
    base04 = "#273747",
    base05 = "#B3B1AD",
    base06 = "#626A73",
    base07 = "#4D556699",
    base08 = "#c4c6d4",
    yellow = "#FFEE99",
    blue   = "#59C2FF",
    teal   = "#95E6CB",
    green  = "#C2D94C",
    orange01 = "#E6B450",
    orange02 = "#FFB454",
    orange03 = "#FF8F40",
    orange04 = "#E6B673",
    orange05 = "#F29668",
    pink     = "#F07178"
  ),
  ui_background   = "$base01",
  ui_foreground   = "$base05",
  code_string     = "$green",
  code_function   = "$orange02",
  code_value      = "$orange04",
  code_comment    = "$base06",
  code_variable   = "$blue",
  code_message    = "$teal",
  code_reserved   = "$orange03",
  code_operator   = "$orange01",
  code_bracket    = "$base05",
  code_namespace  = "$pink",
  code_identifier = "$base05",
  ui_rstudio_background             = "$base00",
  ui_rstudio_foreground             = "$base02",
  ui_rstudio_toolbar_foreground     = "$base02",
  ui_rstudio_tabs_active_background = "$base00",
  ui_rstudio_tabs_active_foreground = "$base05",
  ui_rstudio_tabs_inactive_background = "$base00",
  ui_rstudio_job_progress_bar       = "$teal",
  ui_selection                      = "$base04",
  ui_console_selection              = "$base04",
  ui_line_active                    = "$base00",
  ui_line_active_selection          = "$base03",
  ui_margin_line                    = "$base03",
  rmd_chunk_background              = "$base00",
  ui_cursor                         = "$orange01",
  ui_gutter_foreground              = "$base07",
  ui_debug_background               = "$base03",
  rmd_chunk_header                  = "$yellow",
  rmd_heading_foreground            = "$pink",
  rmd_href                          = "$pink",
  ui_completions_background         = "$base00",
  ui_completions_border             = "$base00",
  ui_completions_foreground         = "$base03",
  ui_completions_selected_foreground = "$base00",
  rstheme_command_palette(),
  rstheme_large_tabs(),
  rstheme_dialog_options(
    selected_foreground = "$base08",
    help_foreground = "$base08",
    input_foreground = "$code_value",
    input_background = "$base01",
    select_foreground = "$base08",
    select_background = "$base01",
    button_hover_foreground = "$base08"
  ),
  rstheme_rainbow_parentheses(
    "$teal", "$pink", "$base05", "$yellow", "$blue", "$green"
  ),
  '.rstudio-themes-flat .gwt-TabLayoutPanelTab-selected {
    .gwt-TabLayoutPanelTabInner .rstheme_tabLayoutCenter {
      box-shadow: 0 -2px 0 $teal inset;
      border-radius: 0 !important;
    }
  }
  ',
  '.rstudio-themes-dark .dataGridHeader, .rstudio-themes-dark tr[__gwt_header_row] > :-webkit-any(td, th), .rstudio-themes-dark .dataTables_info {
    background-color: $base00 !important;
      border-color: $base00 !important;
  }
  '
)
