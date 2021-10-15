#' @title CCC
#' @description Concordance Correlation Coefficient.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @return Element of class `numeric`.
#' @details Calculates the CCC for Predicted-Observed dataset.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' CCC(obs = X, pred = Y)
#' }
#' @rdname CCC
#' @export 
CCC <- function(obs, pred){
  result <-  stats::cor(obs,pred) *
    (2 / (metrica::sdev(pred)/metrica::sdev(obs) +
            metrica::sdev(obs)/metrica::sdev(pred) +
            ((mean(pred)-mean(obs))^2/(metrica::sdev(pred)*metrica::sdev(obs)))) )
  return(result)
}