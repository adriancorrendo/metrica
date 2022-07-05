#' @title Lack of Consistency (Ue)
#' @name Ue
#' @description It estimates the Ue component from the sum of squares decomposition 
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
#' The Ue estimates the proportion of the total sum of squares related to the
#' random error (unsystematic error or variance) following the sum of squares decomposition 
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
#' Ue(obs = X, pred = Y)
#' }
#' @rdname Ue
#' @importFrom rlang eval_tidy quo
#' @export 
Ue <- function(data=NULL,
               obs,
               pred,
               tidy = FALSE,
               na.rm = TRUE){
  Ue <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    100*
    ( 2*length({{obs}})* (1-stats::cor({{obs}},{{pred}}))*
        sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))*
        sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}})) ) / 
    sum(({{obs}}-{{pred}})^2)
    )
  )
  
  if (tidy==TRUE){ return(as.data.frame(Ue)) }
  
  if (tidy==FALSE){ return(list("Ue" = Ue)) }
}