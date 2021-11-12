<!-- NEWS.md is maintained by https://cynkra.github.io/fledge, do not edit -->

# rsthemes 0.3.0 (2021-11-12)

## New Themes

* Four new Material Themes: Dark, Lighter, Ocean, and Palenight 
  (@lusignan, @grrrck #64, #49, #47)
  
* New theme: Serendipity Dark and Light, based on the 
  [VS Code theme from wickedtemplates](https://wvsc.dev) (#73).

## Improvements and Fixes

* Improved dialog styles (#43):
    * Checkboxes now show correct status (thanks @etiennebacher #39)
    * Code snippet editor is now visible (thanks @etiennebacher #37)
    * Fixed button and code search styles that result from dialog styles
    
* File name in _Find all Files_ is now styled (#36, #43)

* Added support for terminal color theming via `rsthemes_terminal_colors()` 
  (@nsgrantham #63). Most themes now set the first eight terminal colors
  (black, red, green, yellow, blue, magenta, cyan, white).
  
* Added `use_theme_rstudio_default()` and corresponding RStudio addin
  _Use Default RStudio Theme_ (thanks @dragosmg, #71).

* Fixed menu item hover and selected colors in complete menu themes

* Added {rsthemes} version and header to final `.rstheme` files

  
* Backgrounds of scrollbars are now transparent and don't hide the code
  underneath the scrollbar (thanks @dragosmg, #75).

# rsthemes 0.2.0 (2020-12-07)

## New Themes

* Yule RStudio (#40)

## Bug Fixes

* `use_theme_auto()` gives better warnings if suncalc or ipapi packages are not
  installed (@pat-s #38)
* Caching of geolocation was fixed for older versions of R prior to 4.0

# rsthemes 0.1.0 (2020-10-01)

* Added `rstheme()`, an R function for creating new themes!

* Three new themes:

  * Horizon Dark ([source](https://horizontheme.netlify.app/))
  * a11y-light and a11y-dark ([source](https://github.com/ericwbailey/a11y-syntax-highlighting))
  * Night Owl ([source](https://github.com/sdras/night-owl-vscode-theme) and [night-owlish](https://github.com/batpigandme/night-owlish))
  
* Added support for automatically choosing light/dark theme by sunrise/sunset
  times using {suncalc} and {ipapi}. (thanks @pat-s, #33)
  
* Added support for full dialog menu theming via `rstheme_dialog_options()`. 
  Full dialog theming is used in _Flat White_, _Horizon Dark_ and _Night Owl_.
  
* Added support for enlarging tabs via `rstheme_large_tabs()`, on display in
  _Flat White_, _Horizon Dark_ and _Night Owl_.

# rsthemes 0.0.11 (2020-07-28)

* Customized rainbow parenthesis colors for all themes (#28)

# rsthemes 0.0.10 (2020-07-27)

* Added option to favorite themes in `try_rsthemes()`. The required code for
  your `~/.Rprofile` is provided, including current favorite themes (#21)
  
* Fixed command palette outlines and highlights as of RStudio 1.4.642

# rsthemes 0.0.7

* Added a new theme: Flat White. Based on the [Atom theme](https://github.com/biletskyy/flatwhite-syntax).

* Many improvements were made to the light theme template,
  including adding background color preferences, better
  targeting of R-specific tokens, and the addition of
  `$rlang-identifier`.

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
