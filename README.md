<p align=center>
  <img src="https://raw.githubusercontent.com/gadenbuie/rsthemes/assets/rsthemes.gif">
  <h1 align="center">{rsthemes}</h1>
</p>

<!-- badges: start -->
[![](https://img.shields.io/badge/rstudio->=1.2.1335-%2381A9D7.svg)](https://www.rstudio.com/products/rstudio/)
![](https://www.r-pkg.org/badges/version/rsthemes)
![](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
<!-- badges: end -->


## Installation

You can install rsthemes from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("gadenbuie/rsthemes")
```

Then, install the included, hand-crafted themes with:

``` r
rsthemes::install_rsthemes()
```

or you can install the themes plus an additional set of [base16-based themes](https://github.com/chriskempson/base16) with

``` r
rsthemes::install_rsthemes(include_base16 = TRUE)
```

## Usage

The rsthemes package includes a couple helper functions for exploring the themes.

``` r
# list installed themes
rsthemes::list_rsthemes()

# Try all themes
rsthemes::try_rsthemes()

# Try just the light, dark, or base16 themes, e.g.
rsthemes::try_rsthemes("light")
```

Use `rstudioapi::applyTheme()` to activate a theme from the R console, or use *Tools* > *Global Options* > *Appearance* to interactively select a theme. 

``` r
# Use a theme
rstudioapi::applyTheme("One Dark {rsthemes}")
```

## Automatic &#x1F305; Light and &#x1F303; Dark Mode

**rsthemes** includes an RStudio addin to easily **Toggle Dark Mode** to switch between two preferred dark and light themes.

### Choose Default Light and Dark Themes

First, set a default light and dark theme. You can use the **Set Default Light Theme to Current** addin (or the corresponding dark theme addin), or you can call the `set_theme_light()` or `set_theme_dark()` functions:

``` r
# Set current theme to default light or dark theme
rsthemes::set_theme_light()
rsthemes::set_theme_dark()

# Set a specific theme to default light or dark theme
rsthemes::set_theme_light("One Light {rsthemes}")
rsthemes::set_theme_dark("One Dark {rsthemes}")
```

To set these defaults for all R sessions, add your preferences to your `~/.Rprofile`. (You can use `usethis::edit_r_profile()` to quickly open your `~/.Rprofile` for editing.)

```r
rsthemes::set_theme_light("GitHub {rsthemes}")
rsthemes::set_theme_dark("Fairyfloss {rsthemes}")
```

You can also set the following global options directly.

```r
# ~/.Rprofile
options(
  rsthemes.theme_light = "Nord Snow Storm {rsthemes}",
  rsthemes.theme_dark = "Nord Polar Night Aurora {rsthemes}"
)
```

### Toggle Dark Mode

Use the **Toggle Dark Mode** addin to switch between your default light and dark themes. You can even set a keyboard shortcut in RStudio — I used <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>D</kbd> — to toggle dark mode.

You can also automatically choose the dark or light theme by time of day, using the included **Auto Choose Dark or Light Theme** addin, which requires that you've set your preferred light/dark themes (see above).

If you would like to automatically choose the dark or light theme by time of day during each new session, you can call `rsthemes::use_theme_auto()` in your `~/.Rprofile`. For best results, use the following template in your `~/.Rprofile` to declare your preferred dark and light themes and to choose the correct style when your R session reloads.

```r
if (interactive() && requireNamespace("rsthemes", quietly = TRUE)) {
  # Set preferred themes if not handled elsewhere..
  rsthemes::set_theme_light("One Light {rsthemes}")  # light theme
  rsthemes::set_theme_dark("One Dark {rsthemes}") # dark theme

  # Whenever the R session restarts inside RStudio...
  setHook("rstudio.sessionInit", function(isNewSession) {
    # Automatically choose the correct theme based on time of day
    rsthemes::use_theme_auto(dark_start = "18:00", dark_end = "6:00")
  }, action = "append")
}
```

## Uninstall

If you want to uninstall all or some of the themes, you can use

``` r
rsthemes::remove_rsthemes()

# or just the base16 themes, e.g.
rsthemes::remove_rsthemes("base16")
```

***

Please note that the 'rsthemes' project is released with a
[Contributor Code of Conduct](CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.
