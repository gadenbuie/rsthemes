serendipity <- list(
  light = list(
    background = "#fafafa",
    foreground = "#576067",
    "gray-light" = "#f0f0f0",
    gray = "#abb0b6",
    "gray-dark" = "#898f93",
    red = "#ED5A5A",    # modified for contrast
    orange = "#E77136", # modified for contrast
    pink = "#f06897",
    purple = "#a173ff",
    green = "#109484",  # modified for contrast
    teal = "#399ee6",
    blue = "#4589ff",
    yellow = "#ffd806",
    pink2 = "#da71d6",
    blue2 = "#87cefa"
  ),
  dark = list(
    background = "#222733",
    foreground = "#cbccc6",
    "gray-light" = "#f0f0f0",
    gray = "#abb0b6",
    "gray-dark" = "#898f93",
    red = "#f06897",
    orange = "#ffb681",
    pink = "#f06897",
    purple = "#aa87e5",
    green = "#9ef0f0",
    teal = "#73d0ff",
    blue = "#78a9ff",
    yellow = "#ffdd00",
    pink2 = "#c166c0",
    blue2 = "#86cefa"
  )
)

# Serendipity Dark --------------------------------------------------------

rstheme(
  "Serendipity Dark",
  theme_dark    = TRUE,
  theme_flat    = TRUE,
  theme_path    = here::here("inst/templates/serendipity-dark.scss"),
  theme_apply   = TRUE,
  theme_as_sass = TRUE,
  theme_palette = serendipity$dark,
  ui_rstudio_tabs_inactive_background = "#1f2430",
  ui_rstudio_tabs_inactive_foreground = "$foreground",
  ui_rstudio_tabs_active_background = "$background",
  ui_rstudio_tabs_active_foreground = "$foreground",
  ui_rstudio_tabs_inactive_hover_background = "lighten($ui_rstudio_tabs_inactive_background, 2%)",
  ui_line_active = "#191e2a",
  ui_background   = "$background",
  ui_foreground   = "$foreground",
  code_string     = "$purple",
  code_function   = "$green",
  code_value      = "$red",
  code_comment    = "$gray",
  code_variable   = "$teal",
  code_message    = "$purple",
  code_reserved   = "$blue",
  code_operator   = "$orange",
  code_namespace  = "$orange",
  code_identifier = "$foreground",
  code_bracket    = "$gray",
  ui_rstudio_background     = "darken($background, 2.5%)",
  ui_rstudio_foreground     = "$foreground",
  ui_selection              = "transparentize($green, 0.90)",
  ui_line_active_selection  = "$ui_selection",
  ui_console_selection      = "$ui_selection",
  ui_margin_line            = "#2e3340",
  ui_cursor                 = "transparentize($green, 0.25)",
  ui_bracket                = "transparentize($red, 0.75)",
  ui_gutter_foreground      = "#414956",
  ui_debug_background       = "transparentize($yellow, 0.75)",
  rmd_chunk_header          = "$purple",
  rmd_heading_foreground    = "$teal",
  rmd_href                  = "$green",
  rmd_chunk_background      = "#1f2430",
  ui_completions_background = "$ui_rstudio_background",
  ui_completions_border     = "#ededed",
  ui_completions_foreground = "$foreground",
  ui_completions_selected_background = "mix($blue2, $ui_rstudio_background, 25%)",
  ui_fold_arrows_foreground = "$foreground",
  ui_fold_arrows_background = "$blue2",
  code_namespace_font_style = "italic",
  rstheme_command_palette(
    item_hover_background = "mix($blue2, $ui_command_palette_item_background, 15%)",
    item_selected_background = "mix($blue2, $ui_command_palette_item_background, 25%)"
  ),
  rstheme_large_tabs(),
  rstheme_dialog_options(heading_foreground = "$purple", help_foreground = "$blue"),
  rstheme_rainbow_parentheses(
    "$gray-dark", "$pink2", "$blue2", "$yellow", "$pink2", "$blue2"
  ),
  rstheme_terminal_colors(
    theme_dark = TRUE,
    red = "$red",
    red_bright = "$pink",
    green = "$green",
    yellow = "$yellow",
    blue = "$blue",
    blue_bright = "$blue2",
    magenta = "$purple",
    cyan = "$teal"
  ),
  '#rstudio_command_palette_list [id^="rstudio_command_entry_"] > :first-child:not([id]) {
    background-color: $red;
    .gwt-Label {
      color: $background;
    }
  }
  .ace_comment {
    font-style: italic;
  }
  body .gwt-TabLayoutPanelTab-selected {
    .gwt-TabLayoutPanelTabInner .rstheme_tabLayoutCenter {
      box-shadow: 0 2px 0 $red inset;
      border-radius: 0 !important;
    }
  }'
)

