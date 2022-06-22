#' @title Confusion Matrix
#' @name confusion_matrix
#' @description It creates a confusion matrix table or plot displaying the agreement between the
#' observed and the predicted classes by the model.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (character or factor).
#' @param pred Vector with predicted values (character or factor).
#' @param plot Logical operator (TRUE/FALSE) that controls the output as a `data.frame` (plot = FALSE) or as a plot of type `ggplot` (plot = TRUE), Default: FALSE
#' @param unit String (text) indicating the type of unit ("count" or "proportion") to show in the confusion matrix, Default: 'count'
#' @param colors Vector or list with two colors indicating how to paint the gradient between "low" and "high", Default: c(low = NULL, high = NULL) uses the standard blue gradient of ggplot2.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return An object of class `data.frame` when plot = FALSE, or of type `ggplot` when plot = TRUE.
#' @details A confusion matrix is a method for summarizing the predictive performance of a classification algorithm. 
#' It is particularly useful if you have an unbalanced number of observations belonging to each class or if you have 
#' a multinomial dataset (more than two classes in your dataset. A confusion matrix can give you a good hint about
#' the types of errors that your model is making.
#' See [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' Ting K.M. (2017).
#' Confusion Matrix. _In: Sammut C., Webb G.I. (eds) Encyclopedia of Machine Learning and Data Mining._ 
#' _Springer, Boston, MA._ \doi{10.1007/978-1-4899-7687-1_50}
#' @examples 
#' \donttest{
#' set.seed(183)
#' # Two-class
#' binomial_case <- data.frame(labels = sample(c("True","False"), 100, replace = TRUE),
#' predictions = sample(c("True","False"), 100, replace = TRUE))
#' # Multi-class
#' multinomial_case <- data.frame(labels = sample(c("Red","Blue", "Green"), 100,
#' replace = TRUE), predictions = sample(c("Red","Blue", "Green"), 100, replace = TRUE))
#' 
#' # Plot two-class confusion matrix
#' confusion_matrix(data = binomial_case, obs = labels, pred = predictions, 
#' plot = TRUE, colors = c(low="pink" , high="steelblue"), unit = "count")
#' 
#' # Plot multi-class confusion matrix
#' confusion_matrix(data = multinomial_case, obs = labels, pred = predictions, 
#' plot = TRUE, colors = c(low="#f9dbbd" , high="#735d78"), unit = "count")
#' }
#' @seealso 
#'  \code{\link[rlang]{eval_tidy}}, \code{\link[rlang]{defusing-advanced}}
#'  \code{\link[dplyr]{select}}
#' @rdname confusion_matrix
#' @export 
#' @importFrom rlang eval_tidy quo
#' @importFrom dplyr select mutate rename %>%
#' @importFrom ggplot2 ggplot geom_tile geom_text scale_fill_gradient labs scale_x_discrete theme_bw
confusion_matrix <- function(data = NULL, obs, pred, 
                             plot = FALSE, unit = "count", 
                             colors = c("low"=NULL, "high"=NULL),
                             na.rm = TRUE) {
  
  Freq <- NULL
  count <- NULL
  
  if (unit == "count") {
    
    matrix <- rlang::eval_tidy(
      data = data,
      rlang::quo(table({{pred}}, {{obs}}, dnn = c("PREDICTED", "OBSERVED")) ) 
    ) 
    
    if(plot == FALSE){ return(matrix) }
    
    else { 
      palette <- c(colors["low"], colors["high"])
      plot <- matrix %>% as.data.frame() %>% 
        dplyr::rename(count = Freq) %>%
        dplyr::mutate(proportion = count/sum(count) ) %>% 
        ggplot2::ggplot(ggplot2::aes_string("PREDICTED","OBSERVED", fill= "count")) +
        ggplot2::geom_tile() + ggplot2::geom_text(ggplot2::aes_string(label = "count")) +
        { if(!is.null(colors[1]))
          ggplot2::scale_fill_gradient(low= palette[[1]], high = palette[[2]]) } +
        ggplot2::labs(x = "Observed",y = "Predicted")+
        ggplot2::scale_x_discrete(position="top")+
        ggplot2::theme_bw()
      
      
      return(plot)
    } }
  
  if (unit == "proportion") {
    
    matrix <- rlang::eval_tidy(
      data = data,
      rlang::quo(table({{pred}}, {{obs}}, dnn = c("PREDICTED", "OBSERVED")) ) 
    ) 
   
    if(plot == FALSE){ return(matrix %>% dplyr::select(-count)) }
    else { 
      palette <- c(colors["low"], colors["high"])
      plot <- matrix %>% as.data.frame() %>% 
        dplyr::rename(count = Freq) %>%
        dplyr::mutate(proportion = count/sum(count) ) %>% 
        ggplot2::ggplot(ggplot2::aes_string("PREDICTED","OBSERVED", fill= "proportion")) +
        ggplot2::geom_tile() + ggplot2::geom_text(ggplot2::aes_string(label = "proportion")) +
        { if(!is.null(colors[1]))
          ggplot2::scale_fill_gradient(low= palette[[1]], high = palette[[2]]) } +
        ggplot2::labs(x = "Observed",y = "Predicted")+
        ggplot2::scale_x_discrete(position="top")+
        ggplot2::theme_bw()
      
      
      return(plot)
    } }
  
}
