#' @title SB
#' @description Squared bias (SB)component of the Mean Square 
#' Error (MSE). 
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @return Element of class `numeric`.
#' @details Calculates the SB for a Predicted-Observed dataset 
#' following the MSE segregattion suggested by Kobayashi and Salam 
#' (2000).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' SB(obs = X, pred = Y)
#' }
#' @rdname SB
#' @export 
SB <- function(obs, pred){
  result <- 
    (mean(obs) - mean(pred))^2
  
  return(result)
}