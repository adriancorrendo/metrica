#' @title RAE
#' @description Relative Abosulte Error.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the RAE for a Predicted-Observed dataset as the
#' the ratio between the sum of absolute residuals (error of
#' predictions with respect to observations) and the sum of absolute
#' errors of observations with respect to its mean. 
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' RAE(obs = X, pred = Y)
#' }
#' @rdname RAE
#' @export 
RAE <- function(obs,
                pred,
                na.rm = TRUE){
  result <- sum(abs(obs-pred)) / sum(abs(obs-mean(obs)))
  return(result)
}