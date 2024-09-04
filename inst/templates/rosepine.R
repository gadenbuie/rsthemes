#' Rosé Pine official color palette(s)
#'
#' These are the official colors as listed on
#' the [Rosé Pine palette page](https://rosepinetheme.com/palette/)
#' in August 2024.
#' @source https://rosepinetheme.com/
#'
rose_pine <- list(
  base = "#191724", # main panels, frames, sidebars, tabs
  surface = "#1f1d2e", # panels not related to focal context
  overlay = "#26233a", # panels temporary in nature (e.g. notifications/dialogs)
  muted = "#6e6a86", # comments, ignored content
  subtle = "#908caa", # secondary content: operators, punctuation, tab names
  text = "#e0def4", # primary content: normal text, variables
  love = "#eb6f92", # term red, diagnostic errors, builtins
  gold = "#f6c177", # term yellow, diagnostic warnings, strings
  rose = "#ebbcba", # term cyan, matching search background, booleans, functions
  pine = "#31748f", # term green, conditionals, keywords
  foam = "#9ccfd8", # term blue, diagnostic info, keys, tags, types
  iris = "#c4a7e7", # term magenta, links, hints, methods, params
  highlight_low = "#21202e", # cursorline background
  highlight_med = "#403d52", # selection background paired with text foreground
  highlight_high = "#524f67" # borders/dividers, cursor background
)

rose_pine_moon <- list(
  base = "#232136",
  surface = "#2a273f",
  overlay = "#393552",
  muted = "#6e6a86",
  subtle = "#908caa",
  text = "#e0def4",
  love = "#eb6f92",
  gold = "#f6c177",
  rose = "#ea9a97",
  pine = "#3e8fb0",
  foam = "#9ccfd8",
  iris = "#c4a7e7",
  highlight_low = "#2a283e",
  highlight_med = "#44415a",
  highlight_high = "#56526e"
)

rose_pine_dawn <- list(
  base = "#faf4ed",
  surface = "#fffaf3",
  overlay = "#f2e9e1",
  muted = "#9893a5",
  subtle = "#797593",
  text = "#575279",
  love = "#b4637a",
  gold = "#ea9d34",
  rose = "#d7827e",
  pine = "#286983",
  foam = "#56949f",
  iris = "#907aa9",
  highlight_low = "#f4ede8",
  highlight_med = "#dfdad9",
  highlight_high = "#cecacd"
)

