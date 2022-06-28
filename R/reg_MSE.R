#' @title Mean Squared Error (MSE) 
#' @name MSE
#' @description It estimates the MSE for a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The MSE, also known as MSD, measures general agreement, as includes both
#' variance (lack of precision) and bias (lack of accuracy). The MSE of predictions
#' could be decomposed following a variety of approaches (e.g. Willmott et al. 1981; Correndo et al. 2021).
#' Its calculation is simple, the sum of squared differences between predictions and observations 
#' divided by the sample size (n). The greater the value the worse the predicted performance.
#' Unfortunately, the units of MSE do not have a direct interpretation. For a more direct interpretation, 
#' the square root of MSE (RMSE) has the same units as the variable of interest.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' Willmott (1981). 
#' On the validation of models. 
#' _Phys. Geogr. 2, 184–194._ \doi{10.1080/02723646.1981.10642213}
#' @references
#' Correndo et al. (2021). 
#' Revisiting linear regression to test agreement in continuous predicted-observed datasets. 
#' _Agric. Syst. 192, 103194._ \doi{10.1016/j.agsy.2021.103194}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' MSE(obs = X, pred = Y)
#' }
#' @rdname MSE
#' @importFrom rlang eval_tidy quo
#' @export 
MSE <- function(data=NULL,
                obs,
                pred,
                tidy = FALSE,
                na.rm = TRUE){
  MSE <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      sum(({{obs}}-{{pred}})^2)/length({{obs}})
    )
  )
  if (tidy==TRUE){ return(as.data.frame(MSE)) }
  
  if (tidy==FALSE){ return(list("MSE" = MSE)) }
}

