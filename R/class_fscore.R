#' @title F-score  
#' @name fscore
#' @description It estimates the F-score for a nominal/categorical predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (character | factor).
#' @param pred Vector with predicted values (character | factor).
#' @param B Numeric value indicating the weight (a.k.a. B or beta) to be applied to the 
#' relationship between recall and precision. B < 1 weights more precision than recall.
#' B > 1 gives B times more importance to recall than precision. Default: 1.
#' @param pos_level Integer, for binary cases, indicating the order (1|2) of the level 
#' corresponding to the positive. Generally, the positive level is the second (2)
#' since following an alpha-numeric order, the most common pairs are 
#' `(Negative | Positive)`, `(0 | 1)`, `(FALSE | TRUE)`. Default : 2.
#' @param atom Logical operator (TRUE/FALSE) to decide if the estimate is made for 
#' each class (atom = TRUE) or at a global level (atom = FALSE); Default : FALSE.
#' When dataset is "binomial" atom does not apply. 
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The F-score (or F-measure) it is a more robust metric than the classic accuracy,
#' especially when the number of cases for each class is uneven. It represents the harmonic 
#' mean of precision and recall. Thus, to achieve high values of F-score it is necessary 
#' to have both high precision and high recall. 
#' 
#' The universal version of F-score employs a coefficient B, by which we can tune the
#' precision-recall ratio. Values of B > 1 give more weight to recall, and B < 1 give more
#' weight to precision. 
#' 
#' For binomial/binary cases, fscore  =  TP / (TP + 0.5*(FP + FN))
#' 
#' The generalized formula applied to multiclass cases is:
#' 
#' \eqn{fscore = \frac{(1 + B ^ 2) * (precision * recall)} {((B ^ 2 * precision) + recall)} }
#' 
#' It is bounded between 0 and 1. 
#' The closer to 1 the better. Values towards zero indicate low performance. 
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_classification.html)
#' @references
#' Goutte, C., Gaussier, E. (2005).
#' A Probabilistic Interpretation of Precision, Recall and F-Score, with Implication for Evaluation. 
#' _In: D.E. Losada and J.M. Fernandez-Luna (Eds.): ECIR 2005_
#' _. Advances in Information Retrieval LNCS 3408, pp. 345–359, 2._
#' _Springer-Verlag Berlin Heidelberg._ \doi{10.1007/978-3-540-31865-1_25}
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
#' # Get F-score estimate for two-class case
#' fscore(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get F-score estimate for each class for the multi-class case
#' fscore(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get F-score estimate for the multi-class case at a global level
#' fscore(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' }
#' @rdname fscore
#' @importFrom rlang eval_tidy quo enquo
#' @export 
fscore <- function(data=NULL, obs, pred, 
                   B = 1, pos_level = 2,
                   atom = FALSE,
                   tidy = FALSE, na.rm = TRUE){
  
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}}) ) )
  
  # If binomial
  if (nrow(matrix) == 2){
    if (pos_level == 1){ 
      TP <- matrix[[1]]
      TPFP <- matrix[[1]] + matrix[[3]]
      TPFN <- matrix[[1]] + matrix[[2]]
      TN <- matrix[[4]]
      N <- matrix[[4]] + matrix[[3]] }
    
    if (pos_level == 2){ 
      TP <- matrix[[4]]
      TPFP <- matrix[[4]] + matrix[[2]]
      TPFN <- matrix[[4]] + matrix[[3]]
      TN <- matrix[[1]]
      N <- matrix[[1]] + matrix[[2]] }
    
    rec <- TP/ (TPFN) 
    prec <- TP/ (TPFP)
    #spec <- TN/N
    
  }
  
  # If multinomial
  if (nrow(matrix) >2) {
    
    # Calculations
    correct <- diag(matrix)
    total_actual <- colSums(matrix)
    total_pred <- rowSums(matrix)
    
    TP   <- diag(matrix)
    TPFP <- rowSums(matrix)
    TPFN <- colSums(matrix)
    TN   <- sum(matrix) - (TPFP + TPFN - TP)
    FP   <- TPFP - TP 
    
      if (atom == FALSE) { 
        prec <- mean(correct / total_pred)
        rec <- mean(correct / total_actual) 
        #spec <- mean( TN / (TN + FP) )
        warning("For multiclass cases, the fscore should be estimated at a class level. Please, consider using `atom = TRUE`")
        }
      
      if (atom == TRUE) { 
        prec <- correct / total_pred
        rec <- correct / total_actual
        #spec <- TN / (TN + FP)
        } 
    
    
  }
  
  # Formula
  fscore <- (1 + B ^ 2) * (prec * rec) / ((B ^ 2 * prec) + rec)
  
  if (tidy==TRUE){
    return(as.data.frame(fscore)) }
  
  if (tidy==FALSE){
    return(list("fscore" = fscore)) }
}

