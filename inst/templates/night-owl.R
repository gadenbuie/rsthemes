night_owl <- rstheme(
  "Night Owl",
  theme_dark    = TRUE,
  theme_flat    = TRUE,
  theme_path    = here::here("inst/templates/night-owl.scss"),
  theme_apply   = FALSE,
  theme_as_sass = TRUE,
  theme_palette = list(
    dark0          = "#010E17",
    dark1          = "#011627",
    dark2          = "#162a3a",

    light0         = "rgb(108,122,137)",
    light1         = "#d6deeb",

    silver         = "#d7dbe0",
    gray           = "#6c7a89",
    "gray-dark"    = "#2e3436",

    blue           = "#82aaff",
    blue1          = "#5ca7e4",
    blue2          = "#3465a4",

    purple         = "#c792ea",
    purple0        = "#2e2040",
    purple1        = "#31364a",
    purple2        = "#75507b",
    "teal-light"   = "#7fdbca",
    "teal-dark"    = "#06989a",
    "yellow-light" = "#ffeb95",
    "yellow-dark"  = "#c4a000",
    orange         = "#f78c6c",
    "orange-light" = "#ecc48d",
    red            = "#d3423e",
    "green-light"  = "#addb67",
    "green-dark"   = "#4e9a06",
    pink           = "#ff2c83",
    olive          = "#637777",
    pesto          = "#807A2F"
  ),

  ui_background   = "$dark1",
  ui_foreground   = "$light1",
  code_string     = "$orange-light",
  code_function   = "$teal-light",
  code_value      = "$green-light",
  code_comment    = "$gray",
  code_variable   = "$blue",
  code_message    = "$pink",
  code_reserved   = "$purple",
  code_operator   = "$blue",
  code_namespace  = "$yellow-light",
  code_identifier = "$light1",
  code_bracket    = "$light0",

  ui_rstudio_background     = "$dark0",
  ui_rstudio_foreground     = "$light0",
  ui_rstudio_toolbar_background = "$dark2",
  ui_rstudio_tabs_active_background = "$dark2",
  ui_rstudio_tabs_inactive_hover_background = "$dark0",
  ui_rstudio_job_progress_bar = "$teal-light",
  ui_rstudio_border         = "$dark1",
  ui_selection              = "transparentize($blue2, 0.85)",
  ui_console_selection      = "$ui_selection",
  ui_line_active_selection  = "transparentize($blue2, 0.75)",
  ui_margin_line            = "transparentize($dark2, 0.25)",
  ui_cursor                 = "transparentize($blue1, 0.5)",
  ui_bracket                = "transparentize($blue1, 0.75)",
  ui_gutter_foreground      = "$gray",
  ui_debug_background       = "transparentize($yellow-dark, 0.75)",
  rmd_chunk_header          = "$blue",
  rmd_heading_foreground    = "$orange",
  rmd_href                  = "$yellow-light",
  rmd_chunk_background      = "$dark2",
  rmd_heading_weight        = "600",
  ui_completions_background = "$dark0",
  ui_completions_border     = "$dark0",
  ui_completions_foreground = "$light1",
  ui_completions_selected_background = "mix($purple, $dark0, 50%)",
  ui_completions_selected_foreground = "$light1",
  ui_fold_arrows_background = "$red",
  ui_fold_arrows_foreground = "$dark0",
  code_namespace_font_style = "italic",
  rstheme_command_palette(
    border = "$dark1",
    item_hover_background = "mix($purple, $dark1, 30%)",
    item_selected_background = "mix($purple, $dark1, 50%)"
  ),
  rstheme_large_tabs(),
  rstheme_dialog_options(
    selected_background = "mix($purple, $dark1, 30%)",
    selected_foreground = "$light1",
    input_foreground = "$light1",
    input_background = "$dark1",
    checkbox_foreground = "$code_value",
    checkbox_background = "$dark1",
    select_foreground = "$light1",
    help_foreground = "$blue1"
  ),
  rstheme_rainbow_parentheses(
    "$code_bracket", "$blue2", "$purple", "$orange", "$green-light", "$red", "$teal-light"
  ),
  rstheme_terminal_colors(
    blue = "$blue2",
    blue_bright = "$blue1",
    red = "$red",
    red_bright = "$pink",
    green = "$green-dark",
    green_bright = "$green-light",
    cyan = "$teal-dark",
    cyan_bright = "$teal-light",
    magenta = "$purple2",
    magenta_bright = "$purple",
    yellow = "$orange-light",
    yellow_bright = "$yellow-light"
  ),
  '.rstudio-themes-flat .gwt-TabLayoutPanelTab-selected {
    .gwt-TabLayoutPanelTabInner .rstheme_tabLayoutCenter {
      box-shadow: 0 4px 0 $blue2 inset;
      border-radius: 0 !important;

      .gwt-Label {
        font-weight: 600;
      }
    }
  }
  '
)
