#' @title MBE
#' @description Mean Bias Error.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @return Element of class `numeric`.
#' @details Calculates the MBErr of Predicted compared to Observed
#' values.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' MBE(obs = X, pred = Y)
#' }
#' @rdname MBE
#' @export 
MBE <- function(obs, pred){
  result <- (mean(pred)-mean(obs))
  return(result)
}