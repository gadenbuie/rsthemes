THEME_APPLY <- NULL #"dark"

elm_colors <- list(
  "red-100"    = "#fff8f9",
  "red-90"     = "#fee8eb",
  "red-80"     = "#fdc7cd",
  "red-70"     = "#fca4ae",
  "red-60"     = "#fb7e8c",
  "red-50"     = "#f54f61",
  "red-40"     = "#c94150",
  "red-30"     = "#a83643",
  "red-20"     = "#852b35",
  "red-10"     = "#6a222a",
  "orange-100" = "#fef9f2",
  "orange-90"  = "#fdebd3",
  "orange-80"  = "#f9cd91",
  "orange-70"  = "#f5ae4b",
  "orange-60"  = "#ef8c02",
  "orange-50"  = "#cb7702",
  "orange-40"  = "#a76101",
  "orange-30"  = "#8b5101",
  "orange-20"  = "#6e4001",
  "orange-10"  = "#573301",
  "green-100"  = "#f6fbf7",
  "green-90"   = "#e2f2e3",
  "green-80"   = "#b9deb9",
  "green-70"   = "#93ca8d",
  "green-60"   = "#7ab26f",
  "green-50"   = "#69965d",
  "green-40"   = "#587b4b",
  "green-30"   = "#4b663d",
  "green-20"   = "#3c5130",
  "green-10"   = "#304025",
  "blue-100"   = "#f7fafb",
  "blue-90"    = "#e4f0f1",
  "blue-80"    = "#bed9de",
  "blue-70"    = "#97c4ca",
  "blue-60"    = "#71aeb7",
  "blue-50"    = "#4896a1",
  "blue-40"    = "#1c7d8b",
  "blue-30"    = "#0e6876",
  "blue-20"    = "#0b535d",
  "blue-10"    = "#09414a",
  "purple-100" = "#fafafb",
  "purple-90"  = "#ededf1",
  "purple-80"  = "#d4d3dd",
  "purple-70"  = "#bcbac9",
  "purple-60"  = "#a4a2b6",
  "purple-50"  = "#8a88a2",
  "purple-40"  = "#716f8e",
  "purple-30"  = "#5e5b7f",
  "purple-20"  = "#4a466f",
  "purple-10"  = "#3a3662",
  "pink-100"   = "#fdf9fb",
  "pink-90"    = "#f9e9f3",
  "pink-80"    = "#f1c9e1",
  "pink-70"    = "#e9a9cf",
  "pink-60"    = "#e088bd",
  "pink-50"    = "#d661a7",
  "pink-40"    = "#b0508a",
  "pink-30"    = "#934373",
  "pink-20"    = "#74355b",
  "pink-10"    = "#5c2a48",
  "slate-100"  = "#f9fafa",
  "slate-90"   = "#ebeeef",
  "slate-80"   = "#cfd5d8",
  "slate-70"   = "#b3bec2",
  "slate-60"   = "#99a6ac",
  "slate-50"   = "#7c8e95",
  "slate-40"   = "#60757e",
  "slate-30"   = "#4a636c",
  "slate-20"   = "#334f5a",
  "slate-10"   = "#213f4b",
  "slate-00"   = "#0e181e"
)

