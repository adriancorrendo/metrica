#' @title Area Under the ROC Curve  
#' @name AUC_roc
#' @description The AUC estimates the area under the receiver operator 
#' curve (ROC) for a nominal/categorical predicted-observed dataset using the 
#' Mann-Whitney U-statistic.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (character | factor).
#' @param pred Vector with predicted values (character | factor).
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. 
#' TRUE returns a data.frame, FALSE returns a list (default).
#' @param na.rm Logic argument to remove rows with missing values (NA). 
#' Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The AUC tests whether positives are ranked higher than negatives. It is
#' simply the area under the ROC curve.
#' 
#' The AUC estimation of this function follows the procedure described by 
#' Hand & Till (2001). The AUC_roc estimated following the trapezoid approach is
#' equivalent to the average between recall and specificity (Powers, 2011), which is 
#' equivalent to the balanced accuracy (\code{balacc}):
#' 
#' \eqn{AUC_roc = \frac{(recall - FPR + 1)}{2} = \frac{recall+specificity}{2} = 1-\frac{FPR+FNR}{2}}
#' 
#' Interpretation: the AUC is equivalent to the probability that a randomly case 
#' from a given class (positive for binary) will have a smaller estimated probability 
#' of belonging to another class (negative for binary) compared to a randomly 
#' chosen member of the another class. 
#' 
#' Values: the AUC is bounded between 0 and 1. The closer to 1 the better. 
#' Values close to 0 indicate inaccurate predictions. An AUC = 0.5 suggests no 
#' discrimination ability between classes; 0.7 < AUC < 0.8 is considered acceptable,
#' 0.8 < AUC < 0.5 is considered excellent, and AUC > 0.9 is outstanding 
#' (Mandrekar, 2010). 
#' 
#' For the multiclass cases, the AUC is equivalent to the average of AUC of each class
#' (Hand & Till, 2001).
#' 
#' Finally, the AUC is directly related to the Gini-index (a.k.a. G1) since Gini + 1 = 2*AUC.
#' (Hand & Till, 2001).
#' 
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' Hanley, J.A., McNeil, J.A. (2017).
#' The meaning and use of the area under a receiver operating characteristic (ROC) curve. 
#' _ Radiology 143(1): 29-36_ \doi{10.1148/radiology.143.1.7063747}
#' 
#' Hand, D.J., Till, R.J. (2001).
#' A simple generalisation of the area under the ROC curve for multiple class
#' classification problems.
#' _ Machine Learning 45: 171-186_ \doi{10.1023/A:1010920819831}  
#' 
#' Mandrekar, J.N. (2010).
#' Receiver operating characteristic curve in diagnostic test assessment.
#' _ J. Thoracic Oncology 5(9): 1315-1316_ \doi{10.1097/JTO.0b013e3181ec173d}
#' 
#' Powers, D.M.W. (2011). 
#' Evaluation: From Precision, Recall and F-Measure to ROC, Informedness, Markedness & Correlation. 
#' _Journal of Machine Learning Technologies 2(1): 37–63._ \doi{10.48550/arXiv.2010.16061}
#' 
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
#' # Get AUC estimate for two-class case
#' AUC_roc(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get AUC estimate for multi-class case
#' AUC_roc(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' }
#' @importFrom rlang eval_tidy quo
#' @rdname AUC_roc
#' @export 
AUC_roc <- function(data = NULL, obs, pred,
                    tidy = FALSE, na.rm = TRUE){
   
   matrix <- rlang::eval_tidy(
      data = data,
      rlang::quo(table({{pred}}, {{obs}}) ) )
   
  # If binomial
  if (nrow(matrix) == 2){
    
  good <- rlang::eval_tidy(data = data, rlang::quo(sum(as.numeric({{pred}} == {{obs}})) ))
  bad <- rlang::eval_tidy(data = data, rlang::quo(sum(as.numeric({{pred}} != {{obs}})) ))
  rank <- rlang::eval_tidy(data = data, rlang::quo(sum(rank({{pred}}, ties.method = "average",
                          na.last = TRUE)  * ({{pred}} == {{obs}})) ))
  
  AUC_roc <- (rank - good * (good + 1) / 2) / (good * bad)
   
  }
   
  # If multinomial
  if (nrow(matrix) > 2){
    
    #AUC <- NaN
    #warning("metrica has not implemented yet the AUC generalization for multiclass cases. A NaN has been produced")
    # Following Powers (2011)
    # FPR
    TP   <- diag(matrix)
    TPFP <- rowSums(matrix)
    TPFN <- colSums(matrix)
    TN   <- sum(matrix) - (TPFP + TPFN - TP)
    FP   <- TPFP - TP
    spec <- mean(TN / (TN + FP))
    FPR <- 1-spec
    
    # recall
    correct <- diag(matrix)
    total_actual <- colSums(matrix)
    recall <- mean(correct / total_actual)
    
    AUC_roc <- (recall - FPR + 1) / 2
  
    }
    
    
   if (tidy == TRUE){
      return(as.data.frame(AUC_roc)) }
   
   if (tidy == FALSE){ return(list("AUC_roc" = AUC_roc)) }

}


