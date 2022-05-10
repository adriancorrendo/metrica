#' @name B1_sma
#' @title Slope of standardized major axis regression (SMA). 
#' @description It calculates the slope (B1) for the bivariate linear relationship
#' between predicted and observed values following the SMA regression.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param orientation Argument of class string specifying the axis
#' orientation, PO for predicted vs observed, and OP for
#' observed vs predicted. Default is orientation = "PO".
#' @param na.rm Logic argument to remove rows with missing values (NA). Default is na_rm = TRUE.
#' @return an object of class `numeric`.
#' @details SMA is a symmetric linear regression (invariant results/interpretation to axis orientation) 
#' recommended to describe the bivariate scatter instead of OLS regression 
#' (classic linear model, which results vary with the axis orientation).
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references 
#' Warton et al. (2006). 
#' Bivariate line-fitting methods for allometry. 
#' _Biol. Rev. Camb. Philos. Soc. 81, 259–291._ \doi{10.1002/1521-4036(200203)44:2<161::AID-BIMJ161>3.0.CO;2-N}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' B1_sma(obs = X, pred = Y)
#' }
#' @rdname B1_sma
#' @importFrom dplyr case_when
#' @importFrom rlang eval_tidy quo
#' @export 
B1_sma <- function(data = NULL, 
                   obs,
                   pred,
                   orientation = "PO",
                   na.rm = TRUE) {
  sdev.pred <- rlang::eval_tidy(
    data = data,
    rlang::quo(sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}})) ) )
  
  sdev.obs <- rlang::eval_tidy(
    data = data,
    rlang::quo(sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}})) ) )
  
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      sdev.pred/sdev.obs
    )
  )
  if (orientation == "OP"){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}})) /
        sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))
    )
  )
  }
  
  return(result)
}

