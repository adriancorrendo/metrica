#' @title Mean Bias Error (MBE) 
#' @name MBE
#' @description It estimates the MBE for a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The MBE is one of the most widely used error metrics. It presents the 
#' same units than the response variable, and it is unbounded. It can be simply 
#' estimated as the difference between the means of predictions and observations. 
#' The closer to zero the better. Negative values indicate overestimation. 
#' Positive values indicate general underestimation. The disadvantages are that is 
#' only sensitive to additional bias, so the MBE may mask a poor performance if 
#' overestimation and underestimation co-exist (a type of proportional bias).
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' MBE(obs = X, pred = Y)
#' }
#' @rdname MBE
#' @importFrom rlang eval_tidy quo
#' @export 
MBE <- function(data=NULL,
                obs,
                pred,
                tidy = FALSE,
                na.rm = TRUE){
  MBE <-  rlang::eval_tidy(
    data=data,
    rlang::quo(
      (mean({{obs}})-mean({{pred}}))
    )
  )
  if (tidy==TRUE){ return(as.data.frame(MBE)) }
  
  if (tidy==FALSE){ return(list("MBE" = MBE)) }
}