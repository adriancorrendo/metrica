#' @title Fowlkes-Mallows Index  
#' @name fmi
#' @description It estimates the Fowlkes-Mallows Index for a nominal/categorical 
#' predicted-observed dataset.
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
#' @details The fmi has gained popularity within the machine learning community 
#' to summarize into a single value the confusion matrix of a binary classification.
#' It is particularly useful when the number of observations belonging to each class
#' is uneven or imbalanced. It is characterized for being symmetric (i.e. no class 
#' has more relevance than the other). It is bounded between -1 and 1. 
#' The closer to 1 the better the classification performance.
#' 
#' The fmi is only available for the evaluation of binary cases (two classes). For 
#' multiclass cases, fmi will produce a `NA` and display a warning. 
#'  
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_classification.html)
#' @references
#' Fowlkes, Edward B; Mallows, Colin L (1983).
#' A method for comparing two hierarchical clusterings.
#' _Journal of the American Statistical Association. 78 (383): 553–569._
#' \doi{10.1080/01621459.1983.10478008}
#' @examples 
#' \donttest{
#' set.seed(123)
#' # Two-class
#' binomial_case <- data.frame(labels = sample(c("True","False"), 100, replace = TRUE), 
#' predictions = sample(c("True","False"), 100, replace = TRUE))
#' # Get fmi estimate for two-class case
#' fmi(data = binomial_case, obs = labels, pred = predictions)
#' }
#' @rdname fmi
#' @importFrom rlang eval_tidy quo enquo
#' @export 
fmi <- function(data=NULL, obs, pred, 
                pos_level = 2,
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
    
    # Formula  
    fmi <- sqrt(prec * rec)
  }
  
  # If multinomial (not implemented yet, need to be checked in literature)
  # if (nrow(matrix) >2) {
  #   
  #   # Calculations
  #   correct <- diag(matrix)
  #   total_actual <- colSums(matrix) 
  #   
  #   TP   <- diag(matrix)
  #   TPFP <- rowSums(matrix)
  #   TPFN <- colSums(matrix)
  #   TN   <- sum(matrix) - (TPFP + TPFN - TP)
  #   FP   <- TPFP - TP 
  #   
  #   rec <- mean(correct / total_actual)
  #   prec <- TP/ (TPFP)
  #   #spec <- mean(TN / (TN + FP))
  #   
  # }
  #   
  # 
  
  if (nrow(matrix) >2) {
    
    fmi <- NaN
    warning("The Fowlkes-Mallows Index is not available for multiclass cases. The result has been recorded as NaN.") 
    
      }
  
  
  
  if (tidy == TRUE) {
    return(as.data.frame(fmi)) }
  
  if (tidy == FALSE) {
    return(list("fmi" = fmi)) } 
}

