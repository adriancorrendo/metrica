#' @title DLambda
#' @description Duveiller's et al. Lambda Agreemeent Coefficient
#' (DLambda).
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na_rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the DLambda for a Predicted-Observed dataset
#' following Duveiller et al. (2015).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' DLambda(obs = X, pred = Y)
#' }
#' @rdname DLambda
#' @export 
DLambda <- function(obs, pred,
                na.rm = TRUE) {
  result <- 
    (2/(metrica::sdev(pred)/metrica::sdev(obs)+
          metrica::sdev(obs)/metrica::sdev(pred)+
          (metrica::MBE(obs,pred)^2/(metrica::sdev(pred)*
                                       metrica::sdev(obs))))) 
  return(result)
}

