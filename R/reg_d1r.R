#' @title Refined Index of Agreement (d1).
#' @name d1r
#' @description It estimates the refined index of agreement (d1r) following 
#' Willmott et al. (2012).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details Similar to d, and d1, the d1r index it is a normalized, dimensionless 
#' metric that tests general agreement. The difference is that d1r modifies the 
#' denominator of the formula (potential error), normalizing the mean absolute error
#' (numerator) by two-times the mean absolute deviation of observed values. It is 
#' bounded between 0 and 1. The disadvantage is that d1r is an asymmetric index, 
#' that is, dependent to the orientation of predicted and observed values.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @references
#' Willmott et al. (2012). 
#' A refined index of model performance. 
#' _Int. J. Climatol. 32, 2088–2094._ \doi{10.1002/joc.2419}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' d1r(obs = X, pred = Y)
#' }
#' @rdname d1r
#' @importFrom rlang eval_tidy quo
#' @export 
d1r <- function(data = NULL,
                obs,
                pred,
                tidy = FALSE,
                na.rm = TRUE) {
  d1r <- rlang::eval_tidy(
    data=data,
    rlang::quo(
      
    1 - ( (sum(abs({{obs}} - {{pred}} ))) / (2 * sum( abs({{obs}} - mean({{obs}}) ))) )
    )
  )
  if (tidy==TRUE){ return(as.data.frame(d1r)) }
  
  if (tidy==FALSE){ return(list("d1r" = d1r)) }
}

