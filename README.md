
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

The goal of the *metrica* package is to offer users of point-forecast
models a complete toolbox with error metrics accounting for different
aspects of the agreement between predicted and observed values.

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

This is a basic example which shows you core functions of *metrica*:

``` r
library(metrica)
# Seed for reproducibility
set.seed(1)
X <- rnorm(n = 100, mean = 0, sd = 10)
Y <- X + rnorm(n=100, mean = 0, sd = 3)

# Data frame
example.data <- data.frame(obs = X, pred = Y)

# Create scatter plot with OP orientation
scatter.plot(obs = example.data$obs, pred = example.data$pred,
             orientation = "PO")
```

<img src="man/figures/README-example-1.png" width="100%" />

``` r
# Create tiles plot with PO orientation
tiles.plot(obs = example.data$obs, pred = example.data$pred,
           bins = 15, orientation = "PO")
```

<img src="man/figures/README-example-2.png" width="100%" />

``` r
# Create a Bland-Altman plot
bland.altman.plot(example.data$obs, example.data$pred)
```

<img src="man/figures/README-example-3.png" width="100%" />

``` r
# Estimate coefficient of determination (R2)
metrica::R2(obs = example.data$obs, pred = example.data$pred)
#> [1] 0.9070934

# Estimate RMSE
metrica::RMSE(obs = example.data$obs, pred = example.data$pred)
#> [1] 2.861482

# Estimate MBE
metrica::MBE(obs = example.data$obs, pred = example.data$pred)
#> [1] -0.1134242

# Estimate metrics summary
metrica::metrics.summary(obs = example.data$obs, pred = example.data$pred)
#> # A tibble: 31 × 2
#>    Metric    value
#>    <chr>     <dbl>
#>  1 B0       0.0650
#>  2 B1       1.05  
#>  3 R2       0.907 
#>  4 CCC      0.951 
#>  5 MAE      2.28  
#>  6 MAPE   543.    
#>  7 SMAPE   55.5   
#>  8 MBE     -0.113 
#>  9 PBE    -10.4   
#> 10 PAB      0.157 
#> # … with 21 more rows
```
