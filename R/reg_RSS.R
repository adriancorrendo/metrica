#' @title Residual Sum of Squares (RSS) 
#' @name RSS
#' @description It estimates the RSS for a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The RSS is the sum of the squared differences between predictions and observations.
#' It represents the base of many error metrics using squared scale such as the Mean Squared Error (MSE).
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' RSS(obs = X, pred = Y)
#' }
#' @rdname RSS
#' @importFrom stats cor var
#' @importFrom rlang eval_tidy quo
#' @export

RSS <- function(data=NULL,
                obs,
                pred,
                tidy = FALSE,
                na.rm = TRUE){
  RSS <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      sum(({{obs}}-{{pred}})^2)
    )
  )
  if (tidy==TRUE){ return(as.data.frame(RSS)) }
  
  if (tidy==FALSE){ return(list("RSS" = RSS)) }
}