#' Create Rosé Pine .rstheme file
#'
#' @param variant A string - A string defining the theme palette variant to use;
#' must be "base", "moon", or "dawn";
#' see [Rosé Pine Variants](https://rosepinetheme.com/palette/)
#' @param apply A Boolean - generate and install/apply the .rstheme file (TRUE),
#' or just save the .rstheme file without applying (FALSE); defaults to FALSE
#' @param as_sass A Boolean - save theme as .sass file and do not apply (TRUE);
#' defaults to FALSE
#' @param ... Additional arguments to pass to [rsthemes::rstheme()] overriding
#' defaults if necessary
#'
#' @export
rosepine_rstheme <- function(
    variant = "base",
    apply = FALSE,
    as_sass = FALSE,
    ...) {
  variant.choices <- list("base" = NULL, "moon" = "Moon", "dawn" = "Dawn")
  stopifnot(
    "Variant must be 'base', 'moon', or 'dawn'." =
      tolower(variant) %in% names(variant.choices)
  )
  variant <- do.call(switch, c(tolower(variant), variant.choices))

  theme_dark <- !identical(variant, "Dawn")

  rp_pal <- get(paste0(
    "rose_pine",
    if (!is.null(variant)) "_",
    tolower(variant)
  ))

  lighten_factor <- 5
  darken_factor <- 5
  .lighten <- function(nm, by = lighten_factor) {
    sprintf("lighten($%s, %s%%)", nm, by)
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
  .transparentize <- function(nm, by = 0.25) {
    paste0(
      "transparentize($",
      nm,
      ", ",
      by,
      ")"
    )
  }

  theme_palette <- list(
    # UI
    bg = rp_pal$base,
    bg_2 = rp_pal$surface,
    bg_3 = rp_pal$overlay,
    hl_1 = rp_pal$highlight_low,
    hl_2 = rp_pal$highlight_med,
    hl_3 = rp_pal$highlight_high,
    fg = rp_pal$text,
    fg_2 = rp_pal$subtle,
    fg_3 = rp_pal$muted,
    # Terminal colors
    red = rp_pal$love,
    green = rp_pal$pine,
    yellow = rp_pal$gold,
    blue = rp_pal$foam,
    purple = rp_pal$iris,
    cyan = rp_pal$rose,
    white = .lighten(
      if (theme_dark) "fg" else "bg_3",
      if (theme_dark) 5 else 10
    ),
    black = .darken(
      if (theme_dark) "bg_3" else "fg",
      if (theme_dark) 5 else 10
    ),
    # Color variants
    dark_red = .darken("red"),
    dark_green = .darken("green"),
    dark_yellow = .darken("yellow"),
    dark_blue = .darken("blue"),
    dark_purple = .darken("purple"),
    dark_cyan = .darken("cyan"),
    light_red = .lighten("red"),
    light_green = .lighten("green"),
    light_yellow = .lighten("yellow"),
    light_blue = .lighten("blue"),
    light_purple = .lighten("purple"),
    light_cyan = .lighten("cyan"),
    # Other
    pal_cursor_line = .lighten("hl_1", 3),
    pal_selection = .transparentize("red", 0.75),
    # Code
    pal_comments = "$fg_3",
    pal_messages = "$red",
    pal_errors = "$red",
    pal_operators = "$fg_2",
    pal_punctuation = "$fg_2",
    pal_variables = "$fg",
    pal_builtins = "$red",
    pal_strings = "$yellow",
    pal_values = "$purple",
    pal_booleans = "$cyan",
    pal_functions = "$cyan",
    pal_conditionals = "$green",
    pal_keywords = "$green",
    pal_namespaces = "$blue",
    pal_tags = "$blue",
    pal_types = "$blue",
    pal_methods = "$purple",
    pal_parameters = "$purple"
  )

  if (as_sass) {
    theme_apply <- FALSE
    theme_as_sass <- TRUE
    theme_path <- here::here(
      "inst/templates/",
      paste0(
        "rose-pine",
        if (!is.null(variant)) "-",
        tolower(variant),
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
          "rose-pine",
          if (!is.null(variant)) "-",
          tolower(variant),
          ".rstheme"
        )
      )
    } else {
      theme_apply <- FALSE
      theme_as_sass <- FALSE
      theme_path <- here::here(
        "inst/themes",
        paste0(
          "rose-pine",
          if (!is.null(variant)) "-",
          tolower(variant),
          ".rstheme"
        )
      )
    }
  }

  theme_args <- list(
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ##  THEME META                                          >>
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    theme_name = paste0("Rosé Pine", if (!is.null(variant)) " ", variant),
    theme_dark = theme_dark,
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
    ui_rstudio_background = .darken("bg", 3),
    ui_rstudio_foreground = "$fg",
    ui_rstudio_tabs_inactive_background = "$bg",
    ui_rstudio_tabs_inactive_hover_background = .lighten("bg", 2),
    ui_rstudio_tabs_inactive_foreground = "$fg_2",
    ui_rstudio_tabs_active_background = "$bg_3",
    ui_rstudio_tabs_active_foreground = "$fg",
    ui_rstudio_scrollbar_background = "$bg_2",
    ui_rstudio_scrollbar_handle = "$hl_2",
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
    ui_bracket = "transparentize($hl_3, 0.1)",
    ui_invisible = "$hl_2",
    ui_margin_line = "$hl_2",
    ui_gutter_background = "$bg_2",
    ui_gutter_foreground = "$fg_3",
    ui_debug_background = "transparentize($yellow, 0.75)",
    ui_completions_background = "transparentize($bg, 0.5)",
    ui_completions_foreground = "$fg",
    ui_completions_border = "$hl_3",
    ui_completions_selected_background = "$bg_3",
    ui_completions_selected_foreground = "$fg",
    ui_fold_arrows_foreground = "$fg",
    ui_fold_arrows_background = "$hl_2",
    #
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ##  CODE                                                >>
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    code_string = "$pal_strings",
    # code_string_background     = "inherit",
    code_namespace = "$pal_namespaces",
    # code_namespace_background  = "inherit",
    code_namespace_font_style = "italic",
    code_function = "$pal_functions",
    # code_function_background   = "inherit",
    code_value = "$pal_values",
    # code_value_background      = "inherit",
    code_comment = "$pal_comments",
    # code_comment_background    = "inherit",
    code_variable = "$pal_variables",
    # code_variable_background   = "inherit",
    code_message = "$pal_messages",
    # code_message_background    = "inherit",
    code_reserved = "$pal_keywords",
    # code_reserved_background   = "inherit",
    code_operator = "$pal_operators",
    # code_operator_background   = "inherit",
    code_identifier = "$fg",
    # code_identifier_background = "inherit",
    code_bracket = "$hl_3",
    # code_bracket_background    = "inherit",
    #
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ##  RMD                                                >>
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    rmd_chunk_background = "$bg_2",
    rmd_heading_foreground = "$pal_tags",
    rmd_chunk_header = "$fg_2",
    rmd_href = "$pal_tags",
    #
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ##  SCSS / PARTIALS                                    >>
    ## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ## -----------------------------------------
    ##  Command palette                      --
    ## -----------------------------------------
    rsthemes::rstheme_command_palette(
      item_hover_background = "lighten($bg, 5%)",
      item_selected_background = "$hl_2"
    ),
    #
    ## -----------------------------------------
    ##  Rainbow parentheses                  --
    ## -----------------------------------------
    rsthemes::rstheme_rainbow_parentheses(
      "$fg_2",
      "$light_red",
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
      background = "$bg_3",
      heading_foreground = "$rmd_heading_foreground",
      help_foreground = "$fg_3",
      border = "$hl_3",
      selected_background = "$hl_2",
      button_border = "$hl_3",
      # button_hover_background = .lighten(
      #   "ui_rstudio_dialog_button_background",
      #   2
      # ),
      input_border = "$hl_2",
      input_background = "$bg_3",
      input_foreground = "$code_string",
      checkbox_background = "$hl_3",
      select_background = "$bg_3"
    ),
    #
    ## -----------------------------------------
    ##  Terminal colors                      --
    ## -----------------------------------------
    rsthemes::rstheme_terminal_colors(
      theme_dark = theme_dark,
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
      black = "$black"
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
        box-shadow: 0 3px 0 $cyan inset;
        border-radius: 0 !important;
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
        color: $hl_3;
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
        color: $fg_3;
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

# Create sass files
purrr::walk(
  c("base", "moon", "dawn"),
  function(variant) {
    rosepine_rstheme(variant = variant, as_sass = TRUE)
  }
)

# Create rstheme files
purrr::walk(
  c("base", "moon", "dawn"),
  function(variant) {
    rosepine_rstheme(variant = variant)
  }
)
