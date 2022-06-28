#' @title Kling-Gupta Model Efficiency (KGE).
#' @name KGE
#' @description It estimates the KGE for a predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The KGE is a normalized, dimensionless, model efficiency that measures general agreement.
#' It presents accuracy, precision, and consistency components. It is symmetric 
#' (invariant to predicted observed orientation). It is positively bounded up to 1. 
#' The closer to 1 the better. 
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references 
#' Kling et al. (2012).
#' Runoff conditions in the upper Danube basin under an ensemble of climate change scenarios.
#' _Journal of Hydrology 424-425, 264-277._ \doi{doi:10.1016/j.jhydrol.2012.01.011}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 9)
#' KGE(obs = X, pred = Y)
#' }
#' @rdname KGE
#' @importFrom rlang eval_tidy quo
#' @export 
KGE <- function(data=NULL,
                obs,
                pred,
                tidy = FALSE,
                na.rm = TRUE) {
  CVr <- rlang::eval_tidy(
    data=data,
    rlang::quo(
    (sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))/mean({{pred}}))/
      (sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))/mean({{obs}}))
    )
  )
  KGE <- rlang::eval_tidy(
    data=data,
    rlang::quo(
    1 - sqrt( ((stats::cor({{obs}},{{pred}})-1))^2 +
                        ((CVr-1))^2 + 
                        (((mean({{pred}})/mean({{obs}}))-1))^2)
    )
  )
  if (tidy==TRUE){ return(as.data.frame(KGE)) }
  
  if (tidy==FALSE){ return(list("KGE" = KGE)) }
}

