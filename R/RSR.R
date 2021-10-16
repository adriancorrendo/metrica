#' @title RSR
#' @description RMSE:Standard Deviation Ratio (RSR).
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the RSR (0-1) for a Predicted-Observed dataset.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' RSR(obs = X, pred = Y)
#' }
#' @rdname RSR
#' @export 
RSR <- function(obs, pred,
                na.rm = TRUE){
  result <- sqrt((sum((obs-pred)^2)/length(obs)))/metrica::SSx(obs)
  return(result)
}