embark_official <- list(
  # Space
  space1 = "#100E23",
  space2 = "#1E1C31",
  space3 = "#2D2B40",
  space4 = "#3E3859",
  space5 = "#585273",
  # Astral
  astral1 = "#8A889D",
  astral2 = "#CBE3E7",
  # Nebula
  nebula01 = "#F48FB1",
  nebula02 = "#A1EFD3",
  nebula03 = "#FFE6B3",
  nebula04 = "#91DDFF",
  nebula05 = "#D4BFFF",
  nebula06 = "#ABF8F7",
  nebula07 = "#F02E6E",
  nebula08 = "#7FE9C3",
  nebula09 = "#F2B482",
  nebula10 = "#78A8FF",
  nebula11 = "#7676FF",
  nebula12 = "#63F2F1"
)

embark <- c(
  embark_official,
  list(
    bg = embark_official$space2,
    bg_dark = embark_official$space1,
    bg_light = embark_official$space3,
    accent_dark = embark_official$space4,
    accent_light = embark_official$space5,
    fg = embark_official$astral2,
    fg_dark = embark_official$astral1,
    red = embark_official$nebula01,
    red_dark = embark_official$nebula07,
    green = embark_official$nebula02,
    green_dark = embark_official$nebula08,
    yellow = embark_official$nebula03,
    yellow_dark = embark_official$nebula09,
    blue = embark_official$nebula04,
    blue_dark = embark_official$nebula10,
    purple = embark_official$nebula05,
    purple_dark = embark_official$nebula11,
    cyan = embark_official$nebula06,
    cyan_dark = embark_official$nebula12
  )
)

