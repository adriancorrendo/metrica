#' @title RRMSE
#' @description Relative Root Mean Square Error.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the RRMSE for a Predicted-Observed dataset.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' RRMSE(obs = X, pred = Y)
#' }
#' @rdname RRMSE
#' @export 
RRMSE <- function(obs, pred,
                 na.rm = TRUE){
  result <- sqrt(sum((obs-pred)^2)/length(obs)) / (mean(obs))
  return(result)
}