#' @title Duveiller's Agreement Coefficient
#' @name lambda
#' @description It estimates the agreement coefficient (lambda) suggested by
#' Duveiller et al. (2016) for a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details lambda measures both accuracy and precision. It is normalized, dimensionless, 
#' bounded (-1;1), and symmetric (invariant to predicted-observed orientation).
#' lambda is equivalent to CCC when r is greater or equal to 0. The closer to 1 the better. 
#' Values towards zero indicate low correlation between observations and predictions.
#' Negative values would indicate a negative relationship between predicted and observed.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @references 
#' Duveiller et al. (2016).
#' Revisiting the concept of a symmetric index of agreement for continuous datasets. 
#' _Sci. Rep. 6, 1-14._ \doi{10.1038/srep19401}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' lambda(obs = X, pred = Y)
#' }
#' @rdname lambda
#' @importFrom rlang eval_tidy quo
#' @export 
lambda <- function(data = NULL, 
                   obs,
                   pred,
                   tidy = FALSE,
                   na.rm = TRUE) {
  MSE <- sum(({{obs}}-{{pred}})^2)/length({{obs}})
  MBE <- (mean({{obs}})-mean({{pred}}))
  
  lambda <- rlang::eval_tidy(
    data=data,
    rlang::quo( 
    1 - ( MSE /
            (sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}) +
               sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}) + 
               MBE^2)) 
    )
  )
  if (tidy==TRUE){ return(as.data.frame(lambda)) }
  
  if (tidy==FALSE){ return(list("lambda" = lambda)) }
} 

