x <- rstheme(
  "a11y-light",
  theme_dark    = FALSE,
  theme_flat    = FALSE,
  theme_path    = here::here("inst/templates/a11y-light.scss"),
  theme_apply   = TRUE,
  theme_as_sass = TRUE,
  theme_palette = list(
    white         = "#FEFEFE",
    black         = "#2B2B2B",
    gray1         = "#545454",
    gray2         = "#696969",
    blue          = "#007faa",
    "blue-med"    = "#4254a7",
    "blue-dark"   = "#19177c",
    "red-bright"  = "#ff0000",
    red           = "#d91e18",
    "red-dark"    = "#ba2121",
    wasabi        = "#7d9029",
    pink          = "#bb6688",
    "purple"      = "#a1024a",
    green         = "#008000",
    orange        = "#bc7a00",
    "orange-dark" = "#aa5d00"
  ),

  ui_background   = "$white",
  ui_foreground   = "$black",
  code_string     = "$green",
  code_function   = "$blue-dark",
  code_value      = "$purple",
  code_comment    = "$gray2",
  code_variable   = "$blue-dark",
  code_message    = "$red-dark",
  code_reserved   = "$blue",
  code_operator   = "$gray2",
  code_namespace  = "$orange-dark",
  code_identifier = "$black",
  code_bracket    = "$gray2",

  ui_rstudio_background     = "$white",
  ui_rstudio_foreground     = "$black",
  ui_selection              = "transparentize($blue-med, 0.85)",
  ui_console_selection      = "$ui_selection",
  ui_margin_line            = "#ededed",
  ui_cursor                 = "transparentize($red, 0.5)",
  ui_bracket                = "transparentize($red, 0.75)",
  ui_gutter_foreground      = "$gray1",
  ui_debug_background       = "transparentize($orange, 0.75)",
  rmd_chunk_header          = "$purple",
  rmd_heading_foreground    = "$red-dark",
  rmd_href                  = "$blue-dark",
  ui_completions_background = "$white",
  ui_completions_border     = "#ededed",
  ui_completions_foreground = "$black",
  code_namespace_font_style = "bold",
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
'
)
