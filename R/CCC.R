#' @title CCC
#' @description Concordance Correlation Coefficient.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the CCC for Predicted-Observed dataset.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' CCC(obs = X, pred = Y)
#' }
#' @rdname CCC
#' @importFrom rlang eval_tidy quo
#' @export 
CCC <- function(data = NULL, 
                obs, 
                pred,
                na.rm = TRUE){
  result <-  rlang::eval_tidy(
    data=data,
    rlang::quo(
      stats::cor({{obs}},{{pred}}) *
    (2 / (sqrt(sum(({{pred}} - mean({{pred}}))^2)/
                 length({{pred}}))/sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}})) +
            sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))/
            sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}})) +
            ((mean({{pred}})-mean({{obs}}))^2/
               (sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))*
                  sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))))) )
    )
  )
  return(result)
}

