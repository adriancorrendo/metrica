#' @title deltaP or Markedness
#' @name deltap
#' @description \code{deltap} estimates the Markedness or deltaP for a nominal/categorical 
#' predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (character | factor).
#' @param pred Vector with predicted values (character | factor).
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
#' @details The \code{deltap} is also known as the markedness. It is a metric 
#' that quantifies the probability that a condition is marked by the predictor with 
#' respect to a random chance (Powers, 2011).
#' 
#' The deltap is related to \code{precision} (or positive predictive values -ppv-)
#' and its inverse (the negative predictive value -\code{npv}-) as follows:
#' 
#' \eqn{deltap = PPV + NPV - 1  = precision + npv - 1}
#'  
#' The higher the deltap the better the classification performance.
#' 
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_classification.html)
#' @references
#' Powers, D.M.W. (2011). 
#' Evaluation: From Precision, Recall and F-Measure to ROC, Informedness, Markedness & Correlation. 
#' _Journal of Machine Learning Technologies 2(1): 37–63._ \doi{10.48550/arXiv.2010.16061}
#' @examples 
#' \donttest{
#' set.seed(123)
#' # Two-class
#' binomial_case <- data.frame(labels = sample(c("True","False"), 100, replace = TRUE), 
#' predictions = sample(c("True","False"), 100, replace = TRUE))
#' # Get deltap estimate for two-class case
#' deltap(data = binomial_case, obs = labels, pred = predictions)
#' 
#' }
#' @rdname deltap
#' @importFrom rlang eval_tidy quo
#' @export 
deltap <- function(data=NULL, obs, pred, 
                pos_level = 2, atom = FALSE,
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
    TNFP <- matrix[[4]] + matrix[[3]]
    TNFN <- matrix[[4]] + matrix[[2]] 
    
    prec <- TP/ TPFP
    npv <- TN / TNFN
    }
    
    if (pos_level == 2){ 
      TP <- matrix[[4]]
      TPFP <- matrix[[4]] + matrix[[2]] 
      TPFN <- matrix[[4]] + matrix[[3]]
      TN <- matrix[[1]]
      TNFP <- matrix[[1]] + matrix[[2]]
      TNFN <- matrix[[1]] + matrix[[3]]  
      
      prec <- TP/ TPFP
      npv <- TN / TNFN
    }
    
    # Formula
    deltap <- prec + npv - 1
    
    
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
    FN <- TPFN - TP
    
    # if (atom == FALSE){
    # prec <- TP/ TPFP
    # npv <- TN / (TN+FN) }
    
    if (atom == TRUE) { 
      prec <- correct / total_pred
      npv <- TN / (TN + FN) }
    
    if (atom == FALSE) { 
      prec <- mean(correct / total_pred)
      npv <- mean(TN / (TN + FN)) }
    
    # Formula
    deltap <- prec + npv - 1
    
    
  }
  
  if (tidy == TRUE) {
    return(as.data.frame(deltap)) }
  
  if (tidy == FALSE) {
    return(list("deltap" = deltap)) } 
}

