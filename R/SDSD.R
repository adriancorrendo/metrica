#' @title SDSD
#' @description Square difference between standard deviations (SDSD)
#' component of the Mean Square Error (MSE). 
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the SDSD for a Predicted-Observed dataset 
#' following the MSE segregattion suggested by Kobayashi and Salam 
#' (2000).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' SDSD(obs = X, pred = Y)
#' }
#' @rdname SDSD
#' @importFrom rlang eval_tidy quo
#' @export 
SDSD <- function(data=NULL,
                 obs,
                 pred,
                 na.rm = TRUE){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo( 
    (sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}})) -
       sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}})))^2
    )
  )
  
  return(result)
}