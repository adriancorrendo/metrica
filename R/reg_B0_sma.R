#' @name B0_sma
#' @title Intercept of standardized major axis regression (SMA). 
#' @description It calculates the intercept (B0) for the bivariate linear relationship
#' between predicted and observed values following the SMA regression.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param orientation Argument of class `string` specifying the axis
#' orientation, PO for predicted vs observed, and OP for
#' observed vs predicted. Default is orientation = "PO".
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na_rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details SMA is a symmetric linear regression (invariant results/interpretation to axis orientation) 
#' recommended to describe the bivariate scatter instead of OLS regression 
#' (classic linear model, which results vary with the axis orientation).
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references 
#' Warton et al. (2006). 
#' Bivariate line-fitting methods for allometry. 
#' _Biol. Rev. Camb. Philos. Soc. 81, 259–291._ \doi{10.1002/1521-4036(200203)44:2<161::AID-BIMJ161>3.0.CO;2-N} 
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' B0_sma(obs = X, pred = Y)
#' }
#' @rdname B0_sma
#' @importFrom rlang eval_tidy quo
#' @export 
B0_sma <- function(data = NULL, 
                   obs,
                   pred,
                   orientation = "PO",
                   tidy = FALSE,
                   na.rm = TRUE){
  
  B1.PO <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))/
        sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))
    )
    )
  
  B1.OP <-rlang::eval_tidy(
    data = data,
    rlang::quo(
      sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}})) /
        sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))  )  )
  
  B0 <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    mean({{pred}}) - (B1.PO*mean({{obs}}))
    )
  )
  
  if(orientation == "OP")
  
  B0 <- rlang::eval_tidy(
      data = data,
      rlang::quo(
        mean({{obs}}) - (B1.OP*mean({{pred}}))
    )
  )

  if (tidy==TRUE){ return(as.data.frame(B0)) }
  
  if (tidy==FALSE){ return(list("B0"=B0)) }
}

