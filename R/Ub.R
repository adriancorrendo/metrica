#' @title Ub
#' @description Proportion of the total sum of squares related to the
#' mean bias (Ub). 
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the Ub for a Predicted-Observed dataset 
#' following the sum of squares segregattion suggested by Smith and
#' Rose (1995) also known as Theil's partial inequalities.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' Ub(obs = X, pred = Y)
#' }
#' @rdname Ub
#' @export 
Ub <- function(obs, pred,
               na.rm = TRUE){
  result <- 
    100 * (length(obs)*(mean(obs)-mean(pred))^2) / sum((obs-pred)^2)
  
  return(result)
}