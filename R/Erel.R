#' @title Relative Model Efficiency (Erel)
#' @name Erel
#' @description It estimates the Erel model efficiency
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The Erel model efficiency normalizes both residuals (numerator) and observed 
#' deviations (denominator) by observed values before squaring them. Compared to the NSE, the Erel is suggested as 
#' more sensitive to systematic over- or under-predictions. 
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references 
#' Krause et al. (2005). 
#' Comparison of different efficiency criteria for hydrological model assessment. 
#' _Adv. Geosci. 5, 89–97._ \doi{10.5194/adgeo-5-89-2005}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' Erel(obs = X, pred = Y)
#' }
#' @rdname Erel
#' @importFrom rlang eval_tidy quo
#' @export 
Erel <- function(data = NULL,
                 obs,
                 pred,
                 na.rm = TRUE) {
  result <- rlang::eval_tidy(
    data=data,
    rlang::quo(
      1 - sum((({{obs}}-{{pred}})/{{obs}})^2)/
    sum((({{obs}}-mean({{obs}}))/mean({{obs}}))^2)
    )
  )
  return(result)
}

