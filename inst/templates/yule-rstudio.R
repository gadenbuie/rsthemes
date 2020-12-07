# library(dplyr)
#
# yule_rstudio_old <- "https://github.com/gadenbuie/yule-rstudio/raw/master/Yule-RStudio.rstheme"
#
# yule_colors <-
#   readLines(yule_rstudio_old)[1:300] %>%
#   extract_colors() %>%
#   tibble(color = .) %>%
#   count(color, sort = TRUE)
#
# prismatic::color(yule_colors$color) %>% plot()

striped_hover <- '
.ace_marker-layer .ace_active-line {
  background: repeating-linear-gradient(
    -45deg,
    #262c3300,
    #262c3300 15px,
    #FFFFFF08 15px,
    #FFFFFF08 25px
  );
}
'

animated_cursor_color <- '
.normal-mode .ace_cursor {
  border: 0 !important;
  animation-name: xmas-background-colors !important;
  animation-duration: 5s !important;
  animation-iteration-count: infinite;
  animation-timing-function: steps !important;
  opacity: 0.75;
}

.ace_cursor {
  color: #ff0010;
  animation-name: xmas-colors !important;
  animation-duration: 5s !important;
  animation-iteration-count: infinite;
  animation-timing-function: steps;
}

@keyframes blink {
  0% {
    opacity: 1;
  }
  75% {
    opacity: 0;
  }
}

@keyframes xmas-background-colors {
  0% {
    background-color: #ff00a9;
    opacity: 0.66;
  }
  10% {
    background-color: #ff00a9;
    opacity: 0.66;
  }
  18% {
    background-color: #ff00a9;
    opacity: 0;
  }
  20% {
    background-color: #7c3eff;
    opacity: 0.66;
  }
  30% {
    background-color: #7c3eff;
    opacity: 0.66;
  }
  38% {
    background-color: #7c3eff;
    opacity: 0;
  }
  40% {
    background-color: #64f3f0;
    opacity: 0.66;
  }
  50% {
    background-color: #64f3f0;
    opacity: 0.66;
  }
  58% {
    background-color: #64f3f0;
    opacity: 0;
  }
  60% {
    background-color: #4fe818;
    opacity: 0.66;
  }
  70% {
    background-color: #4fe818;
    opacity: 0.66;
  }
  78% {
    background-color: #4fe818;
    opacity: 0;
  }
  80% {
    background-color: #ffc400;
    opacity: 0.66;
  }
  90% {
    background-color: #ffc400;
    opacity: 0.66;
  }
  98% {
    background-color: #ffc400;
    opacity: 0;
  }
  100% {
    background-color: #ff00a9;
    opacity: 0.66;
  }
}

@keyframes xmas-colors {
  0% {
    color: #ff00a9;
  }
  20% {
    color: #7c3eff;
  }
  40% {
    color: #64f3f0;
  }
  60% {
    color: #4fe818;
  }
  80% {
    color: #ffc400;
  }
  100 {
    color: #ff0010;
  }
}
'

yule_rstudio <- function(
  ...,
  theme_name = "Yule RStudio",
  theme_path = "yule-rstudio-rsthemes.scss"
) {
  theme_path <- here::here("inst/templates", theme_path)
  rstheme(
    theme_name,
    theme_dark    = TRUE,
    theme_flat    = FALSE,
    theme_path    = theme_path,
    theme_apply   = TRUE,
    theme_as_sass = TRUE,
    theme_palette = list(
      red             = "#de6262",
      green           = "#39b81f",
      yellow          = "#F0c85b",
      "green-dark"    = "#262c33",
      "green-bright"  = "#4fe818",
      "red-bright"    = "#ff0010",
      "blue"          = "#00d3f8",
      black           = "#262c33",
      black2          = "#2e343a",
      "gray-dark"     = "#435052",
      teal            = "#64f3f0",
      purple          = "#7c3eff",
      brown           = "#847d73",
      white           = "#e8e8e8",
      ivory           = "#ede0ce",
      pink            = "#ff00a9",
      "yellow-bright" = "#ffc400",
      navy            = "#23282e",
      "green-slate"   = "#50575f",
      "slate"         = "#808080",
      gold            = "#938536"
    ),

    ui_background   = "$black",
    ui_foreground   = "$white",
    code_string     = "$yellow",
    code_function   = "$red",
    code_operator   = "#96B482",
    code_comment    = "$brown",
    code_variable   = "$yellow",
    code_message    = "mix($teal, $black, 80%)",
    code_reserved   = "$red",
    code_value      = "$green",
    code_namespace  = "$green",
    code_identifier = "$white",
    code_bracket    = "$slate",

    ui_rstudio_background     = "darken($black, 5%)",
    ui_rstudio_foreground     = "$ivory",
    ui_selection = "transparentize($ivory, 0.8)",
    ui_line_active_selection = "transparentize($ivory, 0.8)",
    ui_completions_border = "$slate",
    ui_completions_selected_background = "mix($teal, $black, 40%)",
    ui_completions_background = "$black",
    ui_gutter_foreground = "$slate",
    ui_gutter_background = "darken($black, 5%)",
    # ui_rstudio_tabs_active_background = "$gray-dark",
    ui_rstudio_tabs_active_background = "$black2",
    ui_rstudio_tabs_active_foreground = "$ivory",
    ui_fold_arrows_background = "$teal",
    ui_fold_arrows_foreground = "$slate",
    rmd_heading_foreground = "$yellow-bright",
    rstheme_command_palette(
      item_hover_background = "mix($teal, $black, 25%)",
      item_selected_background = "mix($teal, $black, 35%)"
    ),
    rstheme_rainbow_parentheses(
      "$code_operator", "$teal", "$pink", "$red-bright", "$green-bright", "$yellow-bright"
    ),
    ...
  )
}

yule_rstudio(striped_hover, animated_cursor_color)

yule_rstudio(
  theme_name = "Yule RStudio (Reduced Motion)",
  theme_path = "yule-rstudio-reduced-motion.scss",
  striped_hover
)
