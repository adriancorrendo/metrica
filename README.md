
<!-- README.md is generated from README.Rmd. Please edit that file -->

# metrica: Prediction performance metrics.

<!-- badges: start -->

[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/adriancorrendo/metrica?branch=master&svg=true)](https://ci.appveyor.com/project/adriancorrendo/metrica)
[![R-CMD-check](https://github.com/adriancorrendo/metrica/workflows/R-CMD-check/badge.svg)](https://github.com/adriancorrendo/metrica/actions)
<!-- badges: end -->

The goal of the *metrica* package is to offer users of point-forecast
models a toolbox with a wide spectrum of goodness of fit and error
metrics (+40) accounting for different aspects of the agreement between
predicted and observed values. Also, some basic visualization functions
to assess models performance (e.g. scatter with regression line;
Bland-Altman plot) are provided in customizable format (ggplot).

<img src="man/figures/metrica_logo.png" align="right" height="150" style="float:right; height:150px;">

## 1. Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("adriancorrendo/metrica")
```

## 2. Native datasets

The *metrica* package comes with four example datasets from the APSIM
software: <br/> 1. `wheat`. 137 data-points of wheat grain N (grams per
squared meter) <br/> 2. `barley`. 69 data-points of barley grain number
(x1000 grains per squared meter) <br/> 3. `sorghum`. 36 data-points of
sorghum grain number (x1000 grains per squared meter) <br/> 4.
`chickpea`. 39 data-points of chickpea aboveground dry mass (kg per
hectare) <br/>

These data correspond to the latest, up-to-date, documentation and
validation of version number 2020.03.27.4956. Data available at:
<https://doi.org/10.7910/DVN/EJS4M0>. Further details can be found at
the official APSIM Next Generation website:
<https://APSIMnextgeneration.netlify.app/modeldocumentation> <br/>

## 3. Example Code

This is a basic example which shows you the core functions of *metrica*:

``` r
library(metrica)
library(dplyr)
library(purrr)
library(tidyr)
library(ggpmisc)

# 1. A. Create a fake dataset
# Set seed for reproducibility
set.seed(1)
# Create a random vector (X) with 100 values
X <- rnorm(n = 100, mean = 0, sd = 10)
# Create a second vector (Y) with 100 values by adding error with respect
# to the first vector (X).
Y <- X + rnorm(n=100, mean = 0, sd = 3)
# Merge vectors in a data frame, rename them as synonyms of observed (measured) and predicted (simulated)
example.data <- data.frame(measured = X, simulated = Y)

# 1. B. Or call native example datasets

example.data <- barley %>%  # or 'wheat', 'sorghum', or 'chickpea'
# 1.b. create columns as synonyms of observed (measured) and predicted (simulated)
                mutate(measured = obs, simulated = pred)  


# 2. Use metrica plot functions
# 2.a. Create scatter plot with PO orientation
barley.scat.plot <- metrica::scatter_plot(data = example.data, obs = measured, pred = simulated,
             orientation = "PO")
barley.scat.plot
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

``` r
# Alternative using vectors instead of dataframe
#metrica::scatter_plot(obs = example.data$obs, pred = example.data$pred)

# 2.b. Create tiles plot with OP orientation
barley.tiles.plot <- metrica::tiles_plot(data = example.data, obs = measured, pred = simulated,
           bins = 15, orientation = "OP")

barley.tiles.plot
```

<img src="man/figures/README-unnamed-chunk-2-2.png" width="100%" />

``` r
# 2.c. Create a Bland-Altman plot
barley.ba.plot <- metrica::bland_altman_plot(data = example.data,
                           obs = measured, pred = simulated)

barley.ba.plot
```

<img src="man/figures/README-unnamed-chunk-2-3.png" width="100%" />

``` r
# 3. Get metrics estimates
# 3.a. Single estimates
# 3.a.i. Estimate coefficient of determination (R2)

metrica::R2(data = example.data, obs = measured, pred = simulated)
#> [1] 0.4512998

# 3.a.ii. Estimate root mean squared error (RMSE)
metrica::RMSE(data = example.data, obs = measured, pred = simulated)
#> [1] 3.986028

# 3.a.iii. Estimate mean bias error (MBE)
metrica::MBE(data = example.data, obs = measured, pred = simulated)
#> [1] 0.207378

# 3.b. Metrics Summary 
metrics.sum <- metrica::metrics_summary(data = example.data, 
                                        obs = measured, pred = simulated)  
# Print first 15
head(metrics.sum, n = 15)
#>    Metric      Score
#> 1      B0  1.1282743
#> 2      B1  0.9288715
#> 3       r  0.6717885
#> 4      R2  0.4512998
#> 5      Xa  0.9963915
#> 6     CCC  0.6693644
#> 7     MAE  3.0595501
#> 8    RMAE  0.1629325
#> 9    MAPE 16.8112673
#> 10  SMAPE 16.7848032
#> 11    RAE  0.7639151
#> 12    RSE  0.6164605
#> 13    MBE  0.2073780
#> 14    PBE  1.1043657
#> 15    PAB  0.2706729

# Optional wrangling (WIDE)
metrics.sum.wide <- metrics.sum %>%
  tidyr::pivot_wider(tidyr::everything(),
                      names_from = "Metric",
                      values_from = "Score") 

# 4. Test multiple datasets at once
# 4.a. Create nested df with the native examples
nested.examples <- bind_rows(list(wheat = metrica::wheat, 
                                  barley = metrica::barley,
                                  sorghum = metrica::sorghum, 
                                  chickpea = metrica::chickpea), 
                             .id = "id") %>%
  dplyr::group_by(id) %>% tidyr::nest() %>% dplyr::ungroup()

head(nested.examples %>% group_by(id) %>% dplyr::slice_head(n=2))
#> # A tibble: 4 x 2
#> # Groups:   id [4]
#>   id       data              
#>   <chr>    <list>            
#> 1 barley   <tibble [69 x 2]> 
#> 2 chickpea <tibble [39 x 2]> 
#> 3 sorghum  <tibble [36 x 2]> 
#> 4 wheat    <tibble [137 x 2]>

# 4.b. Run 
multiple.sum <- nested.examples %>% 
  # Store metrics in new.column "performance"
  mutate(performance = map(data, ~metrica::metrics_summary(data=., obs = obs, pred = pred)))

head(multiple.sum)
#> # A tibble: 4 x 3
#>   id       data               performance  
#>   <chr>    <list>             <list>       
#> 1 wheat    <tibble [137 x 2]> <df [41 x 2]>
#> 2 barley   <tibble [69 x 2]>  <df [41 x 2]>
#> 3 sorghum  <tibble [36 x 2]>  <df [41 x 2]>
#> 4 chickpea <tibble [39 x 2]>  <df [41 x 2]>
```

## 4. Print metrics in a plot

``` r
df <- metrica::wheat

# B. Create list of selected metrics
selected.metrics <- c("MAE","RMSE", "RRMSE", "R2", "CCC", "KGE", "PLA", "PLP")

metrica::scatter_plot(data = df, obs = obs, pred = pred, print_metrics = TRUE, 
                      metrics_list = selected.metrics)
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

## 5. Import simulated data from APSIM Classic (.out) and APSIM NextGen (.db)

``` r
# Use import_apsim_out for APSIM Classic output
soybean.out <- metrica::import_apsim_out(filepath = "tests/testthat/examples/soybean.out")

# Use import_apsim_db for APSIM NextGeneration output
soybean.db <- metrica::import_apsim_db(filename = "soybean.example.db",  folder = "tests/testthat/examples/")

head(soybean.out)
#>   Date (dd/mm/yyyy) yield (kg/ha) biomass (kg/ha) grain_protein (%)
#> 1        16/05/2001        1449.8          2915.9            37.115
#> 2        10/05/2002        1092.5          2965.1            37.115
#> 3        23/04/2003        1368.9          3529.6            37.115
#> 4        26/04/2004        2121.6          4710.3            37.115
#> 5        09/05/2005        1950.3          4303.9            37.115
#> 6        20/04/2006        1670.6          3806.6            37.115
#>   GrainN (g/m^2) lai (m^2/m^2) oilGrainN (g/m^2) grain_oil_conc (%)
#> 1           0.00             0                 0                0.4
#> 2           7.10             0                 0                0.4
#> 3           8.90             0                 0                0.4
#> 4          13.79             0                 0                0.4
#> 5          12.68             0                 0                0.4
#> 6          10.86             0                 0                0.4
#head(soybean.db)

# If observed.data is already as a dataframe, the user may do the match using a simple code like this:
# PO.dataframe <- simulated.data %>% left_join(., observed.data) *by = "col" arg. could be required*
```

## 6. Performance metrics available in *metrica*

The **metrica** package contains +40 functions. Two arguments are always
required: `observed`(Oi; a.k.a. actual, measured, truth, target) and
`predicted` (Pi; a.k.a. simulated, fitted) values. Also, there is an
optional `data` arg. that allows to call an existing data frame
containing both observed and predicted. <br/>

Some functions, also require to define axis `orientation`, such as the
slope of linear regression describing the bivariate scatter. Current
included functions cover the world of “regression error” metrics
(i.e. prediction performance for continuous variables). Classification
error metrics coming soon. <br/>

Always keep in mind that predicted values should come from out-of-bag
samples (unseen by training set) to avoid overestimation of prediction
performance. <br/>

| \#  | Metric   | Definition                                                       | Details                                                                                                                                                                                                                                                                                                                                                                     | Formula                                                                                                                         |
|-----|----------|------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|
| A   | `RSS`    | Residual sum of squares (a.k.a. as sum of squares)               | The sum of squared differences between predicted and observed values. It represents the base of many error metrics using squared scale such as the MSE                                                                                                                                                                                                                      | ![equation](formulae/A.RSS.gif)                                                                                                 |
| B   | `TSS`    | Total sum of squares                                             | The sum of the squared differences between the observations and its mean. It is used as a reference error, for example, to estimate explained variance                                                                                                                                                                                                                      | ![equation](formulae/B.TSS.gif)                                                                                                 |
| C   | `var_u`  | Sample variance, uncorrected                                     | The mean of sum of squared differences between values of an `x` and its mean (divided by n, not n-1)                                                                                                                                                                                                                                                                        | ![equation](formulae/C.var.u.gif)                                                                                               |
| D   | `uSD`    | Sample standard deviation, uncorrected                           | The square root of the mean of sum of squared differences between values of an `x` and its mean (divided by n, not n-1)                                                                                                                                                                                                                                                     | ![equation](formulae/D.uSD.gif)                                                                                                 |
| 1   | `B0`     | Intercept of SMA regression                                      | SMA is a symmetric linear regression (invariant results/interpretation to axis orientation) recommended to describe the bivariate scatter instead of OLS regression (classic linear model, which results vary with the axis orientation). B0 could be used to test agreement along with B1 (H0: B0 = 0, B1 = 1)                                                             | ![equation](formulae/1.B0.gif)                                                                                                  |
| 2   | `B1`     | Slope of SMA regression                                          | SMA is a symmetric linear regression (invariant results/interpretation to axis orientation) recommended to describe the bivariate scatter instead of OLS regression (classic linear model, which results vary with the axis orientation). B1 could be used to test isometry of the PO scatter (H0: B1 = 1). B1 also represents the ratio of standard deviations (So and Sp) | ![equation](formulae/2.B1.gif)                                                                                                  |
| 3   | `r`      | Pearson’s correlation coefficient                                | Strength of linear association between P and O. However, it measures “precision” but no accuracy.                                                                                                                                                                                                                                                                           | ![equation](formulae/3.r.gif)                                                                                                   |
| 4   | `R2`     | Coefficient of determination                                     | Strength of linear association between P and O. However, it measures “precision” but no accuracy                                                                                                                                                                                                                                                                            | ![equation](formulae/4.R2.gif)                                                                                                  |
| 5   | `Xa`     | Accuracy coefficient                                             | Measures accuracy. Used to adjust the precision measured by `r` to estimate agreement                                                                                                                                                                                                                                                                                       | ![equation](formulae/5.Xa.gif)                                                                                                  |
| 6   | `CCC`    | Concordance correlation coefficient                              | Tests agreement. It presents both precision (r) and accuracy (Xa) components. Easy to interpret                                                                                                                                                                                                                                                                             | ![equation](formulae/6.CCC.gif)                                                                                                 |
| 7   | `MAE`    | Mean Absolute Error                                              | Measures both lack of accuracy and precision in absolute scale. It keeps the same units than the response variable. Less sensitive to outliers than the MSE or RMSE                                                                                                                                                                                                         | ![equation](formulae/7.MAE.gif)                                                                                                 |
| 8   | `RMAE`   | Relative Mean Absolute Error                                     | Normalizes the MAE with respect to the mean of observations                                                                                                                                                                                                                                                                                                                 | ![equation](formulae/8.RMAE.gif)                                                                                                |
| 9   | `MAPE`   | Mean Absolute Percentage Error                                   | Percentage units (independent scale). Easy to explain and to compare performance across models with different response variables. Asymmetric and unbounded.                                                                                                                                                                                                                 | ![equation](formulae/9.MAPE.gif)                                                                                                |
| 10  | `SMAPE`  | Symmetric Mean Absolute Percentage Error                         | SMAPE tackles the asymmetry issues of MAPE and includes lower (0%) and upper (200%) bounds.                                                                                                                                                                                                                                                                                 | ![equation](formulae/10.SMAPE.gif)                                                                                              |
| 11  | `RAE`    | Relative Absolute Error                                          | RAE normalizes MAE with respect to the total absolute error. Lower bound at 0 (perfect fit) and no upper bound (infinity)                                                                                                                                                                                                                                                   | ![equation](formulae/11.RAE.gif)                                                                                                |
| 12  | `RSE`    | Relative Squared Error                                           | Proportion of the total sum of squares that corresponds to differences between predictions and observations (residual sum of squares)                                                                                                                                                                                                                                       | ![equation](formulae/12.RSE.gif)                                                                                                |
| 13  | `MBE`    | Mean Bias Error                                                  | Main bias error metric. Same units as the response variable. Related to differences between means of predictions and observations. Negative values indicate overestimation. Positive values indicate underestimation. Unbounded.                                                                                                                                            | ![equation](formulae/13.MBE.gif)                                                                                                |
| 14  | `PBE`    | Percentage Bias Error                                            | Useful to identify systematic over or under predictions. Percentage units. As the MBE, PBE negative values indicate overestimation, while positive values indicate underestimation. Unbounded.                                                                                                                                                                              | ![equation](formulae/14.PBE.gif)                                                                                                |
| 15  | `PAB`    | Percentage Additive Bias                                         | Percentage of the MSE related to systematic additive issues on the predictions. Related to difference of the means of predictions and observations                                                                                                                                                                                                                          | ![equation](formulae/15.PAB.gif)                                                                                                |
| 16  | `PPB`    | Percentage Proportional Bias                                     | Percentage of the MSE related to systematic proportionality issues on the predictions. Related to slope of regression line describing the bivariate scatter                                                                                                                                                                                                                 | ![equation](formulae/16.PPB.gif)                                                                                                |
| 17  | `MSE`    | Mean Squared Error                                               | Comprises both accuracy and precision. High sensitivity to outliers                                                                                                                                                                                                                                                                                                         | ![equation](formulae/17.MSE.gif)                                                                                                |
| 18  | `RMSE`   | Root Mean Squared Error                                          | Comprises both precision and accuracy, has the same units than the variable of interest. Very sensitive to outliers                                                                                                                                                                                                                                                         | ![equation](formulae/18.RMSE.gif)                                                                                               |
| 19  | `RRMSE`  | Relative Root Mean Squared Error                                 | RMSE normalized by the mean of observations                                                                                                                                                                                                                                                                                                                                 | ![equation](formulae/19.RRMSE.gif)                                                                                              |
| 20  | `RSR`    | Root Mean Standard Deviation Ratio                               | RMSE normalized by the standard deviation of observations                                                                                                                                                                                                                                                                                                                   | ![equation](formulae/20.RSR.gif)                                                                                                |
| 21  | `iqRMSE` | Inter-quartile Normalized Root Mean Squared Error                | RMSE normalized by the interquartile range length (between percentiles 25th and 75th)                                                                                                                                                                                                                                                                                       | ![equation](formulae/21.iqRMSE.gif)                                                                                             |
| 22  | `MLA`    | Mean Lack of Accuracy                                            | Bias component of MSE decomposition. Correndo et al. (2021)                                                                                                                                                                                                                                                                                                                 | ![equation](formulae/22.MLA.gif)                                                                                                |
| 23  | `MLP`    | Mean Lack of Precision                                           | Variance component of MSE decomposition. Correndo et al. (2021)                                                                                                                                                                                                                                                                                                             | ![equation](formulae/23.MLP.gif)                                                                                                |
| 24  | `PLA`    | Percentage Lack of Accuracy                                      | Percentage of the MSE related to lack of accuracy (systematic differences) on the predictions                                                                                                                                                                                                                                                                               | ![equation](formulae/24.PLA.gif)                                                                                                |
| 25  | `PLP`    | Percentage Lack of Precision                                     | Percentage of the MSE related to lack of precision (unsystematic differences) on the predictions                                                                                                                                                                                                                                                                            | ![equation](formulae/25.PLP.gif)                                                                                                |
| 26  | `SB`     | Squared Bias. Kobayashi and Salam (2000)                         | Additive bias component, MSE decomposition                                                                                                                                                                                                                                                                                                                                  | ![equation](formulae/26.SB.gif)                                                                                                 |
| 27  | `SDSD`   | Product of Standard Deviations. Kobayashi and Salam (2000)       | Proportional bias component, MSE decomposition                                                                                                                                                                                                                                                                                                                              | ![equation](formulae/27.SDSD.gif)                                                                                               |
| 28  | `LCS`    | Lack of Correlation. Kobayashi and Salam (2000)                  | Random error component, MSE decomposition                                                                                                                                                                                                                                                                                                                                   | ![equation](formulae/28.LCS.gif)                                                                                                |
| 29  | `Ue`     | Random error proportion of sum of squares. Smith and Rose (1995) | Sum of squares decomposition. Theils’ partial inequalities                                                                                                                                                                                                                                                                                                                  | ![equation](formulae/29.Ue.gif)                                                                                                 |
| 30  | `Uc`     | Lack of Consistency. Smith and Rose (1995)                       | Sum of squares decomposition. Theils’ partial inequalities                                                                                                                                                                                                                                                                                                                  | ![equation](formulae/30.Uc.gif)                                                                                                 |
| 31  | `Ub`     | Proportional Bias error proportion. Smith and Rose (1995)        | Sum of squares decomposition. Theils’ partial inequalities                                                                                                                                                                                                                                                                                                                  | ![equation](formulae/31.Ub.gif)                                                                                                 |
| 32  | `NSE`    | Nash and Sutcliffe’s Model Efficiency. Nash and Sutcliffe (1970) | Model efficiency using squared residuals                                                                                                                                                                                                                                                                                                                                    | ![equation](formulae/32.NSE.gif)                                                                                                |
| 33  | `E1`     | Absolute Model Efficiency. Legates and McCabes (1999)            | Model efficiency. Modification of NSE using absolute residuals instead of squared residuals                                                                                                                                                                                                                                                                                 | ![equation](formulae/33.E1.gif)                                                                                                 |
| 34  | `Erel`   | Relative Model Efficiency. Krause et al. (2005)                  | Model efficiency                                                                                                                                                                                                                                                                                                                                                            | ![equation](formulae/34.Erel.gif)                                                                                               |
| 35  | `KGE`    | Kling-Gupta Model Efficiency. Kling et al. (2012)                | Model efficiency with accuracy, precision, and consistency components                                                                                                                                                                                                                                                                                                       | ![equation](formulae/35.KGE.gif)                                                                                                |
| 36  | `d`      | Index of Agreement. Willmott (1982)                              | Measures accuracy and precision using squared residuals. Dimensionless (normalized). Bounded \[0;1\]. Asymmetric.                                                                                                                                                                                                                                                           | ![equation](formulae/36.d.gif)                                                                                                  |
| 37  | `d1`     | Modified Index of Agreement. Willmott et al. (1985)              | Measures accuracy and precision using absolute residuals(1). Dimensionless (normalized). Bounded \[0;1\]. Asymmetric.                                                                                                                                                                                                                                                       | ![equation](formulae/37.d1.gif)                                                                                                 |
| 38  | `d1r`    | Refined Index of Agreement. Willmott et al. (2012)               | Refines d1 by a modification on the denominator (potential error) to normalize absolute error                                                                                                                                                                                                                                                                               | ![equation](formulae/38.d1r.gif)                                                                                                |
| 39  | `RAC`    | Robinson’s Agreement Coefficient. Robinson (1957)                | RAC measures both accuracy and precision (general agreement). Dimensionless (normalized). Bounded \[0;1\]. Symmetric.                                                                                                                                                                                                                                                       | ![equation](formulae/39a.RAC.gif) where ![equation](formulae/39b.RAC.gif)                                                       |
| 40  | `AC`     | Ji and Gallo’s Agreement Coefficient. Ji and Gallo (2006)        | AC measures both accuracy and precision (general agreement). Dimensionless (normalized). Positively bounded \[-infinity;1\]. Symmetric.                                                                                                                                                                                                                                     | ![equation](formulae/40.AC.gif)                                                                                                 |
| 41  | `lambda` | Duveiller’s Lambda Coefficient. Duveiller et al. (2015)          | `lambda` measures both accuracy and precision. Dimensionless (normalized). Bounded \[-1;1\]. Symmetric. Equivalent to CCC when `r` is greater or equal to 0                                                                                                                                                                                                                 | ![equation](formulae/41a.lambda.gif) where ![equation](formulae/41b.lambda.gif), otherwise ![equation](formulae/41c.lambda.gif) |
