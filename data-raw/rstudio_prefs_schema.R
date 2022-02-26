pkgload::load_all(here::here())

url <- "https://github.com/rstudio/rstudio/raw/main/src/cpp/session/resources/schema/user-prefs-schema.json"

rstudio_prefs_schema_default <- rs_prefs_schema_prepare(url)

usethis::use_data(rstudio_prefs_schema_default, overwrite = TRUE)
