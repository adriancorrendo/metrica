#' @title r
#' @description Pearson's correlation coefficient (r).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the classic r for a Predicted-Observed dataset.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' r(obs = X, pred = Y)
#' }
#' @rdname r
#' @importFrom stats cor
#' @importFrom rlang eval_tidy quo
#' @export 
r <- function(data=NULL,
              obs,
              pred,
              na.rm = TRUE){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      (sum(({{obs}}-mean({{obs}}))*({{pred}}-mean({{pred}}))))/
    (sqrt(sum(({{obs}}-mean({{obs}}))^2))*sqrt(sum(({{pred}}-mean({{pred}}))^2)))
    )
  )
  return(result)
}