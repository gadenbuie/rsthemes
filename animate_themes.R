library(purrr)
library(magick)
library(fs)

images_files <- dir_ls("themes", regexp = "png$")

images <- map(images_files, image_read)

images_colors <- map(images, as.raster) %>% map_chr(`[`, 350, 1550)

images_order <- order(t(col2rgb(images_colors)) %*% c(.241, .691, .068))

images[images_order] %>%
  map(image_scale, "800x") %>%
  reduce(c) %>%
  image_animate(optimize = FALSE, delay = 25) %>%
  image_write("rsthemes.gif")

