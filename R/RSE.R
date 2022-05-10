#' @title Relative Squared Error (RSE) 
#' @name RSE
#' @description It estimates the RSE for a continuous predicted-observer dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The RSE is the ratio between the residual sum of squares (RSS, error of
#' predictions with respect to observations) and the total sum of squares (TSS, 
#' error of observations with respect to its mean). RSE is dimensionless, so it can be 
#' used to compared models with different units.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html) 
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' RSE(obs = X, pred = Y)
#' }
#' @rdname RSE
#' @importFrom rlang eval_tidy quo
#' @export 
RSE <- function(data = NULL,
                obs,
                pred,
                na.rm = TRUE){
  RSS <- rlang::eval_tidy(
    data = data,
    rlang::quo(sum(({{obs}}-{{pred}})^2) ) )
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      RSS / sum(({{obs}}-mean({{obs}}))^2)
    )
  )
  return(result)
}