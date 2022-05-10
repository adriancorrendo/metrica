#' @title Absolute Model Efficiency (E1)
#' @name E1
#' @description It estimates the E1 model efficiency
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The E1 is a type of model efficiency that modifies the Nash-Sutcliffe model efficiency
#' by using absolute residuals instead of squared residuals. The E1 is used to overcome the NSE 
#' over-sensitivity to extreme values caused by the used of squared residuals.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references 
#' Legates & McCabe (1999). 
#' Evaluating the use of “goodness-of-fit” measures in hydrologic and hydroclimatic model validation. 
#' _Water Resour. Res._ \doi{10.1029/1998WR900018}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' E1(obs = X, pred = Y)
#' }
#' @rdname E1
#' @importFrom rlang eval_tidy quo
#' @export 
E1 <- function(data = NULL,
               obs,
               pred,
               na.rm = TRUE) {
  result <- rlang::eval_tidy(
    data=data,
    rlang::quo(
      1-(sum(abs({{obs}}-{{pred}})))/(sum(abs({{obs}}-mean({{obs}}))))
    )
  )
  return(result)
}

