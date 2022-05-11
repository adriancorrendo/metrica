#' @title Robinson's Agreement Coefficient (RAC).
#' @name RAC
#' @description It estimates the agreement coefficient suggested by
#' Robinson (1957; 1959) for a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The RAC measures both accuracy and precision (general agreement). It is 
#' normalized, dimensionless, bounded (0 to 1), and symmetric (invariant to predicted-observed orientation).
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' Robinson (1957).
#' The statistical measurement of agreement. 
#' _Am. Sociol. Rev. 22(1), 17-25_ \doi{10.2307/2088760}
#' @references
#' Robinson (1959).
#' The geometric interpretation of agreement. 
#' _Am. Sociol. Rev. 24(3), 338-345_ \doi{10.2307/2089382} 
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' RAC(obs = X, pred = Y)
#' }
#' @rdname RAC
#' @importFrom rlang eval_tidy quo
#' @export 
RAC <- function(data=NULL,
                obs,
                pred,
                na.rm = TRUE){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    1 - ((sum(({{obs}} - ({{obs}} + {{pred}})/2)^2) +
            sum(({{pred}} - ({{obs}} + {{pred}})/2)^2) ) /
           ((sum(({{obs}} - (mean({{obs}})+mean({{pred}}))/2)^2) +
               sum(({{pred}} - (mean({{obs}})+mean({{pred}}))/2)^2))))
    )
  )
  return(result)
}