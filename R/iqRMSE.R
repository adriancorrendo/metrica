#' @title iqRMSE
#' @description Relative Root Mean Squared Error.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the iqRMSE for a Predicted-Observed dataset by
#' normalizing the RMSE by the length of the inter-quartile range of
#' observations (percentiles 25th to 75th). 
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' iqRMSE(obs = X, pred = Y)
#' }
#' @rdname iqRMSE
#' @importFrom stats quantile
#' @export 
iqRMSE <- function(obs,
                    pred,
                 na.rm = TRUE){
  result <- sqrt(sum((obs-pred)^2)/length(obs)) / 
    (stats::quantile(obs,probs = c(.75))[[1]]-
       stats::quantile(obs,probs = c(.25))[[1]])
  return(result)
}

