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

Reproducibility.

To conduct a comprehensive assessment of prediction performance combining different perspectives in R, users have to use multiple packages or even have to define functions by hand. 

As an open source software, `metrica` facilitates a transparent and reproducible process to assist researchers on evaluation models performance. 

The use of `metrica` is...

# Usage

### Regression (continuous variables)

For regression models, it includes 4 plotting functions (scatter, tiles, density, & Bland-Altman plots), and 48 prediction performance scores including error metrics (MBE, MAE, RAE, RMAE, MAPE, SMAPE, MSE, RMSE, RRMSE, RSR, PBE, iqRMSE), error decomposition (MLA, MLP, PLA, PLP, PAB, PPB, SB, SDSD, LCS, Ub, Uc, Ue), model efficiency (NSE, E1, Erel, KGE), indices of agreement (d, d1, d1r, RAC, AC, lambda), goodness of fit (r, R2, RSS, TSS, RSE), adjusted correlation coefficients (CCC, Xa, distance correlation-dcorr-, maximal information coefficient -MIC-), variability (uSD, var_u), and symmetric regression coefficients (B0_sma, B1_sma). Specifically for time-series predictions, metrica also includes the Mean Absolute Scaled Error (MASE).

![Caption for example figure.\label{fig:scatter_plot}](man/figures/README-unnamed-chunk-3-1.png) <br/>

### Classification (categorical variables)

For classification (binomial and multinomial) tasks, it includes a function to visualize the confusion matrix using ggplot2, and 27 functions of prediction scores including: accuracy, error rate, precision, recall, specificity, balanced accuracy (balacc), F-score (fscore), adjusted F-score (agf), G-mean (gmean), Bookmaker Informedness (bmi, a.k.a. Youden’s J-index), Markedness (deltaP), Matthews Correlation Coefficient (mcc), Cohen’s Kappa (khat), negative predictive value (npv), positive and negative likelihood ratios (posLr, negLr), diagnostic odds ratio (dor), prevalence (preval), prevalence threshold (preval_t), critical success index (csi, a.k.a. threat score), false positive rate (FPR), false negative rate (FNR), false detection rate (FDR), false omission rate (FOR), and area under the ROC curve (AUC_roc). 

![Caption for example figure.\label{fig:multiclass_cm}](man/figures/README-unnamed-chunk-15-1.png) <br/>

### Table 1: Example table.

| Col1 | Col2 | Col3 |
|---|---|---|
| ABC | DEFG | HIJKL |



# APSIM files

To import files from simulation models like APSIM Classic and APSIM Next Gen...

# Dependencies?

`metrica` has the following main dependencies

Other packages to compute error metrics: <br/>

- `yardstick` 
- `Metrics` 
- `hydroGOF` 
- `performance` 

# Formulae

Single dollars ($) are required for inline mathematics e.g. $f(x) = e^{\pi/x}$

Double dollars make self-standing equations:

$$\Theta(x) = \left\{\begin{array}{l}
0\textrm{ if } x < 0\cr
1\textrm{ else}
\end{array}\right.$$

You can also use plain \LaTeX for equations
\begin{equation}\label{eq:fourier}
\hat f(\omega) = \int_{-\infty}^{\infty} f(x) e^{i\omega x} dx
\end{equation}
and refer to \autoref{eq:fourier} from text.

# Citations

Citations to entries in paper.bib should be in
[rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)
format.

If you want to cite a software repository URL (e.g. something on GitHub without a preferred
citation) then you can do it with the example BibTeX entry below for @fidgit.

For a quick reference, the following citation commands can be used:
- `@author:2001`  ->  "Author et al. (2001)"
- `[@author:2001]` -> "(Author et al., 2001)"
- `[@author1:2001; @author2:2001]` -> "(Author1 et al., 2001; Author2 et al., 2002)"

# Figures

Figures can be included like this: <br/>

![Caption for example figure.\label{fig:logo}](man/figures/metrica_logo.png) <br/>

and referenced from text using \autoref{fig:logo}.

Figure sizes can be customized by adding an optional second parameter:
![Figure #. Metrica logo.](man/figures/metrica_logo.png){ width=20% }

# Acknowledgements

We acknowledge contributions from #### during the genesis of this project.

# License

`metrica` is under MIT License...


# References