# Serendipity Light -------------------------------------------------------

rstheme(
  "Serendipity Light",
  theme_dark    = FALSE,
  theme_flat    = TRUE,
  theme_path    = here::here("inst/templates/serendipity-light.scss"),
  theme_apply   = TRUE,
  theme_as_sass = TRUE,
  theme_palette = serendipity$light,
  ui_rstudio_tabs_inactive_background = "$gray-light",
  ui_rstudio_tabs_inactive_foreground = "$gray-dark",
  ui_rstudio_tabs_active_background = "#fafafa",
  ui_rstudio_tabs_active_foreground = "#232834",
  ui_rstudio_tabs_inactive_hover_background = "lighten($ui_rstudio_tabs_inactive_background, 2%)",
  ui_background   = "$background",
  ui_foreground   = "$foreground",
  code_string     = "$purple",
  code_function   = "$green",
  code_value      = "$red",
  code_comment    = "$gray",
  code_variable   = "$blue",
  code_message    = "$purple",
  code_reserved   = "$orange",
  code_operator   = "$gray-dark",
  code_namespace  = "$teal",
  code_identifier = "$foreground",
  code_bracket    = "$gray",
  ui_rstudio_background     = "darken($background, 2.5%)",
  ui_rstudio_foreground     = "$foreground",
  ui_selection              = "transparentize($green, 0.85)",
  ui_line_active_selection  = "$ui_selection",
  ui_console_selection      = "$ui_selection",
  ui_margin_line            = "#edeef0",
  ui_cursor                 = "transparentize($pink, 0.5)",
  ui_bracket                = "transparentize($red, 0.75)",
  ui_gutter_foreground      = "$gray",
  ui_debug_background       = "transparentize($yellow, 0.75)",
  rmd_chunk_header          = "$purple",
  rmd_heading_foreground    = "$teal",
  rmd_href                  = "$green",
  ui_completions_background = "$background",
  ui_completions_border     = "#ededed",
  ui_completions_foreground = "$foreground",
  ui_completions_selected_background = "mix($blue2, $ui_rstudio_background, 25%)",
  ui_fold_arrows_foreground = "$foreground",
  ui_fold_arrows_background = "$blue2",
  code_namespace_font_style = "italic",
  rstheme_command_palette(
    item_hover_background = "mix($blue2, $ui_command_palette_item_background)",
    item_selected_background = "$blue2"
  ),
  rstheme_large_tabs(),
  rstheme_dialog_options(heading_foreground = "$purple", help_foreground = "$blue"),
  rstheme_rainbow_parentheses(
    "$gray-dark", "$pink2", "$blue2", "$yellow", "$pink2", "$blue2"
  ),
  rstheme_terminal_colors(
    theme_dark = FALSE,
    red = "$red",
    red_bright = "$pink",
    green = "$green",
    yellow = "$yellow",
    blue = "$blue",
    blue_bright = "$blue2",
    magenta = "$purple",
    cyan = "$teal"
  ),
  '#rstudio_command_palette_list [id^="rstudio_command_entry_"] > :first-child:not([id]) {
    background-color: $red;
    .gwt-Label {
      color: $background;
    }
  }
  .ace_comment {
    font-style: italic;
  }
  body .gwt-TabLayoutPanelTab-selected {
    .gwt-TabLayoutPanelTabInner .rstheme_tabLayoutCenter {
      box-shadow: 0 2px 0 $red inset;
      border-radius: 0 !important;
    }
  }'
)


# Live Testing ------------------------------------------------------------

# make_rsthemes()
# hotload_rstheme("inst/themes/serendipity-dark.rstheme")
# hotload_rstheme("inst/themes/serendipity-light.rstheme")
