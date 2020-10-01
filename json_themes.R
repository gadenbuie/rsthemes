theme_names <- rsthemes::list_rsthemes()

theme_info <- lapply(theme_names, rsthemes:::get_theme_info)

theme_info <- lapply(theme_info, function(thm) {
  thm$image <- sub(" {rsthemes}", "", thm$name, fixed = TRUE)
  thm$image <- gsub("[ ,;-]", "_", thm$image)
  thm$image <- tolower(thm$image)
  thm$image <- paste0("https://raw.githubusercontent.com/gadenbuie/rsthemes/assets/themes/", thm$image, ".png")

  thm$isBase16 <- grepl("^base16", thm$name)

  thm
})


jsonlite::write_json(theme_info, "rsthemes.json")
