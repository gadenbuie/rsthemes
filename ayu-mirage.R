rstheme(
  "Ayu Mirage",
  theme_dark    = TRUE,
  theme_flat    = TRUE,
  theme_path    = here::here("inst/templates/ayu-mirage.scss"),
  theme_apply   = TRUE,
  theme_as_sass = TRUE,
  theme_palette = list(
    base00 = "#232834",
    base01 = "#1F2430",
    base02 = "#707A8C",
    base03 = "#707A8C4D",
    base04 = "#33415E",
    base05 = "#CBCCC6",
    base06 = "#5C6773",
    base07 = "#707A8C66",
    purple = "#D4BFFF",
    blue   = "#73D0FF",
    teal   = "#95E6CB",
    green  = "#BAE67E",
    orange01 = "#FFCC66",
    orange02 = "#FFD580",
    orange03 = "#FFA759",
    orange04 = "#FFE6B3",
    orange05 = "#F29E74",    
    pink     = "#F28779"
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
  rmd_chunk_header                  = "$green",
  rmd_heading_foreground            = "$pink",
  rmd_href                          = "$pink",
  ui_completions_background         = "$base00",
  ui_completions_border             = "$base00",
  ui_completions_foreground         = "$base03",
  ui_completions_selected_foreground = "$base00",
  rstheme_command_palette(),
  rstheme_large_tabs(),
  rstheme_dialog_options(
    selected_foreground = "$base05",
    help_foreground = "$base05",
    input_foreground = "$code_value",
    input_background = "$base01",
    select_foreground = "$base05",
    select_background = "$base01",
    button_hover_foreground = "$base05"
  ),
  rstheme_rainbow_parentheses(
    "$teal", "$pink", "$base05", "$purple", "$blue", "$green"
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