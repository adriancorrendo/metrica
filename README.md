
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
metrica::scatter.plot(obs = example.data$obs, pred = example.data$pred,
             orientation = "OP")
```

<img src="man/figures/README-example-1.png" width="100%" />

``` r
# Create tiles plot with PO orientation
metrica::tiles.plot(obs = example.data$obs, pred = example.data$pred,
           bins = 15, orientation = "PO")
```

<img src="man/figures/README-example-2.png" width="100%" />

``` r
# Create a Bland-Altman plot
metrica::bland.altman.plot(example.data$obs, example.data$pred)
```

<img src="man/figures/README-example-3.png" width="100%" />

``` r
# Estimate coefficient of determination (R2)
metrica::R2(obs = example.data$obs, pred = example.data$pred)
#> [1] 0.8974817

# Estimate RMSE
metrica::RMSE(obs = example.data$obs, pred = example.data$pred)
#> [1] 2.861482

# Estimate MBE
metrica::MBE(obs = example.data$obs, pred = example.data$pred)
#> [1] -0.1134242

# Estimate metrics summary
metrica::metrics.summary(obs = example.data$obs, pred = example.data$pred)
#> # A tibble: 36 × 2
#>    Metric    value
#>    <chr>     <dbl>
#>  1 B0       0.0650
#>  2 B1       1.05  
#>  3 R2       0.897 
#>  4 CCC      0.951 
#>  5 MAE      2.28  
#>  6 MAPE   543.    
#>  7 SMAPE   55.5   
#>  8 RAE      0.320 
#>  9 RSE      0.103 
#> 10 MBE     -0.113 
#> # … with 26 more rows
```

## Metrics available in *metrica*

The **metrica** package contains +40 functions . Most of them work with
only two arguments: `observed`(a.k.a. actual, measured, truth, target)
and `predicted` (a.k.a. simulated, fitted) values. For now, included
functions cover the world of “regression error” metrics (i.e. prediction
performance for continuous variables). Classification error metrics
coming soon. <br/>

<img src="https://render.githubusercontent.com/render/math?math=e^{i \pi} = -1">

| \#  | Metric   | Definition                                                                  | Details                                                                                             | Formula                                                                                                                                                                                                                                                                                                                          |
|-----|----------|-----------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1   | `B0`     | Intercept of SMA regression                                                 | Use                                                                                                 | ![equation](https://latex.codecogs.com/gif.image?%5Cdpi%7B300%7D%20%5Cbg_white%20%5Cbeta_%7B0_%7BPO%7D%7D%20=%20%5Cbar%7BP%7D%20-%20%5Cfrac%7BS_P%7D%7BS_O%7D) or ![equation](https://latex.codecogs.com/gif.image?%5Cdpi%7B300%7D%20%5Cbg_white%20%5Cbeta_%7B0_%7BOP%7D%7D%20=%20%5Cbar%7BO%7D%20-%20%5Cfrac%7BS_O%7D%7BS_P%7D) |
| 2   | `B1`     | Slope of SMA regression                                                     | Use                                                                                                 | ![equation](https://latex.codecogs.com/gif.image?%5Cdpi%7B300%7D%20%5Cbg_white%20%5Cbeta_%7B1_%7BSMA%7D%7D%20=%20%5Cfrac%7BS_O%7D%7BS_P%7D)                                                                                                                                                                                      |
| 3   | `r`      | Pearson’s correlation coefficient                                           | Strength of linear association between P and O. . However, it measures “precision” but no accuracy. | ![equation](https://latex.codecogs.com/gif.image?%5Cdpi%7B300%7D%20%5Cbg_white%20r%20=%20%5Cfrac%7B%7BS%7D_%7BPO%7D%7D%7B%7BS%7D_%7BP%7D%7BS%7D_%7BO%7D%7D)                                                                                                                                                                      |
| 4   | `R2`     | Coefficient of determination                                                | Strength of linear association between P and O. However, it measures “precision” but no accuracy    | ![equation](https://latex.codecogs.com/gif.image?%5Cdpi%7B300%7D%20%5Cbg_white%20R%5E%7B2%7D%20=%20%5Cfrac%7B%7BS%5E2%7D_%7BPO%7D%7D%7B%7BS%5E2%7D_%7BP%7D%7BS%5E2%7D_%7BO%7D%7D)                                                                                                                                                |
| 5   | `Xa`     | Accucacy coefficient                                                        | Measures accuracy. Used to adjust the precision measured by `r` to estimate agreement               | ![equation](https://latex.codecogs.com/gif.image?%5Cdpi%7B300%7D%20%5Cbg_white%20X_a%20=%20%5Cfrac%7B2%7D%7B%5Cfrac%7BS_P%7D%7BS_O%7D%20+%20%5Cfrac%7BS_O%7D%7BS_P%7D%20+%20%5Cfrac%7B(%5Cbar%7BO%7D-%5Cbar%7BP%7D)%5E2%7D%7BS_O%20S_P%7D%7D)                                                                                    |
| 6   | `CCC`    | Concordance correlation coefficient                                         | Tests agreement. It presents both precision (r) and accuracy (Xa) components. Easy to interpret     | ![equation](https://latex.codecogs.com/gif.image?%5Cdpi%7B300%7D%20%5Cbg_white%20CCC%20=%20r%20*%20X_a)                                                                                                                                                                                                                          |
| 7   | `MAE`    | Mean Absolute Error                                                         | Use                                                                                                 | ![equation](https://latex.codecogs.com/gif.image?%5Cdpi%7B300%7D%20%5Cbg_white%20MAE%20=%20%5Cfrac%7B1%7D%7Bn%7D%20%5Csum%7B%7CO_i%20-%20P_i%7C%7D)                                                                                                                                                                              |
| 8   | `MAPE`   | Mean Absolute Percentage Error                                              | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 9   | `SMAPE`  | Symmetric Mean Absolute Percentage Error                                    | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 10  | `RAE`    | Mean Absolute Error                                                         | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 11  | `RSE`    | Relative Absolute Error                                                     | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 12  | `MBE`    | Mean Bias Error                                                             | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 13  | `PBE`    | Percentage Bias Error                                                       | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 14  | `PAB`    | Percentage Absolute Error                                                   | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 15  | `PPB`    | Percentage Proportional Bias                                                | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 16  | `MSE`    | Mean Squared Error                                                          | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 17  | `RMSE`   | Root Mean Squared Error                                                     | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 18  | `RSE`    | Relative Squared Error                                                      | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 19  | `RRMSE`  | Relative Root Mean Squared Error                                            | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 20  | `RSR`    | Root Mean Standard Deviation Ratio                                          | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 21  | `iqRMSE` | Inter-quartile Normalized Root Mean Squared Error                           | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 22  | `MLA`    | Mean Lack of Accuracy. Correndo’s MSE decomposition. Correndo et al. (2012) | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 23  | `MLP`    | Mean Lack of Precision Correndo’s MSE decomposition. Correndo et al. (2012) | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 24  | `PLA`    | Percentage Lack of Accuracy                                                 | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 25  | `PLP`    | Percentage Lack of Precision                                                | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 26  | `MSEs`   | Systematic MSE. Willmott’s MSE decomposition. Willmott et al. (1985)        | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 27  | `MSEu`   | Unsystematic MSE. Willmott’s MSE decomposition. Willmott et al. (1985)      | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 28  | `SB`     | Squared Bias. Kobayashi and Salam’s decomposition                           | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 29  | `SDSD`   | Product of Standard Deviations. Kobayashi and Salam’s decomposition         | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 30  | `LCS`    | Lack of Correlation. Kobayashi and Salam’s decomposition                    | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 31  | `Ue`     | Random error proportion. Theils’ partial inequalities                       | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 32  | `Uc`     | Lack of Consistency. Theils’ partial inequalities                           | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 33  | `Ub`     | Bias error proportion. Theils’ partial inequalities                         | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 34  | `NSE`    | Nash and Sutcliffe’s Model Efficiency. Nash and Sutcliffe (1970)            | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 35  | `E1`     | Absolute Model Efficiency.                                                  | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 36  | `Erel`   | Relative Model Efficiency. Krause et al. (2005)                             | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 37  | `KGE`    | Kling-Gupta Model Efficiency. Kling et al. (2012)                           | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 38  | `d`      | Index of Agreement. Willmott (1982)                                         | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 39  | `d1`     | Absolute Index of Agreement. Willmott et al. (1985)                         | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 40  | `RAC`    | Robinson’s Agreement Coefficient. Robinson (1957)                           | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 41  | `AC`     | Ji and Gallo’s Agreement Coefficient. Ji and Gallo (2006)                   | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
| 42  | `lambda` | Duveiller’s Lambda Coefficient. Duveiller et al. (2015)                     | Use                                                                                                 | Formula                                                                                                                                                                                                                                                                                                                          |
