# rsthemes 0.0.3

* Choose theme installation directory based on RStudio version. For 1.3.555+ the
  themes are now installed into `~/.config/rstudio/themes`. An additional
  `destdir` argument was added to `install_rsthemes()` for future flexibility.
  Related to this RStudio desktop issue: 
  https://github.com/rstudio/rstudio/issues/5674#issuecomment-548484300.
  (thanks @pat-s)

# rsthemes 0.0.2

* Added automatic light/dark mode switching with `use_theme_auto()` and
  `use_theme_toggle()`. Includes RStudio addins to help set the default themes
  or to toggle between light and dark mode themes. To permanently choose default
  themes for each mode, users can set options in `~/.Rprofile`. 
  See `?use_theme_auto` for more information.

* Brought flatter style from Fairyfloss to One Dark/Light, Nord, and Oceanic Plus themes
