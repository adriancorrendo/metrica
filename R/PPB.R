#' @title PPB
#' @description Percentage Proportional Bias (PPB) component of the
#' Mean Square Error (MSE).
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the PPB (%) for a Predicted-Observed dataset
#' following the symmetric MSE decomposition suggested by
#' Correndo et al (2021).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' PPB(obs = X, pred = Y)
#' }
#' @rdname PPB
#' @export 
PPB <- function(obs, pred,
                na.rm = TRUE){
  result <- 
    100 * (metrica::SDSD(obs,pred) /
             metrica::MSE(obs, pred))
  
  return(result)
}