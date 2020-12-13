rstheme(
  "Dracula",
  theme_dark    = TRUE,
  theme_flat    = TRUE,
  theme_path    = here::here("inst/templates/dracula.scss"),
  theme_apply   = TRUE,
  theme_as_sass = TRUE,
  theme_palette = list(
    base00 = "#21232D",
    base01 = "#282A36",
    base02 = "#44475A",
    base03 = "#6272A4",
    base04 = "#6071A8",
    white = "#F8F8F2",
    yellow = "#F1FA8C",
    cyan   = "#8BE9FD",
    green   = "#50FA7B",
    orange = "#FFB86C",    
    red     = "#FF5555",
    pink   = "#FF79C6",
    purple = "#BD93F9"
  ),
  ui_background   = "$base01",
  ui_foreground   = "mix($base03, $white, 70%)",
  code_string     = "$yellow",
  code_function   = "$green",
  code_value      = "$purple",
  code_comment    = "$base03",
  code_variable   = "$orange",
  code_message    = "$purple",
  code_reserved   = "$cyan",
  code_operator   = "$pink",
  code_bracket    = "$white",
  code_namespace  = "$pink",
  code_identifier = "$white",
  ui_rstudio_background             = "$base00",
  ui_rstudio_foreground             = "mix($base03, $white, 70%)",
  ui_rstudio_toolbar_foreground     = "$base03",
  ui_rstudio_tabs_active_background = "$base00",
  ui_rstudio_tabs_active_foreground = "$white",
  ui_rstudio_tabs_inactive_background = "$base00",
  ui_rstudio_job_progress_bar       = "$orange",
  ui_selection                      = "$base03",
  ui_console_selection              = "$base03",
  ui_line_active                    = "$base00",
  ui_line_active_selection          = "$base03",
  ui_margin_line                    = "$base03",
  rmd_chunk_background              = "$base00",
  ui_cursor                         = "transparentize($white, 0.25)",
  ui_gutter_foreground              = "$base04",
  ui_debug_background               = "$base03",
  rmd_chunk_header                  = "$orange",
  rmd_heading_foreground            = "$purple",
  rmd_href                          = "$cyan",
  ui_completions_background         = "$base00",
  ui_completions_border             = "$base00",
  ui_completions_foreground         = "$base03",
  ui_completions_selected_foreground = "$base00",
  rstheme_command_palette(),
  rstheme_large_tabs(),
  rstheme_dialog_options(
    selected_foreground = "$white",
    help_foreground = "$white",
    input_foreground = "$code_value",
    input_background = "$base01",
    select_foreground = "$base03",
    select_background = "$base01"
  ),
  rstheme_rainbow_parentheses(
    "$cyan", "$pink", "$white", "$yellow", "$red", "$green"
  ),
  '.rstudio-themes-flat .gwt-TabLayoutPanelTab-selected {
    .gwt-TabLayoutPanelTabInner .rstheme_tabLayoutCenter {
      box-shadow: 0 -2px 0 $pink inset;
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