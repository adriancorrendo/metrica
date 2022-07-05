#' @title Percentage Lack of Precision (PLP) 
#' @name PLP
#' @description It estimates the PLP, the contribution of the unsystematic error to
#' the Mean Squared Error (MSE) for a continuous predicted-observed dataset 
#' following Correndo et al. (2021).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The PLP (%, 0-100) represents the  contribution of the Mean Lack of Precision (MLP), 
#' the  unsystematic (random) component of the MSE. It is obtained via a symmetric decomposition 
#' of the MSE (invariant to predicted-observed orientation). 
#' The greater the value the greater the contribution of unsystematic error to the MSE.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @references 
#' Correndo et al. (2021). 
#' Revisiting linear regression to test agreement in continuous predicted-observed datasets. 
#' _Agric. Syst. 192, 103194._ \doi{10.1016/j.agsy.2021.103194}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' PLP(obs = X, pred = Y)
#' }
#' @rdname PLP
#' @importFrom rlang eval_tidy quo
#' @export 
PLP <- function(data=NULL,
                obs,
                pred,
                tidy = FALSE,
                na.rm = TRUE){
  MSE <- sum(({{obs}}-{{pred}})^2)/length({{obs}})
  MLP <- sum (abs({{obs}} - ((mean({{obs}}) -
                                (sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))/
                                   sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))*mean({{pred}}))) +
                               sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))/
                               sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}})) * {{pred}})) *
                abs({{pred}} - ((mean({{pred}}) - (sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))/
                                                     sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))*mean({{obs}}))) +
                                  sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))/
                                  sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}})) * {{obs}}) ) ) /
    length({{obs}})
  PLP <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    100 * (MLP / MSE)
    )
  )
  
  if (tidy==TRUE){ return(as.data.frame(PLP)) }
  
  if (tidy==FALSE){ return(list("PLP" = PLP)) }
}