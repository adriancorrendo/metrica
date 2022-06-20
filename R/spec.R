#' @title Specificity  
#' @name spec
#' @description It estimates the specificity for a nominal/categorical predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (character | factor).
#' @param pred Vector with predicted values (character | factor).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The specificity (or sensitivity) is a non-normalized coefficient that represents the
#' ratio between the correctly predicted cases to the total number of actual observations
#' that belong to a given class. 
#' 
#' For binomial cases, specificity  =  True positives/total number of actual positives = TP/(TP + FN)
#' 
#' It is bounded between 0 and 1. 
#' The closer to 1 the better. Values towards zero indicate low performance. 
#' It can be estimated for each particular class or at a global level.
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' Ting K.M. (2017)
#' Precision and Recall. 
#' _In: Sammut C., Webb G.I. (eds) Encyclopedia of Machine Learning and Data Mining._
#' _Springer, Boston, MA._ \doi{10.1007/978-1-4899-7687-1_659}
#' (2017) Sensitivity. 
#' _In: Sammut C., Webb G.I. (eds) Encyclopedia of Machine Learning and Data Mining._
#' _Springer, Boston, MA._ \doi{10.1007/978-1-4899-7687-1_751}
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
#' # Get specificity estimate for two-class case
#' spec(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get specificity estimate for each class for the multi-class case
#' spec(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get specificity estimate for the multi-class case at a global level
#' spec(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' }
#' @rdname spec
#' @importFrom rlang eval_tidy quo
#' @export 
spec <- function(data=NULL, obs, pred, tidy = FALSE, na.rm = TRUE){
  
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}}) ) )
  
  #levels <- nrow(matrix)
  
  # If binomial
  if (nrow(matrix) == 2){ 
    TN <- matrix[[1]]
    N <- matrix[[1]] + matrix[[2]]
    
    spec <- TN/N }
  
  # If multinomial
  if (nrow(matrix) > 2) {
    
    TP   <- diag(matrix)
    TPFP <- rowSums(matrix)
    TPFN <- colSums(matrix)
    TN   <- sum(matrix) - (TPFP + TPFN - TP)
    FP   <- TPFP - TP 
    
    spec <- TN / (TN + FP)   
    
  }
  
  if (tidy==TRUE){
    return(as.data.frame(spec)) }
  
  if (tidy==FALSE){
    return(spec) 
  }
  
}

