#' Everforest official color palette(s)
#'
#' These are the official colors as listed on the
#' [Everforest palette page](https://github.com/sainnhe/everforest/blob/master/palette.md).
#' @source https://github.com/sainnhe/everforest
#' @name everforest_palette
#'
NULL

#' @rdname everforest_palette
#'
dark_foreground <- list(
  fg = "#d3c6aa",
  red = "#e67e80",
  orange = "#e69875",
  yellow = "#dbbc7f",
  green = "#a7c080",
  aqua = "#83c092",
  blue = "#7fbbb3",
  purple = "#d699b6",
  grey_0 = "#7a8478",
  grey_1 = "#859289",
  grey_2 = "#9da9a0",
  statusline_1 = "#a7c080",
  statusline_2 = "#d3c6aa", # unused in RStudio
  statusline_3 = "#e67e80" # unused in RStudio
)

#' @rdname everforest_palette
#'
dark_background <- list(
  hard = list(
    bg_dim = "#1e2326",
    bg_0 = "#272e33",
    bg_1 = "#2e383c",
    bg_2 = "#374145",
    bg_3 = "#414b50",
    bg_4 = "#495156",
    bg_5 = "#4f5b58", # not currently used
    bg_visual = "#4c3743",
    bg_red = "#493b40",
    bg_green = "#3c4841",
    bg_blue = "#384b55",
    bg_yellow = "#45443c"
  ),
  medium = list(
    bg_dim = "#232a2e",
    bg_0 = "#2d353b",
    bg_1 = "#343f44",
    bg_2 = "#3d484d",
    bg_3 = "#475258",
    bg_4 = "#4f585e",
    bg_5 = "#56635f", # not currently used
    bg_visual = "#543a48",
    bg_red = "#514045",
    bg_green = "#425047",
    bg_blue = "#3a515d",
    bg_yellow = "#4d4c43"
  ),
  soft = list(
    bg_dim = "#293136",
    bg_0 = "#333c43",
    bg_1 = "#3a464c",
    bg_2 = "#434f55",
    bg_3 = "#4d5960",
    bg_4 = "#555f66",
    bg_5 = "#5d6b66", # not currently used
    bg_visual = "#5c3f4f",
    bg_red = "#59464c",
    bg_green = "#48584e",
    bg_blue = "#3f5865",
    bg_yellow = "#55544a"
  )
)

#' @rdname everforest_palette
#'
light_foreground <- list(
  fg = "#5c6a72",
  red = "#f85552",
  orange = "#f57d26",
  yellow = "#dfa000",
  green = "#8da101",
  aqua = "#35a77c",
  blue = "#3a94c5",
  purple = "#df69ba",
  grey_0 = "#a6b0a0",
  grey_1 = "#939f91",
  grey_2 = "#829181",
  statusline_1 = "#93b259",
  statusline_2 = "#708089", # unused in RStudio
  statusline_3 = "#e66868" # unused in RStudio
)

#' @rdname everforest_palette
#'
light_background <- list(
  hard = list(
    bg_dim = "#f2efdf",
    bg_0 = "#fffbef",
    bg_1 = "#f8f5e4",
    bg_2 = "#f2efdf",
    bg_3 = "#edeada",
    bg_4 = "#e8e5d5",
    bg_5 = "#bec5b2",# not currently used
    bg_visual = "#f0f2d4",
    bg_red = "#ffe7de",
    bg_green = "#f3f5d9",
    bg_blue = "#ecf5ed",
    bg_yellow = "#fef2d5"
  ),
  medium = list(
    bg_dim = "#efebd4",
    bg_0 = "#fdf6e3",
    bg_1 = "#f4f0d9",
    bg_2 = "#efebd4",
    bg_3 = "#e6e2cc",
    bg_4 = "#e0dcc7",
    bg_5 = "#bdc3af", # not currently used
    bg_visual = "#eaedc8",
    bg_red = "#fbe3da",
    bg_green = "#f0f1d2",
    bg_blue = "#e9f0e9",
    bg_yellow = "#faedcd"
  ),
  soft = list(
    bg_dim = "#e5dfc5",
    bg_0 = "#f3ead3",
    bg_1 = "#eae4ca",
    bg_2 = "#e5dfc5",
    bg_3 = "#ddd8be",
    bg_4 = "#d8d3ba",
    bg_5 = "#b9c0ab", # not currently used
    bg_visual = "#e1e4bd",
    bg_red = "#f4dbd0",
    bg_green = "#e5e6c5",
    bg_blue = "#e1e7dd",
    bg_yellow = "#f1e4c5"
  )
)

