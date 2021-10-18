#' @title B0.sma
#' @description Slope of standardized major axis regression
#' (symmetric).
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param orientation Argument of class string specifying the axis
#' orientation, PO for predicted vs observed, and OP for
#' observed vs predicted. Default is orientation = "PO".
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na_rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the intercept (B0) for the bivariate
#' Predicted-Observed dataset following the standardized major 
#' axis regression, Warton et al. (2006).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' B0.sma(obs = X, pred = Y)
#' }
#' @rdname B0.sma
#' @export 
B0.sma <- function(obs,
                     pred,
                     orientation = "PO",
                     na.rm = TRUE){
  
  slope <- metrica::sdev(pred)/metrica::sdev(obs)
  result <- mean(pred) - (slope*mean(obs))
  
  if(orientation == "OP")
    slope <- metrica::sdev(obs)/metrica::sdev(pred)
    result <- mean(obs) - (slope*mean(pred))
    
  return(result)
}

