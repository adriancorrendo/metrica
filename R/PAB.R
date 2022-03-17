#' @title PAB
#' @description Percentage Additive Bias (PAB) component of the
#' Mean Square Error (MSE).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the PAB (%) for a Predicted-Observed dataset
#' following the symmetric MSE decomposition suggested by
#' Correndo et al (2021).
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' PAB(obs = X, pred = Y)
#' }
#' @rdname PAB
#' @importFrom rlang eval_tidy quo
#' @export 
PAB <- function(data=NULL,
                obs,
                pred,
                na.rm = TRUE){
  SB <- (mean({{obs}}) - mean({{pred}}))^2
  MSE <- sum(({{obs}}-{{pred}})^2)/length({{obs}})
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    100 * (SB / MSE)
    )
  )
  
  return(result)
}