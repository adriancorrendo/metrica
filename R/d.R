#' @title Willmott's Index of Agreement (d)
#' @name d
#' @description It estimates the Willmott's index of agreement (d) for a 
#' continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The d index it is a normalized, dimensionless metric that tests general agreement.
#' It measures both accuracy and precision using squared residuals. It is bounded between 0 and 1. 
#' The disadvantage is that d is an asymmetric index, that is, dependent to what is orientation of
#' predicted and observed values.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' Willmott (1981). 
#' On the validation of models. 
#' _Phys. Geogr. 2, 184–194._ \doi{10.1080/02723646.1981.10642213}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' d(obs = X, pred = Y)
#' }
#' @rdname d
#' @importFrom rlang eval_tidy quo
#' @export 
d <- function(data = NULL,
              obs,
              pred,
              na.rm = TRUE) {
  result <- rlang::eval_tidy(
    data=data,
    rlang::quo(
    1-((sum(({{obs}}-{{pred}})^2))/sum((abs({{obs}}-mean({{pred}}))+
                                  abs({{pred}}-mean({{obs}})))^2))
    )
  )
  return(result)
}

