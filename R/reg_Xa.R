#' @title Accuracy Component (Xa) of CCC 
#' @name Xa
#' @description It estimates the Xa component for the calculation of the Concordance 
#' Correlation Coefficient (CCC) following Lin (1989).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The Xa measures accuracy of prediction. It goes from 0 (completely inaccurate) to 1 (perfectly accurate).
#' It is used to adjust the precision measured by the correlation coefficient (r) 
#' in order to evaluate agreement through the CCC.
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
#' Xa(obs = X, pred = Y)
#' }
#' @rdname Xa
#' @importFrom rlang eval_tidy quo
#' @export 
Xa <- function(data=NULL,
               obs,
               pred,
               tidy = FALSE,
               na.rm = TRUE){
  Xa <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      (2 / (sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))/
              sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}})) +
              sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))/
              sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}})) +
              ((mean({{pred}})-mean({{obs}}))^2/
                 (sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))*
                    sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))))) )
    )
  )
  if (tidy==TRUE){ return(as.data.frame(Xa)) }
  
  if (tidy==FALSE){ return(list("Xa" = Xa)) }
}