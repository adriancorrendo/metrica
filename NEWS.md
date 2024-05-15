# metrica 2.0.4
This version:
1) fixes an issue found for Debian for Importing APSIM NewGeneration files that violated CRAN Policy's.

2) adds a new classification metric called P4, following Sitarz, M. (2023) doi:10.54364/AAIML.2023.1161. 
https://github.com/adriancorrendo/metrica/issues/36
Special thanks to Davide Chicco for suggesting this metric.

3) fixes an error in the invF05 formula from the adjusted F-score metric (agf):
  - InvF0.5=(5/4) * ((npv * spec)/( (0.5^2*npv) +spec ))
https://github.com/adriancorrendo/metrica/issues/37
Special thanks to Gilles Koumou for pointing out the error and helping to fix it!

4) adds a new plot argument, shape_fill, indicating the shape fill for the data points on the 'scatter_plot' and 'bland_altman_plot' functions.

5) replace 'size' argument with 'linewidth' following ggplot2 updates.

6) replace deprecated 'aes_string()' within several plot functions with 'aes()' following latest ggplot2 updates.

#####################################################################################################

- PREVIOUS VERSIONS

# metrica 2.0.3
This version fixes an issue found for Debian for Importing APSIM NewGeneration files that violated CRAN Policy's.

Change details:

1) Adding a READ-ONLY flag within import_apsim_db() as follows:

con <- DBI::dbConnect(..., flags = RSQLite::SQLITE_RO)

2) Simplified vignette for open "APSIM: Importing APSIM Classic and NewGeneration files" now implementing "eval = FALSE" for a chunk containing example code to open APSIM files. Code is there but not running by default.

Potentially problematic code line:
apsim_out_filepath <- system.file("extdata/soybean.out", package = "metrica")


# metrica 2.0.2

This new version fixes minor bugs from version 2.0.1, typos, update and add new vignettes, and add alternative functions to several classification performance metrics. Details:

This new development version fixes minor bugs found in v2.0.1:

1) Adding "Contributing"" and "Code of conduct"" sections to the README file.

2) Adding "CODE_OF_CONDUCT.md" file.

3) Adding a list of abbreviations used on the vignette "Available Classification Metrics".

4) Fixing a bug on the PLA and PLP formulas, which were not working when the `data` argument was specified.

5) Corrects, on the DESCRIPTION file, the minimum R version required (from 2.1.0 to 3.6.2)

6) Including an "extdata" directory containing APSIM example files (soybean.out & soybean.example.db)

7) Fix typos in the documentation of RRMSE, RSR, and iqRMSE, which formulas were corrected (removing 100 from the beginning of formulas.

8) Add alternative functions to recall performing identical job such as (i) sensitivity, (ii) True Positive Rate -TPR-, and (iii) Hit Rate -hitrate-.

9) Add alternative functions to specificity performing identical job such as (i) selectivity, (ii) True Negative Rate -TNR-.

12) Add vignettes related to (i) publication of metrica on the Journal of Open Source Software (JOSS),  (ii) the metrica `ShinyApp`, and (iii) the new `cheatsheets` of the metrica package.

11) Make a correction on the vignette specifying the formula of Duveiller's `lambda()`, which by the way does not affect the `lambda()` function itself.

10) Add alternative functions to precision (`ppv()`), mcc (`phi_coef()`), bmi (`jindex()`), csi (`jaccardindex()`), and deltap (`mk()`).

11) Add `CITATION` file into "inst/" folder following `bibentry` format.


# metrica 2.0.1

* July 23th, 2022. <br/>

This new version fixes minor bugs found in v2.0.0:

1) regression lines with "OP" orientation in scatter_plot(), density_plot(), and tiles_plot(), which were producing the "PO" oriented regression lines instead.

2) estimation of "d1r" index for regression, which produced misleading values due to a typo in the denominator.

3) printing metrics on confusion matrix, which produced a NaN when printing 9 metrics.


# metrica 2.0.0

* July 4th, 2022. <br/>

This new version of metrica includes:

1) Twenty-seven (27) additional functions to evaluate quality of predictions for classification problems:
  
  - `confusion_matrix()`: Confusion matrix (as data.frame or plot).
  - `accuracy()`: Accuracy.
  - `error_rate()`: Error Rate, misclassification rate.
  - `precision()`: Precision.
  - `recall()`: Recall, sensitivity, true positive rate.
  - `specificity()`: Specificity, selectivity, true negative rate.
  - `fscore()`: F-score.
  - `agf()`: Adjusted F-score.
  - `gmean()`: G-mean.
  - `khat()`: Cohen's Kappa Coefficient.
  - `baccu()`: Balanced Accuracy.
  - `mcc()`: Matthews Correlation Coefficient.
  - `fmi()`: Fowlkes-Mallows Index.
  - `bmi()`: Informedness, Bookmaker Index.
  - `csi()`: Critical Success Index, Threat Score, Jaccard Index.
  - `deltap()`: Markedness or deltaP.
  - `posLr()`: Positive Likelihood Ratio.
  - `negLr()`: Negative Likelihood Ratio.
  - `dor()`: Diagnostic Odds Ratio.
  - `npv()`: Negative Predictive Value.
  - `FPR()`: False Positive Rate, false alarm, fall-out.
  - `FNR()`: False Negative Rate, miss rate.
  - `FDR()`: False Detection Rate, False Discovery Rate.
  - `FOR()`: False Omission Rate.
  - `preval()`: Prevalence.
  - `preval_t()`: Prevalence threshold.
  - `AUC_roc()`: Area Under the ROC Curve (trapezoid approach).

