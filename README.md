
<!-- README.md is generated from README.Rmd. Please edit that file -->

# metrica

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/adriancorrendo/metrica.svg?branch=master)](https://app.travis-ci.com/github/adriancorrendo/metrica)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/adriancorrendo/metrica?branch=master&svg=true)](https://ci.appveyor.com/project/adriancorrendo/metrica)
[![Codecov test
coverage](https://codecov.io/gh/adriancorrendo/metrica/branch/master/graph/badge.svg)](https://codecov.io/gh/adriancorrendo/metrica?branch=master)
<!-- badges: end -->

The goal of metrica packages is to offer preulation models users a
toolbox of different error metrics accounting for different aspects of
the…

<img src="man/figures/metrica_logo.png" height="300" align="right"/>

## Installation

You can install the released version of metrica from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("metrica")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("adriancorrendo/metrica")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(metrica)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/master/examples>.

You can also embed plots, or images, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
