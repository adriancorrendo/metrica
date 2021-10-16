#' @title MAPE
#' @description Mean Absolute Percentage Error.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @return Element of class `numeric`.
#' @details Calculates the MAPE for a Predicted-Observed dataset.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' MAPE(obs = X, pred = Y)
#' }
#' @rdname MAPE
#' @export 
MAPE <- function(obs, pred){
  result <- (sum((abs(obs-pred)/obs))/length(obs))*100
  return(result)
}