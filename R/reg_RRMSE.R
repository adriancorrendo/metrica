#' @title Relative Root Mean Squared Error (RMSE) 
#' @name RRMSE
#' @description It estimates the RRMSE for a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The RRMSE (%) normalizes the Root Mean Squared Error (RMSE) by the mean 
#' of observations. It goes from 0 to infinity. The lower the better the prediction performance.
#' In literature, it can be also found as NRMSE (normalized root mean squared error).
#' However, here we use RRMSE since several other alternatives to 
#' "normalize" the RMSE exist (e.g., RSR, iqRMSE).
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' RRMSE(obs = X, pred = Y)
#' }
#' @rdname RRMSE
#' @importFrom rlang eval_tidy quo
#' @export 
RRMSE <- function(data=NULL,
                  obs, 
                  pred,
                  tidy = FALSE,
                  na.rm = TRUE){
  RRMSE <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    sqrt(sum(({{obs}}-{{pred}})^2)/length({{obs}})) / (mean({{obs}}))
    )
  )
  if (tidy==TRUE){ return(as.data.frame(RRMSE)) }
  
  if (tidy==FALSE){ return(list("RRMSE" = RRMSE)) }
}