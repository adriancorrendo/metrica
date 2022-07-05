#' @title Percentage Additive Bias (PAB)
#' @name PAB
#' @description It estimates the contribution of the proportional bias to the Mean Squared Error (MSE) 
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
#' @details The PAB represents contribution of additive bias () component of the MSE. 
#' The PAB = 100*((mO-mP)^2/MSE), where mO, and mP represent the mean of observations
#' and predictions, respectively. 
#' The greater the value the greater the contribution of additive bias to the prediction error.
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
#' PAB(obs = X, pred = Y)
#' }
#' @rdname PAB
#' @importFrom rlang eval_tidy quo
#' @export 
PAB <- function(data=NULL,
                obs,
                pred,
                tidy = FALSE,
                na.rm = TRUE){
  SB <- (mean({{obs}}) - mean({{pred}}))^2
  MSE <- sum(({{obs}}-{{pred}})^2)/length({{obs}})
  
  PAB <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    100 * (SB / MSE)
    )
  )
  
  if (tidy==TRUE){ return(as.data.frame(PAB)) }
  
  if (tidy==FALSE){ return(list("PAB" = PAB)) }
}