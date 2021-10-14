#' @title Xa
#' @description Accuracy component of Concordance Correlation.
#' @param obs Vector with observed values (numeric).
#' @param pre Vector with predicted values (numeric).
#' @return Element of class `double`.
#' @details Calculates the Xa in Predicted-Observed dataset
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' Xa(obs = X, pre = Y)
#' }
#' @rdname Xa
#' @export 
Xa <- function(obs, pre){
  (2 / (sdev(pre)/sdev(obs) +
          sdev(obs)/sdev(pre) +
          ((mean(pre)-mean(obs))^2/(sdev(pre)*sdev(obs)))) )
}