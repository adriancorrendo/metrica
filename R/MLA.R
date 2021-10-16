#' @title MLA
#' @description Mean Lack of Accuracy (MLA) component of the Mean 
#' Square Error (MSE).
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the MLA for a Predicted-Observed dataset
#' following the symmetric MSE decomposition suggested by
#' Correndo et al (2021).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' MLA(obs = X, pred = Y)
#' }
#' @rdname MLA
#' @export 
MLA <- function(obs, pred,
                na.rm = TRUE){
  result <- 
    sum ((
      pred - ( (mean(obs) - (metrica::sdev(obs)/
                               metrica::sdev(pred)*mean(pred))) +
                metrica::sdev(obs)/
                 metrica::sdev(pred) * pred))^2) / length(obs) 
  
  return(result)
}