#' @title Matthews Correlation Coefficient  
#' @name mcc
#' @description It estimates the mcc for a nominal/categorical predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (character | factor).
#' @param pred Vector with predicted values (character | factor).
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
#' @details The mcc it is also known as the phi-coefficient. It has gained 
#' popularity within the machine learning community to summarize into a single 
#' value the confusion matrix of a binary classification.
#' 
#' It is particularly useful when the number of observations belonging to each class
#' is uneven or imbalanced. It is characterized for being symmetric (i.e. no class 
#' has more relevance than the other). It is bounded between -1 and 1. 
#' The closer to 1 the better the classification performance. 
#' 
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' Chicco, D., Jurman, G. (2020)
#' The advantages of the Matthews correlation coefficient (MCC) over F1 score and 
#' accuracy in binary classification evaluation. 
#' _BMC Genomics 21, 6 (2020)._ \doi{10.1186/s12864-019-6413-7}
#' @examples 
#' \donttest{
#' set.seed(123)
#' # Two-class
#' binomial_case <- data.frame(labels = sample(c("True","False"), 100, replace = TRUE), 
#' predictions = sample(c("True","False"), 100, replace = TRUE))
#' 
#' # Get mcc estimate for two-class case
#' mcc(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' }
#' @rdname mcc
#' @importFrom rlang eval_tidy quo
#' @export 
mcc <- function(data=NULL, obs, pred, 
                pos_level = 2,
                tidy = FALSE, na.rm = TRUE){
  
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}}) ) )
  
  # If binomial
  if (nrow(matrix) == 2){
    
    if(pos_level == 1) {
    TP <- matrix[[1]]
    FP <- matrix[[3]]
    TN <- matrix[[4]]
    FN <- matrix[[2]] }
    
    if(pos_level == 2) {
      TP <- matrix[[4]]
      FP <- matrix[[2]]
      TN <- matrix[[1]]
      FN <- matrix[[3]] }
    
    # MCC estimate
    mcc <- (TP * TN - FP * FN) / sqrt( (TP+FP) * (TP+FN) * (TN+FP) * (TN+FN) ) 
    
    }
  
  # If multinomial
  if (nrow(matrix) >2) {
    
    #mcc <- NA
    #warning("The generalization of the Matthews Correlation Coefficient for a multiclass setting has not been implemented yet in metrica") 
    
    P_sum <- rowSums(matrix)
    O_sum <- colSums(matrix)
    
    n_correct <- sum(diag(matrix))
    n_samples <- sum(matrix)
    
    cov_OP <- n_correct * n_samples - (O_sum %*% P_sum)
    cov_PP <- n_samples^2 - (P_sum %*% P_sum)
    cov_OO <- n_samples^2 - (O_sum %*% O_sum)
    
    mcc <- sum(cov_OP / sqrt(cov_PP * cov_OO))
    
    }
  
  if (tidy == TRUE) {
    return(as.data.frame(mcc)) }
  
  if (tidy == FALSE) {
    return(list("mcc" = mcc)) } 
}

