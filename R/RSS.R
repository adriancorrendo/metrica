#' @title RSS
#' @description Residual Sum of Squares (RSS).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the RSS for a Predicted-Observed dataset.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' RSS(obs = X, pred = Y)
#' }
#' @rdname RSS
#' @importFrom stats cor var
#' @importFrom rlang eval_tidy quo
#' @export

RSS <- function(data=NULL,
                  obs,
                  pred,
                  na.rm = TRUE){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      sum(({{obs}}-{{pred}})^2)
    )
  )
  return(result)
}