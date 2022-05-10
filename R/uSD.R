#' @title Uncorrected Standard Deviation 
#' @name uSD
#' @description It estimates the (uSD) of observed or predicted values.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param x Vector with numeric observed or predicted values.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The uSD is the sample, uncorrected standard deviation. The square root of 
#' the mean of sum of squared differences between vector values with respect to their mean.
#' It is uncorrected because it is divided by the sample size (n), not n-1.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' uSD(x = X)
#' }
#' @rdname uSD
#' @importFrom rlang eval_tidy quo
#' @export 

uSD <- function(data=NULL,
                x,
                na.rm = TRUE){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      sqrt(sum(({{x}} - mean({{x}}))^2)/length({{x}}))
    )
  )
  return(result)
}