#' @title PAB
#' @description Percentage Additive Bias (PAB) component of the
#' Mean Square Error (MSE).
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @return Element of class `numeric`.
#' @details Calculates the PAB (%) for a Predicted-Observed dataset
#' following the symmetric MSE decomposition suggested by
#' Correndo et al (2021).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' PAB(obs = X, pred = Y)
#' }
#' @rdname PAB
#' @export 
PAB <- function(obs, pred){
  result <- 
    100 * (metrica::SB(obs,pred) /
             metrica::MSE(obs, pred))
  
  return(result)
}