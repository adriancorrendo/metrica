#' @title Percentage Bias Error (PBE).
#' @name PBE
#' @description It estimates the PBE for a continuous predicted-observed dataset
#' following Gupta et al. (1999).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The PBE (%) is useful to identify systematic over or under predictions. 
#' It is an unbounded metric. The closer to zero the bias of predictions. 
#' Negative values indicate overestimation, while positive values indicate underestimation.
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html) 
#' @references 
#' Gupta et al. (1999). 
#' Status of automatic calibration for hydrologic models: Comparison with multilevel expert calibration.
#' _J. Hydrologic Eng. 4(2): 135-143._ \doi{10.1061/(ASCE)1084-0699(1999)4:2(135)} 
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' PBE(obs = X, pred = Y)
#' }
#' @rdname PBE
#' @importFrom rlang eval_tidy quo
#' @export 
PBE <- function(data=NULL,
                obs, 
                pred,
                na.rm = TRUE){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      100 * (sum({{obs}}-{{pred}}) / sum({{obs}}))
    )
  )
  return(result)
}