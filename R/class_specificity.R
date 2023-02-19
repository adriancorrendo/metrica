#' @title Specificity  | True Negative Rate
#' @name specificity
#' @description \code{specificity} estimates the specificity (a.k.a. selectivity, 
#' or true negative rate -TNR-)  
#' for a nominal/categorical predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (character | factor).
#' @param pred Vector with predicted values (character | factor).
#' @param atom Logical operator (TRUE/FALSE) to decide if the estimate is made for 
#' each class (atom = TRUE) or at a global level (atom = FALSE); Default : FALSE.
#' When dataset is "binomial" atom does not apply.
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
#' @details The specificity (or selectivity, or true negative rate-TNR-) is a non-normalized 
#' coefficient that represents the ratio between the correctly negative predicted 
#' cases (or true negative -TN- for binary cases) to the total number of actual 
#' observations not belonging to a given class (actual negatives -N- for binary cases). 
#' 
#' For binomial cases, \eqn{specificity  =  \frac{TN}{N} = \frac{TN}{TN+FP}}
#' 
#' The \code{specificity} metric is bounded between 0 and 1. The closer to 1 the better. 
#' Values towards zero indicate low performance. For multinomial cases, it can be 
#' either estimated for each particular class or at a global level.
#' 
#' The false positive rate (or false alarm, or fall-out) is the complement of the 
#' specificity, representing the ratio between the number of false positives (FP) 
#' to the actual number of negatives (N). The \code{FPR} formula is:
#' 
#' \eqn{FPR = 1 - specificity = 1 - TNR = \frac{FP}{N}}
#' 
#' The \code{FPR} is bounded between 0 and 1. The closer to 0 the better. Low performance 
#' is indicated with FPR > 0.5.
#' 
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_classification.html)
#' @references
#' Ting K.M. (2017)
#' Sensitivity and Specificity. 
#' _In: Sammut C., Webb G.I. (eds) Encyclopedia of Machine Learning and Data Mining._
#' _Springer, Boston, MA._ \doi{10.1007/978-0-387-30164-8_752}
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
#' replace = TRUE), predictions = sample(c("Red","Blue", "Green"), 100, replace = TRUE)    )
#' 
#' # Get specificity and FPR estimates for two-class case
#' specificity(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' FPR(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get specificity estimate for each class for the multi-class case
#' specificity(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get specificity estimate for the multi-class case at a global level
#' specificity(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' }
#' @importFrom rlang eval_tidy quo
#' @rdname specificity
#' @export 
specificity <- function(data=NULL, obs, pred, 
                        atom = FALSE, pos_level = 2, 
                        tidy = FALSE, na.rm = TRUE){
  # Specificity  
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}}) ) )
  
  #levels <- nrow(matrix)
  
  # If binomial
  if (nrow(matrix) == 2){ 
    
    if (pos_level == 1){ 
    
    TN <- matrix[[4]]
    TNFP <- matrix[[4]] + matrix[[3]] }
    
    if (pos_level == 2){
      TN <- matrix[[1]]
      TNFP <- matrix[[1]] + matrix[[2]] }
      
      spec <- TN / TNFP  }
  
  # If multinomial
  if (nrow(matrix) > 2) {
    
    TP   <- diag(matrix)
    TPFP <- rowSums(matrix)
    TPFN <- colSums(matrix)
    TN   <- sum(matrix) - (TPFP + TPFN - TP)
    FP   <- TPFP - TP 
    
  if (atom == TRUE) { spec <- TN / (TN + FP) }
  
    if (atom == FALSE) { spec <- mean(TN / (TN + FP)) }
  }
  
  if (tidy==TRUE){ return(as.data.frame(spec)) }
  
  if (tidy==FALSE){ return(list("spec" = spec)) }
  
}
#' @rdname specificity
#' @description \code{FPR} estimates the false positive rate (a.k.a fall-out or false alarm) 
#' for a nominal/categorical predicted-observed dataset.
#' @export 
FPR <- function(data=NULL, obs, pred, 
                atom = FALSE, pos_level = 2,
                tidy = FALSE, na.rm = TRUE){
  # False Positive Rate (FPR)
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}}) ) )
  
  #levels <- nrow(matrix)
  
  # If binomial
  if (nrow(matrix) == 2){ 
    
    if (pos_level == 1){ 
      
      TN <- matrix[[4]]
      TNFP <- matrix[[4]] + matrix[[3]] }
    
    if (pos_level == 2){
      TN <- matrix[[1]]
      TNFP <- matrix[[1]] + matrix[[2]] }
    
    spec <- TN / TNFP  }
  
  # If multinomial
  if (nrow(matrix) > 2) {
    
    TP   <- diag(matrix)
    TPFP <- rowSums(matrix)
    TPFN <- colSums(matrix)
    TN   <- sum(matrix) - (TPFP + TPFN - TP)
    FP   <- TPFP - TP 
    
    if (atom == TRUE) { spec <- TN / (TN + FP) }
    
    if (atom == FALSE) { spec <- mean( TN / (TN + FP) ) }
  }
  # Formula
  FPR <- 1 - spec
  
  if (tidy==TRUE){ return(as.data.frame(FPR)) }
  
  if (tidy==FALSE){ return(list("FPR" = FPR)) }
   
}
NULL
#' @rdname specificity
#' @description \code{TNR} alternative renamed version of `specificity()`.
#' @export
#' 
TNR <- function(
  data=NULL, obs = NULL, pred = NULL, 
  atom = FALSE, pos_level = 2, 
  tidy = FALSE, na.rm = TRUE
  ) {
  res <- specificity(
    data = data, obs = obs, pred = pred, 
    atom = FALSE, pos_level = 2, 
    tidy = FALSE, na.rm = TRUE
  )
  return(res)
  }


