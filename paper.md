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
    affiliation: 3
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
 - name: Department of Agronomy, University of Georgia, GA, USA.
   index: 3
 - name: CSIRO, Australia.
   index: 4
date: 18 July 2022
bibliography: paper.bib
---

# Summary 

![Figure #. Metrica logo.](man/figures/metrica_logo.png){ width=15% }

The `metrica` R-package [@metrica_manual] is an open-source software designed to facilitate the quantitative and visual assessment of prediction performance of point-forecast simulation models for continuous (regression) and categorical variables (classification). The package assembles a series of more than 80 functions that account for multiple aspects of the agreement between predicted and observed values. Without the need of advanced skills on programming, `metrica` enables users to automate the estimation of multiple prediction performance metrics including goodness of fit, error metrics, error decomposition, model efficiency, indices of agreement, and to produce stylish data visualization outputs.

# Statement of need

Evaluating the prediction quality is perhaps the most relevant step for any simulation model (@Wallach_etal_2019). A myriad of metrics and visualization techniques exist to conduct the prediction performance assessment (@Tedeschi_2006, add 1-2 more). However, to conduct a comprehensive assessment of predicted-observed agreement in R, users have to rely on multiple packages, and sometimes on self-defined functions, which increases the risk of committing involuntary mistakes due to the need of fluctuating syntax and data wrangling.

In the area of agricultural sciences in particular, point-forecast simulation models such as the Agricultural Production Systems sIMulator (APSIM) [@APSIM_classic, @APSIM_nextgen] count with tools to facilitate the integration into R through packages such as apsimx [@apsimx_manual]. However, the assessment of the model simulations quality is not yet integrated for R users.

As the reproducibility of data analysis continues as a challenge for modern science [@Seibold_2022], the development of open source software like `metrica` represent a step-forward toward transparent and reproducible process to assist researchers on the evaluation models performance. We especifically decided to create `metrica` in R software [@R_Core_Team] due to its substantial role in modern data science [@Thiem_2018]. Under the open-source philosophy, R hosts cutting-edge algorithms that combined with an infrastructure like the Comprehensive R Archive Network (CRAN) -enhancing global dissemination-,  clearly empowers the democratization of statistical computing [@Hackenberger_2020].

This article introduces the `metrica` R-package, developed with the main objective of contributing to reproducible evaluation of point-forecast models performance. 

# Usage

### System requirements and installation

Since the metrica package operates within the R environment, the first step is to install R (version 4.2.0 or higher), a free software available at its official website [@R_Core_Team]. To assist on the interface experience with R, we encourage users to install the latest version RStudio desktop [@RStudio_manual] as a free and user-friendly environment that facilitates to operate R.

To install the latest stable version (CRAN mirror) of metrica package, users just need to run to following lines:

```
install.packages("metrica")

```

To install the latest development version (GitHub repository) of soiltestcorr package, users just need to run to following lines:

```
devtools::install_github("adriancorrendo/metrica")

```

To load the package, users simply need to type:

```
library(metrica)

```

## Using the functions

There are two basic arguments common to all `metrica` functions: (i)
`obs`(Oi; observed, a.k.a. actual, measured, truth, target, label), and
(ii) `pred` (Pi; predicted, a.k.a. simulated, fitted, modeled, estimate)
values.

Optional arguments include `data` that allows to call an existing data
frame containing both observed and predicted vectors, and `tidy`, which
controls the type of output as a list (tidy = FALSE) or as a data.frame
(tidy = TRUE).

For regression, some specific functions for regression also require to
define the axis `orientation`. For example, the slope of the symmetric
linear regression describing the bivariate scatter (SMA).

For binary classification (two classes), functions also require to check
the `pos_level` arg., which indicates the alphanumeric order of the
“positive level”. Normally, the most common binary denominations are
c(0,1), c(“Negative”, “Positive”), c(“FALSE”, “TRUE”), so the default
pos_level = 2 (1, “Positive”, “TRUE”). However, other cases are also
possible, such as c(“Crop”, “NoCrop”) for which the user needs to
specify pos_level = 1.

For multiclass classification tasks, some functions present the `atom`
arg. (logical TRUE / FALSE), which controls the output to be an overall
average estimate across all classes, or a class-wise estimate. For
example, user might be interested in obtaining estimates of precision
and recall for each possible class of the prediction.


### Regression (continuous variables)

For regression models, it includes 4 plotting functions (scatter, tiles, density, & Bland-Altman plots), and 48 prediction performance scores including error metrics (MBE, MAE, RAE, RMAE, MAPE, SMAPE, MSE, RMSE, RRMSE, RSR, PBE, iqRMSE), error decomposition (MLA, MLP, PLA, PLP, PAB, PPB, SB, SDSD, LCS, Ub, Uc, Ue), model efficiency (NSE, E1, Erel, KGE), indices of agreement (d, d1, d1r, RAC, AC, lambda), goodness of fit (r, R2, RSS, TSS, RSE), adjusted correlation coefficients (CCC, Xa, distance correlation-dcorr-, maximal information coefficient -MIC-), variability (uSD, var_u), and symmetric regression coefficients (B0_sma, B1_sma). Specifically for time-series predictions, metrica also includes the Mean Absolute Scaled Error (MASE).

Use wheat example

```r
data_wheat <- metrica::wheat
```

```r
my_reg_metrics <- c("RMSE", "MAE", "KGE", "d", "PLP", "PLA")
metrics_summary(data = data_wheat, type = "regression", metrics_list = my_reg_metrics)
```

![Caption for example figure.\label{fig:scatter_plot}](man/figures/README-unnamed-chunk-3-1.png) 

### Classification (categorical variables)

For classification (binomial and multinomial) tasks, it includes a function to visualize the confusion matrix using ggplot2, and 27 functions of prediction scores including: accuracy, error rate, precision, recall, specificity, balanced accuracy (balacc), F-score (fscore), adjusted F-score (agf), G-mean (gmean), Bookmaker Informedness (bmi, a.k.a. Youden’s J-index), Markedness (deltaP), Matthews Correlation Coefficient (mcc), Cohen’s Kappa (khat), negative predictive value (npv), positive and negative likelihood ratios (posLr, negLr), diagnostic odds ratio (dor), prevalence (preval), prevalence threshold (preval_t), critical success index (csi, a.k.a. threat score), false positive rate (FPR), false negative rate (FNR), false detection rate (FDR), false omission rate (FOR), and area under the ROC curve (AUC_roc). 

Use maize_phenology example

```r
data_multiclass <- metrica::maize_phenology
```
```r
recall(data = data_multiclass, obs = , pred = , atom = TRUE)
```

```r
metrics_summary(data = data_multiclass, obs = , type = "classification")
```

![Caption for example figure.\label{fig:multiclass_cm}](man/figures/README-unnamed-chunk-15-1.png) 

### Table 1: Example table.

| Col1 | Col2 | Col3 |
|---|---|---|
| ABC | DEFG | HIJKL |


# APSIM files

The metrica package was developed to assess the prediction performance of, among other, crop simulation models such as APSIM. In order to import files from simulation models like APSIM Classic (*.out files), users can implement:

```r
metrica::import_apsim_out(filepath = "../*.out")
```
To import files from the APSIM Next Generation (SQL, *.db files), users can use the following lines of code:

```r
metrica::import_apsim_db(filename = "*.db", folder = "../folder/")
```

# Similar packages

Other packages to compute evaluate models performance compared to `metrica`: 

- `yardstick` [@yardstick_manual] provides an extensive collection of metrics, however, it presents less amount of metrics and it does not other offer plotting functions for regression and classification. As advantages, it provides options for classification models with "probabilities".

- `Metrics` [@Metrics_manual] presents a good amount of metrics for binary classification, and for regression. However, `metrica` offers more metrics. The `Metrics` package has no plotting functions, it only works under the vectorized form (data.frame$variable), for classification it does not work for multi-class cases, and it does not work if the values of the predicted and observed vectors are not numeric (binary, 0-1).

- `hydroGOF` [@hydroGOF_manual] offers a good collection of metrics, however, some of them very specific for hydrology problems. In terms of plots, it only provides a few  visualization functions and using base R plots. It does not offer options for classification.

- `cvms` [@cvms_package] offers less variety of metrics and it does not offer plotting functions for regression. It offers great flexibility to create confusion matrices.

- `scoringutils` [@scoringutils_package] offers a wide variety of scoring rules but focused in probabilistic forecast but not in point-forecast models.

- `performance` [@performance_paper] offers a compelling toolbox for the evaluation of statistical models but it only works with the models' objects (because it works with their likelihood). Therefore, it does not support the evaluation point-forecast with simply predicted and observed values.


# Figures

Figures can be included like this: 

![Caption for example figure.\label{fig:logo}](man/figures/metrica_logo.png) 

and referenced from text using \autoref{fig:logo}.

Figure sizes can be customized by adding an optional second parameter:
![Figure #. Metrica logo.](man/figures/metrica_logo.png){ width=20% }

# Acknowledgements

We acknowledge contributions from #### during the genesis of this project.

# License

`metrica` is under MIT License...


# References
