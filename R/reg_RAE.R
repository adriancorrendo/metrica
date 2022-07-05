#' @title Relative Absolute Error (RAE) 
#' @name RAE
#' @description It estimates the RAC for a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The RAE normalizes the Mean Absolute Error (MAE) with respect to the 
#' total absolute error. It is calculated as the ratio between the sum of absolute 
#' residuals (error of predictions with respect to observations) and the sum of 
#' absolute errors of observations with respect to its mean. 
#' It presents its lower bound at 0 (perfect fit), and has no upper bound. 
#' It can be used to compare models using different units.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' RAE(obs = X, pred = Y)
#' }
#' @rdname RAE
#' @importFrom rlang eval_tidy quo
#' @export 
RAE <- function(data=NULL,
                obs,
                pred,
                tidy = FALSE,
                na.rm = TRUE){
  RAE <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      sum(abs({{obs}}-{{pred}})) / sum(abs({{obs}}-mean({{obs}})))
    )
  )
  if (tidy==TRUE){ return(as.data.frame(RAE)) }
  
  if (tidy==FALSE){ return(list("RAE" = RAE)) }
}