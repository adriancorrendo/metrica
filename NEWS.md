# metrica 2.0.0

* July 3rd, 2022. <br/>

This new version of metrica includes:

1) Twenty-seven (27) new functions to evaluate quality of predictions for classification problems:
  
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

2) Three (3) new functions to the family of regression performance metrics:
  
  -`MASE()` (Mean Absolute Scaled Error) for Time Series Analysis.
  - `dcorr()` (Distance correlation) as wrapper of dcor() from energy package (https://CRAN.R-project.org/package=energy), and
  - `MIC()` (Maximal Information Coefficient) as wrapper of mine_stat() from minerva package (https://CRAN.R-project.org/package=minerva).
  - `RMLA()` (Root Mean Lack of Accuracy)
  - `RMLP()` (Root Mean Lack of Precision)

3) One (1) new plotting function for regression problems:
  - `density_plot()`, to create a plot that paints density areas of predicted and observed coordinates.
  
4) Four (4) new arguments to plotting functions scatter_plot, tiles_plot, and density_plot (no deprecated):
  - `print_eq` (to print equation or not)
  - `position_metrics` (to customize position of metrics_table when print_metrics = TRUE)
  - `position_eq` (to customize position of equation when print_eq = TRUE)
  - `colors` (for tile_plot and density_plot, to paint gradient from "low" to "high" density of points)
  
5) Adding the argument `tidy` to all metrics functions, which allows to control the user the type of return (tidy=TRUE returns a data.frame, tidy = FALSE returns a list)


6) Fixing a minor a bug on the `NSE()` function to estimate the Nash-Sutcliffe model efficiency that produced only values of NSE=1.00 on v1.2.3.

6) Improved coverage of the code testing.

7) README update.

8) Vignettes update creating versions for both classification and regression, and for importing APSIM files.


######################################################################################################

# Previous versions

# metrica 1.2.3 (CRAN)

* May, 10, 2022. <br/>

Maintenance update fixing minor errors after feedback from CRAN submission of v1.2.2 (e.g. use 
'donttest' instead of 'dontrun' in functions' examples, adding references into functions).
Also, the available metrics vignette was updated adding the corresponding citations of 
formulae used into functions.

# metrica 1.2.2 (dev)

* May, 05, 2022. <br/>

Maintenance update fixing minor bugs related to checks before CRAN submission (e.g. spelling check, URLs, DOIs, etc.)

# metrica 1.2.1 (dev)

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

New features (1.2.0) (dev):

Data: a new (Optional) arg. called "data" is included for all functions,
which serves to call an existing data frame containing the predicted-observed data.
This facilitates passing the functions to multiple and nested data frames at once 
using mapping functions.

APSIM: includes two new functions to read APSIM output files from APSIM Classic ["*.out", 
import.apsim.out()] and APSIM NextGen ["*.db", import.apsim.db()].


