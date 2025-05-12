#' nightfox.nvim color palette(s)
#'
#' These are the official colors as listed in the
#' [nightfox.nvim repo](https://github.com/EdenEast/nightfox.nvim).
#' @source https://github.com/EdenEast/nightfox.nvim/tree/main/lua/nightfox/palette
#' @name nightfox_palettes
#'
NULL

#' @rdname nightfox_palettes
#'
palettes <- list(
  nightfox = list(
    black   = "#393b44",
    red     = "#c94f6d",
    green   = "#81b29a",
    yellow  = "#dbc074",
    blue    = "#719cd6",
    magenta = "#9d79d6",
    cyan    = "#63cdcf",
    white   = "#dfdfe0",
    orange  = "#f4a261",
    pink    = "#d67ad2",

    comment = "#738091",

    bg0     = "#131a24", # Dark bg (status line and float)
    bg1     = "#192330", # Default bg
    bg2     = "#212e3f", # Lighter bg (colorcolm folds)
    bg3     = "#29394f", # Lighter bg (cursor line)
    bg4     = "#39506d", # Conceal, border fg

    fg0     = "#d6d6d7", # Lighter fg
    fg1     = "#cdcecf", # Default fg
    fg2     = "#aeafb0", # Darker fg (status line)
    fg3     = "#71839b", # Darker fg (line numbers, fold colums)

    sel0    = "#2b3b51", # Popup bg, visual selection bg
    sel1    = "#3c5372"  # Popup sel bg, search bg
  ),
  dawnfox = list(
    black   = "#575279",
    red     = "#b4637a",
    green   = "#618774",
    yellow  = "#ea9d34",
    blue    = "#286983",
    magenta = "#907aa9",
    cyan    = "#56949f",
    white   = "#e5e9f0",
    orange  = "#d7827e",
    pink    = "#d685af",

    comment = "#9893a5",

    bg0     = "#ebe5df", # Dark bg (status line and float)
    bg1     = "#faf4ed", # Default bg
    bg2     = "#ebe0df", # Lighter bg (colorcolm folds)
    bg3     = "#ebdfe4", # Lighter bg (cursor line)
    bg4     = "#bdbfc9", # Conceal, border fg

    fg0     = "#4c4769", # Lighter fg
    fg1     = "#575279", # Default fg
    fg2     = "#625c87", # Darker fg (status line)
    fg3     = "#a8a3b3", # Darker fg (line numbers, fold colums)

    sel0    = "#d0d8d8", # Popup bg, visual selection bg
    sel1    = "#b8cece"  # Popup sel bg, search bg
  ),
  dayfox = list(
    black   = "#352c24",
    red     = "#a5222f",
    green   = "#396847",
    yellow  = "#AC5402",
    blue    = "#2848a9",
    magenta = "#6e33ce",
    cyan    = "#287980",
    white   = "#f2e9e1",
    orange  = "#955f61",
    pink    = "#a440b5",

    comment = "#837a72",

    bg0     = "#e4dcd4", # Dark bg (status line and float)
    bg1     = "#f6f2ee", # Default bg
    bg2     = "#dbd1dd", # Lighter bg (colorcolm folds)
    bg3     = "#d3c7bb", # Lighter bg (cursor line)
    bg4     = "#aab0ad", # Conceal, border fg

    fg0     = "#302b5d", # Lighter fg
    fg1     = "#3d2b5a", # Default fg
    fg2     = "#643f61", # Darker fg (status line)
    fg3     = "#824d5b", # Darker fg (line numbers, fold colums)

    sel0    = "#e7d2be", # Popup bg, visual selection bg
    sel1    = "#a4c1c2"  # Popup sel bg, search bg
  ),
  duskfox = list(
    black   = "#393552",
    red     = "#eb6f92",
    green   = "#a3be8c",
    yellow  = "#f6c177",
    blue    = "#569fba",
    magenta = "#c4a7e7",
    cyan    = "#9ccfd8",
    white   = "#e0def4",
    orange  = "#ea9a97",
    pink    = "#eb98c3",

    comment = "#817c9c",

    bg0     = "#191726", # Dark bg (status line and float)
    bg1     = "#232136", # Default bg
    bg2     = "#2d2a45", # Lighter bg (colorcolm folds)
    bg3     = "#373354", # Lighter bg (cursor line)
    bg4     = "#4b4673", # Conceal, border fg

    fg0     = "#eae8ff", # Lighter fg
    fg1     = "#e0def4", # Default fg
    fg2     = "#cdcbe0", # Darker fg (status line)
    fg3     = "#6e6a86", # Darker fg (line numbers, fold colums)

    sel0    = "#433c59", # Popup bg, visual selection bg
    sel1    = "#63577d"  # Popup sel bg, search bg
  ),
  nordfox = list(
    black   = "#3b4252",
    red     = "#bf616a",
    green   = "#a3be8c",
    yellow  = "#ebcb8b",
    blue    = "#81a1c1",
    magenta = "#b48ead",
    cyan    = "#88c0d0",
    white   = "#e5e9f0",
    orange  = "#c9826b",
    pink    = "#bf88bc",

    comment = "#60728a",

    bg0     = "#232831", # Dark bg (status line and float)
    bg1     = "#2e3440", # Default bg
    bg2     = "#39404f", # Lighter bg (colorcolm folds)
    bg3     = "#444c5e", # Lighter bg (cursor line)
    bg4     = "#5a657d", # Conceal, border fg

    fg0     = "#c7cdd9", # Lighter fg
    fg1     = "#cdcecf", # Default fg
    fg2     = "#abb1bb", # Darker fg (status line)
    fg3     = "#7e8188", # Darker fg (line numbers, fold colums)

    sel0    = "#3e4a5b", # Popup bg, visual selection bg
    sel1    = "#4f6074"  # Popup sel bg, search bg
  ),
  terafox = list(
    black   = "#2F3239",
    red     = "#e85c51",
    green   = "#7aa4a1",
    yellow  = "#fda47f",
    blue    = "#5a93aa",
    magenta = "#ad5c7c",
    cyan    = "#a1cdd8",
    white   = "#ebebeb",
    orange  = "#ff8349",
    pink    = "#cb7985",

    comment = "#6d7f8b",

    bg0     = "#0f1c1e", # Dark bg (status line and float)
    bg1     = "#152528", # Default bg
    bg2     = "#1d3337", # Lighter bg (colorcolm folds)
    bg3     = "#254147", # Lighter bg (cursor line)
    bg4     = "#2d4f56", # Conceal, border fg

    fg0     = "#eaeeee", # Lighter fg
    fg1     = "#e6eaea", # Default fg
    fg2     = "#cbd9d8", # Darker fg (status line)
    fg3     = "#587b7b", # Darker fg (line numbers, fold colums)

    sel0    = "#293e40", # Popup bg, visual selection bg
    sel1    = "#425e5e"  # Popup sel bg, search bg
  )
)

