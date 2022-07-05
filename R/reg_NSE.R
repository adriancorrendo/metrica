#' @title Nash-Sutcliffe Model Efficiency (NSE) 
#' @name NSE
#' @description It estimates the model efficiency suggested by Nash & Sutcliffe (1970)
#' for a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The NSE measures general agreement. It is normalized (by the variance of the observations) and dimensionless. 
#' It is calculated using the absolute squared differences between the predictions and observations, 
#' which has been suggested as an issue due to over-sensitivity to outliers.
#' It goes form -infinity to 1. The closer to 1 the better the prediction performance.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @references 
#' Nash & Sutcliffe (1970).
#' River flow forecasting through conceptual models part I - A discussion of principles.
#' _J. Hydrol. 10(3), 292-290._ \doi{10.1016/0022-1694(70)90255-6}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' NSE(obs = X, pred = Y)
#' }
#' @rdname NSE
#' @importFrom rlang eval_tidy quo
#' @export 

NSE <- function(data=NULL,
                obs,
                pred,
                tidy = FALSE,
                na.rm = TRUE) {
  
  n <- rlang::eval_tidy(data = data,
                        rlang::quo(length({{obs}}) ) )
  
  mean_obs <- rlang::eval_tidy(data = data,
                               rlang::quo( sum({{obs}}) ) )  / n
  
  numerator <-  rlang::eval_tidy(data = data,
                                 rlang::quo( 
                                   sum( ({{obs}}-{{pred}})^2 ) / n ) )
  
  denominator <- rlang::eval_tidy(data = data,
                                  rlang::quo(
                                    sum( ({{obs}} - mean_obs)^2 ) / n ) )
  
  NSE <- 1 - ( numerator / denominator )
  
  if (tidy==TRUE){ return(as.data.frame(NSE)) }
  
  if (tidy==FALSE){ return(list("NSE" = NSE)) }
}

