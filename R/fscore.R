#' @title F-score  
#' @name fscore
#' @description It estimates the F-score for a nominal/categorical predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (character | factor).
#' @param pred Vector with predicted values (character | factor).
#' @param B Numeric value indicating the weight (a.k.a. β or beta) to be applied to the 
#' relationship between recall and precision. β < 1 weights more precision than recall.
#' β > 1 gives B times more importance to recall than precision. Default: 1. 
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The F-score (or F-measure) is the harmonic mean of precision and recall.
#' The universal version of F-score employs a coefficient β, by which can be the 
#' precision-recall ratio tuned. 
#' 
#' For binomial cases, F-score  =  TP / (TP + 0.5*(FP + FN))
#' 
#' It is bounded between 0 and 1. 
#' The closer to 1 the better. Values towards zero indicate low performance. 
#' For the formula and more details, see 
#' [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' Goutte, C., Gaussier, E. (2005).
#' A Probabilistic Interpretation of Precision, Recall and F-Score, with Implication for Evaluation. 
#' _In: D.E. Losada and J.M. Fernandez-Luna (Eds.): ECIR 2005_
#' _. Advances in Information Retrieval LNCS 3408, pp. 345–359, 2._
#' _Springer-Verlag Berlin Heidelberg._ \doi{10.1007/978-3-540-31865-1_25}
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
#' fscore(data = binomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get F-score estimate for each class for the multi-class case
#' fscore(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' 
#' # Get F-score estimate for the multi-class case at a global level
#' fscore(data = multinomial_case, obs = labels, pred = predictions, tidy = TRUE)
#' }
#' @rdname fscore
#' @importFrom rlang eval_tidy quo
#' @export 
fscore <- function(data=NULL, obs, pred, B = 1, tidy = FALSE, na.rm = TRUE){
  
  recall <- rlang::eval_tidy(
    data = data,
    rlang::quo(recall(data = data, obs={{obs}}, pred={{pred}}, tidy = FALSE)) )
  
  precision <- rlang::eval_tidy(
    data = data,
    rlang::quo(precision(data = data, obs={{obs}}, pred={{pred}}, tidy = FALSE)) )
  
  #fscore <- (2 * recall * precision )/(recall + precision)
  fscore <- (1 + B ^ 2) * (precision * recall) / ((B ^ 2 * precision) + recall)
  
  if (tidy==TRUE){
    return(as.data.frame(fscore)) }
  
  if (tidy==FALSE){
    return(fscore) }
}

