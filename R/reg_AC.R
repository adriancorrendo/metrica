#' @title Ji and Gallo's Agreement Coefficient (AC)
#' @name AC
#' @description It estimates the agreement coefficient suggested by Ji & Gallo (2006)
#' for a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details 
#' The Ji and Gallo's AC measures general agreement, including both accuracy and precision. 
#' It is normalized, dimensionless, positively bounded (-infinity;1), and symmetric.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @references 
#' Ji & Gallo (2006). An agreement coefficient for image comparison.
#' _Photogramm. Eng. Remote Sensing 7, 823–833_ \doi{10.14358/PERS.72.7.823}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' df <- data.frame(obs = X, pred = Y)
#' AC(df, obs = X, pred = Y)
#' }
#' @rdname AC
#' @importFrom rlang eval_tidy quo
#' @export 
AC <- function(data = NULL, 
               obs, 
               pred,
               tidy = FALSE,
               na.rm = TRUE) {
  AC <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    1 -(sum(({{obs}}-{{pred}})^2)/
          sum((abs(mean({{pred}})-mean({{obs}}))+abs({{obs}}-mean({{obs}})))*
                (abs(mean({{pred}})-mean({{obs}}))+abs({{pred}}-mean({{pred}}))))) 
    )
  )
  if (tidy==TRUE){ return(as.data.frame(AC)) }
  
  if (tidy==FALSE){ return(list("AC" = AC)) }
}

