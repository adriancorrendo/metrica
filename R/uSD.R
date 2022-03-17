#' @title uSD
#' @description Uncorrected Standard Deviation (uSD) of observed or predicted values.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param x Vector with numeric observed or predicted values.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Element of class `numeric`.
#' @details Calculates uSD from a vector x.
#' @examples 
#' \dontrun{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' sdev.obs(obs = X)
#' }
#' @rdname uSD
#' @importFrom rlang eval_tidy quo
#' @export 

uSD <- function(data=NULL,
                x,
                na.rm = TRUE){
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      sqrt(sum(({{x}} - mean({{x}}))^2)/length({{x}}))
    )
  )
  return(result)
}