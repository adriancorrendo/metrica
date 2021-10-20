#' @title d1r
#' @description Refined Willmott's Index of Agreement (d1r).
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the d1e for a Predicted-Observed dataset
#' following Willmott et al. (2012), which modifies the denominator
#' (potential error) when normalizing the mean absolute error
#' (numerator).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' d1r(obs = X, pred = Y)
#' }
#' @rdname d1r
#' @export 
d1r <- function(obs, pred,
               na.rm = TRUE) {
  result <- 
    1-((sum(abs(obs-pred)))/2*sum(abs(obs-mean(obs))))
  return(result)
}

