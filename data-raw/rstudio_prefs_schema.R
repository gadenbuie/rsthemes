library(purrr)

url <- "https://github.com/rstudio/rstudio/raw/main/src/cpp/session/resources/schema/user-prefs-schema.json"

rsp_schema <- jsonlite::read_json(url)

flatten_name <- function(x, name, parent = NULL) {
  x[["name"]] <- name
  if ("properties" %in% names(x)) {
    x[["properties"]] <- imap(x[["properties"]], flatten_name, parent = x)
  }
  if (!is.null(parent)) {
    x[["parent"]] <- c(x[["parent"]], parent[["name"]])
    x[["default"]] <- parent[["default"]][[name]]
  }
  as_rsp_pref(x[union("name", names(x))])
}

as_rsp_pref <- function(x) {
  structure(x, class = "rsthemes_rstudio_pref")
}

rstudio_prefs_schema <-
  rsp_schema %>%
  pluck("properties") %>%
  imap(flatten_name)

usethis::use_data(rstudio_prefs_schema, overwrite = TRUE)
