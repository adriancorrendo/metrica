#' @title PBE
#' @description Percentage Bias Error.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the PBE (%) for a Predicted-Observed dataset.
#' Negative values indicate overestimation. Positive values indicate
#' underestimation. Moriasi et al. (2007).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' PBE(obs = X, pred = Y)
#' }
#' @rdname PBE
#' @export 
PBE <- function(obs, pred,
                na.rm = TRUE){
  result <- 100 * (sum(obs-pred) / sum(obs))
  return(result)
}