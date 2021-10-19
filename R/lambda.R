#' @title lambda
#' @description Duveiller's et al. Lambda Agreemeent Coefficient
#' (DLambda).
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the lambda coefficient for a Predicted-Observed
#' dataset following Duveiller et al. (2015).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' lambda(obs = X, pred = Y)
#' }
#' @rdname lambda
#' @export 
lambda <- function(obs, pred,
                na.rm = TRUE) {
  result <- 
    1 - ( (metrica::MSE(obs,pred)) /
            (metrica::var.u(obs) + metrica::var.u(pred) + 
               metrica::MBE(obs,pred)^2)) 
  return(result)
} 

