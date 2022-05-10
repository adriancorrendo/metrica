#' @title Inter-Quartile Root Mean Squared Error 
#' @name iqRMSE
#' @description It estimates the IqRMSE for a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The iqRMSE normalizes the RMSE by the length of the inter-quartile range of
#' observations (percentiles 25th to 75th). As an error metric, the lower the values the better. 
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' iqRMSE(obs = X, pred = Y)
#' }
#' @rdname iqRMSE
#' @importFrom stats quantile
#' @importFrom rlang eval_tidy quo
#' @export 
iqRMSE <- function(data = NULL,
                   obs,
                   pred,
                   na.rm = TRUE) {
  result <- rlang::eval_tidy(
    data=data,
    rlang::quo(
      sqrt(sum(({{obs}}-{{pred}})^2)/length({{obs}})) / 
    (stats::quantile({{obs}},probs = c(.75))[[1]]-
       stats::quantile({{obs}},probs = c(.25))[[1]])
    )
  )
  return(result)
}

