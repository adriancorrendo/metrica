#' @title Concordance correlation coefficient (CCC) 
#' @name CCC
#' @description It estimates the Concordance Correlation Coefficient (CCC) for 
#' a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The CCC it is a normalized coefficient that tests general agreement. 
#' It presents both precision (r) and accuracy (Xa) components. It is positively bounded to 1. 
#' The closer to 1 the better. Values towards zero indicate low correlation between observations and predictions.
#' Negative values would indicate a negative relationship between predicted and observed.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' Lin (1989). 
#' A concordance correlation coefficient to evaluate reproducibility.
#' _Biometrics 45 (1), 255–268._ \doi{10.2307/2532051}
#' @examples 
#' \donttest{
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
                tidy = FALSE,
                na.rm = TRUE){
  CCC <-  rlang::eval_tidy(
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
  if (tidy==TRUE){ return(as.data.frame(CCC)) }
  
  if (tidy==FALSE){ return(list("CCC" = CCC)) }
}

