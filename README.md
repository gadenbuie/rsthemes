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

**rsthemes** includes an RStudio addin to easily **Toggle Dark Mode** to switch between two preferred dark and light themes. For the toggle to work, you must set a default light and dark theme. These can be set using the **Set Default Light Theme to Current** and **Set Default Dark Theme to Current** addins, or alternatively, using the set light and dark theme functions:

``` r
# Set a default light theme
rsthemes::set_theme_light()

# Set a default dark theme
rsthemes::set_theme_dark()
```

You can then create a keyboard shortcut (I used <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>D</kbd>) to toggle dark mode. If you would like for the themes to be remebered during each new session, you can add the following code to your `~/.Rprofile`:

```r
options(
  rsthemes.theme_light = "One Light {rsthemes}",
  rsthemes.theme_dark = "One Dark {rsthemes}"
)
```

You can also automatically choose the dark or light theme by time of day, using the included **Auto Choose Dark or Light Theme** addin. This addin also requires default light and dark themes to be chosen. If you would like to automatically choose the dark or light theme by time of day during each new session, you can call `rsthemes::use_theme_auto()` in your `~/.Rprofile`. For best results, use the following template in your `~/.Rprofile` to declare your preferred dark and light themes and to choose the correct style when your R session reloads.

```r
if (
  interactive() && 
  requireNamespace("rsthemes", quietly = TRUE) && 
  requireNamespace("later", quietly = TRUE)
) {
  # Use later to delay until RStudio is ready
  later::later(function() {
    rsthemes::set_theme_light("One Light {rsthemes}")  # light theme
    rsthemes::set_theme_dark("One Dark {rsthemes}") # dark theme

    # To automatically choose theme based on time of day
    rsthemes::use_theme_auto(dark_start = "18:00", dark_end = "6:00")
  }, delay = 1)
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
