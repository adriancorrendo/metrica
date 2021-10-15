#' @title SDSD
#' @description Square difference between standard deviations (SDSD)
#' component of the Mean Square Error (MSE). 
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @return Element of class `numeric`.
#' @details Calculates the SDSD for a Predicted-Observed dataset 
#' following the MSE segregattion suggested by Kobayashi and Salam 
#' (2000).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' SDSD(obs = X, pred = Y)
#' }
#' @rdname SDSD
#' @export 
SDSD <- function(obs, pred){
  result <- 
    (metrica::sdev(pred) - metrica::sdev(obs))^2
  
  return(result)
}