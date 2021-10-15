#' @title RMSE
#' @description Root Mean Square Error.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @return Element of class `numeric`.
#' @details Calculates the RMSE comparing Predicted and Observed
#' values.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' RMSE(obs = X, pred = Y)
#' }
#' @rdname RMSE
#' @export 
RMSE <- function(obs, pred){
  result <- sqrt(sum((obs-pred)^2)/length(obs))
  return(result)
}