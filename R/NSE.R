#' @title Nash-Sutcliffe Model Efficiency (NSE) 
#' @name NSE
#' @description It estimates the NSE for a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The NSE measures general agreement. It is normalized (by the variance of the observations) and dimensionless. 
#' It is calculated using the absolute squared differences between the predictions and observations, 
#' which has been suggested as an issue due to over-sensitivity to outliers.
#' It goes form -infinity to 1. The closer to 1 the better the prediction performance.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references 
#' Nash & Sutcliffe (1970).
#' River flow forecasting through conceptual models part I - A discussion of principles.
#' _J. Hydrol. 10(3), 292-290._ \doi{10.1016/0022-1694(70)90255-6}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' NSE(obs = X, pred = Y)
#' }
#' @rdname NSE
#' @importFrom rlang eval_tidy quo
#' @export 
NSE <- function(data=NULL,
                obs,
                pred,
                na.rm = TRUE) {
  MSE <- sum(({{obs}}-{{pred}})^2)/length({{obs}})
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      1-(MSE/
           sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))
    )
  )
  return(result)
}

