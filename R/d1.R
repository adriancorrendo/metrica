#' @title d1
#' @description Modified Willmott's Index of Agreement (d1).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the d1 for a Predicted-Observed dataset
#' following Willmott et al. (1985), which uses absolute instead of
#' squared residuals.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' d1(obs = X, pred = Y)
#' }
#' @rdname d1
#' @importFrom rlang eval_tidy quo
#' @export 
d1 <- function(data = NULL,
               obs,
               pred,
               na.rm = TRUE) {
  result <- rlang::eval_tidy(
    data=data,
    rlang::quo(
    1-((sum(abs({{obs}}-{{pred}})))/sum(abs({{pred}}-mean({{obs}}))+
                                  abs({{obs}}-mean({{obs}}))))
    )
  )
  return(result)
}

