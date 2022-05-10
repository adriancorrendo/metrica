#' @title Root Mean Squared Error (RMSE) 
#' @name RMSE
#' @description It estimates the RMSE for a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The RMSE is one of the most widely used error metrics in literature to 
#' evaluate prediction performance. It measures general agreement, being sensitive to
#' both lack of precision and lack of accuracy. It is simply the square root of 
#' the Mean Squared Error (MSE). Thus, it presents the same units as the variable of 
#' interest, facilitating the interpretation. It goes from 0 to infinity. The lower 
#' the value the better the prediction performance. Its counterpart is being very
#' sensitive to outliers.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' RMSE(obs = X, pred = Y)
#' }
#' @rdname RMSE
#' @importFrom rlang eval_tidy quo
#' @export 
RMSE <- function(data=NULL,
                 obs,
                 pred,
                 na.rm = TRUE){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      sqrt(sum(({{obs}}-{{pred}})^2)/length({{obs}}))
    )
  )
  return(result)
}