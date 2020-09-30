rstheme(
  "Horizon Dark",
  theme_dark    = TRUE,
  theme_flat    = TRUE,
  theme_path    = here::here("inst/templates/horizon-dark.scss"),
  theme_apply   = TRUE,
  theme_as_sass = TRUE,
  theme_palette = list(
    base00 = "#16161c",
    base01 = "#1a1c23",
    base02 = "#1c1e26",
    base03 = "#232530",
    base04 = "#2e303e",
    base05 = "#6c6f93",
    base06 = "#8A8CA8",
    base07 = "#acafc3",
    base08 = "#c4c6d4",
    purple = "#b877db",
    teal   = "#25b2bc",
    red    = "#e95678",
    orange = "#f09383",
    gold   = "#fab795",
    yellow = "#fac29a",
    green1 = "#09f7a0",
    green2 = "#27d796"
  ),
  ui_background   = "$base01",
  ui_foreground   = "$base06",
  code_string     = "$orange",
  code_function   = "$purple",
  code_value      = "$orange",
  # how do we feel about this?
  code_comment    = "$base05",
  code_variable   = "$green2",
  code_message    = "$yellow",
  code_reserved   = "$orange",
  code_operator   = "$gold",
  code_namespace  = "$teal",
  code_identifier = "$red",
  ui_rstudio_background             = "$base00",
  ui_rstudio_foreground             = "$base07",
  ui_rstudio_toolbar_foreground     = "$base05",
  ui_rstudio_tabs_active_background = "$base00",
  ui_rstudio_tabs_active_foreground = "$base08",
  ui_rstudio_job_progress_bar       = "$purple",
  ui_selection                      = "$base00",
  ui_console_selection              = "$base00",
  ui_line_active                    = "$base00",
  ui_line_active_selection          = "$base03",
  ui_margin_line                    = "$base03",
  rmd_chunk_background              = "$base02",
  ui_cursor                         = "#1eaeae",
  ui_gutter_foreground              = "#565875",
  ui_debug_background               = "$base03",
  rmd_chunk_header                  = "$orange",
  rmd_heading_foreground            = "$red",
  rmd_href                          = "#e9436f",
  ui_completions_background         = "$base00",
  ui_completions_border             = "$base00",
  ui_completions_foreground         = "$base08",
  ui_completions_selected_foreground = "$base08",
  rstheme_command_palette(),
  rstheme_large_tabs(),
  rstheme_dialog_options(),
  rstheme_rainbow_parentheses(
    "$code_comment", "#21bfc2", "#fab795", "#f43e5c", "#07da8c", "#b877db"
  ),
  '.rstudio-themes-flat .gwt-TabLayoutPanelTab-selected {
    .gwt-TabLayoutPanelTabInner .rstheme_tabLayoutCenter {
      box-shadow: 0 3px 0 $red inset;
      border-radius: 0 !important;

      .gwt-Label {
        font-weight: 600;
      }
    }
  }
  '
)
