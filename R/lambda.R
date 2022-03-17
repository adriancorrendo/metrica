#' @title lambda
#' @description Duveiller's et al. Lambda Agreemeent Coefficient
#' (DLambda).
#' @param data (Optional) argument to call an existing data frame containing the data.
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
#' @importFrom rlang eval_tidy quo
#' @export 
lambda <- function(data = NULL, 
                   obs,
                   pred,
                   na.rm = TRUE) {
  MSE <- sum(({{obs}}-{{pred}})^2)/length({{obs}})
  MBE <- (mean({{obs}})-mean({{pred}}))
  result <- rlang::eval_tidy(
    data=data,
    rlang::quo( 
    1 - ( MSE /
            (sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}) +
               sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}) + 
               MBE^2)) 
    )
  )
  return(result)
} 

