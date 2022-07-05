#' @title Sample Correlation Coefficient (r)
#' @name r
#' @description It estimates the Pearson's coefficient of correlation (r) for a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The r coefficient measures the strength of linear relationship between two variables.
#' It only accounts for precision, but it is not sensitive to lack of prediction accuracy. 
#' It is a normalized, dimensionless coefficient, that ranges between -1 to 1. It is expected that
#' predicted and observed values will show 0 < r < 1.
#' It is also known as the Pearson Product Moment Correlation, among other names.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @references 
#' Kirch (2008)
#' Pearson’s Correlation Coefficient. 
#' _In: Kirch W. (eds) Encyclopedia of Public Health. Springer, Dordrecht._ 
#' \doi{https://doi.org/10.1007/978-1-4020-5614-7_2569}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' r(obs = X, pred = Y)
#' }
#' @rdname r
#' @importFrom stats cor
#' @importFrom rlang eval_tidy quo
#' @export 
r <- function(data=NULL,
              obs,
              pred,
              tidy = FALSE,
              na.rm = TRUE){
  r <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      (sum(({{obs}}-mean({{obs}}))*({{pred}}-mean({{pred}}))))/
    (sqrt(sum(({{obs}}-mean({{obs}}))^2))*sqrt(sum(({{pred}}-mean({{pred}}))^2)))
    )
  )
  if (tidy==TRUE){ return(as.data.frame(r)) }
  
  if (tidy==FALSE){ return(list("r"=r)) }
}