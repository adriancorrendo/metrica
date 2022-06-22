#' @title Balanced Accuracy  
#' @name baccu
#' @description It estimates the balanced accuracy for a nominal/categorical predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (character | factor).
#' @param pred Vector with predicted values (character | factor).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The balanced accuracy is the average between recall and specificity.
#' It is particularly useful when the number of observation belonging to each class
#' is despair or imbalanced, and when especial attention is given to the negative
#' cases. It is bounded between 0 and 1. Values towards zero indicate low performance. 
#' The closer to 1 the better. 
#'  
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' García, V., Mollineda, R.A., Sánchez, J.S. (2009). Index of Balanced Accuracy: 
#' A Performance Measure for Skewed Class Distributions. 
#' _In: Araujo, H., Mendonça, A.M., Pinho, A.J., Torres, M.I. (eds) Pattern Recognition and Image Analysis._ 
#' _IbPRIA 2009. Lecture Notes in Computer Science, vol 5524._
#' _Springer-Verlag Berlin Heidelberg._ \doi{10.1007/978-3-642-02172-5_57}
#' @examples 
#' \donttest{
#' set.seed(123)
#' # Two-class
#' binomial_case <- data.frame(labels = sample(c("True","False"), 100, replace = TRUE), 
#' predictions = sample(c("True","False"), 100, replace = TRUE))
#' # Multi-class
#' multinomial_case <- data.frame(labels = sample(c("Red","Blue", "Green"), 100, replace = TRUE),
#' predictions = sample(c("Red","Blue", "Green"), 100, replace = TRUE)    )
#' 
#' # Get balanced accuracy estimate for two-class case
#' baccu(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get balanced accuracy estimate for the multi-class case
#' baccu(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' }
#' @rdname baccu
#' @importFrom rlang eval_tidy quo
#' @export 
baccu <- function(data=NULL, obs, pred, tidy = FALSE, na.rm = TRUE){
  
  recall <- rlang::eval_tidy(
    data = data,
    rlang::quo(metrica::recall(data = data, obs={{obs}}, pred={{pred}}, atom = FALSE)) )
  
  specificity <- rlang::eval_tidy(
    data = data,
    rlang::quo(metrica::specificity(data = data, obs={{obs}}, pred={{pred}}, atom = FALSE)) )
  
  baccu <- (recall + specificity) / 2
  
  if (tidy==TRUE){
    return(as.data.frame(baccu)) }
  
  if (tidy==FALSE){
    return(baccu) }
}