rsthemes::rstheme(
  ##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ##  THEME META                                          >>
  ##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  theme_name    = "Embark",
  theme_dark    = TRUE,
  theme_flat    = TRUE,
  theme_palette = embark,
  theme_as_sass = FALSE,
  theme_apply   = FALSE,
  theme_path    = here::here("inst/themes/embark.rstheme"),
  #
  ##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ##  UI                                                  >>
  ##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ##-----------------------------------------
  ##  RStudio                              --
  ##-----------------------------------------
  ui_background                             = "$bg",
  ui_foreground                             = "$fg",
  ui_rstudio_background                     = "darken($bg, 2.5%)",
  ui_rstudio_foreground                     = "$fg",
  ui_rstudio_tabs_inactive_background       = "$bg",
  ui_rstudio_tabs_inactive_hover_background = "lighten($bg, 2%)",
  ui_rstudio_tabs_inactive_foreground       = "$fg_dark",
  ui_rstudio_tabs_active_background         = "$bg_light",
  ui_rstudio_tabs_active_foreground         = "$fg",
  #
  ##----------------------------------------
  ##  Interactions                        --
  ##----------------------------------------
  ui_cursor             = "transparentize($cyan, 0.25)",
  ui_selection          = "transparentize($red, 0.5)",
  ui_console_selection  = "$ui_selection",
  #
  ##----------------------------------------
  ##  Guides                              --
  ##----------------------------------------
  ui_line_active                      = "lighten($bg_light, 5%)",
  ui_line_active_selection            = "$ui_selection",
  ui_bracket                          = "transparentize($red, 0.6)",
  ui_invisible                        = "$accent_dark",
  ui_margin_line                      = "$accent_dark",
  ui_gutter_background                = "lighten($bg, 2%)",
  ui_gutter_foreground                = "$fg_dark",
  ui_debug_background                 = "transparentize($yellow, 0.75)",
  ui_completions_background           = "transparentize($bg, 0.25)",
  ui_completions_foreground           = "$fg",
  ui_completions_border               = "$accent_light",
  ui_completions_selected_background  = "$bg_light",
  ui_completions_selected_foreground  = "$fg",
  ui_fold_arrows_foreground           = "$fg",
  ui_fold_arrows_background           = "$accent_dark",
  #
  ##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ##  CODE                                                >>
  ##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  code_string               = "$purple",
  code_namespace            = "$cyan",
  code_namespace_font_style = "italic",
  code_function             = "$yellow",
  code_value                = "$green",
  code_comment              = "$fg_dark",
  code_variable             = "$cyan_dark",
  code_message              = "$red",
  code_reserved             = "$yellow",
  code_operator             = "$yellow_dark",
  code_identifier           = "$fg",
  code_bracket              = "$fg_dark",
  #
  ##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ##  RMD                                                >>
  ##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  rmd_chunk_background    = "$bg_light",
  rmd_heading_foreground  = "$cyan_dark",
  rmd_chunk_header        = "$purple",
  rmd_href                = "$green_dark",
  #
  ##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ##  SCSS / PARTIALS                                    >>
  ##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ##-----------------------------------------
  ##  Command palette                      --
  ##-----------------------------------------
  rsthemes::rstheme_command_palette(
    item_hover_background = "lighten($bg, 5%)",
    item_selected_background = "$accent_dark"
  ),
  #
  ##-----------------------------------------
  ##  Rainbow parentheses                  --
  ##-----------------------------------------
  rsthemes::rstheme_rainbow_parentheses(
    "$fg_dark",
    "$purple",
    "$green_dark",
    "$red",
    "$yellow",
    "$blue_dark",
    "$fg"
  ),
  #
  ##----------------------------------------
  ##  Use large tabs                      --
  ##----------------------------------------
  rsthemes::rstheme_large_tabs(),
  #
  ##----------------------------------------
  ##  Dialog options                      --
  ##----------------------------------------
  rsthemes::rstheme_dialog_options(
    heading_foreground = "$rmd_heading_foreground",
    help_foreground = "$fg_dark",
    border = "$bg_light",
    selected_background = "$bg_light",
    button_border = "$bg_light",
    button_hover_background = "lighten($bg, 2%)",
    input_border = "$accent_dark",
    input_background = "$bg_light",
    input_foreground = "$code_string",
    checkbox_background = "$accent_light",
    select_background = "$bg_light"
  ),
  #
  ##-----------------------------------------
  ##  Terminal colors                      --
  ##-----------------------------------------
  rsthemes::rstheme_terminal_colors(
    theme_dark = TRUE,
    red = "$red_dark",
    red_bright = "$red",
    green = "$green_dark",
    green_bright = "$green",
    yellow = "$yellow_dark",
    yellow_bright = "$yellow",
    blue = "$blue_dark",
    blue_bright = "$blue",
    cyan = "$cyan_dark",
    cyan_bright = "$cyan",
    magenta = "$purple_dark",
    magenta_bright = "$purple",
    white = "darken($fg, 10%)",
    white_bright = "darken($fg, 5%)",
    black = "$accent_light",
    black_bright = "lighten($accent_light, 10%)"
  ),
  #
  ##-----------------------------------------
  ##  Flat theme extras                    --
  ##-----------------------------------------
  # I used this snippet found in the the `rsthemes` Elm theme code at
  # https://github.com/gadenbuie/rsthemes inst/templates/elm.R
  # In order:
  # - add light bar, remove tab outline
  # - dim the file icon when not selected
  # - put more space between file icon and file name
  '
  .rstudio-themes-flat .gwt-TabLayoutPanelTab-selected {
    .gwt-TabLayoutPanelTabInner .rstheme_tabLayoutCenter {
      box-shadow: 0 3px 0 $cyan inset;
      border-radius: 0 !important;
      .gwt-Label {
        \\ font-weight: 600;
        \\ color: $fg;
      }
    }
  }
  .rstudio-themes-flat .gwt-TabLayoutPanelTab:not(.gwt-TabLayoutPanelTab-seected):not(:hover) .rstheme_tabLayoutCenter img {
    opacity: 0.5;
  }
  .rstudio-themes-flat .gwt-TabLayoutPanelTab .rstheme_tabLayoutCenter td:fist-child > img {
    position: relative;
    left: -5px;
  }
  ',
  '
  .rstudio-themes-flat .gwt-PopupPanel .popupContent
  #rstudio_command_palette_list [aria-selected="true"] {
    &, [id^="rstudio_command_entry"], table .gwt-Label, table td {
      color: $ui_completions_selected_foreground;
    }
  }
  .rstudio-themes-flat .popupContent [id^="rstudio_command"] [id^="rtudio_command_entry_"] {
    & > div:first-child:not([id^="rstudio_command_entry_"]) {
      background-color: $cyan;
      .gwt-Label {
        color: $bg;
      }
    }
    .gwt-Label.rstudio-fixed-width-font {
      color: $fg_dark;
    }
  }
  ',
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
    margin: -1px 0 0 0 !important;
    padding: 0px;
    border: 0 !important;
    border-radius: 1;
  }
  '
)
