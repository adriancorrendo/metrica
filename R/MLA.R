#' @title Mean Lack of Accuracy (MLA)
#' @name MLA
#' @description It estimates the MLA, the systematic error component to
#' the Mean Squared Error (MSE), for a continuous predicted-observed dataset 
#' following Correndo et al. (2021).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The MLA represents the systematic (bias) component of the MSE. 
#' It is obtained via a symmetric decomposition of the MSE (invariant to 
#' predicted-observed orientation) using a symmetric regression line.
#' The MLA is equal to the sum of systematic differences divided by the sample size (n). 
#' The greater the value the greater the bias of the predictions.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references 
#' Correndo et al. (2021). 
#' Revisiting linear regression to test agreement in continuous predicted-observed datasets. 
#' _Agric. Syst. 192, 103194._ \doi{10.1016/j.agsy.2021.103194}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' MLA(obs = X, pred = Y)
#' }
#' @rdname MLA
#' @importFrom rlang eval_tidy quo
#' @export 
MLA <- function(data=NULL,
                obs,
                pred,
                na.rm = TRUE){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    sum ((
      pred - ( (mean({{obs}}) - (sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))/
                sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))*mean({{pred}}))) +
                 sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))/
                 sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}})) * {{pred}}))^2) / length({{obs}}) 
    )
  )
  
  return(result)
}