elm_light <- rstheme(
  "Elm light",
  theme_dark    = FALSE,
  theme_flat    = TRUE,
  theme_apply   = identical(THEME_APPLY, "light"),
  theme_as_sass = FALSE,
  theme_path    = here::here("inst/themes/elm-light.rstheme"),
  theme_palette = elm_colors,

  ui_background   = "$slate-100",
  ui_foreground   = "$slate-00",

  code_string     = "$green-40",
  code_string_background = "transparentize($green-90, 0.4)",
  code_function   = "$blue-20",
  code_function_background = "transparentize($blue-90, 0.4)",
  code_reserved      = "$red-30",
  code_comment    = "$slate-30",
  code_variable   = "$red-30",
  code_variable_background = "transparentize($red-90, 0.3)",
  code_message    = "$red-40",
  code_value   = "$pink-30",
  code_value_background = "transparentize($pink-90, 0.4)",
  code_operator   = "$orange-50",
  code_namespace  = "$purple-10",
  # code_namespace_background = "transparentize($purple-80, 0.66)",
  code_identifier = "$slate-20",
  code_bracket    = "$slate-20",

  ui_rstudio_background     = "$slate-90",
  ui_rstudio_foreground     = "$slate-10",
  ui_selection              = "transparentize($blue-80, 0.5)",
  ui_console_selection      = "$ui_selection",
  ui_line_active            = "transparentize($blue-80, 0.85)",
  ui_line_active_selection  = "$ui_selection",
  ui_margin_line            = "$slate-90",
  ui_cursor                 = "$pink-60",
  ui_rstudio_job_progress_bar = "$blue-60",

  ui_rstudio_scrollbar_handle         = "$ui_rstudio_background",
  ui_rstudio_tabs_inactive_foreground = "$slate-30",
  ui_rstudio_tabs_inactive_background = "$slate-90",
  ui_rstudio_tabs_active_background   = "mix($slate-90, $slate-100, 20%)",
  ui_gutter_foreground                = "$slate-60",
  ui_invisible                        = "$slate-70",
  ui_fold_arrows_foreground           = "$red-70",
  ui_fold_arrows_background           = "$red-20",
  ui_bracket                          = "$red-80",
  ui_completions_selected_foreground  = "$purple-10",
  ui_completions_selected_background  = "mix($ui_completions_background, $purple-80, 30%)",
  ui_debug_background                 = "mix($ui_background, $pink-80, 60%)",
  rmd_chunk_header                    = "$blue-30",
  rmd_chunk_background                = "darken($slate-100, 2%)",
  rmd_heading_foreground              = "$pink-30",
  rmd_heading_background              = "$pink-90",
  rmd_href                            = "$pink-30",
  rmd_heading_weight                  = "600",

  rstheme_rainbow_parentheses(
    "$slate-20", "$blue-30", "$red-20", "$green-50", "$purple-40", "$orange-50", "$pink-30"
  ),
  rstheme_command_palette(
    item_selected_background = "$ui_completions_selected_background",
    item_hover_background = "mix($ui_completions_background, $ui_completions_selected_background, 50%)"
  ),
  rstheme_dialog_options(),
  rstheme_large_tabs(),
  rstheme_terminal_colors(
    theme_dark = FALSE,
    red = "$red-40",
    red_bright = "$red-70",
    green = "$green-50",
    green_bright = "$green-70",
    blue= "$blue-40",
    blue_bright = "$blue-70",
    yellow = "$orange-60",
    yellow_bright = "$orange-70",
    magenta= "$pink-40",
    magenta_bright = "$pink-70",
    cyan= "$purple-40",
    cyan_bright = "$purple-70",
    black = "$slate-00",
    black_bright = "$slate-10",
    white = "$slate-70",
    white_bright = "$slate-80"
  ),

  '
[class="ace_keyword"] {
	font-weight: 600;
}
.ace_function {
  font-weight: 600;
}
.ace_comment {
  font-style: italic;
}
.ace_bracket {
  margin: -1px 0 0 -1px !important;
  padding: 1px;
  border: 0 !important;
  border-radius: 0;
}
*::-webkit-scrollbar-thumb:hover {
  background-color: mix($slate-100, $blue-40, 70%) !important;
}
#rstudio_shell_widget table[role="presentation"] {
  background-color: $slate-100 !important;
}
.rstudio-themes-flat .gwt-TabLayoutPanelTab-selected {
  .gwt-TabLayoutPanelTabInner .rstheme_tabLayoutCenter {
    box-shadow: 0px 3px 0 $blue-50 inset;
    border-radius: 0 !important;

    .gwt-Label {
      // font-weight: 600;
      color: $blue-10;
    }
  }
}
.rstudio-themes-flat .gwt-TabLayoutPanelTab:not(.gwt-TabLayoutPanelTab-selected):not(:hover) .rstheme_tabLayoutCenter img {
  opacity: 0.5;
}
.rstudio-themes-flat .gwt-TabLayoutPanelTab .rstheme_tabLayoutCenter td:first-child > img {
  position: relative;
  left: -5px;
}
.rstudio-themes-flat .gwt-PopupPanel .popupContent #rstudio_command_palette_list [aria-selected="true"] {
  &, [id^="rstudio_command_entry"], table .gwt-Label, table td {
    color: $ui_completions_selected_foreground;
  }
}
.rstudio-themes-flat .popupContent [id^="rstudio_command"] [id^="rstudio_command_entry_"] {
  & > div:first-child:not([id^="rstudio_command_entry_"]) {
    background-color: $purple-90;
    .gwt-Label {
      color: $purple-30;
    }
  }
  .gwt-Label.rstudio-fixed-width-font {
    color: $pink-20;
    background-color: $pink-90;
  }
}
'
)

