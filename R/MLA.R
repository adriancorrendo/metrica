#' @title MLA
#' @description Mean Lack of Accuracy (MLA) component of the Mean 
#' Square Error (MSE).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the MLA for a Predicted-Observed dataset
#' following the symmetric MSE decomposition suggested by
#' Correndo et al (2021).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' MLA(obs = X, pred = Y)
#' }
#' @rdname MLA
#' @importFrom rlang eval_tidy quo
#' @export 
MLA <- function(data=NULL,
                obs,
                pred,
                na.rm = TRUE){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    sum ((
      pred - ( (mean({{obs}}) - (sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))/
                sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))*mean({{pred}}))) +
                 sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))/
                 sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}})) * {{pred}}))^2) / length({{obs}}) 
    )
  )
  
  return(result)
}