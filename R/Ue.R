#' @title Ue
#' @description Lack of consistency (Ue). Proportion of the total sum
#' of squares related to the proportional bias. 
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the Ue (%) for a Predicted-Observed dataset 
#' following the sum of squares segregattion suggested by Smith and
#' Rose (1995) also known as Theil's partial inequalities.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' Ue(obs = X, pred = Y)
#' }
#' @rdname Ue
#' @export 
Ue <- function(obs, pred,
               na.rm = TRUE){
  result <- 
    100*
    ( 2*length(obs)* (1-stats::cor(obs,pred))*
        metrica::sdev(pred)*metrica::sdev(obs) ) / 
    sum((obs-pred)^2)
  
  return(result)
}