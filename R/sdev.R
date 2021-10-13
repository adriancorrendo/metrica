#' @title sdev
#' @description Uncorrected Standard Deviation (uSD).
#' @param x Vector with numeric elements.
#' @return Element of class `double`.
#' @details Calculates uSD from a vector x.
#' @examples 
#' \dontrun{
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' sdev(x = X)
#' }
#' @rdname sdev
#' @export 
sdev <- function(x){
  sqrt(sum((x - mean(x))^2)/length(x))
}