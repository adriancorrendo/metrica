#' @title Uncorrected Variance (var_u)
#' @name var_u
#' @description It estimates the var_u of observed or predicted values.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param x Vector with numeric elements.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details The var_u is the sample, uncorrected variance. It is calculated as the mean
#' of sum of squared differences between values of an x and its mean, divided by the sample size (n).
#' It is uncorrected because it is divided by n, and by not n-1 (traditional variance).
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @examples 
#' \donttest{
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