elm_dark <- rstheme(
  "Elm dark",
  theme_dark    = TRUE,
  theme_flat    = TRUE,
  theme_apply   = identical(THEME_APPLY, "dark"),
  theme_as_sass = FALSE,
  theme_path    = here::here("inst/themes/elm-dark.rstheme"),
  theme_palette = elm_colors,

  ui_background   = "$slate-00",
  ui_foreground   = "$slate-80",

  code_string     = "$green-80",
  code_function   = "$blue-60",
  code_reserved   = "$red-70",
  code_comment    = "$slate-60",
  code_variable   = "$red-60",
  code_message    = "$red-60",
  code_value      = "$pink-70",
  code_operator   = "$orange-80",
  code_namespace  = "$pink-70",
  code_identifier = "$slate-80",
  code_bracket    = "$slate-80",

  ui_rstudio_background     = "$slate-00",
  ui_rstudio_foreground     = "$slate-60",

  ui_selection                        = "transparentize($purple-30, 0.8)",
  ui_console_selection                = "$ui_selection",
  ui_line_active                      = "transparentize($slate-10, 0.75)",
  ui_line_active_selection            = "$ui_selection",
  ui_margin_line                      = "transparentize($slate-10, 0.66)",
  ui_cursor                           = "$orange-40",
  ui_rstudio_scrollbar_handle         = "mix($slate-00, $blue-10, 70%)",
  ui_rstudio_tabs_inactive_foreground = "$slate-70",
  ui_rstudio_tabs_inactive_background = "$slate-00",
  ui_rstudio_tabs_active_background   = "mix($slate-00, $slate-10, 85%)",
  ui_gutter_foreground                = "$slate-30",
  ui_invisible                        = "$slate-10",
  ui_bracket                          = "$slate-10",
  ui_fold_arrows_foreground           = "$red-20",
  ui_fold_arrows_background           = "$red-70",
  ui_completions_selected_background  = "mix($ui_completions_background, $purple-20, 50%)",
  ui_completions_selected_foreground  = "$purple-80",
  ui_rstudio_job_progress_bar         = "$blue-30",
  ui_debug_background                 = "mix($ui_background, $pink-30, 60%)",
  rmd_chunk_header                    = "$blue-60",
  rmd_chunk_background                = "lighten($slate-00, 2%)",
  rmd_heading_foreground              = "$pink-80",
  rmd_href                            = "$pink-80",
  rmd_heading_weight                  = "600",

  rstheme_command_palette(
    item_selected_background = "$ui_completions_selected_background",
    item_hover_background = "mix($ui_completions_background, $ui_completions_selected_background, 50%)"
  ),
  rstheme_dialog_options(),
  rstheme_large_tabs(),
  rstheme_rainbow_parentheses(
    "$slate-20", "$blue-40", "$red-40", "$green-60", "$purple-50", "$orange-60", "$pink-40"
  ),
  rstheme_terminal_colors(
    theme_dark = FALSE,
    red = "$red-40",
    red_bright = "$red-60",
    green = "$green-40",
    green_bright = "$green-70",
    blue= "$blue-40",
    blue_bright = "$blue-70",
    yellow = "$orange-50",
    yellow_bright = "$orange-70",
    magenta= "$pink-40",
    magenta_bright = "$pink-70",
    cyan= "$purple-40",
    cyan_bright = "$purple-50",
    black = "$slate-10",
    black_bright = "$slate-30",
    white = "$slate-80",
    white_bright = "$slate-100"
  ),

  '
[class="ace_keyword"] {
	font-weight: 600;
}
.ace_function {
  font-weight: 600;
}
.ace_comment {
  font-style: italic;
}
.ace_bracket {
  margin: -2px 0 0 -2px !important;
  padding: 1px;
  border: 1px solid $pink-40 !important;
  border-radius: 0;
  background-color: black;
}
*::-webkit-scrollbar-thumb:hover {
  background-color: mix($slate-00, $blue-10, 30%) !important;
}
#rstudio_shell_widget {
  border-color: $slate-00;
  table[role="presentation"] {
    background-color: $slate-00 !important;
  }
}
.rstudio-themes-flat .gwt-TabLayoutPanelTab-selected {
  .gwt-TabLayoutPanelTabInner .rstheme_tabLayoutCenter {
    box-shadow: 0px 3px 0 $blue-40 inset;
    border-radius: 0 !important;

    .gwt-Label {
      // font-weight: 600;
      color: $blue-90;
    }
  }
}
.rstudio-themes-dark .gwt-TabLayoutPanelTab:not(.gwt-TabLayoutPanelTab-selected):not(:hover) .rstheme_tabLayoutCenter img {
  opacity: 0.5;
}
.rstudio-themes-dark .gwt-TabLayoutPanelTab .rstheme_tabLayoutCenter td:first-child > img {
  position: relative;
  left: -5px;
}
.rstudio-themes-flat .gwt-PopupPanel .popupContent #rstudio_command_palette_list [aria-selected="true"] {
  &, [id^="rstudio_command_entry"], table .gwt-Label, table td {
    color: $ui_completions_selected_foreground;
  }
}
.rstudio-themes-flat .popupContent [id^="rstudio_command"] [id^="rstudio_command_entry_"] {
  & > div:first-child:not([id^="rstudio_command_entry_"]) {
    background-color: $purple-20;
    .gwt-Label {
      color: $purple-80;
    }
  }
  .gwt-Label.rstudio-fixed-width-font {
    color: $pink-80;
  }
}
'
)
