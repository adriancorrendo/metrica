#' @title MBE
#' @description Mean Bias Error.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the MBE of Predicted compared to Observed
#' values. Negative values indicate overestimation. Positive
#' values indicate underestimation. Moriasi et al. (2007).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' MBE(obs = X, pred = Y)
#' }
#' @rdname MBE
#' @importFrom rlang eval_tidy quo
#' @export 
MBE <- function(data=NULL,
                obs,
                pred,
                na.rm = TRUE){
  result <-  rlang::eval_tidy(
    data=data,
    rlang::quo(
      (mean({{obs}})-mean({{pred}}))
    )
  )
  return(result)
}