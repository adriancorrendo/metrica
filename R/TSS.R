#' @title TSS
#' @description Total Sum of Squares (R2).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the TSS for a Predicted-Observed dataset.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' TSS(obs = X, pred = Y)
#' }
#' @rdname TSS
#' @importFrom stats cor var
#' @importFrom rlang eval_tidy quo
#' @export 
TSS <- function(data=NULL,
                obs, 
                na.rm = TRUE){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      sum(({{obs}}-mean({{obs}}))^2)
    )
  )
  return(result)
}