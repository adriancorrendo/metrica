#' @title Erel
#' @description Krause Relative Model Efficiency (Erel).
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @return Element of class `numeric`.
#' @details Calculates the Erel for a Predicted-Observed dataset
#' following Krause et al. (2005).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' Erel(obs = X, pred = Y)
#' }
#' @rdname Erel
#' @export 
Erel <- function(obs, pred,
                na_rm = TRUE) {
  result <- 1 - sum(((obs-pred)/obs)^2)/
    sum(((obs-mean(obs))/mean(obs))^2)
  return(result)
}

