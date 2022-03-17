#' @title E1
#' @description Legates and McCabe's Model Efficiency (E1).
#' @param data (Optional) argument to call an existing data frama contaning the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the E1 for a Predicted-Observed dataset
#' following Legates and McCabee (1990).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' E1(obs = X, pred = Y)
#' }
#' @rdname E1
#' @importFrom rlang eval_tidy quo
#' @export 
E1 <- function(data = NULL,
               obs,
               pred,
               na.rm = TRUE) {
  result <- rlang::eval_tidy(
    data=data,
    rlang::quo(
      1-(sum(abs({{obs}}-{{pred}})))/(sum(abs({{obs}}-mean({{obs}}))))
    )
  )
  return(result)
}

