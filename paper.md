---
title: 'metrica: an R package to evaluate prediction performance of regression
and classification point-forecast models'
tags:
  - R
  - APSIM
  - Machine Learning
  - error metrics
  - prediction quality
authors:
  - name: Adrian A. Correndo^[Corresponding author] 
    orcid: 0000-0002-4172-289X
    affiliation: 1
  - name: Luiz H. Moro Rosso 
    orcid: 0000-0002-8642-911X
    affiliation: 2
  - name: Carlos H. Hernandez
    orcid: 0000-0001-5171-2516
    affiliation: 1
  - name: Leonardo M. Bastos
    orcid: 0000-0001-8958-6527
    affiliation: 5
  - name: Luciana Nieto 
    orcid: 0000-0002-7172-0799
    affiliation: 1
  - name: Dean Holzworth
    orcid: 0000-0000-0000-0000
    affiliation: 4
  - name: Ignacio A. Ciampitti
    orcid: 0000-0001-9619-5129
    affiliation: 1
affiliations:
 - name: Department of Agronomy, Kansas State University, Manhattan, KS, USA.
   index: 1
 - name: Private Consultant, Brasil.
   index: 2
 - name: Department of Crop and Soil Sciences, University of Georgia, Athens, GA, USA.
   index: 3
 - name: CSIRO Agriculture and Food, Australia.
   index: 4
date: 18 July 2022
bibliography: paper.bib
---

# Summary 

![](man/figures/metrica_logo.png){ width=24% align=left}

The `metrica` R-package [@metrica_manual] is an open-source software designed to facilitate the quantitative and visual assessment of prediction performance of point-forecast simulation models for continuous (regression) and categorical variables (classification). The package assembles a series of 80+ functions that account for multiple aspects of the agreement between predicted and observed values. Without the need of advanced skills on programming, `metrica` enables users to automate the estimation of multiple prediction performance metrics including goodness of fit, error metrics, error decomposition, model efficiency, indices of agreement, and to produce stylish data visualization outputs. This article introduces the `metrica` R-package, developed with the main objective of contributing to reproducible evaluation of point-forecast models performance.

# Statement of need

Evaluating the prediction quality is a crucial step for any simulation model, for which a myriad of metrics and visualization techniques have been developed [@Tedeschi_2006; @Yang_2014; @Wallach_etal_2019]. Nonetheless, to conduct a comprehensive assessment of the predicted-observed agreement in R [@R_Core_Team], users normally have to rely on multiple packages, and even on self-defined functions, which increases the risk of involuntary mistakes due to the need of fluctuating syntax and data wrangling.

As the reproducibility of data analysis continues to be a challenge for science [@Seibold_2022], the development of open source software like `metrica` represent a step-forward toward transparent and reproducible process to assist researchers on evaluating models performance. We specifically decided to create `metrica` in R software [@R_Core_Team] due to its substantial role in data science [@Thiem_2018]. Under the open-source philosophy, R hosts cutting-edge algorithms that combined with an infrastructure like the Comprehensive R Archive Network (CRAN) -enhancing global dissemination-, clearly empowers the democratization of statistical computing [@Hackenberger_2020].

Finally, it is noteworthy that in the area of agricultural sciences, although point-forecast simulation models such as the Agricultural Production Systems sIMulator (APSIM) [@APSIM_classic; @APSIM_nextgen] count with tools to facilitate the integration into R through packages such as apsimx [@apsimx_manual], the assessment of their prediction quality is not yet integrated for R users. Therefore, we aim `metrica` to offer users of agricultural simulation models a toolbox for assessing the simulation performance.

# Package features

For regression models, `metrica` includes 4 plotting functions (scatter, tiles, density, & Bland-Altman plots) using `ggplot2` [@ggplot_book], and 48 prediction performance scores. For classification models (two-class or multi-class), it includes one function to visualize the confusion matrix, and 27 functions of prediction scores. The full list of regression and classification performance metrics, along with their corresponding description, formula, and literature sources, is presented in the package documentation at: 

- Regression metrics: https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html.

- Classification metrics: https://adriancorrendo.github.io/metrica/articles/available_metrics_classification.html.

