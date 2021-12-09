devtools::load_all()

r_files <- fs::dir_ls(here::here("inst/templates/"), regexp = "R$")
r_files <- r_files[!grepl("make[.]R", r_files)]

purrr::walk(r_files, source)

make_rsthemes(here::here("inst", "themes"), here::here("inst", "templates"))
devtools::load_all()
install_rsthemes()
