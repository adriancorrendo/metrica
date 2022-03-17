#' @title MLP
#' @description Mean Lack of Precision (MLP) component of the Mean 
#' Square Error (MSE).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the MLP for a Predicted-Observed dataset
#' following the MSE decomposition suggested by Correndo et al (2021).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' MLP(obs = X, pred = Y)
#' }
#' @rdname MLP
#' @importFrom rlang eval_tidy quo
#' @export 
MLP <- function(data=NULL,
                obs, 
                pred,
                na.rm = TRUE){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      sum (abs({{obs}} - ((mean({{obs}}) -
        (sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))/
           sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))*mean({{pred}}))) +
          sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))/
          sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}})) * {{pred}})) *
          abs({{pred}} - ((mean({{pred}}) - (sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))/
          sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))*mean({{obs}}))) +
            sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))/
            sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}})) * {{obs}}) ) ) /
    length({{obs}}) 
    )
  )
  
  return(result)
}

