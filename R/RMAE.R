#' @title RMAE
#' @description Relative Mean Absolute Error (RMAE).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates the RMAE for a Predicted-Observed dataset by
#' normalizing the MAE by the mean of observations.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' RMAE(obs = X, pred = Y)
#' }
#' @rdname RMAE
#' @importFrom rlang eval_tidy quo
#' @export 
RMAE <- function(data=NULL,
                obs,
                pred,
                na.rm = TRUE){
  MAE <- sum(abs({{obs}}-{{pred}}))/length({{obs}})
  result <- rlang::eval_tidy(
    data=data,
    rlang::quo(
    MAE / mean({{obs}})
    )
  )
  return(result)
}