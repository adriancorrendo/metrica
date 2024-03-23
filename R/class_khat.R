#' @title K-hat (Cohen's Kappa Coefficient)
#' @name khat
#' @description It estimates the Cohen's Kappa Coefficient for a nominal/categorical 
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
#' @details The Cohen's Kappa Coefficient is the accuracy normalized by the possibility 
#' of agreement by chance. Thus, it is considered a more robust agreement measure than
#' simply the accuracy. The kappa coefficient was originally described for evaluating
#' agreement of classification between different "raters" (inter-rater reliability).
#' 
#' It is positively bounded to 1, but it is not negatively bounded. 
#' The closer to 1 the better as Kappa assumes its theoretical maximum value of 1 
#' (perfect agreement) only when both observed and predicted values are equally 
#' distributed across the classes (i.e. identical row and column sums). Thus, 
#' the lower the kappa the lower the prediction quality. 
#' 
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_classification.html)
#' @references
#' Cohen, J. (1960).
#' A coefficient of agreement for nominal scales. 
#' _ Educational and Psychological Measurement 20 (1): 37–46._
#' \doi{10.1177/001316446002000104}
#' @examples 
#' \donttest{
#' set.seed(123)
#' # Two-class
#' binomial_case <- data.frame(labels = sample(c("True","False"), 100, replace = TRUE), 
#' predictions = sample(c("True","False"), 100, replace = TRUE))
#' # Multi-class
#' multinomial_case <- data.frame(labels = sample(c("Red","Blue", "Green"), 100, 
#' replace = TRUE), predictions = sample(c("Red","Blue", "Green"), 100, replace = TRUE))
#' 
#' # Get Cohen's Kappa Coefficient estimate for two-class case
#' khat(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get Cohen's Kappa Coefficient estimate for each class for the multi-class case
#' khat(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get Cohen's Kappa Coefficient estimate for the multi-class case at a global level
#' khat(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' }
#' @rdname khat
#' @importFrom rlang eval_tidy quo
#' @export 
khat <- function(data=NULL, obs, pred, 
                 pos_level = 2,
                 tidy = FALSE, na.rm = TRUE){
  
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}}) ) )
  
  # If binomial
  if (nrow(matrix) == 2){ 
    
    if (pos_level == 1){ 
    TP <- matrix[[1]]
    FP <- matrix[[3]]
    TN <- matrix[[4]]
    FN <- matrix[[2]] }
    
    if (pos_level == 2){ 
      TP <- matrix[[4]]
      FP <- matrix[[2]]
      TN <- matrix[[1]]
      FN <- matrix[[3]] }
    
    
    khat <- 2*(TP * TN - FP * FN) / ( (TP+FP) * (TN+FP) + (TP+FN) * (TN+FN) ) 
    
  }
  
  # If multinomial,
  if (nrow(matrix) >2) {
  
  expected <- outer(rowSums(matrix), colSums(matrix)) / sum(matrix)
  
  #levels <- nrow(matrix)
  off_diag <- matrix(1L, nrow = nrow(matrix), ncol = nrow(matrix))
  diag(off_diag) <- 0L
  
  n_off_diag <- sum(off_diag * matrix)
  n_random <- sum(off_diag * expected)
  
  khat <- 1 - (n_off_diag / n_random)
  }
  
  if (tidy==TRUE){return(as.data.frame(khat)) }
  
  if (tidy==FALSE){ return(khat) }
  
}

