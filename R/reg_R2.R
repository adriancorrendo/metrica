#' @title Coefficient of determination (R2).
#' @name R2
#' @description It estimates the R2 for a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The R2 is one of the most widely used metrics evaluating models performance.
#' R2 is appropriate to estimate the strength of linear association between two variables.
#' It is positively bounded to 1, but it may produce negative values. 
#' The closer to 1 the better linear association between predictions and observations. 
#' However, R2 presents a major flaw for prediction performance evaluation: 
#' it is not sensitive to lack of accuracy (additive or proportional bias). Thus, R2 
#' only measures precision, but it does not account for accuracy of the predictions.  
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references 
#' Yang et al. (2014). 
#' An evaluation of the statistical methods for testing the performance of crop models with observed data.
#' _Agric. Syst. 127, 81-89._ \doi{10.1016/j.agsy.2014.01.008}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' R2(obs = X, pred = Y)
#' }
#' @rdname R2
#' @importFrom stats cor
#' @importFrom rlang eval_tidy quo
#' @export 
R2 <- function(data=NULL,
               obs,
               pred,
               tidy = FALSE,
               na.rm = TRUE){
  
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      1 - (sum(({{obs}}-{{pred}})^2)/sum(({{obs}}-mean({{obs}}))^2))
    )
  )
  
  R2 <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      (sum(({{obs}}-mean({{obs}}))*({{pred}}-mean({{pred}}))))^2/
    (sqrt(sum(({{obs}}-mean({{obs}}))^2))*sqrt(sum(({{pred}}-mean({{pred}}))^2)))^2
    )
  )
  
  if (tidy==TRUE){ return(as.data.frame(R2)) }
  
  if (tidy==FALSE){ return(list("R2" = R2)) }
  
}