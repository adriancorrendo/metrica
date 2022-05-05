#' @title SB
#' @description Squared bias (SB)component of the Mean Square 
#' Error (MSE). 
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the SB for a Predicted-Observed dataset 
#' following the MSE segregation suggested by Kobayashi and Salam 
#' (2000).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' SB(obs = X, pred = Y)
#' }
#' @rdname SB
#' @importFrom rlang eval_tidy quo
#' @export 
SB <- function(data=NULL,
               obs,
               pred,
               na.rm = TRUE){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    (mean({{obs}}) - mean({{pred}}))^2
    )
  )
  
  return(result)
}