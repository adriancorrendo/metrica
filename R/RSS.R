#' @title RSS
#' @description Residual Sum of Squares (R2).
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the RSS for a Predicted-Observed dataset.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' RSS(obs = X, pred = Y)
#' }
#' @rdname RSS
#' @importFrom stats cor var
#' @export 
RSS <- function(obs, pred,
               na.rm = TRUE){
  result <- sum((obs-pred)^2)
  return(result)
}