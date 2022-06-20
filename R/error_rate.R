#' @title Error rate  
#' @name error_rate
#' @description It estimates the error rate for a nominal/categorical predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (character | factor).
#' @param pred Vector with predicted values (character | factor).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE returns a data.frame, FALSE returns a list (default).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The error rate represents the opposite of accuracy, referring to a 
#' measure of the degree to which the predictions miss-classify the reality. 
#' The classification error_rate is calculated as the ratio between the number of 
#' incorrectly classified objects with respect to the total number of objects. 
#' It is bounded between 0 and 1. The closer to 1 the worse. Values towards zero 
#' indicate low error_rate of predictions. It can be also expressed as percentage 
#' if multiplied by 100. It is estimated at a global level (not at the class level).
#' The error rate is directly related to the accuracy, since error_rate = 1 – accuracy' .
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' (2017) Accuracy. _In: Sammut C., Webb G.I. (eds) Encyclopedia of Machine Learning and Data Mining_
#' _Springer, Boston, MA._ \doi{10.1007/978-1-4899-7687-1_3}
#' @examples 
#' \donttest{
#' set.seed(123)
#' # Two-class
#' binomial_case <- data.frame(labels = sample(c("True","False"), 100, 
#' replace = TRUE), predictions = sample(c("True","False"), 100, replace = TRUE))
#' # Multi-class
#' multinomial_case <- data.frame(labels = sample(c("Red","Blue", "Green"), 100, 
#' replace = TRUE), predictions = sample(c("Red","Blue", "Green"), 100, replace = TRUE)    )
#' 
#' # Get error_rate estimate for two-class case
#' error_rate(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get error_rate estimate for multi-class case
#' error_rate(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' }
#' @rdname error_rate
#' @importFrom rlang eval_tidy quo
#' @export 
error_rate <- function(data = NULL, obs, pred, tidy = FALSE, na.rm = TRUE){
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}}) ) )
  
  # Overall estimation
  correct <- sum(diag(matrix))
  total <- sum(matrix)    
  
  misclass_rate <- 1 - (correct / total)
  
  if (tidy == TRUE){
    return(as.data.frame(misclass_rate)) }
  
  if (tidy == FALSE){
    return(misclass_rate) }
  
}

