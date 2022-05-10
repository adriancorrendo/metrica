#' @title Lack of Correlation (LCS)
#' @name LCS
#' @description It estimates the lack of correlation (LCS) component of the Mean 
#' Squared Error (MSE) proposed by Kobayashi & Salam (2000).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The LCS represents the random component of the prediction error following
#' Kobayashi & Salam (2000). The lower the value the less contribution to the MSE.
#' However, it needs to be compared to MSE as its benchmark.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' Kobayashi & Salam (2000).
#' Comparing simulated and measured values using mean squared deviation and its components. 
#' _Agron. J. 92, 345–352._ \doi{10.2134/agronj2000.922345x}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' LCS(obs = X, pred = Y)
#' }
#' @rdname LCS
#' @importFrom rlang eval_tidy quo
#' @export 
LCS <- function(data=NULL,
                obs,
                pred,
                na.rm = TRUE){
  result <- rlang::eval_tidy(
    data=data,
    rlang::quo(
    2 * sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}})) * 
      sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}})) *
    (1 - stats::cor({{obs}},{{pred}}))
    )
  )
  return(result)
}