#' @title PLA
#' @description Percentage Lack of Accuracy (PLA) component of the Mean 
#' Square Error (MSE).
#' @param data (Optional) argument to call an exisitng data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the PLA (%) for a Predicted-Observed dataset
#' following the symmetric MSE decomposition suggested by
#' Correndo et al (2021).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' PLA(obs = X, pred = Y)
#' }
#' @rdname PLA
#' @importFrom rlang eval_tidy quo
#' @export 
PLA <- function(data=NULL,
                obs,
                pred,
                na.rm = TRUE){
  MSE <- sum(({{obs}}-{{pred}})^2)/length({{obs}})
  MLA <- sum ((
    pred - ( (mean({{obs}}) - (sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))/
                                 sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))*mean({{pred}}))) +
               sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))/
               sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}})) * {{pred}}))^2) / length({{obs}})
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    100 * (MLA / MSE)
    )
  )
  
  return(result)
}