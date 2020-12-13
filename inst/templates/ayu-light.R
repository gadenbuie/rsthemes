rstheme(
  "Ayu Light",
  theme_dark    = FALSE,
  theme_flat    = TRUE,
  theme_path    = here::here("inst/templates/ayu-light.scss"),
  theme_apply   = TRUE,
  theme_as_sass = TRUE,
  theme_palette = list(
    base00 = "#FFFFFF",
    base01 = "#FAFAFA",
    base02 = "#8A9199",
    base03 = "#8A919959",
    base04 = "#D1E4F4",
    base05 = "#575F66",
    base06 = "#ABB0B6",
    base07 = "#8A919966",
    purple = "#A37ACC",
    blue   = "#399EE6",
    teal   = "#4CBF99",
    green  = "#86B300",
    orange01 = "#FF9940",
    orange02 = "#F2AE49",
    orange03 = "#FA8D3E",
    orange04 = "#E6BA7E",
    orange05 = "#ED9366",    
    pink     = "#F07171"
  ),
  ui_background   = "$base01",
  ui_foreground   = "$base05",
  code_string     = "$green",
  code_function   = "$orange02",
  code_value      = "$purple",
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
  rmd_heading_foreground            = "$green",
  rmd_href                          = "$pink",
  ui_completions_background         = "$base00",
  ui_completions_border             = "$base00",
  ui_completions_foreground         = "$base03",
  ui_completions_selected_foreground = "$base03",
  rstheme_command_palette(),
  rstheme_large_tabs(),
  rstheme_dialog_options(
    selected_foreground = "$base05",
    help_foreground = "$base05",
    input_foreground = "$code_value",
    input_background = "$base01",
    select_foreground = "$base06",
    select_background = "$base01"
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