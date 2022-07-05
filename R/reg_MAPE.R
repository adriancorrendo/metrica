#' @title Mean Absolute Percentage Error (MAPE) 
#' @name MAPE
#' @description It estimates the MAPE of a continuous predicted-observed dataset.
#' @param data (optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The MAPE is expressed in percentage units (independent scale), which it
#' makes easy to explain and to compare performance across models with different response variables. 
#' MAPE is asymmetric (sensitive to axis orientation). The lower the better. 
#' As main disadvantage, MAPE produces infinite or undefined values for zero or close-to-zero observed values.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @references 
#' Kim & Kim (2016).
#' A new metric of absolute percentage error for intermittent demand forecast.
#' _Int. J. Forecast. 32, 669-679._\doi{10.1016/j.ijforecast.2015.12.003}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' MAPE(obs = X, pred = Y)
#' }
#' @rdname MAPE
#' @importFrom rlang eval_tidy quo
#' @export 
MAPE <- function(data=NULL,
                 obs,
                 pred,
                 tidy = FALSE,
                 na.rm = TRUE){
  MAPE <-  rlang::eval_tidy(
    data=data,
    rlang::quo(
    (sum((abs({{obs}}-{{pred}})/{{obs}}))/length({{obs}}))*100
    )
  )
  if (tidy==TRUE){ return(as.data.frame(MAPE)) }
  
  if (tidy==FALSE){ return(list("MAPE" = MAPE)) }
}