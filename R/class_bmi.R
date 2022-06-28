#' @title Bookmaker Informedness  
#' @name bmi
#' @description It estimates the Bookmaker Informedness (a.k.a. Youden's J-index) for a nominal/categorical predicted-observed dataset.
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
#' @details The Bookmaker Informedness (or Youden's J index) it is a suitable metric when the 
#' number of cases for each class is uneven. 
#' 
#' The general formula applied to both binary and multiclass cases is:
#' 
#' \eqn{bmi = recall + specificity - 1 }
#' 
#' It is bounded between 0 and 1. 
#' The closer to 1 the better. Values towards zero indicate low performance. 
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' Youden, W.J. (1950).
#' Index for rating diagnostic tests. 
#' _. Cancer 3: 32-35._
#' \doi{10.1002/1097-0142(1950)3:1<32::AID-CNCR2820030106>3.0.CO;2-3}
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
#' # Get Informedness estimate for two-class case
#' bmi(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get Informedness estimate for each class for the multi-class case
#' bmi(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get Informedness estimate for the multi-class case at a global level
#' bmi(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' }
#' @rdname bmi
#' @importFrom rlang eval_tidy quo enquo
#' @export 
bmi <- function(data=NULL, obs, pred, 
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
      TNFP <- matrix[[4]] + matrix[[3]] }
    
    if (pos_level == 2){ 
      TP <- matrix[[4]]
      TPFP <- matrix[[4]] + matrix[[2]]
      TPFN <- matrix[[4]] + matrix[[3]]
      TN <- matrix[[1]]
      TNFP <- matrix[[1]] + matrix[[2]] }
    
    rec <- TP/ (TPFN) 
    #prec <- TP/ (TPFP)
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
    #TNFP   <- sum(matrix) - (TPFP + TPFN - TP)
    TN   <- sum(matrix) - (TPFP + TPFN - TP)
    FP   <- TPFP - TP 
    
    rec <- mean(correct / total_actual)
    #prec <- TP/ (TPFP)
    spec <- mean(TN / (TN + FP))
    
  }
  
  # Calculation
  bmi <- rec + spec - 1
  
  if (tidy==TRUE){
    return(as.data.frame(bmi)) }
  
  if (tidy==FALSE){
    return(list("bmi" = bmi)) }
}

