#' @title MSE
#' @description Mean Square Error.
#' @param obs Vector with observed values (numeric).
#' @param pre Vector with predicted values (numeric).
#' @return Element of class `double`.
#' @details Calculates the MSE comparing Predicted and Observed
#' values.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' MSE(obs = X, pre = Y)
#' }
#' @rdname MSE
#' @export 
MSE <- function(obs, pre){
  sum((obs-pre)^2)/length(obs)
}

