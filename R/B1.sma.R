#' @title B1.sma
#' @description Slope of standardized major axis regression
#' (symmetric).
#' @param data (Optional) argument to call an existing data frame containing the data.
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
#' @importFrom dplyr case_when
#' @importFrom rlang eval_tidy quo
#' @export 
B1.sma <- function(data = NULL, 
                   obs,
                   pred,
                   orientation = "PO",
                   na.rm = TRUE) {
  sdev.pred <- rlang::eval_tidy(
    data = data,
    rlang::quo(sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}})) ) )
  
  sdev.obs <- rlang::eval_tidy(
    data = data,
    rlang::quo(sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}})) ) )
  
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      sdev.pred/sdev.obs
    )
  )
  if (orientation == "OP"){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}})) /
        sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))
    )
  )
  }
  
  return(result)
}

