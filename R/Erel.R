#' @title Erel
#' @description Krause Relative Model Efficiency (Erel).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the Erel for a Predicted-Observed dataset
#' following Krause et al. (2005).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' Erel(obs = X, pred = Y)
#' }
#' @rdname Erel
#' @importFrom rlang eval_tidy quo
#' @export 
Erel <- function(data = NULL,
                 obs,
                 pred,
                 na.rm = TRUE) {
  result <- rlang::eval_tidy(
    data=data,
    rlang::quo(
      1 - sum((({{obs}}-{{pred}})/{{obs}})^2)/
    sum((({{obs}}-mean({{obs}}))/mean({{obs}}))^2)
    )
  )
  return(result)
}

