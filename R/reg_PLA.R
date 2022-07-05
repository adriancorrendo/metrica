#' @title Percentage Lack of Accuracy (PLA) 
#' @name PLA
#' @description It estimates the PLA, the contribution of the systematic error to
#' the Mean Squared Error (MSE) for a continuous predicted-observed dataset 
#' following Correndo et al. (2021).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The PLA (%, 0-100) represents the  contribution of the Mean Lack of Accuracy (MLA), 
#' the systematic (bias) component of the MSE. It is obtained via a symmetric decomposition of
#' the MSE (invariant to predicted-observed orientation). The PLA can be further segregated 
#' into percentage additive bias (PAB) and percentage proportional bias (PPB). 
#' The greater the value the greater the contribution of systematic error to the MSE.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @references 
#' Correndo et al. (2021). 
#' Revisiting linear regression to test agreement in continuous predicted-observed datasets. 
#' _Agric. Syst. 192, 103194._ \doi{10.1016/j.agsy.2021.103194}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' PLA(obs = X, pred = Y)
#' }
#' @rdname PLA
#' @importFrom rlang eval_tidy quo
#' @export 
PLA <- function(data=NULL,
                obs,
                pred,
                tidy = FALSE,
                na.rm = TRUE){
  MSE <- sum(({{obs}}-{{pred}})^2)/length({{obs}})
  MLA <- sum ((
    pred - ( (mean({{obs}}) - (sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))/
                                 sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))*mean({{pred}}))) +
               sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))/
               sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}})) * {{pred}}))^2) / length({{obs}})
  
  PLA <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    100 * (MLA / MSE)
    )
  )
  
  if (tidy==TRUE){ return(as.data.frame(PLA)) }
  
  if (tidy==FALSE){ return(list("PLA" = PLA)) }
}