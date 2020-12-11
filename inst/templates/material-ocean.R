rstheme(
  "Material Ocean",
  theme_dark    = TRUE,
  theme_flat    = TRUE,
  theme_path    = here::here("inst/templates/material-ocean.scss"),
  theme_apply   = TRUE,
  theme_as_sass = TRUE,
  theme_palette = list(
    base00 = "#090D14",
    base01 = "#0F121C",
    base02 = "#1c1e26",
    base03 = "#232530",
    base04 = "#242937",
    base05 = "#6c6f93",
    base06 = "#A5ABD0",
    base07 = "#1F2233",
    base08 = "#ffffff",
    purple = "#C792E9",
    blue   = "#81AAFF",
    sky    = "#88DDFE",
    aqua   = "#84ffff",
    teal   = "#81D4CC",
    green  = "#C3E88D",
    gold   = "#FFC956",
    orange = "#F88C6C",
    red    = "#F07178"
  ),
  ui_background   = "$base01",
  ui_foreground   = "$base06",
  code_string     = "$green",
  code_function   = "$blue",
  code_value      = "$orange",
  code_comment    = "$base05",
  code_variable   = "$gold",
  code_message    = "$sky",
  code_reserved   = "$purple",
  code_operator   = "$sky",
  code_namespace  = "$red",
  code_identifier = "$base06",
  ui_rstudio_background             = "$base00",
  ui_rstudio_foreground             = "$base06",
  ui_rstudio_toolbar_foreground     = "$base05",
  ui_rstudio_tabs_active_background = "$base00",
  ui_rstudio_tabs_active_foreground = "$base08",
  ui_rstudio_tabs_inactive_background = "$base00",
  ui_rstudio_tabs_inactive_foreground = "$base06",
  ui_rstudio_job_progress_bar       = "$blue",
  ui_selection                      = "$base07",
  ui_console_selection              = "$base00",
  ui_line_active                    = "$base00",
  ui_line_active_selection          = "$base03",
  ui_margin_line                    = "$base03",
  rmd_chunk_background              = "$base00",
  ui_cursor                         = "$gold",
  ui_gutter_foreground              = "$base04",
  ui_debug_background               = "$base03",
  rmd_chunk_header                  = "$teal",
  rmd_heading_foreground            = "$gold",
  rmd_href                          = "$red",
  ui_completions_background         = "$base00",
  ui_completions_border             = "$base00",
  ui_completions_foreground         = "$base08",
  ui_completions_selected_foreground = "$base08",
  ui_completions_selected_background = "mix($teal, $ui_rstudio_background, 40%)",
  rstheme_command_palette(
    item_selected_background = "mix($teal, $ui_rstudio_background, 40%)",
    item_hover_background = "mix($teal, $ui_rstudio_background, 20%)"
  ),
  rstheme_large_tabs(),
  rstheme_dialog_options(
    selected_foreground = "$base08",
    help_foreground = "$base08",
    input_foreground = "$orange",
    input_background = "$base01",
    select_foreground = "$base06",
    select_background = "$base01"
  ),
  rstheme_rainbow_parentheses(
    "$gold", "$red", "$purple", "$green", "$blue", "$orange", "$teal"
  ),
  '.rstudio-themes-flat .gwt-TabLayoutPanelTab-selected {
    .gwt-TabLayoutPanelTabInner .rstheme_tabLayoutCenter {
      box-shadow: 0 -2px 0 $aqua inset;
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