rstheme(
  "Material Darker",
  theme_dark    = TRUE,
  theme_flat    = TRUE,
  theme_path    = here::here("inst/templates/material-darker.scss"),
  theme_apply   = TRUE,
  theme_as_sass = TRUE,
  theme_palette = list(
    base00 = "#1B1B1B",
    base01 = "#222222",
    base02 = "#232530",
    base03 = "#616161",
    base04 = "#EAFFFF",
    base05 = "#ffffff",
    base06 = "#848484",
    purple = "#C792E9",
    blue   = "#81AAFF",
    sky    = "#88DDFE",
    aqua   = "#84ffff",
    teal   = "#81D4CC",
    green  = "#C3E88D",
    gold   = "#FDCA68",
    orange = "#F88C6C",
    red    = "#F07178"
  ),
  ui_background   = "$base01",
  ui_foreground   = "$base06",
  code_string     = "$green",
  code_function   = "$blue",
  code_value      = "$orange",
  code_comment    = "$base03",
  code_variable   = "$gold",
  code_message    = "$sky",
  code_reserved   = "$purple",
  code_operator   = "$sky",
  code_bracket = "$sky",
  code_namespace  = "$red",
  code_identifier = "$base05",
  ui_rstudio_background             = "$base00",
  ui_rstudio_foreground             = "$base04",
  ui_rstudio_toolbar_foreground     = "$base03",
  ui_rstudio_tabs_active_background = "$base00",
  ui_rstudio_tabs_active_foreground = "$base05",
  ui_rstudio_tabs_inactive_background = "$base00",
  ui_rstudio_tabs_inactive_foreground = "$base06",
  ui_rstudio_job_progress_bar       = "$orange",
  ui_selection                      = "mix($base04, $base01, 10%)",
  ui_console_selection              = "$base00",
  ui_line_active                    = "$base00",
  ui_line_active_selection          = "$base02",
  ui_margin_line                    = "$base02",
  rmd_chunk_background              = "$base00",
  ui_cursor                         = "$gold",
  ui_gutter_foreground              = "mix($base03, $base01, 50%)",
  ui_debug_background               = "$base02",
  rmd_chunk_header                  = "$teal",
  rmd_heading_foreground            = "$gold",
  rmd_href                          = "$red",
  ui_completions_background         = "$base01",
  ui_completions_border             = "$base00",
  ui_completions_foreground         = "$base05",
  ui_completions_selected_foreground = "$base05",
  rstheme_command_palette(),
  rstheme_large_tabs(),
  rstheme_dialog_options(
    heading_foreground = "$orange",
    help_foreground = "$base05",
    selected_foreground = "$base05",
    foreground = "$base06",
    input_foreground = "$gold",
    button_hover_foreground = "$base05"
  ),
  rstheme_rainbow_parentheses(
    "$blue", "$gold", "$red", "$purple", "$green", "$orange", "$teal"
  ),
  '.rstudio-themes-flat .gwt-TabLayoutPanelTab-selected {
    .gwt-TabLayoutPanelTabInner .rstheme_tabLayoutCenter {
      box-shadow: 0 -2px 0 $orange inset;
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