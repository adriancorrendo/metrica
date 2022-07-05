#' @title Symmetric Mean Absolute Percentage Error (SMAPE). 
#' @name SMAPE
#' @description It estimates the SMAPE for a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The SMAPE (%) is a normalized, dimensionless, and bounded (0% to 200%).
#' It is a modification of the MAPE where the denominator is half 
#' of the sum of absolute differences between observations and predictions.
#' This modification solves the problem of MAPE of producing negative or undefined values.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @references 
#' Makridakis (1993).
#' Accuracy measures: theoretical and practical concerns.
#' _Int. J. Forecast. 9, 527-529._ \doi{10.1016/0169-2070(93)90079-3}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' SMAPE(obs = X, pred = Y)
#' }
#' @rdname SMAPE
#' @importFrom rlang eval_tidy quo
#' @export 
SMAPE <- function(data=NULL,
                  obs,
                  pred,
                  tidy = FALSE,
                  na.rm = TRUE){
  SMAPE <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    100/length({{obs}})*
    (sum (abs({{obs}}-{{pred}})/((abs({{obs}})+abs({{pred}}))/2)))
    )
  )
  if (tidy==TRUE){ return(as.data.frame(SMAPE)) }
  
  if (tidy==FALSE){ return(list("SMAPE" = SMAPE)) }
}