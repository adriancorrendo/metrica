# metrica 1.3.0

* June 13th, 2022. <br/>

Adding new plotting function:
  - density_plot, to create a plot that paints density areas of predicted and observed coordinates.
  
Adding new arguments to plotting functions scatter_plot, tiles_plot, and density_plot:
  - print_eq (to print equation or not)
  - position_metrics (to customize position of metrics_table when print_metrics = TRUE)
  - position_eq (to customize position of equation when print_eq = TRUE)
  - colors (for tile_plot and density_plot, to paint gradient from "low" to "high" density of points)

Adding two new functions to the family of regression performance metrics:
  - dcorr (Distance correlation) as wrapper of dcor() from energy package (https://CRAN.R-project.org/package=energy), and
  - MIC (Maximal Information Coefficient) as wrapper of mine_stat() from minerva package (https://CRAN.R-project.org/package=minerva).

# Previous versions

# metrica 1.2.4

* May 27th, 2022. <br/>

Development update fixing minor a bug on the NSE() function to estimate the Nash-Sutcliffe model efficiency that produce only values of NSE=1.00 on v1.23.

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

New features (1.2.0):

Data: a new (Optional) arg. called "data" is included for all functions,
which serves to call an existing data frame containing the predicted-observed data.
This facilitates passing the functions to multiple and nested data frames at once 
using mapping functions.

APSIM: includes two new functions to read APSIM output files from APSIM Classic ["*.out", 
import.apsim.out()] and APSIM NextGen ["*.db", import.apsim.db()].


