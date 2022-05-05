#' @title Uc
#' @description Lack of consistency (Uc). Proportion of the total sum
#' of squares related to the proportional bias.
#' @param data (Optional) argument to call an existing data frame containing the data. 
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the Uc (%) for a Predicted-Observed dataset 
#' following the sum of squares segregation suggested by Smith and
#' Rose (1995) also known as Theil's partial inequalities.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' Uc(obs = X, pred = Y)
#' }
#' @rdname Uc
#' @importFrom rlang eval_tidy quo
#' @export 
Uc <- function(data=NULL,
               obs, pred,
               na.rm = TRUE){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    100*(length({{obs}})*
           (sqrt(sum(({{obs}} - mean({{obs}}))^2)/
                   length({{obs}}))-sqrt(sum(({{pred}} - mean({{pred}}))^2)/
                                           length({{pred}})))^2) /
      sum(({{obs}}-{{pred}})^2)
    )
  )
  
  return(result)
}