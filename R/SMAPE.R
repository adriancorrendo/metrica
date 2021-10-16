#' @title SMAPE
#' @description Symmetric Mean Absolute Percentage Error.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the SMAPE for a Predicted-Observed dataset.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' MAPE(obs = X, pred = Y)
#' }
#' @rdname SMAPE
#' @export 
SMAPE <- function(obs, pred,
                  na.rm = TRUE){
  result <-
    100/length(obs)*
    (sum (abs(obs-pred)/((abs(obs)+abs(pred))/2)))
  return(result)
}