#' Create Everforest .rstheme file
#'
#' @param dark A Boolean - use dark (TRUE) or light (FALSE) theme;
#' defaults to TRUE
#' @param variant A string - the theme palette variant to use
#' (hard, medium, soft); see [Everforest](https://github.com/sainnhe/everforest)
#' @param apply A Boolean - generate and install/apply the .rstheme file (TRUE),
#' or just save the .rstheme file without applying (FALSE); defaults to FALSE
#' @param as_sass A Boolean - save theme as .sass file and do not apply (TRUE),
#' defaults to FALSE
#' @param ... Additional arguments to pass to [rsthemes::rstheme()] overriding
#' defaults if necessary
#'
#' @export
everforest_rstheme <- function(
    dark = TRUE,
    variant = "medium",
    apply = FALSE,
    as_sass = FALSE,
    ...) {
  variant.choices <- c("medium", "hard", "soft")
  variant <- match.arg(tolower(variant), variant.choices)

  ef_foreground <- get(paste0(
    if (dark) "dark" else "light",
    "_foreground"
  ))
  ef_background <- get(paste0(
    if (dark) "dark" else "light",
    "_background"
  ))[[variant]]
  ef_pal <- c(
    ef_foreground,
    ef_background
  )

  lighten_factor <- 5
  darken_factor <- 5
  .lighten <- function(nm, by = lighten_factor) {
    paste0(
      "lighten($",
      nm,
      ", ",
      by,
      "%)"
    )
  }
  .darken <- function(nm, by = darken_factor) {
    paste0(
      "darken($",
      nm,
      ", ",
      by,
      "%)"
    )
  }

  theme_palette <- list(
    # UI
    bg = ef_pal$bg_0,
    bg_dim = ef_pal$bg_dim,
    bg_1 = ef_pal$bg_1,
    bg_2 = ef_pal$bg_2,
    bg_3 = ef_pal$bg_3,
    bg_4 = ef_pal$bg_4,
    # bg_5 = ef_pal$bg_5, # currently unused
    hl = ef_pal$grey_0,
    hl_1 = ef_pal$grey_1,
    hl_2 = ef_pal$grey_2,
    fg = ef_pal$fg,
    fg_dim = .darken("fg"),
    line_1 = ef_pal$statusline_1,
    line_2 = ef_pal$statusline_2,
    line_3 = ef_pal$statusline_3,
    pal_cursor_line = "$bg_1",
    pal_selection = ef_pal$bg_visual,
    # Terminal colors
    red = ef_pal$red,
    orange = ef_pal$orange, # not used by terminal colors
    green = ef_pal$green,
    yellow = ef_pal$yellow,
    blue = ef_pal$blue,
    purple = ef_pal$purple,
    cyan = ef_pal$aqua,
    white = "$fg",
    black = "$bg_dim",
    # Color variants
    dark_red = ef_pal$bg_red,
    dark_orange = .darken("orange"),
    dark_green = ef_pal$bg_green,
    dark_yellow = ef_pal$bg_yellow,
    dark_blue = ef_pal$bg_blue,
    dark_purple = .darken("purple"),
    dark_cyan = .darken("cyan"),
    light_red = .lighten("red"),
    light_orange = .lighten("orange"),
    light_green = .lighten("green"),
    light_yellow = .lighten("yellow"),
    light_blue = .lighten("blue"),
    light_purple = .lighten("purple"),
    light_cyan = .lighten("cyan"),
    # Code
    pal_comments = "$hl_1",
    pal_messages = "$orange",
    pal_errors = "$red",
    pal_operators = "$orange",
    pal_punctuation = "$hl_1",
    pal_variables = "$fg",
    pal_strings = "$cyan",
    pal_values = "$blue",
    pal_booleans = "$purple",
    pal_functions = "$green",
    pal_conditionals = "$red",
    pal_keywords = "$orange",
    pal_namespaces = "$yellow",
    pal_tags = "$orange",
    pal_types = "$yellow",
    pal_methods = "$green",
    pal_parameters = "$fg"
  )

  print(theme_palette)

  if (as_sass) {
    theme_apply <- FALSE
    theme_as_sass <- TRUE
    theme_path <- here::here(
      "inst/templates",
      paste0(
        "everforest-",
        if (dark) "dark-" else "light-",
        variant,
        ".scss"
      )
    )
  } else {
    if (apply) {
      theme_apply <- TRUE
      theme_as_sass <- FALSE
      theme_path <- here::here(
        "inst/themes",
        paste0(
          "everforest-",
          if (dark) "dark-" else "light-",
          variant,
          ".rstheme"
        )
      )
    } else {
      theme_apply <- FALSE
      theme_as_sass <- FALSE
      theme_path <- here::here(
        "inst/themes",
        paste0(
          "everforest-",
          if (dark) "dark-" else "light-",
          variant,
          ".rstheme"
        )
      )
    }
  }

  theme_args <- list(
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ##  THEME META                                          >>
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    theme_name = paste0(
      "Everforest ",
      if (dark) "Dark " else "Light ",
      variant
    ),
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
    ui_rstudio_background = "$bg_dim",
    ui_rstudio_foreground = "$fg_dim",
    ui_rstudio_tabs_inactive_background = "$bg_dim",
    ui_rstudio_tabs_inactive_hover_background = "$bg",
    ui_rstudio_tabs_inactive_foreground = "$hl_2",
    ui_rstudio_tabs_active_background = "$bg_1",
    ui_rstudio_tabs_active_foreground = "$fg",
    ui_rstudio_scrollbar_background = "$bg_2",
    ui_rstudio_scrollbar_handle = "transparentize($hl, 0.5)",
    #
    ## ----------------------------------------
    ##  Interactions                        --
    ## ----------------------------------------
    ui_cursor = "transparentize($cyan, 0.25)",
    ui_selection = "$pal_selection",
    ui_console_selection = "$ui_selection",
    #
    ## ----------------------------------------
    ##  Guides                              --
    ## ----------------------------------------
    ui_line_active = "$pal_cursor_line",
    ui_line_active_selection = "$ui_selection",
    ui_bracket = "$dark_blue",
    ui_invisible = "$hl_1",
    ui_margin_line = "$hl",
    ui_gutter_background = "$bg",
    ui_gutter_foreground = "$hl",
    ui_debug_background = "$dark_yellow",
    ui_completions_background = "transparentize($bg_2, 0.4)",
    ui_completions_foreground = "$fg",
    ui_completions_border = "$hl_1",
    ui_completions_selected_background = "$dark_green",
    ui_completions_selected_foreground = "$fg",
    ui_fold_arrows_foreground = "$hl_1",
    ui_fold_arrows_background = "$bg_1",
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
    # This is fixed below with the .ace_constant.ace_languange selector.
    code_message = "$pal_messages",
    code_reserved = "$pal_conditionals",
    code_operator = "$pal_operators",
    code_identifier = "$fg",
    code_bracket = "$hl",
    #
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ##  RMD                                                >>
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    rmd_chunk_background = "$bg_dim",
    rmd_heading_foreground = "$pal_tags",
    rmd_chunk_header = "$hl",
    rmd_href = "$hl_1",
    #
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ##  SCSS / PARTIALS                                    >>
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ## -----------------------------------------
    ##  Command palette                      --
    ## -----------------------------------------
    rsthemes::rstheme_command_palette(
      item_hover_background = "$bg_1",
      item_selected_background = "$pal_selection"
    ),
    #
    ## -----------------------------------------
    ##  Rainbow parentheses                  --
    ## -----------------------------------------
    rsthemes::rstheme_rainbow_parentheses(
      "$hl_1",
      "$light_orange",
      "$light_green",
      "$light_yellow",
      "$light_blue",
      "$light_purple",
      "$light_cyan"
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
      background = "$bg_1",
      foreground = "$fg",
      heading_foreground = "$rmd_heading_foreground",
      help_foreground = "$fg_dim",
      border = "$hl_1",
      selected_background = "$dark_blue",
      button_border = "$hl_1",
      input_border = "$hl_1",
      input_background = "$bg_4",
      input_foreground = "$pal_strings",
      checkbox_background = "$bg_4",
      select_background = "$bg_3"
    ),
    #
    ## -----------------------------------------
    ##  Terminal colors                      --
    ## -----------------------------------------
    rsthemes::rstheme_terminal_colors(
      theme_dark = TRUE,
      red = "$red",
      red_bright = "$light_red",
      green = "$green",
      green_bright = "$light_green",
      yellow = "$yellow",
      yellow_bright = "$light_yellow",
      blue = "$blue",
      blue_bright = "$light_blue",
      cyan = "$cyan",
      cyan_bright = "$light_cyan",
      magenta = "$purple",
      magenta_bright = "$light_purple",
      white = "$white",
      black = "$black",
      black_bright = "$hl"
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
        box-shadow: 0 3px 0 $line_1 inset;
        border-radius: 0 !important;

        .gwt-Label {
          \\ font-weight: 600;
          \\ color: $fg;
        }
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
        color: $hl;
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
    [class="ace_keyword"] {
      font-weight: 600;
    }
    .ace_function {
      font-weight: 600;
    }
    .ace_comment {
      font-style: italic;
    }
    .ace_constant {
      color: $pal_booleans
    }
    .ace_constant.ace_language {
      color: $pal_booleans
    }
    .ace_constant.ace_numeric {
      font-color: $pal_values
    }
    .ace_bracket {
      margin: -1px 0 0 -1px !important;
      padding: 1px;
      border: 0 !important;
      border-radius: 1;
    }
    '
  )
  theme_args <- modifyList(theme_args, list(...))
  do.call(rsthemes::rstheme, theme_args)
}
