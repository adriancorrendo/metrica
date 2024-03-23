#' @title Lack of Consistency (Uc)
#' @name Uc
#' @description It estimates the Uc component from the sum of squares decomposition 
#' described by Smith & Rose (1995).
#' @param data (Optional) argument to call an existing data frame containing the data. 
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The Uc estimates the proportion of the total sum of squares related to the
#' lack of consistency (proportional bias) following the sum of squares decomposition 
#' suggested by Smith and Rose (1995) also known as Theil's partial inequalities.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @references 
#' Smith & Rose (1995). 
#' Model goodness-of-fit analysis using regression and related techniques. 
#' _Ecol. Model. 77, 49–64._ \doi{10.1016/0304-3800(93)E0074-D}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' Uc(obs = X, pred = Y)
#' }
#' @rdname Uc
#' @importFrom rlang eval_tidy quo
#' @export 
Uc <- function(data=NULL,
               obs, pred,
               tidy = FALSE,
               na.rm = TRUE){
  Uc <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    100*(length({{obs}})*
           (sqrt(sum(({{obs}} - mean({{obs}}))^2)/
                   length({{obs}}))-sqrt(sum(({{pred}} - mean({{pred}}))^2)/
                                           length({{pred}})))^2) /
      sum(({{obs}}-{{pred}})^2)
    )
  )
  
  if (tidy==TRUE){ return(as.data.frame(Uc)) }
  
  if (tidy==FALSE){ return(list("Uc" = Uc)) }
}