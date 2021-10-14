#' @title SSx
#' @description Sum of Squares (SS) or Uncorrected Variance (not n-1).
#' @param x Vector with numeric elements.
#' @return Element of class `double`.
#' @details Calculates the SS from a vector x.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' SSx(x = X)
#' }
#' @rdname SSx
#' @export 
SSx <- function(x){
  sum((x - mean(x))^2)/length(x)
}