To extent of our knowledge, compared to similar R packages designed for model evaluation such as `yardstick` [@yardstick_manual], `mlr3` [@mlr3_paper], `Metrics` [@Metrics_manual], `hydroGOF` [@hydroGOF_manual], `cvms` [@cvms_package], `scoringutils`[@scoringutils_package], or `performance` [@performance_paper], `metrica` provides several unique features not supported, or partially supported by the latter such as:

- offering the most extensive collection of prediction performance metrics for both regression (48) and classification (27) models.

- working under both vectorized (just calling variables with $) or tabulated forms (using the `data` argument).

- controling the output format as a list (`tidy = FALSE`) or as a table (`tidy = TRUE`).

- for classification, functions automatically recognizing two-class or multi-class data; and specifically for multi-class cases, several metrics can be estimated for each class (`atom = TRUE`).

- for regression, implementing a symmetric linear regression (standardized major axis-SMA-, [@Warton_2006]) to describe: i) the pattern of the bivariate relationship with linear parameters (`B0_sma`, `B1_sma`), and ii) the degree of predicted-observed agreement by using the SMA-line to decompose the mean-squared-error (MSE) into lack of accuracy (`MLA`, `PLA`, `RMLA`) and lack of precision (`MLP`, `PLP`, `RMLP`) components [@CORRENDO2021_AgSyst]. 

- offering alternative MSE decomposition approaches such as the ones described by [@Kobayashi_Salam_2000] (`SB`, `SDSD`, `LCS`), and by [@Smith_Rose_1995] (`Ub`, `Uc`, `Ue`).

- including multiple indices of agreement and model efficiencies at their alternative versions such as: i) the index of agreement `d` [@Willmott_1981], and its modified `d1` [@Willmott_etal_1985] and refined `d1r` [@Willmott_etal_2012] variants, ii) the Nash–Sutcliffe model efficiency (`NSE`) [@Nash_1970] and its improved variants `E1` [@Legates_1999], `Erel` [@Krause_2005], and Kling-Gupta model efficiency (`KGE`) [@Kling_etal_2012], iii) the Robinson's index of agreement (RAC) [@Robinson_1957; @Robinson_1959], iv) the Ji & Gallo agreement coefficient (AC) [@Ji_Gallo_2006], v) the Duvellier's `lambda` [@Duveiller_2016], vi) the distance correlation (`dcorr`) [@Szekely_2007], or vii) the maximal information coefficient (`MIC`) [@Reshef_2011]), among others.

- importing files from APSIM Classic with `import_apsim_out()`), and from APSIM Next Generation with the `import_apsim_db()` function.

## System requirements and installation

Since `metrica` operates within R, the first step is to install R (version 4.2.0 or higher). We encourage users to install RStudio desktop [@RStudio_manual], a free and user-friendly environment that facilitates operations in R.

To install and load the package:

```r
# Stable version (CRAN)
install.packages("metrica")

# Development version (GitHub)
devtools::install_github("adriancorrendo/metrica")

# Load
library(metrica)

```

## Using the functions

There are two basic arguments common to all `metrica` functions: (i) `obs`(Oi; observed, a.k.a. actual, measured, truth, target, label), and (ii) `pred` (Pi; predicted, a.k.a. simulated, fitted, modeled, estimate) values. 

For regression, some specific functions require defining the axis `orientation` (e.g. the slope of the SMA regression (`B1_sma`)). 

For two-class models, the `pos_level` argument serves to indicate the alphanumeric order of the “positive level”. Following most two-class denominations as c(0,1), c(“Negative”, “Positive”), and c(“FALSE”, “TRUE”), the default `pos_level = 2` (1, “Positive”, “TRUE”). However, we recognize other cases as possible (e.g. c(“Crop”, “NoCrop”)), for which the user needs to specify pos_level = 1.

For multi-class classification, some functions present the `atom` argument (TRUE / FALSE), which controls the output to be an overall average estimate across all classes (default), or class-wise.

## Example 1: Regression (continuous variables)

The following lines of code serve to run basic regression performance analysis using a native dataset called `wheat`.

