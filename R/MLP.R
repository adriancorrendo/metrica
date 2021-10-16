#' @title MLP
#' @description Mean Lack of Precision (MLP) component of the Mean 
#' Square Error (MSE).
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the MLP for a Predicted-Observed dataset
#' following the MSE decomposition suggested by Correndo et al (2021).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' MLP(obs = X, pred = Y)
#' }
#' @rdname MLP
#' @export 
MLP <- function(obs, pred,
                na.rm = TRUE){
  result <- sum (abs(obs - ((mean(obs) -
        (metrica::sdev(obs)/metrica::sdev(pred)*mean(pred))) +
          metrica::sdev(obs)/metrica::sdev(pred) * pred)) *
          abs(pred - ((mean(pred) - (metrica::sdev(pred)/
          metrica::sdev(obs)*mean(obs))) +
            metrica::sdev(pred)/metrica::sdev(obs) * obs) ) ) /
    length(obs) 
  
  return(result)
}