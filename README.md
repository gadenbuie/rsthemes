
<p align="center">
<img src="https://raw.githubusercontent.com/gadenbuie/rsthemes/assets/rsthemes.gif">
<h1 align="center">
{rsthemes}
</h1>
</p>
<!-- badges: start -->

[![rsthemes status
badge](https://gadenbuie.r-universe.dev/badges/rsthemes)](https://gadenbuie.r-universe.dev)
![](https://www.r-pkg.org/badges/version/rsthemes)
![](https://lifecycle.r-lib.org/articles/figures/lifecycle-stable.svg)
<!-- badges: end -->

## Installation

You can install rsthemes from my
[r-universe](https://gadenbuie.r-universe.dev) with:

``` r
install.packages(
  "rsthemes",
  repos = c(gadenbuie = 'https://gadenbuie.r-universe.dev', getOption("repos"))
)
```

Or you can install rsthemes from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("gadenbuie/rsthemes")
```

Then, install the included, hand-crafted themes with:

``` r
rsthemes::install_rsthemes()
```

or you can install the themes plus an additional set of [base16-based
themes](https://github.com/chriskempson/base16) with

``` r
rsthemes::install_rsthemes(include_base16 = TRUE)
```

## Usage

The rsthemes package includes a couple helper functions for exploring
the themes.

``` r
# list installed themes
rsthemes::list_rsthemes()

# Try all themes
rsthemes::try_rsthemes()

# Try just the light, dark, or base16 themes, e.g.
rsthemes::try_rsthemes("light")
```

Use `rstudioapi::applyTheme()` to activate a theme from the R console,
or use *Tools* \> *Global Options* \> *Appearance* to interactively
select a theme.

``` r
# Use a theme
rstudioapi::applyTheme("One Dark {rsthemes}")
```

## Easy Theme Switching

**rsthemes** includes RStudio addins and functions to…
<a name="automatic--light-and--dark-mode"></a>

- 🌅 **Toggle Dark Mode**<br>Switch between two preferred dark and light
  themes

- 🌃 **Auto Dark Mode**<br>Automatically choose a dark or light theme by
  time of day

- ❤️ **Favorite Themes**<br>Switch between a few of your favorite themes

- 🥱 **Use Default RStudio Theme**<br>Switch back to RStudio’s default
  theme

#### Choose Your Preferred Themes

First, set a default light and dark theme. For your current R sessions,
you can use the **Set Default Light Theme to Current** addin (or the
corresponding dark theme addin), or you can call the `set_theme_light()`
or `set_theme_dark()` functions:

``` r
# Set current theme to default light or dark theme
rsthemes::set_theme_light()
rsthemes::set_theme_dark()

# Set a specific theme to default light or dark theme
rsthemes::set_theme_light("One Light {rsthemes}")
rsthemes::set_theme_dark("One Dark {rsthemes}")
```

To create a list of your **favorite** themes, you can use
`set_theme_favorite()`.

``` r
# Add current theme to your list of favorites
rsthemes::set_theme_favorite()

# Add a list of themes to your favorites
rsthemes::set_theme_favorite(
  c("GitHub {rsthemes}", "One Light {rsthemes}", "One Dark {rsthemes}")
)
```

These functions only save your preferences for the *current* R session.
To set these defaults for all R sessions, add your preferences to your
`~/.Rprofile`. (You can use `usethis::edit_r_profile()` to quickly open
your `~/.Rprofile` for editing.)

``` r
# ~/.Rprofile
if (interactive()) {
  rsthemes::set_theme_light("GitHub {rsthemes}")
  rsthemes::set_theme_dark("Fairyfloss {rsthemes}")
  rsthemes::set_theme_favorite(
    c("GitHub {rsthemes}", 
      "One Light {rsthemes}", 
      "One Dark {rsthemes}")
  )
}
```

You can also set the following global options directly.

``` r
# ~/.Rprofile
options(
  rsthemes.theme_light = "Nord Snow Storm {rsthemes}",
  rsthemes.theme_dark = "Nord Polar Night Aurora {rsthemes}",
  rsthemes.theme_favorite = paste("One", c("Light", "Dark"), "{rsthemes}")
)
```

### Toggle Your Favorite Themes

Use the **Next Favorite Theme** addin to walk through your list of
favorite themes. Use the *Modify Keyboard Shortcuts…* dialog in the
*Tools* menu of RStudio to create a keyboard shortcut to make it easy to
quickly switch themes — I use <kbd>Ctrl</kbd>+ <kbd>Alt</kbd> +
<kbd>N</kbd>. You can also manually call `use_theme_favorite()` to use
the next theme in the your favorites list.

Each time you run the addin, RStudio switches to the next theme in your
favorites list. This is great if you have a few themes that you use in
various contexts. For example, I have my personal favorite themes plus a
few themes that work well during class or presentation sessions.

### Automatic or Manual Light/Dark Mode

Use the **Toggle Dark Mode** addin to switch between your default light
and dark themes. You can even set a keyboard shortcut in RStudio — I
used <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>D</kbd> — to toggle dark
mode.

You can also automatically choose the dark or light theme by time of
day, using the included **Auto Choose Dark or Light Theme** addin, which
requires that you’ve set your preferred light/dark themes (see above).

If you would like to automatically choose the dark or light theme by
time of day during each new session, you can call
`rsthemes::use_theme_auto()` in your `~/.Rprofile`. For best results,
use the following template in your `~/.Rprofile` to declare your
preferred dark and light themes and to choose the correct style when
your R session reloads.

``` r
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

### Go Back to the Default

Sometimes when you’re teaching or demonstrating RStudio features, you’d
like to have your IDE match the appearance of your learners, or at least
the basic theme that everyone starts out with when they install RStudio
for the first time.

Use the **Use Default RStudio Theme** to quickly switch back to
RStudio’s default theme, Textmate. Or, you can use
`rsthemes::use_default_rstudio_theme()` to initiate the switch, perhaps
from within the `.Rprofile` file of your teaching project.

## Uninstall

If you want to uninstall all or some of the themes, you can use

``` r
rsthemes::remove_rsthemes()

# or just the base16 themes, e.g.
rsthemes::remove_rsthemes("base16")
```

## Thanks and Theme Credits

### Palettes

- [base16](https://github.com/chriskempson/base16) (Various Authors)
- [Fairyfloss](https://github.com/sailorhg/fairyfloss) ([Amy Wibowo
  (sailorhg)](https://github.com/sailorhg))
- [Flat White](https://github.com/biletskyy/flatwhite-syntax) ([Dmitry
  Biletskyy](https://github.com/biletskyy))
- [Nord](https://github.com/arcticicestudio/nord) ([Sven
  Greb](https://www.svengreb.de/))
- [Oceanic Plus](https://github.com/marcoms/oceanic-plus) ([Marco
  Scannadinari](https://github.com/marcoms))
- [Atom One
  Dark](https://github.com/atom/atom/tree/master/packages/one-dark-syntax)
- [Atom One
  Light](https://github.com/atom/atom/tree/master/packages/one-light-syntax)
- [Solarized](https://ethanschoonover.com/solarized) (Ethan Schoonover)
- [Horizon Dark](https://horizontheme.netlify.app/) (Jonathan Olaleye)
- [a11y-syntax-highlighting](https://github.com/ericwbailey/a11y-syntax-highlighting)
  ([Eric Bailey](https://ericwbailey.design/))
- [Night Owl](https://github.com/sdras/night-owl-vscode-theme) ([Sarah
  Drasner](https://sarah.dev/))
  - with huge thanks to original [Night
    Owlish](https://github.com/batpigandme/night-owlish) implementation
    in RStudio by [Mara Averick](https://maraaverick.rbind.io/)
- Yule RStudio
  - Based on the [Yule
    tmTheme](https://tmtheme-editor.herokuapp.com/#!/editor/theme/Yule)
  - Ported from
    [gadenbuie/yule-rstudio](https://github.com/gadenbuie/yule-rstudio)
  - Featuring a background image by [Joanna
    Kosinska](https://unsplash.com/@joannakosinska)
- [Material Theme](https://material-theme.site/)
  - Contributed to rsthemes by [Zac de
    Lusignan](https://www.zacdelusignan.com/)
- [Serendipity](https://wvsc.dev/)
  ([wickedtemplates](https://www.wickedtemplates.com/))
- [Embark](embark) ([Eric Hunt](https://github.com/eric-hunt))

------------------------------------------------------------------------

Please note that the ‘rsthemes’ project is released with a [Contributor
Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project,
you agree to abide by its terms.
