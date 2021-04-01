devtools::load_all()

r_files <- fs::dir_ls(here::here("inst/templates/"), regexp = "R$")
r_files <- r_files[!grepl("make[.]R", r_files)]

purrr::walk(r_files, source)

make_rsthemes()
install_rsthemes()
