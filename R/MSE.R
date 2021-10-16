#' @title MSE
#' @description Mean Square Error (MSE).
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the MSE comparing Predicted and Observed
#' values.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' MSE(obs = X, pred = Y)
#' }
#' @rdname MSE
#' @export 
MSE <- function(obs, pred,
                na.rm = TRUE){
  result <- sum((obs-pred)^2)/length(obs)
  return(result)
}

