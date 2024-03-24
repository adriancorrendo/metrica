#' @title Modified Index of Agreement (d1).
#' @name d1
#' @description It estimates the modified index of agreement (d1) using absolute
#' differences following Willmott et al. (1985).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details Similar to d, the d1 index it is a normalized, dimensionless metric that tests general agreement.
#' The difference with d, is that d1 uses absolute residuals instead of squared residuals. It is bounded between 0 and 1. 
#' The disadvantage is that d is an asymmetric index, that is, dependent to the orientation of
#' predicted and observed values.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @references
#' Willmott et al. (1985). 
#' Statistics for the evaluation and comparison of models. 
#' _J. Geophys. Res. 90, 8995._ \doi{10.1029/jc090ic05p08995}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' d1(obs = X, pred = Y)
#' }
#' @rdname d1
#' @importFrom rlang eval_tidy quo
#' @export 
d1 <- function(data = NULL,
               obs,
               pred,
               tidy = FALSE,
               na.rm = TRUE) {
  d1 <- rlang::eval_tidy(
    data=data,
    rlang::quo(
    1-((sum(abs({{obs}}-{{pred}})))/sum(abs({{pred}}-mean({{obs}}))+
                                  abs({{obs}}-mean({{obs}}))))
    )
  )
  if (tidy==TRUE){ return(as.data.frame(d1)) }
  
  if (tidy==FALSE){ return(list("d1" = d1)) }
}

