#' @title var_u
#' @description Uncorrected Sample Variance (var_u, not n-1).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param x Vector with numeric elements.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the var_u of a vector x.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' var_u(x = X)
#' }
#' @rdname var_u
#' @importFrom rlang eval_tidy quo
#' @export 
var_u <- function(data=NULL,
                  x,
                  na.rm = TRUE){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    sum(({{x}} - mean({{x}}))^2)/length({{x}})
    )
  )
  return(result)
}