#' @title SSx
#' @description Sum of Squares (SS) or Uncorrected Variance (not n-1).
#' @param x Vector with numeric elements.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the SS from a vector x.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' SSx(x = X)
#' }
#' @rdname SSx
#' @export 
SSx <- function(x,
                na.rm = TRUE){
  result <- sum((x - mean(x))^2)/length(x)
  return(result)
}