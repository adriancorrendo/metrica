#' @title NSE
#' @description Nash-Sutcliffe's Model Efficiency.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the NSE for a Predicted-Observed dataset
#' following Nash and Sutcliffe (1970).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' NSE(obs = X, pred = Y)
#' }
#' @rdname NSE
#' @export 
NSE <- function(obs, pred,
                na.rm = TRUE) {
  result <- 1-(metrica::MSE(obs,pred)/metrica::var.u(obs))
  return(result)
}