2) Three (3) additional functions to the family of regression performance metrics:
  
  - `MASE()` (Mean Absolute Scaled Error) for Time Series Analysis.
  - `dcorr()` (Distance correlation) as wrapper of dcor() from energy package (https://CRAN.R-project.org/package=energy), and
  - `MIC()` (Maximal Information Coefficient) as wrapper of mine_stat() from minerva package (https://CRAN.R-project.org/package=minerva).
  - `RMLA()` (Root Mean Lack of Accuracy)
  - `RMLP()` (Root Mean Lack of Precision)
  
3) Update of the metrics_summary() function including:
  - run performance metrics summary either for "regression" or "classification"
  using the new `type` argument, 'required' to specify the type of prediction task.
  - `pos_level` argument, for binomial classification, to allow the user to specify the alphanumeric order of the "positive" level.
  -

4) One (1) additional plotting function for regression:
  - `density_plot()`, to create a plot that paints density areas of predicted and observed coordinates.
  
5) Fixing issue with the `tiles_plot()` not plotting hexagons. Changed ggplot2::geom_hex() by ggplot2::stat_bin2d
  
6) Seventeen (17) additional arguments to customize scatter_plot, tiles_plot, and density_plot:
  - `print_eq` (to print equation or not)
  - `position_metrics` (to customize position of metrics_table when print_metrics = TRUE)
  - `position_eq` (to customize position of equation when print_eq = TRUE)
  - `eq_color` (to customize color of the equation when print_eq = TRUE)
  - `colors` (for tile_plot and density_plot, to paint gradient from "low" to "high" density of points)
  - `shape_type` (to customize shape of the scatter_plot() and bland_altman_plot())
  - `shape_size` (to customize shape of the scatter_plot() and bland_altman_plot())
  - `shape_color` (to customize shape of the scatter_plot() and bland_altman_plot())
  - `regline_type` (to customize regression line of the scatter_plot(), tiles_plot, and density_plot())
  - `regline_size` (to customize regression line of the scatter_plot(), tiles_plot, and density_plot())
  - `regline_color` (to customize regression line of the scatter_plot(), tiles_plot, and density_plot())
  - `zeroline_type` (to customize lines of the bland_altman_plot())
  - `zeroline_size` (to customize lines of the bland_altman_plot())
  - `zeroline_color` (to customize lines of the bland_altman_plot())
  - `limitsline_type` (to customize lines of the bland_altman_plot())
  - `limitsline_size` (to customize lines of the bland_altman_plot())
  - `limitsline_color` (to customize lines of the bland_altman_plot())
  
7) Adding the argument `tidy` to all metrics functions, which allows to control the user the type of return (tidy=TRUE returns a data.frame, tidy = FALSE returns a list)

8) Fixing a minor a bug on the `NSE()` function to estimate the Nash-Sutcliffe model efficiency that produced only values of NSE=1.00 on v1.2.3.

9) Improved coverage of the code testing.

9) README update with new features descriptions and links to vignettes.

10) Updated vignettes creating independent versions for classification and regression models, and for importing APSIM files.

# metrica 1.2.3

* May, 10, 2022. <br/>

Maintenance update fixing minor errors after feedback from CRAN submission of v1.2.2 (e.g. use 
'donttest' instead of 'dontrun' in functions' examples, adding references into functions).
Also, the available metrics vignette was updated adding the corresponding citations of 
formulae used into functions.

# metrica 1.2.2

* May, 05, 2022. <br/>

Maintenance update fixing minor bugs related to checks before CRAN submission (e.g. spelling check, URLs, DOIs, etc.)

# metrica 1.2.1

Minor updates (1.2.1):

Update of function and arguments' names replacing  "." by "_":

Old | New
import.apsim.out | import_apsim_out
import.apsim.db | import_apsim_db
metrics.summary | metrics_summary
scatter.plot | scatter_plot
tiles.plot | tiles_plot
bland.altman.plot | bland_altman_plot
B0.sma | B0_sma
B1.sma | B1_sma
metrics.list | metrics_list
print.metrics | print_metrics

---------------------

New features (1.2.0)

Data: a new (Optional) arg. called "data" is included for all functions,
which serves to call an existing data frame containing the predicted-observed data.
This facilitates passing the functions to multiple and nested data frames at once 
using mapping functions.

APSIM: includes two new functions to read APSIM output files from APSIM Classic ["*.out", 
import.apsim.out()] and APSIM NextGen ["*.db", import.apsim.db()].


