#' @title Adjusted F-score  
#' @name agf
#' @description It estimates the Adjusted F-score for a nominal/categorical 
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
#' @details The Adjusted F-score (or Adjusted F-measure) is an improvement over the 
#' F1-score especially when the data classes are imbalanced. This metric more properly 
#' accounts for the different misclassification costs across classes. It weights more 
#' the sensitivity (recall) metric than precision and gives strength to the false negative
#' values. This index accounts for all elements of the original confusion matrix and 
#' provides more weight to patterns correctly classified in the minority class (positive).
#'  
#' It is bounded between 0 and 1. 
#' The closer to 1 the better. Values towards zero indicate low performance. 
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_classification.html)
#' @references
#' Maratea, A., Petrosino, A., Manzo, M. (2014).
#' Adjusted-F measure and kernel scaling for imbalanced data learning. 
#' _Inf. Sci. 257: 331-341._ \doi{10.1016/j.ins.2013.04.016}
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
#' agf(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get F-score estimate for each class for the multi-class case
#' agf(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get F-score estimate for the multi-class case at a global level
#' agf(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' }
#' @rdname agf
#' @importFrom rlang eval_tidy quo enquo
#' @export 
agf <- function(data=NULL, obs, pred, 
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
      TNFN <- matrix[[4]] + matrix[[2]]
      TN <- matrix[[4]]
      N <- matrix[[4]] + matrix[[3]] }
    
    if (pos_level == 2){ 
      TP <- matrix[[4]]
      TPFP <- matrix[[4]] + matrix[[2]]
      TPFN <- matrix[[4]] + matrix[[3]]
      TNFN <- matrix[[1]] + matrix[[3]]
      TN <- matrix[[1]]
      N <- matrix[[1]] + matrix[[2]] }
    
    rec <- TP/ (TPFN) 
    prec <- TP/ (TPFP)
    spec <- TN/N
    npv <- TN/ (TNFN)
    
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
    
    if (atom == FALSE) { 
      prec <- mean(correct / total_pred)
      rec <- mean(correct / total_actual)
      spec <- mean( TN / (TN + FP) )
      npv <- mean( TN / (TN + FN) )
      warning("For multiclass cases, the agf should be estimated at a class level. Please, consider using `atom = TRUE`")
    }
    
    if (atom == TRUE) { 
      prec <- correct / total_pred
      rec <- correct / total_actual
      spec <- TN / (TN + FP)
      npv <- TN / (TN + FN)
    } 
    
    
  }
  
  # Formula components
 # F2 <- 5 * ( (rec*prec) / ((4*rec) + prec) )
  #invF05 <- (5/4) * ( (rec*prec) / (( (0.5^2) * rec)+prec) )
  F2 <- 5 * ( (rec*prec) / ((4*prec) + rec) )
  invF05 <- (5/4) *( (npv*spec) / (( (0.5^2) * npv) + spec))
  
  agf <- sqrt(F2 * invF05)
  
  if (tidy==TRUE){
    return(as.data.frame(agf)) }
  
  if (tidy==FALSE){
    return(list("agf"=agf)) }
}

