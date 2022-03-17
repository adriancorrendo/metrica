#' @title d
#' @description Willmott's Index of Agreement (d).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the d for a Predicted-Observed dataset
#' following Willmott (1981).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' d(obs = X, pred = Y)
#' }
#' @rdname d
#' @importFrom rlang eval_tidy quo
#' @export 
d <- function(data = NULL,
              obs,
              pred,
              na.rm = TRUE) {
  result <- rlang::eval_tidy(
    data=data,
    rlang::quo(
    1-((sum(({{obs}}-{{pred}})^2))/sum((abs({{obs}}-mean({{pred}}))+
                                  abs({{pred}}-mean({{obs}})))^2))
    )
  )
  return(result)
}

