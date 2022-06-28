#' @title Mean Absolute Error (MAE)
#' @name MAE
#' @description It estimates the MAE for a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The MAE measures both lack of accuracy and precision in absolute scale.
#' It keeps the same units than the response variable. It is less sensitive to outliers 
#' than the MSE or RMSE. The lower the better.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references 
#' Willmott & Matsuura (2005). 
#' Advantages of the mean absolute error (MAE) over the root mean square error (RMSE) in assessing average model performance. 
#' _Clim. Res. 30, 79–82._ \doi{10.3354/cr030079}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' MAE(obs = X, pred = Y)
#' }
#' @rdname MAE
#' @importFrom rlang eval_tidy quo
#' @export 
MAE <- function(data=NULL,
                obs,
                pred,
                tidy = FALSE,
                na.rm = TRUE){
  MAE <- rlang::eval_tidy(
    data=data,
    rlang::quo(
    sum(abs({{obs}}-{{pred}}))/length({{obs}})
    )
  )
  if (tidy==TRUE){ return(as.data.frame(MAE)) }
  
  if (tidy==FALSE){ return(list("MAE" = MAE)) }
}