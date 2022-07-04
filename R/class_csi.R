#' @title Critical Success Index  
#' @name csi
#' @description It estimates the Critical Success Index (a.k.a. threat score, 
#' Jaccard Index) for a nominal/categorical predicted-observed dataset.
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
#' @details The \code{csi} is also known as the threat score or the Jaccard Index.
#' It is a metric especially useful for binary classification tasks, representing the
#' proportion of true positive (TP) cases with respect to the sum of predicted positive 
#' (PP = TP + FP) and true negative (TN) cases.
#' 
#' \eqn{csi = \frac{TP}{TP + TN + FP} }
#'  
#' It is bounded between 0 and 1. The closer to 1 the better the classification performance, 
#' while zero represents the worst result.
#' 
#' It has been extensively used in meteorology (NOOA) as a verification measure 
#' of categorical forecast performance equal to the total number of correct event forecast
#' (hits = TP) divided by the total number of event forecasts plus the number of misses (hits +
#' false alarms + misses = TP + FP + TN). However, the csi has been criticized for 
#' not representing an unbiased measure of forecast skill (Schaefer, 1990).
#' 
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' NOOA. 
#' Forecast Verification Glossary.
#' _Space Weather Prediction Center, NOOA._ \url{https://www.swpc.noaa.gov/sites/default/files/images/u30/Forecast%20Verification%20Glossary.pdf} 
#' 
#' Schaefer, J.T. (1990). 
#' The critical success index as an indicator of warning skill. 
#' _Weather and Forecasting 5(4): 570-575._ \doi{10.1175/1520-0434(1990)005<0570:TCSIAA>2.0.CO;2}
#' @examples 
#' \donttest{
#' set.seed(123)
#' # Two-class
#' binomial_case <- data.frame(labels = sample(c("True","False"), 100, replace = TRUE), 
#' predictions = sample(c("True","False"), 100, replace = TRUE))
#' # Get csi estimate for two-class case
#' csi(data = binomial_case, obs = labels, pred = predictions)
#' 
#' }
#' @rdname csi
#' @importFrom rlang eval_tidy quo
#' @export 
csi <- function(data=NULL, obs, pred, 
                pos_level = 2, atom = FALSE,
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
    
    csi <- TP / (TP + TNFP) 
    
    
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
    
    if (atom == FALSE){ csi <- mean(TP / (TP + TN + FP)) }
    
    if (atom == TRUE){ csi <- TP / (TP + TN + FP) }
    
    
  }
  
  if (tidy == TRUE) {
    return(as.data.frame(csi)) }
  
  if (tidy == FALSE) {
    return(list("csi" = csi)) } 
}

