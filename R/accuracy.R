#' @title Accuracy  
#' @name accuracy
#' @description It estimates the accuracy for a nominal/categorical predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (character | factor).
#' @param pred Vector with predicted values (character | factor).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE returns a data.frame, FALSE returns a list (default).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details Accuracy refers to a measure of the degree to which the predictions of a 
#' model matches the reality being modeled. The classification accuracy is calculated 
#' as the ratio between the number of correctly classified objects with respect to
#' the total number of objects. It is bounded between 0 and 1. The closer to 1 the better. 
#' Values towards zero indicate low accuracy of predictions. It can be also expressed
#' as percentage if multiplied by 100. It is estimated at a global level (not 
#' at the class level).
#' Accuracy is directly related to the error_rate, since accuracy = 1 – error_rate' .
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
#' replace = TRUE), predictions = sample(c("Red","Blue", "Green"), 100, replace = TRUE) )
#' 
#' # Get accuracy estimate for two-class case
#' accuracy(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get accuracy estimate for multi-class case
#' accuracy(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' }
#' @rdname accuracy
#' @importFrom rlang eval_tidy quo
#' @export 
accuracy <- function(data = NULL, obs, pred, tidy = FALSE, na.rm = TRUE){
   matrix <- rlang::eval_tidy(
      data = data,
      rlang::quo(table({{pred}}, {{obs}}) ) )
   
   # Overall estimation
   correct <- sum(diag(matrix))
   total <- sum(matrix) 
   
   accuracy <- correct / total
   
   if (tidy == TRUE){
      return(as.data.frame(accuracy)) }
   
   if (tidy == FALSE){
      return(accuracy) }
   
}

