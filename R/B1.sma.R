#' @title B1.sma
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
#' @details Calculates the slope (B1) for the bivariate 
#' Predicted-Observed dataset following the standardized major axis
#' regression, Warton et al. (2006).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' B1.sma(obs = X, pred = Y)
#' }
#' @rdname B1.sma
#' @export 
B1.sma <- function(obs,
                  pred,
                  orientation = "PO",
                  na.rm = TRUE) {
    result <- metrica::sdev(pred)/metrica::sdev(obs)
  if(orientation == "OP")
    result <- metrica::sdev(obs)/metrica::sdev(pred)
  return(result)
}