```r
# Define dataset
data_wheat <- metrica::wheat

# Estimate Root Mean Square Error, result as a list
RMSE(data = data_wheat, obs = obs, pred = pred, tidy = FALSE)
#> $RMSE
#> [1] 1.666441

# Store results as a data frame
RMSE(data = data_wheat, obs = obs, pred = pred, tidy = TRUE)
```
| Metric | Score |
|---|---|
| RMSE | 1.67 |


Estimate multiple regression metrics at once using `metrica::metrics_summary()`:

```r
# Define metrics list
my_reg_metrics <- c("R2", "CCC", "MBE", "RMSE", "RSR", "NSE", "KGE")

# Run metrics summary
metrics_summary(data = data_wheat, 
                obs = obs, pred = pred,
                type = "regression", 
                metrics_list = my_reg_metrics)

#>         Metric          Score
#> 1           R2     0.84555376
#> 2          CCC     0.91553253
#> 3          MBE     0.31815953
#> 4         RMSE     1.66644142
#> 5          RSR     0.09678632
#> 6          PLP     5.15949064
#> 7          PLA    94.84050936
#> 8          NSE     0.83871126
#> 9          KGE     0.91064709
                
```

To produce a scatter plot of predicted vs. observed values as a customizable `ggplot` object users may use:

```r
scatter_plot(data = data_wheat, 
             obs = obs , pred = pred,
             orientation = "PO",
             print_metrics = TRUE, 
             metrics_list = my_reg_metrics
             print_eq = TRUE,
             position_eq = c(x=15, y = 2), 
             # Optional arguments to customize the plot
             shape_type = 21,
             shape_color = "steelblue",
             shape_size = 3,
             regline_type = "F1",
             regline_color = "#9e0059",
             regline_size = 2)+
  # Customize axis breaks
  scale_y_continuous(breaks = seq(0,30, by = 5))+
  scale_x_continuous(breaks = seq(0,30, by = 5))
```

![Figure 1. Predicted vs. Observed scatter plot using metrica::scatter_plot(). ](man/figures/JOSS_regression_scatter_plot.png) 

### Classification (categorical variables)

The following lines of code serve to run a basic classification performance analysis using a native dataset called `maize_phenology`.

```r
# Define dataset
data_multiclass <- metrica::maize_phenology

# Estimate accuracy, result as a list
accuracy(data = data_multiclass, obs = actual, pred = predicted, tidy = FALSE)

#> $accuracy
#> [1] 0.8834951

# Result as a data frame
accuracy(data = data_multiclass, obs = actual, pred = predicted, tidy = TRUE)

#>         Metric       Score
#> 1     accuracy   0.8834951

```
| Metric | Score |
|---|---|
| accuracy | 0.8834951 |

```r
# Define selected metrics
my_class_metrics <- c("accuracy", "precision", "recall", "specificity",
                      "fscore", "gmean", "khat")

# Run the summary for selected metrics    
metrics_summary(data = data_multiclass, 
                obs = actual, pred = predicted,
                type = "classification")

#>         Metric        Score
#> 1     accuracy 8.834951e-01
#> 2    precision 8.335108e-01
#> 3       recall 8.405168e-01
#> 4  specificity 9.915764e-01
#> 5       fscore 8.369991e-01
#> 6          agf 8.370017e-01
#> 7        gmean 9.129275e-01
#> 8         khat 8.624527e-01
                
```

To produce a classical confusion matrix plot users may use:

```r
confusion_matrix(data = data_multiclass,
                 obs = actual, pred = predicted, 
                 plot = TRUE, 
                 colors = c(low="grey85" , high="steelblue"), 
                 unit = "count",
                 # Print metrics_summary
                 print_metrics = TRUE,
                 # List of performance metrics
                 metrics_list = my_class_metrics,
                 # Position (bottom or top)
                 position_metrics = "bottom")

```

![Figure 2. Confusion matrix plot using metrica::confusion_matrix().](man/figures/JOSS_classification_confusion_matrix.png) 


# Acknowledgements

Authors gratefully acknowledge the financial support from Kansas State University for sponsoring A.A. Correndo's Postdoctoral Position and Dr. I.A. Ciampitti's research program. This is contribution no. 22-###-J from the Kansas Agricultural Experiment Station.

# References