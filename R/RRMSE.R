#' @title RRMSE
#' @description Relative Root Mean Squared Error.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the RRMSE for a Predicted-Observed dataset by
#' normalizing the RMSE by the mean of observations. In literature, it
#' can be also found as NRMSE (normalized root mean squared error),
#' however, here we use RRMSE since several other alternatives to 
#' "normalize" the RMSE exist (e.g., RSR, iqRMSE).
#' @examples 
#' \dontrun{
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
                  na.rm = TRUE){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    sqrt(sum(({{obs}}-{{pred}})^2)/length({{obs}})) / (mean({{obs}}))
    )
  )
  return(result)
}