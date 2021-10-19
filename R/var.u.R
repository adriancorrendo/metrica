#' @title var.u
#' @description Uncorrected Sample Variance (var.u, not n-1).
#' @param x Vector with numeric elements.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the var.u of a vector x.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' var.u(x = X)
#' }
#' @rdname var.u
#' @export 
var.u <- function(x,
                na.rm = TRUE){
  result <- sum((x - mean(x))^2)/length(x)
  return(result)
}