#' @title Likelihood Ratios (Classification)
#' @name likelihood_ratios
#' @description It estimates the positive likelihood ratio \code{posLr}, 
#' negative likelihood ratio \code{negLr}, and diagnostic odds ratio \code{dor} 
#' for a nominal/categorical predicted-observed dataset.
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
#' @details The likelihood ratios are metrics designed to assess the expectations of
#' classification tasks. They are highly related to recall (sensitivity or true positive rate) 
#' and specificity (selectivity or true negative rate).
#' 
#' For a multiclass case, positive and negative results are class-wise. We can either 
#' hit the actual class, or the actual non-class. For example, a classification
#' may have 3 potential results: cat, dog, or fish. Thus, when the actual value is dog, 
#' the only true positive is dog, but we can obtain a true negative either by classifying 
#' it as a cat or a fish. The posLr, negLr, and dor estimates are the mean across all classes.
#' 
#' The positive likelihood ratio (posLr) measures the odds of obtaining a positive 
#' prediction in cases that are actual positives. 
#' 
#' The negative likelihood ratio (negLr) relates the odds of obtaining a negative 
#' prediction for actual non-negatives relative to the probability of actual negative 
#' cases obtaining a negative prediction result.
#' 
#' Finally, the diagnostic odds ratio (dor) measures the effectiveness of classification.
#' It represents the odds of a positive prediction result in actual (observed) positive 
#' cases with respect to the odds of a positive prediction for the actual negative cases.
#' 
#' The ratios are define as follows:
#' 
#' \eqn{posLr = \frac{recall}{1+specificity} = \frac{TPR}{FPR}}
#' 
#' \eqn{negLr = \frac{1-recall}{specificity} = \frac{FNR}{TNR}} 
#' 
#' \eqn{dor = \frac{posLr}{negLr}}  
#'  
#' For more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_classification.html)
#' @references
#' GlasaJeroen, A.S., Lijmer, G., Prins, M.H., Bonsel, G.J., Bossuyta, P.M.M. (2009). 
#' The diagnostic odds ratio: a single indicator of test performance. 
#' _Journal of Clinical Epidemiology 56(11): 1129-1135._ \doi{10.1016/S0895-4356(03)00177-X}
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
#' # Get posLr, negLr, and dor for a two-class case
#' posLr(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' negLr(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' dor(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' }
#' @importFrom rlang eval_tidy quo
#' @rdname likelihood_ratios
#' @export
#' 
posLr <- function(data=NULL, obs, pred, 
                  pos_level = 2, atom = FALSE,
                  tidy = FALSE, na.rm = TRUE){
  # Positive Likelihood Ratio 
  
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}}) ) )
  
  # If binomial
  if (nrow(matrix) == 2){
    if(pos_level == 1){
    TP <- matrix[[1]]
    TPFN <- matrix[[1]] + matrix[[2]]
    TN <- matrix[[4]]
    TNFP <- matrix[[4]] + matrix[[3]] }
    
    if(pos_level == 2){
      TP <- matrix[[4]]
      TPFN <- matrix[[4]] + matrix[[3]]
      TN <- matrix[[1]]
      TNFP <- matrix[[1]] + matrix[[2]] }
    
    rec <- TP / TPFN 
    spec <- TN / TNFP
    
    }
  
  # If multinomial
  if (nrow(matrix) >2) {
    
    # Calculations
    correct <- diag(matrix)
    total_actual <- colSums(matrix) 
    
    TP   <- diag(matrix)
    TPFP <- rowSums(matrix)
    TPFN <- colSums(matrix)
    TN   <- sum(matrix) - (TPFP + TPFN - TP)
    FP   <- TPFP - TP 
    
    if (atom == FALSE) { 
      #prec <- mean(correct / total_pred)
      rec <- mean(correct / total_actual)
      spec <- mean(TN / (TN + FP))
      #warning("For multiclass cases, the gmean should be estimated at a class level. Please, consider using `atom = TRUE`")
    }
    
    if (atom == TRUE) { 
      #prec <- correct / total_pred
      rec <- correct / total_actual
      spec <- TN / (TN + FP)
    }
    
  }
  # Formula
  posLr <- rec / (1 - spec)
  
  if (tidy==TRUE){
    return(as.data.frame(posLr)) }
  
  if (tidy==FALSE){
    return( list("posLr" = posLr)) }
}

