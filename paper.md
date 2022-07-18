---
title: 'metrica: an R package for assessing predictive performance of regression
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
    orcid: 0000-0000-0000-0000
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

---

# Summary

`metrica` is an compilation of +80 functions designed to quantitatively and visually evaluate the prediction performance of regression (continuous variables) and classification (categorical variables) point-forecast models (e.g. APSIM, DSSAT, DNDC, Supervised Machine Learning). The software offers a toolbox with a wide spectrum of goodness of fit, error metrics, indices, and coefficients accounting for different aspects of the agreement between predicted and observed values, plus some basic visualization functions to assess models performance (e.g. confusion matrix, scatter with regression line; Bland-Altman plot) provided in customizable format (ggplot).

# Statement of need

Distance based computations and models are at the core of many spatial analysis operations in various scientific fields.
The simplest distance metric is the Euclidean distance (or distance as the crow flies), it is easy and inexpensive to compute. The use of this simple metric may be well fitted to study some phenomenon, such as species distribution or pollution diffusion. 
But whenever research aims at studying human activities (transport of persons or goods for example) it is common to use more realistic metrics based on road distance or travel time.

To conduct a comprehensive assessment of prediction performance combining different perspectives in R, users have to use multiple packages or even have to define functions by hand. 

As an open source software, `metrica` facilitates a transparent and reproducible process to assist researchers on evaluation models performance. 

The use of `metrica` is also suggested by the package for sustainable transport planning `stplanr` [@stplanr]

# Usage

For regression models, it includes 4 plotting functions (scatter, tiles, density, & Bland-Altman plots), and 48 prediction performance scores including error metrics (MBE, MAE, RAE, RMAE, MAPE, SMAPE, MSE, RMSE, RRMSE, RSR, PBE, iqRMSE), error decomposition (MLA, MLP, PLA, PLP, PAB, PPB, SB, SDSD, LCS, Ub, Uc, Ue), model efficiency (NSE, E1, Erel, KGE), indices of agreement (d, d1, d1r, RAC, AC, lambda), goodness of fit (r, R2, RSS, TSS, RSE), adjusted correlation coefficients (CCC, Xa, distance correlation-dcorr-, maximal information coefficient -MIC-), variability (uSD, var_u), and symmetric regression coefficients (B0_sma, B1_sma). Specifically for time-series predictions, metrica also includes the Mean Absolute Scaled Error (MASE).

For classification (binomial and multinomial) tasks, it includes a function to visualize the confusion matrix using ggplot2, and 27 functions of prediction scores including: accuracy, error rate, precision, recall, specificity, balanced accuracy (balacc), F-score (fscore), adjusted F-score (agf), G-mean (gmean), Bookmaker Informedness (bmi, a.k.a. Youden’s J-index), Markedness (deltaP), Matthews Correlation Coefficient (mcc), Cohen’s Kappa (khat), negative predictive value (npv), positive and negative likelihood ratios (posLr, negLr), diagnostic odds ratio (dor), prevalence (preval), prevalence threshold (preval_t), critical success index (csi, a.k.a. threat score), false positive rate (FPR), false negative rate (FNR), false detection rate (FDR), false omission rate (FOR), and area under the ROC curve (AUC_roc). 

### Table 1: Example table.

| Class | Role | When to Subclass |
|---|---|---|
| ABC | DEFG | HIJKL |



# APSIM files

# Dependencies?

`metrica` has the following main

Other packages to compute error metrics: <br/>

- `yardstick` [@citation]
- `Metrics` [@citation]
- `hydroGOF` [@citation]
- `performance` [@citation]


# References