#' @title P4-metric  
#' @name p4
#' @description It estimates the P4-metric for a nominal/categorical predicted-observed dataset.
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
#' @details The P4-metric it is a metric designed for binary classifiers. It is estimated from
#' precision, recall, specificity, and npv (negative predictive value). 
#' The P4 it was designed to address criticism against the F-score, so it may be perceived as
#' its extension. Unfortunately, it has not been generalized yet for multinomial cases.
#' 
#' For binomial/binary cases, 
#' 
#' \eqn{p4  =  \frac{(4 x TP x TN)} {(4 x TP x TN + (TP + TN) x FP + FN)} }
#' 
#' Or:
#' 
#' \eqn{p4 = \frac{4} {\frac{1}{precision} + \frac{1}{recall} + \frac{1}{specificity} + \frac{1}{npv} } }
#' 
#' The P4 metric has not been generalized for multinomial cases. 
#' The P4 metric is bounded between 0 and 1. 
#' The closer to 1 the better, which will require precision, recall, specificity and npv being close to 1.
#' Values towards zero indicate low performance, which could be the product of only one of the four conditional probabilities being close to 0. 
#' 
#' 
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_classification.html)
#' @references
#' Sitarz, M. (2023).
#' Extending F1 metric, probabilistic approach. 
#' _Adv. Artif. Intell. Mach. Learn., 3 (2):1025-1038._\doi{10.54364/AAIML.2023.1161}
#' 
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
#' # Get P4-metric estimate for two-class case
#' p4(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' }
#' @rdname p4
#' @importFrom rlang eval_tidy quo enquo
#' @export 
p4 <- function(data=NULL, obs, pred,
               pos_level = 2,
               tidy = FALSE, na.rm = TRUE,
               atom = FALSE){
  
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}}) ) )
  
  # If binomial
  if (nrow(matrix) == 2){
    
    if (pos_level == 1){ 
      TP <- matrix[[1]]
      TN <- matrix[[4]]
      TPFP <- matrix[[1]] + matrix[[3]]
      TPFN <- matrix[[1]] + matrix[[2]]
      FP <- TPFP - TP
      FN <- matrix[[2]]
      TNFP <- matrix[[4]] + matrix[[3]]
      }
    
    if (pos_level == 2){ 
      TP <- matrix[[4]]
      TN <- matrix[[1]]
      TPFP <- matrix[[4]] + matrix[[2]]
      TPFN <- matrix[[4]] + matrix[[3]]
      FP <- TPFP - TP
      FN <- matrix[[3]]
      TNFP <- matrix[[1]] + matrix[[2]]
      
      }
    
    rec <- TP/ (TPFN) 
    prec <- TP/ (TPFP)
    spec <- TN / TNFP 
    
    # Formula
    p4 <- (4 * TN * TP) / (4 * TN * TP + (TP + TN)*(FP + FN))
    
  }
  
 # If multinomial
  if (nrow(matrix) >2) {
    warning("Sorry, the p4 metric has not been generalized for multinomial cases. A NaN has been recorded as the result")
    # Calculations
    correct <- diag(matrix)
    total_actual <- colSums(matrix)
    total_pred <- rowSums(matrix)
    
    TP   <- diag(matrix)
    TPFP <- rowSums(matrix)
    TPFN <- colSums(matrix)
    TN   <- sum(matrix) - (TPFP + TPFN - TP)
    FP   <- TPFP - TP
    FN   <- TPFN - TN
    
    # Just tentative generalization. It is pending to be tested with authors of P4
    if (atom == FALSE) { 
         # prec <- mean(correct / total_pred)
         # rec <- mean(correct / total_actual) 
         # spec <- mean( TN / (TN + FP) )
         # npv <- mean(TN / (TN + FN))
      
      # Formula 
      # p4 <- 4 / ( (1/prec) + (1/rec) + (1/spec) + (1/npv) )
      p4 <- NaN
        
        }
      
    if (atom == TRUE) { 
        #  prec <- correct / total_pred
        #  rec <- correct / total_actual
        #  spec <- TN / (TN + FP)
        #  npv <- TN / (TN + FN)
        # 
        # # Formula
        # p4 <- 4 / ( (1/prec) + (1/rec) + (1/spec) + (1/npv) )
      p4 <- NaN
        } 
    
  }
  
  if (tidy==TRUE){
    return(as.data.frame(p4)) }
  
  if (tidy==FALSE){
    return(list("p4" = p4)) }
}