#' @rdname likelihood_ratios
#' @export
#' 
negLr <- function(data=NULL, obs, pred, 
                  pos_level = 2, atom = FALSE,
                  tidy = FALSE, na.rm = TRUE){
  # Negative Likelihood Ratio 
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}}) ) )
  
  # If binomial
  if (nrow(matrix) == 2){
    if(pos_level == 1){
      TP <- matrix[[1]]
      TPFN <- matrix[[1]] + matrix[[2]]
      TN <- matrix[[4]]
      TNFP <- matrix[[4]] + matrix[[3]] }
    
    if(pos_level == 2){
      TP <- matrix[[4]]
      TPFN <- matrix[[4]] + matrix[[3]]
      TN <- matrix[[1]]
      TNFP <- matrix[[1]] + matrix[[2]] }
    
    rec <- TP / TPFN 
    spec <- TN / TNFP
    
  }
  
  # If multinomial
  if (nrow(matrix) >2) {
    
    # Calculations
    correct <- diag(matrix)
    total_actual <- colSums(matrix) 
    
    TP   <- diag(matrix)
    TPFP <- rowSums(matrix)
    TPFN <- colSums(matrix)
    TN   <- sum(matrix) - (TPFP + TPFN - TP)
    FP   <- TPFP - TP 
    
    if (atom == FALSE) { 
      #prec <- mean(correct / total_pred)
      rec <- mean(correct / total_actual)
      spec <- mean(TN / (TN + FP))
      #warning("For multiclass cases, the gmean should be estimated at a class level. Please, consider using `atom = TRUE`")
    }
    
    if (atom == TRUE) { 
      #prec <- correct / total_pred
      rec <- correct / total_actual
      spec <- TN / (TN + FP)
    }
    
  }
  
  # Formula
  negLr <- (1 - rec) / spec
  
  if (tidy==TRUE){
    return(as.data.frame(negLr)) }
  
  if (tidy==FALSE){
    return(list("negLr" = negLr)) }
}
#' @rdname likelihood_ratios
#' @export
#'  
dor <- function(data=NULL, obs, pred, 
                pos_level = 2, atom = FALSE,
                tidy = FALSE, na.rm = TRUE){
  # Diagnostic Odds Ratio
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}}) ) )
  
  # If binomial
  if (nrow(matrix) == 2){
    if(pos_level == 1){
      TP <- matrix[[1]]
      TPFN <- matrix[[1]] + matrix[[2]]
      TN <- matrix[[4]]
      TNFP <- matrix[[4]] + matrix[[3]] }
    
    if(pos_level == 2){
      TP <- matrix[[4]]
      TPFN <- matrix[[4]] + matrix[[3]]
      TN <- matrix[[1]]
      TNFP <- matrix[[1]] + matrix[[2]] }
    
    rec <- TP / TPFN 
    spec <- TN / TNFP
    
  }
  
  # If multinomial
  if (nrow(matrix) >2) {
    
    # Calculations
    correct <- diag(matrix)
    total_actual <- colSums(matrix) 
    
    TP   <- diag(matrix)
    TPFP <- rowSums(matrix)
    TPFN <- colSums(matrix)
    TN   <- sum(matrix) - (TPFP + TPFN - TP)
    FP   <- TPFP - TP 
    
    if (atom == FALSE) { 
      #prec <- mean(correct / total_pred)
      rec <- mean(correct / total_actual)
      spec <- mean(TN / (TN + FP))
      #warning("For multiclass cases, the gmean should be estimated at a class level. Please, consider using `atom = TRUE`")
    }
    
    if (atom == TRUE) { 
      #prec <- correct / total_pred
      rec <- correct / total_actual
      spec <- TN / (TN + FP)
    }
    
  }
  
  #Formula
  posLr <- rec / (1 - spec)
  negLr <- (1 - rec) / spec
  
  dor <- posLr / negLr
  
  if (tidy==TRUE){return(as.data.frame(dor)) }
  
  if (tidy==FALSE){
    return( list("dor" = dor) ) }
}
NULL