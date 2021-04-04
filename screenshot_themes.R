#! /usr/local/bin/Rscript

# brew install smokris/getwindowid/getwindowid
# getwindowid RStudio --list

# Resize RStudio window to 1920 x 1600
rstudio_window <- 40595 # replace with window id found above
themes <- rsthemes::list_rsthemes(list_installed = FALSE)

system("resize-rstudio", wait = TRUE)
rstudioapi::executeCommand("activateConsole")
rstudioapi::executeCommand("consoleClear")
rstudioapi::sendToConsole('remotes::install_github("gadenbuie/rsthemes")\nrsthemes::install_rsthemes()', execute = FALSE)

for (theme in themes) {
  rstudioapi::applyTheme(theme)
  Sys.sleep(1)
  theme_file <- sub(" {rsthemes}", "", theme, fixed = TRUE)
  theme_file <- gsub("[ ,;-]", "_", theme_file)
  theme_file <- tolower(theme_file)
  theme_file <- here::here("themes", theme_file)
  cmd <- glue::glue(
    "screencapture -o -l{rstudio_window} {theme_file}.png"
  )
  system(cmd, wait = TRUE)
}
