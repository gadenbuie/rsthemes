<p align=center>
  <img src="https://raw.githubusercontent.com/gadenbuie/rsthemes/assets/rsthemes.gif">
  <h1 align="center">{rsthemes}</h1>
</p>

<!-- badges: start -->
[![](https://img.shields.io/badge/rstudio-1.2.1335-%2381A9D7.svg)](https://www.rstudio.com/products/rstudio/)
![](https://www.r-pkg.org/badges/version/rsthemes)
![](https://img.shields.io/badge/lifecycle-experimental-orange.svg)
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
rsthemes::install_rsthemes(base16 = TRUE)
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
