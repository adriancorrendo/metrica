#' @title RMSE
#' @description Root Mean Square Error.
#' @param obs Vector with observed values (numeric).
#' @param pre Vector with predicted values (numeric).
#' @return Element of class `double`.
#' @details Calculates the RMSE comparing Predicted and Observed
#' values.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' RMSE(obs = X, pre = Y)
#' }
#' @rdname RMSE
#' @export 
RMSE <- function(obs, pre){
  sqrt(sum( (obs-pre)^2) / length(obs) )
}