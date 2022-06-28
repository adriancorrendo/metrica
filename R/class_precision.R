#' @title Precision  
#' @name precision
#' @description \code{precision} estimates the precision (a.k.a. positive predictive 
#' value -PPV-) for a nominal/categorical predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (character | factor).
#' @param pred Vector with predicted values (character | factor).
#' @param atom Logical operator (TRUE/FALSE) to decide if the estimate is made for 
#' each class (atom = TRUE) or at a global level (atom = FALSE); Default : FALSE.
#' @param pos_level Integer, for binary cases, indicating the order (1|2) of the level 
#' corresponding to the positive. Generally, the positive level is the second (2)
#' since following an alpha-numeric order, the most common pairs are 
#' `(Negative | Positive)`, `(0 | 1)`, `(FALSE | TRUE)`. Default : 2.
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The precision is a non-normalized coefficient that represents the
#' ratio between the correctly predicted cases (or true positive -TP- for binary cases) 
#' to the total predicted observations for a given class (or total predicted positive 
#' -PP- for binary cases) or at overall level. 
#' 
#' For binomial cases, \eqn{precision = \frac{TP}{PP} = \frac{TP}{TP + FP} }
#' 
#' The \code{precision} metric is bounded between 0 and 1. The closer to 1 the better. 
#' Values towards zero indicate low precision of predictions. It can be estimated 
#' for each particular class or at a global level.
#' 
#' The false detection rate or false discovery rate (FDR) represents the proportion
#' of false positives with respect to the total number of cases predicted as positive.
#' 
#' For binomial cases, \eqn{FDR = 1 - precision = \frac{FP}{PP} = \frac{FP}{TP + FP} }
#' 
#' The \code{precision} metric is bounded between 0 and 1. The closer to 1 the better. 
#' Values towards zero indicate low precision of predictions.
#' 
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
#' # Get FDR estimate for two-class case
#' FDR(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get precision estimate for each class for the multi-class case
#' precision(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE, atom = TRUE)
#' 
#' # Get precision estimate for the multi-class case at a global level
#' precision(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE, atom = TRUE)
#' }
#' @importFrom rlang eval_tidy quo
#' @rdname precision
#' @export 
#' 
precision <- function(data=NULL, obs, pred, tidy = FALSE, atom = FALSE, na.rm = TRUE,
                      pos_level = 2) {
  # Precision
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}})))
  
  # If binomial
  if (nrow(matrix) == 2){ 
    
    if (pos_level == 1){  
    TP <- matrix[[1]]
    TPFP <- matrix[[1]] + matrix[[3]] }
    
    if (pos_level == 2){  
      TP <- matrix[[4]]
      TPFP <- matrix[[4]] + matrix[[2]] }
    
    precision <- TP/ (TPFP) }
  
  # If multinomial
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
    return(list("precision" = precision)) }
}
#' @rdname precision
#' @description \code{FDR} estimates the complement of precision (a.k.a. positive predictive 
#' value -PPV-) for a nominal/categorical predicted-observed dataset.
#' @export 
#' 
FDR <- function(data=NULL, obs, pred, 
                atom = FALSE, pos_level = 2,
                tidy = FALSE, na.rm = TRUE){
  # False Discovery Rate (FDR)
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}})))
  
  # If binomial
  if (nrow(matrix) == 2){ 
    
    if (pos_level == 1){  
      TP <- matrix[[1]]
      TPFP <- matrix[[1]] + matrix[[3]] }
    
    if (pos_level == 2){  
      TP <- matrix[[4]]
      TPFP <- matrix[[4]] + matrix[[2]] }
    
    precision <- TP/ (TPFP) }
  
  # If multinomial
  if (nrow(matrix) >2) {
    
    # Calculations
    correct <- diag(matrix)
    total_pred <- rowSums(matrix)
    
    if (atom == FALSE) { 
      precision <- mean(correct / total_pred) }
    
    if (atom == TRUE) { 
      precision <- correct / total_pred }
  }
  # Formula
  FDR <- 1 - precision
  
  if (tidy==TRUE){ return(as.data.frame(FDR)) }
  
  if (tidy==FALSE){ return(list("FDR" = FDR)) }
  
}
NULL

