# rsthemes 0.0.6

* Added a favorite themes list. Similar to the preferred light/dark themes,
  users can now chose their favorite themes and walk through them.
  Use `set_theme_favorite()` interactively or in your `~/.Rprofile` with a
  vector of theme names. Then use `use_theme_favorite()` or the **Next Favorite Theme**
  RStudio addin to walk through this list of themes. (#11)

* `install_rsthemes()` now uses `rstudioapi::addTheme(..., force = TRUE)` to
  install themes, rather than trying to guess the correct directory. If this
  method fails, users can use the `destdir` option to install into non-standard
  directories. If all else fails, please open an issue in 
  [rstudio/rstudioapi](https://github.com/rstudio/rstudioapi). (thanks @leonawicz, #15)

# rsthemes 0.0.5

* Rewrite automatic light/dark section of README for clarity (thanks @MikeJohnPage, #12)
* Remove dependency on `later` and recommend using `rstudio.sessionInit` hook to
  set the auto light/dark theme selection (thanks @mine-centinkaya-rundel, #8)

# rsthemes 0.0.4

* Update comment and invisible colors of Solarized Themes (thanks @dragosmg, #3)

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
