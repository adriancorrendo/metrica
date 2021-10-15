#' @title Uc
#' @description Lack of consistency (Uc). Proportion of the total sum
#' of squares related to the proportional bias. 
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @return Element of class `numeric`.
#' @details Calculates the Uc (%) for a Predicted-Observed dataset 
#' following the sum of squares segregattion suggested by Smith and
#' Rose (1995) also known as Theil's partial inequalities.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' Uc(obs = X, pred = Y)
#' }
#' @rdname Uc
#' @export 
Uc <- function(obs, pred){
  result <- 
    100*(length(obs)*
           (metrica::sdev(obs)-metrica::sdev(pred))^2) /
    sum((obs-pred)^2)
  
  return(result)
}