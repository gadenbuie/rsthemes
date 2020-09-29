x <- rstheme(
  "a11y-dark",
  theme_dark    = TRUE,
  theme_flat    = FALSE,
  theme_path    = here::here("inst/templates/a11y-dark.sass"),
  theme_apply   = TRUE,
  theme_as_sass = TRUE,
  theme_palette = list(
    white         = "#FEFEFE",
    black         = "#2B2B2B",
    gray1         = "#dbdbdb",
    gray2         = "#a0a0a0",
    blue          = "#00e0e0",
    "blue-med"    = "#4254a7",
    "blue-dark"   = "#009DC4",
    "red-bright"  = "#ff0000",
    red           = "#ffa07a",
    "red-dark"    = "#E56D75",
    wasabi        = "#7d9029",
    pink          = "#bb6688",
    "purple"      = "#dcc6e0",
    green         = "#abe338",
    orange        = "#ffd700",
    "orange-dark" = "#FFA500",
    magenta       = "#E35BD8"
  ),
  ui_background   = "$black",
  ui_foreground   = "$white",
  code_string     = "$green",
  code_function   = "$blue-dark",
  code_value      = "$purple",
  code_comment    = "$gray2",
  code_variable   = "$blue-dark",
  code_message    = "$red-dark",
  code_reserved   = "$blue",
  code_operator   = "$gray2",
  code_namespace  = "$orange-dark",
  code_identifier = "$white",
  code_bracket    = "$gray2",

  ui_rstudio_background     = "$black",
  ui_rstudio_foreground     = "$white",
  ui_selection              = "#473245",
  ui_console_selection      = "$ui_selection",
  ui_line_active            = "transparentize($white, 0.95)",
  ui_line_active_selection  = "$ui_selection",
  ui_margin_line            = "#54545444",
  ui_cursor                 = "transparentize($blue, 0.5)",
  ui_bracket                = "transparentize($blue, 0.75)",
  ui_gutter_foreground      = "$gray1",
  ui_debug_background       = "transparentize($orange, 0.75)",
  rmd_chunk_header          = "$purple",
  rmd_heading_foreground    = "$red-dark",
  rmd_href                  = "$blue-dark",
  ui_completions_background = "$black",
  ui_completions_border     = "$black",
  ui_completions_foreground = "$white",
  ui_rstudio_job_progress_bar = "$orange-dark",
  rstheme_command_palette(),
  rstheme_rainbow_parentheses(
    "$gray2", "$blue-med", "$red", "$green", "$purple", "$orange", "$wasabi"
  ),
  '
[class="ace_keyword"] {
	font-weight: 600;
}
.ace_function {
  font-weight: 600;
}
.rstudio-themes-flat .rstudio-themes-border,
.rstudio-themes-flat .rstudio-themes-dark-grey .windowframe>div:last-child,
.rstudio-themes-flat .rstudio-themes-dark-grey .rstudio-themes-background,
.rstudio-themes-flat .rstudio-themes-dark-grey .gwt-TabLayoutPanelTabs table.rstheme_tabLayoutCenter,
.rstudio-themes-flat .rstudio-themes-dark-grey .rstheme_minimizedWindowObject,
.rstudio-themes-flat .rstudio-themes-dark-grey .rstheme_minimizedWindowObject>div:last-child,
.rstudio-themes-flat .rstudio-themes-dark-grey .rstheme_minimizedWindowObject table.rstheme_tabLayoutCenter,
.rstudio-themes-flat .rstudio-themes-dark-grey .rstheme_minimizedWindowObject table.rstheme_center,
.rstudio-themes-flat .rstudio-themes-dark-grey .rstheme_toolbarWrapper,
.rstudio-themes-flat .rstudio-themes-dark-grey .gwt-TabLayoutPanel>div>div.gwt-TabLayoutPanelTabs {
  border-color: #454545;
}
'
)
