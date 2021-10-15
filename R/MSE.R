#' @title MSE
#' @description Mean Square Error.
#' @param data Dataframe with observed and predicted vectors.
#' @param obs Vector with observed values (numeric).
#' @param pre Vector with predicted values (numeric).
#' @return Element of class `double`.
#' @details Calculates the MSE comparing Predicted and Observed
#' values.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' MSE(obs = X, pre = Y)
#' }
#' @rdname MSE
#' @export 
MSE <- function(data, obs, pred, ...,
                options = list(), 
                na_rm = TRUE) {
  names <- names(data)
  obs <- tidyselect::vars_pull(names, {{obs}})
  pred <- tidyselect::vars_pull(names, {{obs}})
  
  sum((data$obs-data$pre)^2)/length(data$obs)
}

