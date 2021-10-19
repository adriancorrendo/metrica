#' @title TSS
#' @description Total Sum of Squares (R2).
#' @param obs Vector with observed values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the TSS for a Predicted-Observed dataset.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' TSS(obs = X, pred = Y)
#' }
#' @rdname TSS
#' @importFrom stats cor var
#' @export 
TSS <- function(obs, 
               na.rm = TRUE){
  result <- sum((obs-mean(obs))^2)
  return(result)
}