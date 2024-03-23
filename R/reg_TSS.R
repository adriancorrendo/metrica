#' @title Total Sum of Squares (TSS) 
#' @name TSS
#' @description It estimates the TSS for observed vector.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The TSS sum of the squared differences between the observations and its mean.
#' It is used as a reference error, for example, to estimate explained variance.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' TSS(obs = X)
#' }
#' @rdname TSS
#' @importFrom stats cor var
#' @importFrom rlang eval_tidy quo
#' @export 
TSS <- function(data=NULL,
                obs, 
                tidy = FALSE,
                na.rm = TRUE){
  TSS <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      sum(({{obs}}-mean({{obs}}))^2)
    )
  )
  if (tidy==TRUE){ return(as.data.frame(TSS)) }
  
  if (tidy==FALSE){ return(list("TSS" = TSS)) }
}