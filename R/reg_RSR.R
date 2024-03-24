#' @title Root Mean Standard Deviation Ratio (RSR)
#' @name RSR
#' @description It estimates the MSE normalized by the standard deviation of observed values
#' following Moriasi et al. (2007).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The RSR normalizes the Root Mean Squared Error (RMSE) using the standard 
#' deviation of observed values. It goes from an optimal value of 0 to infinity. 
#' Based on RSR, Moriasi et al. (2007) indicates performance ratings as: 
#' i) very-good (0-0.50), ii) good (0.50-0.60), iii) satisfactory (0.60-0.70), or 
#' iv) unsatisfactory (>0.70). 
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @references 
#' Moriasi et al. (2007). 
#' Model Evaluation Guidelines for Systematic Quantification of Accuracy in Watershed Simulations.
#' _Trans. ASABE 50, 885–900._ \doi{10.13031/2013.23153}
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' RSR(obs = X, pred = Y)
#' }
#' @rdname RSR
#' @importFrom rlang eval_tidy quo
#' @export 
RSR <- function(data=NULL,
                obs,
                pred,
                tidy = FALSE,
                na.rm = TRUE){
  var.u <- sum(({{obs}} - mean({{obs}}))^2)/length({{obs}})
  
  RSR <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      sqrt((sum(({{obs}}-{{pred}})^2)/length({{obs}})))/
        var.u
    )
  )
  if (tidy==TRUE){ return(as.data.frame(RSR)) }
  
  if (tidy==FALSE){ return(list("RSR" = RSR)) }
}