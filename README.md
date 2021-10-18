
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

This is a basic example which shows you core functions of metrica:

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
             orientation = "OP")
```

<img src="man/figures/README-example-1.png" width="100%" />

``` r
# Create tiles plot with PO orientation
tiles.plot(obs = example.data$obs, pred = example.data$pred, bins = 10, orientation = "PO")
```

<img src="man/figures/README-example-2.png" width="100%" />

``` r
# Estimate R2
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
#>          R2       CCC      MAE        MBE      MSE       MLA      MLP     RMSE
#> 1 0.9070934 0.9512255 2.283581 -0.1134242 8.188078 0.2095862 7.978492 2.861482
#>      RRMSE        RSR       PBE       PAB      PPB     MAPE   SMAPE      PLA
#> 1 2.627928 0.03582699 -10.41666 0.1571194 2.402532 542.9795 55.4614 2.559651
#>        PLP       Ue       Uc        Ub       NSE        E1      Erel       KGE
#> 1 97.44035 97.44035 2.402532 0.1571194 0.8974817 0.6797942 -46.14172 0.7936299
#>          d1       RAC        AC   DLambda
#> 1 0.8440456 0.9756118 0.9001633 0.9987515
```
