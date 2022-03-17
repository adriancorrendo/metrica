#' @title AC
#' @description Ji and Gallo's Agreement Coefficient (AC).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the AC for a Predicted-Observed dataset
#' following Ji and Gallo (2006).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' df <- data.frame(obs = X, pred = Y)
#' AC(df, obs = X, pred = Y)
#' }
#' @rdname AC
#' @importFrom rlang eval_tidy quo
#' @export 
AC <- function(data = NULL, 
               obs, 
               pred,
               na.rm = TRUE) {
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    1 -(sum(({{obs}}-{{pred}})^2)/
          sum((abs(mean({{pred}})-mean({{obs}}))+abs({{obs}}-mean({{obs}})))*
                (abs(mean({{pred}})-mean({{obs}}))+abs({{pred}}-mean({{pred}}))))) 
    )
  )
  return(result)
}

