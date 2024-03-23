#' @title Negative Predictive Value 
#' @name npv
#' @description \code{npv} estimates the npv (a.k.a. positive predictive 
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
#' @details The npv is a non-normalized coefficient that represents the
#' ratio between the correctly predicted cases (or true positive -TP- for binary cases) 
#' to the total predicted observations for a given class (or total predicted positive 
#' -PP- for binary cases) or at overall level. 
#' 
#' For binomial cases, \eqn{npv = \frac{TP}{PP} = \frac{TP}{TP + FP} }
#' 
#' The \code{npv} metric is bounded between 0 and 1. The closer to 1 the better. 
#' Values towards zero indicate low npv of predictions. It can be estimated 
#' for each particular class or at a global level.
#' 
#' The false omission rate (FOR) represents the proportion
#' of false negatives with respect to the number of negative predictions (PN).
#' 
#' For binomial cases, \eqn{FOR = 1 - npv = \frac{FN}{PN} = \frac{FN}{TN + FN} }
#' 
#' The \code{npv} metric is bounded between 0 and 1. The closer to 1 the better. 
#' Values towards zero indicate low npv of predictions.
#' 
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_classification.html)
#' @references
#' Wang H., Zheng H. (2013).
#' Negative Predictive Value. 
#' _In: Dubitzky W., Wolkenhauer O., Cho KH., Yokota H. (eds) Encyclopedia of Systems Biology._ 
#' _ Springer, New York, NY._ \doi{10.1007/978-1-4419-9863-7_234}
#' 
#' Trevethan, R. (2017).
#' _Sensitivity, Specificity, and Predictive Values: Foundations, Pliabilities, and Pitfalls_
#' _ in Research and Practice. Front. Public Health 5:307_ \doi{10.3389/fpubh.2017.00307}
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
#' # Get npv estimate for two-class case
#' npv(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get fdr estimate for two-class case
#' FDR(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get npv estimate for each class for the multi-class case
#' npv(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE, atom = TRUE)
#' 
#' # Get npv estimate for the multi-class case at a global level
#' npv(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE, atom = TRUE)
#' }
#' @importFrom rlang eval_tidy quo
#' @rdname npv
#' @export 
#' 
npv <- function(data=NULL, obs, pred, 
                atom = FALSE, pos_level = 2,
                tidy = FALSE, na.rm = TRUE) {
  # Negative Predictive Val
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}}) ) )
  
  # If binomial
  if (nrow(matrix) == 2){
    
    if (pos_level == 1){
    TN <- matrix[[4]]
    TNFN <- matrix[[4]] + matrix[[2]] }
    
    if (pos_level == 2){
    TN <- matrix[[1]]
    TNFN <- matrix[[1]] + matrix[[3]] }
    
    npv <- TN/ (TNFN) }
  
  # If multinomial
  if (nrow(matrix) >2) {
    
    # Calculations
    TPFP <- rowSums(matrix)
    TPFN <- colSums(matrix)
    TP   <- diag(matrix)
    FP <- TPFP - TP 
    TN   <- sum(matrix) - (TPFP + TPFN - TP)
    FN <- TPFN - TP
    
    if (atom == TRUE) { 
      # Formula
      npv <- TN / (TN + FN) }
    
    if (atom == FALSE) { 
      # Formula
      npv <- mean(TN / (TN + FN)) }
  }
  
  if (tidy == TRUE) {
    return(as.data.frame(npv)) }
  
  if (tidy == FALSE) {
    return(list("npv" = npv)) }
}
#' @rdname npv
#' @description \code{FOR} estimates the false omission rate, which is the complement 
#' of the negative predictive value for a nominal/categorical predicted-observed dataset.
#' @export 
#' 
FOR <- function(data=NULL, obs, pred, 
                atom = FALSE, pos_level = 2,
                tidy = FALSE, na.rm = TRUE){
  # False Discovery Rate (fdr)
  # Negative Predictive Val
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}}) ) )
  
  # If binomial
  if (nrow(matrix) == 2){
    
    if (pos_level == 1){
      TN <- matrix[[4]]
      TNFN <- matrix[[4]] + matrix[[2]] }
    
    if (pos_level == 2){
      TN <- matrix[[1]]
      TNFN <- matrix[[1]] + matrix[[3]] }
    
    npv <- TN/ (TNFN) }
  
  if (nrow(matrix) >2) {
    
    # Calculations
    
    TPFP <- rowSums(matrix)
    TPFN <- colSums(matrix)
    TP   <- diag(matrix)
    FP <- TPFP - TP 
    TN   <- sum(matrix) - (TPFP + TPFN - TP)
    FN <- TPFN - TP
    
    if (atom == TRUE) { npv <- TN / (TN + FN) }
    
    if (atom == FALSE) { npv <- mean(TN / (TN + FN)) }
  }
  # Estimation
  FOR <- 1 - npv
  
  if (tidy==TRUE){ return(as.data.frame(FOR)) }
  
  if (tidy==FALSE){ return(list("FOR" = FOR)) }
  
}
NULL
