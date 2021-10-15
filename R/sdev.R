#' @title sdev
#' @description Uncorrected Standard Deviation (uSD).
#' @param x Vector with numeric elements.
#' @return Element of class `numeric`.
#' @details Calculates uSD from a vector x.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' sdev(x = X)
#' }
#' @rdname sdev
#' @export 
sdev <- function(x){
  result <- sqrt(sum((x - mean(x))^2)/length(x))
  return(result)
}