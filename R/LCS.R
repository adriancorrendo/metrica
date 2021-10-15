#' @title LCS
#' @description Lack of correlation (LCS)component of the Mean Square Error (MSE). 
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @return Element of class `numeric`.
#' @details Calculates the LCS for a Predicted-Observed dataset 
#' following the MSE segregattion suggested by Kobayashi and Salam 
#' (2000).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' LCS(obs = X, pred = Y)
#' }
#' @rdname LCS
#' @export 
LCS <- function(obs, pred){
  result <- 
    2 * metrica::sdev(pred) * metrica::sdev(obs) *
    (1 - stats::cor(obs,pred))
  
  return(result)
}