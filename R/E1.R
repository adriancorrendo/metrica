#' @title E1
#' @description Legates and McCabe's Model Efficiency (E1).
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @return Element of class `numeric`.
#' @details Calculates the E1 for a Predicted-Observed dataset
#' following Legates and McCabee (1990).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' E1(obs = X, pred = Y)
#' }
#' @rdname E1
#' @export 
E1 <- function(obs, pred,
                na_rm = TRUE) {
  result <- 1-(sum(abs(obs-pred)))/(sum(abs(obs-mean(obs))))
  return(result)
}

