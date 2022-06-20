#' @title Precision  
#' @name precision
#' @description It estimates the precision for a nominal/categorical predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (character | factor).
#' @param pred Vector with predicted values (character | factor).
#' @param atom Logical operator (TRUE/FALSE) to decide if the estimate is made for 
#' each class (atom = TRUE) or at a global level (atom = FALSE); Default : FALSE.
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The precision is a non-normalized coefficient that represents the
#' ratio between the correctly predicted cases to the total predicted observations
#' for a given class or at overall level. 
#' 
#' For binomial cases, precision = True positives/total number of positives predicted = TP/(TP + FP)
#' 
#' It is bounded between 0 and 1. 
#' The closer to 1 the better. Values towards zero indicate low precision of predictions. 
#' It can be estimated for each particular class or at a global level.
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' Ting K.M. (2017)
#' Precision and Recall. 
#' _In: Sammut C., Webb G.I. (eds) Encyclopedia of Machine Learning and Data Mining._
#' _Springer, Boston, MA._ \doi{10.1007/978-1-4899-7687-1_659}
#' @examples 
#' \donttest{
#' set.seed(123)
#' # Two-class
#' binomial_case <- data.frame(labels = sample(c("True","False"), 100, 
#' replace = TRUE), predictions = sample(c("True","False"), 100, replace = TRUE))
#' # Multi-class
#' multinomial_case <- data.frame(labels = sample(c("Red","Blue", "Green"), 100, 
#' replace = TRUE), predictions = sample(c("Red","Blue", "Green"), 100, replace = TRUE))
#' 
#' # Get precision estimate for two-class case
#' precision(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get precision estimate for each class for the multi-class case
#' precision(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE, atom = TRUE)
#' 
#' # Get precision estimate for the multi-class case at a global level
#' precision(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE, atom = TRUE)
#' }
#' @rdname precision
#' @importFrom rlang eval_tidy quo
#' @export 
precision <- function(data=NULL, obs, pred, tidy = FALSE, atom = FALSE, na.rm = TRUE) {
  
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}}) ) )
  
  #levels <- nrow(matrix)
  
  # If binomial
  if (nrow(matrix) == 2){ 
    TP <- matrix[[4]]
    TPFP <- matrix[[4]] + matrix[[2]]
    
    precision <- TP/ (TPFP) }
  
  if (nrow(matrix) >2) {
    
    # Calculations
    correct <- diag(matrix)
    total_pred <- rowSums(matrix)
    
    if (atom == FALSE) { 
      precision <- mean(correct / total_pred) }
    
    if (atom == TRUE) { 
      precision <- correct / total_pred }
  }
  
  if (tidy == TRUE) {
    return(as.data.frame(precision)) }
  
  if (tidy == FALSE) {
    return(precision) }
}


