#' @title Prevalence 
#' @name prevalence
#' @description \code{preval} estimates the prevalence of positive cases 
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
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The prevalence measures the overall proportion of actual positives with
#' respect to the total number of observations. Currently, it is defined for binary cases only.
#' 
#' The general formula is:
#' 
#' \eqn{preval = \frac{positive}{positive + negative} }
#' 
#' The prevalence threshold represents an point on the ROC curve (function of 
#' sensitivity (recall) and specificity) below which the precision (or PPV) 
#' dramatically drops.
#' 
#' \eqn{preval_t = \frac{\sqrt{TPR * FPR} - FPR}{TPR - FPR} }
#' 
#' It is bounded between 0 and 1. 
#' The closer to 1 the better. Values towards zero indicate low performance. 
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' Freeman, E.A., Moisen, G.G. (2008).
#' A comparison of the performance of threshold criteria for binary classification in terms of predicted prevalence and kappa. 
#' _. Ecol. Modell. 217(1-2): 45-58._ \doi{10.1016/j.ecolmodel.2008.05.015}
#' 
#' Balayla, J. (2020).
#' Prevalence threshold (φe) and the geometry of screening curves.
#' _Plos one, 15(10):e0240215, _ \doi{10.1371/journal.pone.0240215}
#' 
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
#' # Get prevalence estimate for two-class case
#' preval(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get prevalence estimate for each class for the multi-class case
#' preval(data = multinomial_case, obs = labels, pred = predictions, atom = TRUE)
#' 
#' }
#' @rdname prevalence
#' @importFrom rlang eval_tidy quo
#' @export 
preval <- function(data=NULL, obs, pred, 
                   atom = FALSE, pos_level = 2,
                   tidy = FALSE, na.rm = TRUE){
  
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}}) ) )
  
  # If binomial
  if (nrow(matrix) == 2){
    
    if(pos_level == 1){
    TP <- matrix[[1]]
    FN <- matrix[[2]]
    n <- sum(matrix) }
    
    if(pos_level == 2){
      TP <- matrix[[4]]
      FN <- matrix[[3]]
      n <- sum(matrix) }
    
    prev <- (TP + FN) / n }
  
  # If multinomial
  if (nrow(matrix) >2) {
    
    # Calculations
    total_obs <- colSums(matrix)
    n <- sum(matrix)
    
    if (atom == FALSE) { 
      #prev <- mean( total_obs / n)
      prev <- NaN
      warning("For multiclass cases, prevalence should be estimated at a class level. A NaN has been recorded as the result. Please, use `atom = TRUE`")
      }
    
    if (atom == TRUE) { 
      prev <- total_obs / n }
  }
  
  if (tidy == TRUE) {
    return(as.data.frame(prev)) }
  
  if (tidy == FALSE) {
    return(list("prev" = prev)) }
}
#' @rdname prevalence
#' @description \code{preval_t} estimates the prevalence threshold for a binary
#' predicted-observed dataset.
#' @export 
preval_t <- function(data=NULL, obs, pred, 
                     atom = FALSE, pos_level = 2,
                     tidy = FALSE, na.rm = TRUE){
  
  #positive_level <- rlang::enquo(pos_level)
  
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}}) ) )
  
  # If binomial
  if (nrow(matrix) == 2){ 
    if (pos_level == 1){
      TP <- matrix[[1]]
      TPFN <- matrix[[1]] + matrix[[2]] 
      TN <- matrix[[4]]
      TNFP <- matrix[[4]] + matrix[[3]]}
    
    if (pos_level == 2){
      TP <- matrix[[4]]
      TPFN <- matrix[[4]] + matrix[[3]]
      TN <- matrix[[1]]
      TNFP <- matrix[[1]] + matrix[[2]]}
    
    TPR <- TP/ TPFN # a.k.a. recall
    FPR <- TN / TNFP  
    # Formula
    preval_t <- (sqrt(TPR * FPR) - FPR) / (TPR - FPR)
    }
  
  # If multinomial
  if (nrow(matrix) >2) { 
    
    # If atom = FALSE can't continue
    if (atom == FALSE){
      preval_t <- NaN
      warning("For multiclass cases, prevalence threshold should be estimated at a class level. 
      A NaN has been recorded as the result. Please, use `atom = TRUE`.") }
    
    # If atom = TRUE
    if (atom == TRUE) { 
      # Calculations
      correct <- diag(matrix)
      total_actual <- colSums(matrix) 
      TPR <- correct / total_actual # a.k.a. recall
      
      TP   <- diag(matrix)
      TPFP <- rowSums(matrix)
      TPFN <- colSums(matrix)
      TN   <- sum(matrix) - (TPFP + TPFN - TP)
      FP   <- TPFP - TP 
      spec <- TN / (TN + FP)
      FPR <- 1 - spec
      
      # Formula
      preval_t <- (sqrt(TPR * FPR) - FPR) / (TPR - FPR)
      }
        }
    
  # FPR 
 
  
 if (tidy == TRUE) {
   return(as.data.frame(preval_t)) }
 
 if (tidy == FALSE) {
   return(list("preval_t" = preval_t)) }
   
   
}

