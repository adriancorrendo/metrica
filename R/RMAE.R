#' @title Relative Mean Absolute Error (RMAE)
#' @name RMAE
#' @description It estimates the RMAE for a continuous predicted-observed dataset. 
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The RMAE normalizes the Mean Absolute Error (MAE) by the mean of observations.
#' The closer to zero the lower the prediction error.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' RMAE(obs = X, pred = Y)
#' }
#' @rdname RMAE
#' @importFrom rlang eval_tidy quo
#' @export 
RMAE <- function(data=NULL,
                obs,
                pred,
                na.rm = TRUE){
  MAE <- sum(abs({{obs}}-{{pred}}))/length({{obs}})
  result <- rlang::eval_tidy(
    data=data,
    rlang::quo(
    MAE / mean({{obs}})
    )
  )
  return(result)
}