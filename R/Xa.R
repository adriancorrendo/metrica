#' @title Xa
#' @description Accuracy component of Concordance Correlation.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `double`.
#' @details Calculates the Xa for a Predicted-Observed dataset.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' Xa(obs = X, pred = Y)
#' }
#' @rdname Xa
#' @export 
Xa <- function(obs, pred,
               na.rm = TRUE){
  result <- (2 / (metrica::sdev(pred)/metrica::sdev(obs) +
          metrica::sdev(obs)/metrica::sdev(pred) +
          ((mean(pred)-mean(obs))^2/(metrica::sdev(pred)*metrica::sdev(obs)))) )
  return(result)
}