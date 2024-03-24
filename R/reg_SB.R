#' @title Squared bias (SB)
#' @name SB
#' @description It estimates the SB component of the Mean Squared Error (MSE) 
#' proposed by Kobayashi & Salam (2000). 
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The SB represents the additive bias component of the prediction error 
#' following Kobayashi & Salam (2000). It is in square units of the variable of interest, so 
#' it does not have a direct interpretation. The lower the value the less contribution to the MSE. 
#' However, it needs to be compared to MSE as its benchmark.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @references
#' Kobayashi & Salam (2000).
#' Comparing simulated and measured values using mean squared deviation and its components. 
#' _Agron. J. 92, 345–352._ \doi{10.2134/agronj2000.922345x}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' SB(obs = X, pred = Y)
#' }
#' @rdname SB
#' @importFrom rlang eval_tidy quo
#' @export 
SB <- function(data=NULL,
               obs,
               pred,
               tidy = FALSE,
               na.rm = TRUE){
  SB <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    (mean({{obs}}) - mean({{pred}}))^2
    )
  )
  
  if (tidy==TRUE){ return(as.data.frame(SB)) }
  
  if (tidy==FALSE){ return(list("SB" = SB)) }
}