#' Create Nightfox .rstheme file
#'
#' @param style A string - the theme palette variant to use; see [Nightfox](https://github.com/EdenEast/nightfox.nvim/) -- _carbonfox_ not yet included
#' @param apply A Boolean - generate and install/apply the .rstheme file (TRUE),
#' or just save the .rstheme file without applying (FALSE); defaults to FALSE
#' @param as_sass A Boolean - save theme as .sass file and do not apply (TRUE),
#' defaults to FALSE
#' @param ... Additional arguments to pass to [rsthemes::rstheme()] overriding
#' defaults if necessary
#'
#' @export
nightfox_rstheme <- function(
    style = c("nightfox", "dawnfox", "dayfox", "duskfox", "nordfox", "terafox"),
    apply = FALSE,
    as_sass = FALSE,
    ...) {
  style <- rlang::arg_match(style)

  dark <- !(style %in% c("dawnfox", "dayfox"))

  nf_pal <- palettes[[style]]

  lighten_factor <- 5
  darken_factor <- 5
  .lighten <- function(nm, by = lighten_factor) {
    sprintf("lighten($%s, %s%%)", nm, by)
  }
  .darken <- function(nm, by = darken_factor) {
    sprintf("darken($%s, %s%%)", nm, by)
  }

  theme_palette <- list(
    # UI
    bg0 = nf_pal$bg0,
    bg1 = nf_pal$bg1,
    bg2 = nf_pal$bg2,
    bg3 = nf_pal$bg3,
    bg4 = nf_pal$bg4,
    bg = "$bg1",
    bg_dim = "$bg0",
    fg0 = nf_pal$fg0,
    fg1 = nf_pal$fg1,
    fg2 = nf_pal$fg2,
    fg3 = nf_pal$fg3,
    fg = "$fg1",
    fg_dim = "$fg3",
    ui_sel = nf_pal$sel1,
    pal_cursor_line = "$bg3",
    vis_sel = nf_pal$sel0,
    # Terminal colors
    red = nf_pal$red,
    orange = nf_pal$orange, # not used by terminal colors
    green = nf_pal$green,
    yellow = nf_pal$yellow,
    blue = nf_pal$blue,
    magenta = nf_pal$magenta,
    cyan = nf_pal$cyan,
    white = nf_pal$white,
    black = nf_pal$black,
    # Color variants
    red_dark = .darken("red"),
    orange_dark = .darken("orange"),
    green_dark = .darken("green"),
    yellow_dark = .darken("yellow"),
    blue_dark = .darken("blue"),
    magenta_dark = .darken("magenta"),
    cyan_dark = .darken("cyan"),
    red_bright = .lighten("red"),
    orange_bright = .lighten("orange"),
    green_bright = .lighten("green"),
    yellow_bright = .lighten("yellow"),
    blue_bright = .lighten("blue"),
    magenta_bright = .lighten("magenta"),
    cyan_bright = .lighten("cyan"),
    # Code
    pal_comments = nf_pal$comment,
    pal_messages = "$orange",
    pal_errors = "$red",
    pal_operators = "$fg2",
    pal_punctuation = "$fg1",
    pal_variables = "$white",
    pal_strings = "$green",
    pal_values = "$orange",
    pal_booleans = "$orange_bright",
    pal_functions = "$blue_bright",
    pal_conditionals = "$magenta_bright",
    pal_keywords = "$magenta",
    pal_namespaces = "$cyan",
    pal_tags = "$orange",
    pal_types = "$yellow",
    pal_methods = "$green",
    pal_parameters = "$fg"
  )

  theme_file <- paste0(tolower(style), if (as_sass) ".scss" else ".rstheme")

  theme_apply <- apply && !as_sass
  theme_as_sass <- as_sass
  theme_path <- here::here(
    if (as_sass) "inst/templates" else "inst/themes",
    theme_file
  )

  theme_args <- list(
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ##  THEME META                                          >>
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    theme_name = paste0(tools::toTitleCase(style)),
    theme_dark = dark,
    theme_flat = TRUE,
    theme_palette = theme_palette,
    theme_as_sass = theme_as_sass,
    theme_apply = theme_apply,
    theme_path = theme_path,
    #
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ##  UI                                                  >>
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ## -----------------------------------------
    ##  RStudio                              --
    ## -----------------------------------------
    ui_background = "$bg",
    ui_foreground = "$fg",
    ui_rstudio_background = "$bg0",
    ui_rstudio_foreground = "$fg_dim",
    ui_rstudio_tabs_inactive_background = "$bg0",
    ui_rstudio_tabs_inactive_hover_background = "$bg",
    ui_rstudio_tabs_inactive_foreground = "$fg2",
    ui_rstudio_tabs_active_background = "$bg1",
    ui_rstudio_tabs_active_foreground = "$fg",
    ui_rstudio_scrollbar_background = "$bg0",
    ui_rstudio_scrollbar_handle = "$bg4",
    #
    ## ----------------------------------------
    ##  Interactions                        --
    ## ----------------------------------------
    ui_cursor = "$fg0",
    ui_selection = "$vis_sel",
    ui_console_selection = "$ui_sel",
    #
    ## ----------------------------------------
    ##  Guides                              --
    ## ----------------------------------------
    ui_line_active = "$pal_cursor_line",
    ui_line_active_selection = .lighten("vis_sel", 10),
    ui_bracket = "transparentize($fg2, 0.8)",
    ui_invisible = "$fg3",
    ui_margin_line = "$bg4",
    ui_gutter_background = "$bg0",
    ui_gutter_foreground = "$fg3",
    ui_debug_background = "$yellow_dark",
    ui_completions_background = "transparentize($bg, 0.4)",
    ui_completions_foreground = "$fg2",
    ui_completions_border = "$bg4",
    ui_completions_selected_background = "transparentize($ui_sel, 0.4)",
    ui_completions_selected_foreground = "$fg0",
    ui_fold_arrows_foreground = "$fg3",
    ui_fold_arrows_background = "$bg2",
    #
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ##  CODE                                                >>
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    code_string = "$pal_strings",
    code_namespace = "$pal_namespaces",
    code_namespace_font_style = "italic",
    code_function = "$pal_functions",
    code_value = "$pal_values",
    code_comment = "$pal_comments",
    code_variable = "$pal_variables",
    # RStudio currently colors messages and Boolean values the same.
    # This is fixed below with the .ace_constant.ace_language selector.
    code_message = "$pal_messages",
    code_reserved = "$pal_conditionals",
    code_operator = "$pal_operators",
    code_identifier = "$fg",
    code_bracket = "$fg",
    #
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ##  RMD                                                >>
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    rmd_chunk_background = .darken("bg", 2),
    rmd_heading_foreground = "$pal_tags",
    rmd_chunk_header = "$fg3",
    rmd_href = "$fg2",
    #
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ##  SCSS / PARTIALS                                    >>
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ## -----------------------------------------
    ##  Command palette                      --
    ## -----------------------------------------
    rsthemes::rstheme_command_palette(
      item_hover_background = "$ui_sel",
      item_selected_background = "$bg3"
    ),
    #
    ## -----------------------------------------
    ##  Rainbow parentheses                  --
    ## -----------------------------------------
    rsthemes::rstheme_rainbow_parentheses(
      "$fg1",
      "$orange_bright",
      "$green_bright",
      "$yellow_bright",
      "$blue_bright",
      "$magenta_bright",
      "$cyan_bright"
    ),
    #
    ## ----------------------------------------
    ##  Use large tabs                      --
    ## ----------------------------------------
    rsthemes::rstheme_large_tabs(),
    #
    ## ----------------------------------------
    ##  Dialog options                      --
    ## ----------------------------------------
    rsthemes::rstheme_dialog_options(
      background = "$bg",
      foreground = "$fg2",
      heading_foreground = "$rmd_heading_foreground",
      help_foreground = "$fg_dim",
      border = "$bg4",
      selected_background = "$bg3",
      button_border = "$bg4",
      input_border = "$bg4",
      input_background = "$bg0",
      input_foreground = "$pal_strings",
      checkbox_background = "$bg0",
      select_background = "$bg0"
    ),
    #
    ## -----------------------------------------
    ##  Terminal colors                      --
    ## -----------------------------------------
    rsthemes::rstheme_terminal_colors(
      theme_dark = TRUE,
      red = "$red",
      red_bright = "$red_bright",
      green = "$green",
      green_bright = "$green_bright",
      yellow = "$yellow",
      yellow_bright = "$yellow_bright",
      blue = "$blue",
      blue_bright = "$blue_bright",
      cyan = "$cyan",
      cyan_bright = "$cyan_bright",
      magenta = "$magenta",
      magenta_bright = "$magenta_bright",
      white = "$white",
      black = "$black",
      black_bright = "$fg"
    ),
    #
    ## -----------------------------------------
    ##  Flat theme extras                    --
    ## -----------------------------------------
    # I used this snippet found in the the `rsthemes` Elm theme code at
    # https://github.com/gadenbuie/rsthemes inst/templates/elm.R
    # - add light bar, remove tab outline
    "
    .rstudio-themes-flat .gwt-TabLayoutPanelTab-selected {
      .gwt-TabLayoutPanelTabInner .rstheme_tabLayoutCenter {
        box-shadow: 0 3px 0 $ui_sel inset;
        border-radius: 0 !important;
      }
    }
    ",
    # - dim the file icon when not selected
    "
    .rstudio-themes-flat .gwt-TabLayoutPanelTab:not(.gwt-TabLayoutPanelTab-selected):not(:hover) .rstheme_tabLayoutCenter img {
      opacity: 0.5;
    }
      ",
    # - put more space between file icon and file name
    "
    .rstudio-themes-flat .gwt-TabLayoutPanelTab .rstheme_tabLayoutCenter td:first-child > img {
      position: relative;
      left: -5px;
    }
    ",
    # - fix light text on light background in Update Packages dialog
    #   and dark text for some headings and help text in Options dialog
    '
    .gwt-DialogBox {
      &[aria-label="Update Packages"] table[role="presentation"] tbody {
        color: $fg2;
      }
      & table[role="presentation"] .gwt-Label {
        color: $rmd_heading_foreground;
      }
    }
    ',
    # - command palette tweaks, table color, highlighting of recent command
    '
    .rstudio-themes-flat .gwt-PopupPanel .popupContent
    #rstudio_command_palette_list [aria-selected="true"] {
      &, [id^="rstudio_command_entry"], table .gwt-Label, table td {
        color: $ui_completions_selected_foreground;
      }
    }
    .rstudio-themes-flat .popupContent [id^="rstudio_command"] [id^="rstudio_command_entry_"] {
      & > div:first-child:not([id^="rstudio_command_entry_"]) {
        background-color: $cyan;
        .gwt-Label {
          color: $bg;
        }
      }
      .gwt-Label.rstudio-fixed-width-font {
        color: $fg_dim;
      }
    }
    ',
    # - changes to code styling
    '
    .ace_keyword {
      font-weight: 300;
    }
    .ace_function {
      font-weight: 300;
    }
    .ace_comment {
      font-style: italic;
    }
    .ace_constant {
      color: $orange_bright;
    }
    .ace_constant.ace_language {
      font-weight: 300;
      color: $pal_booleans;
    }
    .ace_constant.ace_numeric {
      font-color: $pal_values;
    }
    .ace_bracket {
      margin: -1px 0 0 -1px !important;
      padding: 1px;
      border: 0 !important;
      border-radius: 1;
    }
    ',
    '
    [class~="sourceCode"] {
      background-clip: text !important;
    }
    '
  )
  theme_args <- modifyList(theme_args, list(...))
  do.call(rsthemes::rstheme, theme_args)
}

purrr::walk(
  c("nightfox", "dawnfox", "dayfox", "duskfox", "nordfox", "terafox"),
  function(style) {
    nightfox_rstheme(style = style, as_sass = TRUE)
  }
)
