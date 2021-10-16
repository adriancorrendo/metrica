#' @title KGE
#' @description Kling-Gupta Model Efficiency (KGE).
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the KGE for a Predicted-Observed dataset
#' following Kling et al. (2012).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' KGE(obs = X, pred = Y)
#' }
#' @rdname KGE
#' @export 
KGE <- function(obs, pred,
                na.rm = TRUE) {
  CVr <- (metrica::sdev(pred)/mean(pred))/(metrica::sdev(obs)/mean(obs))
  result <- 1 - sqrt( ((stats::cor(obs,pred)-1))^2 +
                        ((CVr-1))^2 + 
                        (((mean(pred)/mean(obs))-1))^2)
  return(result)
}

