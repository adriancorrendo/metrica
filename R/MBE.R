#' @title MBE
#' @description Mean Bias Error.
#' @param obs Vector with observed values (numeric).
#' @param pre Vector with predicted values (numeric).
#' @return Element of class `double`.
#' @details Calculates the MBErr of Predicted compared to Observed
#' values.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' MBE(obs = X, pre = Y)
#' }
#' @rdname MBE
#' @export 
MBE <- function(obs, pre){
  (mean(pre)-mean(obs))
}