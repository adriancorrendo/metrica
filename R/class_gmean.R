#' @title Geometric Mean  
#' @name gmean
#' @description It estimates the Geometric Mean score for a nominal/categorical predicted-observed dataset.
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
#' @details The gmean is a metric especially useful for imbalanced classes because it 
#' measures the balance between the classification performance on both major (over-represented)
#' as well as on minor (under-represented) classes. As stated above, it is particularly 
#' useful when the number of observations belonging to each class is uneven. 
#' 
#' The gmean score is equivalent to the square-root of the product of specificity 
#' and recall (a.k.a. sensitivity).
#' 
#' \eqn{gmean = \sqrt{recall * specificity} }
#'  
#' It is bounded between 0 and 1. The closer to 1 the better the classification performance, 
#' while zero represents the worst.
#' 
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' De Diego, I.M., Redondo, A.R., Fernández, R.R., Navarro, J., Moguerza, J.M. (2022).
#' General Performance Score for classification problems.
#' _ Appl. Intell. (2022)._ \doi{10.1007/s10489-021-03041-7}
#' @examples 
#' \donttest{
#' set.seed(123)
#' # Two-class
#' binomial_case <- data.frame(labels = sample(c("True","False"), 100, replace = TRUE), 
#' predictions = sample(c("True","False"), 100, replace = TRUE))
#' # Get gmean estimate for two-class case
#' gmean(data = binomial_case, obs = labels, pred = predictions)
#' 
#' }
#' @rdname gmean
#' @importFrom rlang eval_tidy quo
#' @export 
gmean <- function(data=NULL, obs, pred, 
                  pos_level = 2,
                  tidy = FALSE, na.rm = TRUE){
  
  matrix <- rlang::eval_tidy(
    data = data,
    rlang::quo(table({{pred}}, {{obs}}) ) )
  
  # If binomial
  if (nrow(matrix) == 2){
    if (pos_level == 1){ 
    TP <- matrix[[1]]
    TPFN <- matrix[[1]] + matrix[[2]]
    TN <- matrix[[4]]
    TNFP <- matrix[[4]] + matrix[[3]] }
    
    if (pos_level == 2){ 
      TP <- matrix[[4]]
      TPFN <- matrix[[4]] + matrix[[3]]
      TN <- matrix[[1]]
      TNFP <- matrix[[1]] + matrix[[2]] }
    
    rec <- TP/ (TPFN) 
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
    
    rec <- mean(correct / total_actual)
    spec <- mean(TN / (TN + FP))
    
  }
  
  gmean <- sqrt(spec * rec)
  
  if (tidy == TRUE) {
    return(as.data.frame(gmean)) }
  
  if (tidy == FALSE) {
    return(list("gmean" = gmean)) } 
}

