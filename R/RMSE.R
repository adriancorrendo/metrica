#' @title RMSE
#' @description Root Mean Square Error.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the RMSE for a Predicted-Observed dataset.
#' @examples 
#' \dontrun{
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