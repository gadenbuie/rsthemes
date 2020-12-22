devtools::load_all()

r_files <- fs::dir_ls("inst/templates/", regexp = "R$")

purrr::walk(r_files, source)

make_rsthemes()
install_rsthemes()
