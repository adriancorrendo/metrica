#' @title RAC
#' @description Robinson's Agreement Coefficient.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the RAC for a Predicted-Observed dataset 
#' following Robinson (1957,1959).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' RAC(obs = X, pred = Y)
#' }
#' @rdname RAC
#' @export 
RAC <- function(obs, pred,
                na.rm = TRUE){
  result <- 
    1 - ((sum((obs - (obs + pred)/2)^2) +
            sum((pred - (obs + pred)/2)^2) ) /
           ((sum((obs - (mean(obs)+mean(pred))/2)^2) +
               sum((pred - (mean(obs)+mean(pred))/2)^2))))
  return(result)
}