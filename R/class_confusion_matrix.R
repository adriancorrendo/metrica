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
#' @param print_metrics boolean TRUE/FALSE to embed metrics in the plot. Default is FALSE.
#' @param metrics_list vector or list of selected metrics to print on the plot. 
#' Default: c("accuracy", "precision", "recall").
#' @param position_metrics string specifying the position to print the performance 
#' `metrics_list`. Options are "top" (as a subtitle) or "bottom" (as a caption).
#' Default: "bottom".
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
#' @importFrom ggplot2 ggplot geom_tile geom_text scale_fill_gradient labs scale_x_discrete scale_y_discrete theme_bw theme element_text element_rect element_blank scale_size_manual guides rel
confusion_matrix <- function(data = NULL, obs, pred, 
                             plot = FALSE, unit = "count", 
                             colors = c("low"=NULL, "high"=NULL),
                             print_metrics = FALSE,
                             metrics_list = c("accuracy", "precision", "recall"),
                             position_metrics = "top",
                             na.rm = TRUE) {
  
  Freq <- NULL
  count <- NULL
  PREDICTED <- NULL
  OBSERVED <- NULL
  levels <- NULL
  levels_metrics_list <- length(metrics_list)
  isdiag <- NULL
  
  
  matrix <- rlang::eval_tidy(
    data = {{data}},
    rlang::quo(table({{pred}}, {{obs}}, dnn = c("PREDICTED", "OBSERVED")) ) )
  
  if(plot == FALSE) { return(matrix) }
    
    if(plot == TRUE) { 
      # Transfor matrix into data.frame for plotting
      mat_plot <- matrix %>% as.data.frame() %>%
        dplyr::mutate(PREDICTED = as.factor(PREDICTED), OBSERVED = as.factor(OBSERVED)) %>% 
        dplyr::rename(count = Freq) %>%
        dplyr::mutate(proportion = round(count/sum(count),2) ) %>% 
        dplyr::mutate(isdiag = (PREDICTED == OBSERVED)) |>
        dplyr::arrange(isdiag)
      # Obtain the levels the order the cm
      levels <- levels(mat_plot[["PREDICTED"]])
      # Obtain the palette
      palette <- c(colors["low"], colors["high"])
      # Plot
      
      if (unit == "count") {
      plot <- mat_plot %>% 
        ggplot2::ggplot(ggplot2::aes_string(y="PREDICTED",x="OBSERVED")) +
        ggplot2::geom_tile(ggplot2::aes_string(width=0.975, height=0.975, 
                                               fill= "count", col = "count",
                                               size = "isdiag"), alpha = 0.65) + 
        ggplot2::geom_text(ggplot2::aes_string(label = "count")) +
        { if(!is.null(colors[1]))
          ggplot2::scale_fill_gradient(low= palette[[1]], high = palette[[2]])} +
        { if(!is.null(colors[1]))
        ggplot2::scale_color_gradient(low= palette[[1]], high = palette[[2]]) } +
        ggplot2::scale_size_manual(values = c(0,2))+
        ggplot2::guides(size = "none")+
        ggplot2::labs(x = "Observed",y = "Predicted")+
        ggplot2::scale_x_discrete(position="top")+
        ggplot2::scale_y_discrete(limits=rev(levels))+
        ggplot2::theme_bw()+
        ggplot2::theme(panel.border = ggplot2::element_rect(color = "grey75"),
                       panel.grid = ggplot2::element_blank(),
                       axis.title = ggplot2::element_text(face = "bold", size = ggplot2::rel(1.25)),
                       axis.text.y = ggplot2::element_text(angle = 90, hjust = 0.5, vjust = 0.5),
                       plot.subtitle = element_text(size=ggplot2::rel(0.85), hjust=0, face="italic", color="black"),
                       plot.caption = element_text(size=ggplot2::rel(0.85), hjust=0, face="italic", color="black"))
      }
      
      if (unit == "proportion") {
        plot <- mat_plot %>% 
          ggplot2::ggplot(ggplot2::aes_string(y="PREDICTED",x="OBSERVED")) +
          ggplot2::geom_tile(ggplot2::aes_string(width=0.975, height=0.975,
                                                 fill= "proportion", col = "proportion",
                                                 size = "isdiag"), alpha = 0.65) + 
          ggplot2::geom_text(ggplot2::aes_string(label = "proportion")) +
          { if(!is.null(colors[1]))
            ggplot2::scale_fill_gradient(low= palette[[1]], high = palette[[2]])} +
          { if(!is.null(colors[1]))
            ggplot2::scale_color_gradient(low= palette[[1]], high = palette[[2]]) } +
          ggplot2::scale_size_manual(values = c(0,2))+
          ggplot2::guides(size = "none")+
          ggplot2::labs(x = "Observed",y = "Predicted")+
          ggplot2::scale_x_discrete(position="top")+
          ggplot2::scale_y_discrete(limits=rev(levels))+
          ggplot2::theme_bw()+
          ggplot2::theme(panel.border = ggplot2::element_rect(color = "grey75"),
                         panel.grid = ggplot2::element_blank(),
                         axis.title = ggplot2::element_text(face = "bold", size = ggplot2::rel(1.25)),
                         axis.text.y = ggplot2::element_text(angle = 90, hjust = 0.5, vjust = 0.5),
                         plot.subtitle = element_text(size=ggplot2::rel(0.85), hjust=0, face="italic", color="black"),
                         plot.caption = element_text(size=ggplot2::rel(0.85), hjust=0, face="italic", color="black"))
      }
      
      if (print_metrics == TRUE){
        
      # Generate metrics summary
       metrics.table <- rlang::eval_tidy(
          data = data,
          rlang::quo(
            metrica::metrics_summary(data = data, obs = {{obs}}, pred = {{pred}},
                                     type = "classification",
                                     metrics_list = metrics_list) ) ) %>% 
          # Round numbers for clarity
          dplyr::mutate_if(base::is.numeric,~base::round(.,2)) 
        
      
      if (levels_metrics_list == 1){
        plot <-
              if (position_metrics == "top"){ 
                plot + ggplot2::labs(subtitle = paste("Performance metrics: \n", metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], ".")) } 
              else { 
                plot + ggplot2::labs(caption = paste("Performance metrics: \n", metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], ".")) }
              }
            if (levels_metrics_list == 2){ 
              plot <-
              if (position_metrics == "top"){ plot + ggplot2::labs(subtitle = paste("Performance metrics: \n", metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",                                                metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "." )) }
              else { plot +
                ggplot2::labs(caption = paste("Performance metrics: \n", 
                                              metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",
                                              metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "." )) } }
            if (levels_metrics_list == 3){
              plot <-
              if (position_metrics == "top"){ 
                plot +
                ggplot2::labs(subtitle = paste("Performance metrics: \n", 
                                               metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",
                                               metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "; ",
                                               metrics.table[3, "Metric"], " = ", metrics.table[3, "Score"], "." )) } 
              else { 
                plot +
                ggplot2::labs(caption = paste("Performance metrics: \n", 
                                              metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",
                                              metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "; ",
                                              metrics.table[3, "Metric"], " = ", metrics.table[3, "Score"], "." )) } }
            if (levels_metrics_list == 4){
              plot <-
              if (position_metrics == "top"){
                plot +
                ggplot2::labs(subtitle = paste("Performance metrics: \n", 
                                               metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",
                                            metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "; ",
                                            metrics.table[3, "Metric"], " = ", metrics.table[3, "Score"], "; ",
                                            metrics.table[4, "Metric"], " = ", metrics.table[4, "Score"], "." )) }
              else {
                plot +
                ggplot2::labs(caption = paste("Performance metrics: \n", metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",
                                                metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "; ",
                                                metrics.table[3, "Metric"], " = ", metrics.table[3, "Score"], "; ",
                                                metrics.table[4, "Metric"], " = ", metrics.table[4, "Score"], "." )) } }
           if (levels_metrics_list == 5){
             plot <-
             if (position_metrics == "top"){
               plot +
                ggplot2::labs(subtitle = paste("Performance metrics: \n", metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",
                                            metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "; ",
                                            metrics.table[3, "Metric"], " = ", metrics.table[3, "Score"], "; ",
                                            metrics.table[4, "Metric"], " = ", metrics.table[4, "Score"], "; ",
                                            metrics.table[5, "Metric"], " = ", metrics.table[5, "Score"], "." )) } 
             else {
               plot +
               ggplot2::labs(caption = paste("Performance metrics: \n", metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",
                                               metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "; ",
                                               metrics.table[3, "Metric"], " = ", metrics.table[3, "Score"], "; ",
                                               metrics.table[4, "Metric"], " = ", metrics.table[4, "Score"], "; ",
                                               metrics.table[5, "Metric"], " = ", metrics.table[5, "Score"], ".")) } }
            if (levels_metrics_list == 6){
              plot <-
              if (position_metrics == "top"){
                plot +
                ggplot2::labs(subtitle = strwrap(paste("Performance metrics: \n", metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",
                                                       metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "; ",
                                                       metrics.table[3, "Metric"], " = ", metrics.table[3, "Score"], "; ",
                                                       metrics.table[4, "Metric"], " = ", metrics.table[4, "Score"], "; ",
                                                       metrics.table[5, "Metric"], " = ", metrics.table[5, "Score"], "; \n",
                                                       metrics.table[6, "Metric"], " = ", metrics.table[6, "Score"], "." ))
                                ) }
              else {
                plot +
                ggplot2::labs(caption = paste("Performance metrics: \n", metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",
                                                metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "; ",
                                                metrics.table[3, "Metric"], " = ", metrics.table[3, "Score"], "; ",
                                                metrics.table[4, "Metric"], " = ", metrics.table[4, "Score"], "; ",
                                                metrics.table[5, "Metric"], " = ", metrics.table[5, "Score"], "; \n",
                                                metrics.table[6, "Metric"], " = ", metrics.table[6, "Score"], ".")) } }
            if (levels_metrics_list == 7){
              plot <-
              if (position_metrics == "top"){
                plot +
                ggplot2::labs(subtitle = paste("Performance metrics: \n", metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",
                                            metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "; ",
                                            metrics.table[3, "Metric"], " = ", metrics.table[3, "Score"], "; ",
                                            metrics.table[4, "Metric"], " = ", metrics.table[4, "Score"], "; ",
                                            metrics.table[5, "Metric"], " = ", metrics.table[5, "Score"], "; \n",
                                            metrics.table[6, "Metric"], " = ", metrics.table[6, "Score"], "; ",
                                            metrics.table[7, "Metric"], " = ", metrics.table[7, "Score"], "." )) }
              else {
                plot +
                ggplot2::labs(caption = paste("Performance metrics: \n", metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",
                                                metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "; ",
                                                metrics.table[3, "Metric"], " = ", metrics.table[3, "Score"], "; ",
                                                metrics.table[4, "Metric"], " = ", metrics.table[4, "Score"], "; ",
                                                metrics.table[5, "Metric"], " = ", metrics.table[5, "Score"], "; \n",
                                                metrics.table[6, "Metric"], " = ", metrics.table[6, "Score"], "; ",
                                                metrics.table[7, "Metric"], " = ", metrics.table[7, "Score"], ".")) } }
          if (levels_metrics_list == 8){
            plot <-
            if (position_metrics == "top"){
              plot +
              ggplot2::labs(subtitle = paste("Performance metrics: \n", metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",
                                            metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "; ",
                                            metrics.table[3, "Metric"], " = ", metrics.table[3, "Score"], "; ",
                                            metrics.table[4, "Metric"], " = ", metrics.table[4, "Score"], "; ",
                                            metrics.table[5, "Metric"], " = ", metrics.table[5, "Score"], "; \n",
                                            metrics.table[6, "Metric"], " = ", metrics.table[6, "Score"], "; ",
                                            metrics.table[7, "Metric"], " = ", metrics.table[7, "Score"], "; ",
                                            metrics.table[8, "Metric"], " = ", metrics.table[8, "Score"], "; ",
                                            metrics.table[9, "Metric"], " = ", metrics.table[9, "Score"], "."  )) }
            else {
              plot +
              ggplot2::labs(caption = paste("Performance metrics: \n", metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",
                                              metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "; ",
                                              metrics.table[3, "Metric"], " = ", metrics.table[3, "Score"], "; ",
                                              metrics.table[4, "Metric"], " = ", metrics.table[4, "Score"], "; ",
                                              metrics.table[5, "Metric"], " = ", metrics.table[5, "Score"], "; \n",
                                              metrics.table[6, "Metric"], " = ", metrics.table[6, "Score"], "; ",
                                              metrics.table[7, "Metric"], " = ", metrics.table[7, "Score"], "; ",
                                              metrics.table[8, "Metric"], " = ", metrics.table[8, "Score"], "; ",
                                              metrics.table[9, "Metric"], " = ", metrics.table[9, "Score"], ".")) } }
          if (levels_metrics_list == 9){
            plot <-
            if (position_metrics == "top"){
              plot +
              ggplot2::labs(subtitle = paste("Performance metrics: \n", metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",
                                            metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "; ",
                                            metrics.table[3, "Metric"], " = ", metrics.table[3, "Score"], "; ",
                                            metrics.table[4, "Metric"], " = ", metrics.table[4, "Score"], "; ",
                                            metrics.table[5, "Metric"], " = ", metrics.table[5, "Score"], "; \n",
                                            metrics.table[6, "Metric"], " = ", metrics.table[6, "Score"], "; ",
                                            metrics.table[7, "Metric"], " = ", metrics.table[7, "Score"], "; ",
                                            metrics.table[8, "Metric"], " = ", metrics.table[8, "Score"], "; ",
                                            metrics.table[9, "Metric"], " = ", metrics.table[9, "Score"], ".")) }
            else { 
              plot +
              ggplot2::labs(caption = paste("Performance metrics: \n", metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",
                                              metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "; ",
                                              metrics.table[3, "Metric"], " = ", metrics.table[3, "Score"], "; ",
                                              metrics.table[4, "Metric"], " = ", metrics.table[4, "Score"], "; ",
                                              metrics.table[5, "Metric"], " = ", metrics.table[5, "Score"], "; \n",
                                              metrics.table[6, "Metric"], " = ", metrics.table[6, "Score"], "; ",
                                              metrics.table[7, "Metric"], " = ", metrics.table[7, "Score"], "; ",
                                              metrics.table[8, "Metric"], " = ", metrics.table[8, "Score"], "; ",
                                              metrics.table[9, "Metric"], " = ", metrics.table[9, "Score"], ".")) } }
            if (levels_metrics_list == 10){
              plot <-
              if (position_metrics == "top"){
                plot +
               ggplot2::labs(subtitle = paste("Performance metrics: \n", metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",
                                            metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "; ",
                                            metrics.table[3, "Metric"], " = ", metrics.table[3, "Score"], "; ",
                                            metrics.table[4, "Metric"], " = ", metrics.table[4, "Score"], "; ",
                                            metrics.table[5, "Metric"], " = ", metrics.table[5, "Score"], "; \n",
                                            metrics.table[6, "Metric"], " = ", metrics.table[6, "Score"], "; ",
                                            metrics.table[7, "Metric"], " = ", metrics.table[7, "Score"], "; ",
                                            metrics.table[8, "Metric"], " = ", metrics.table[8, "Score"], "; ",
                                            metrics.table[9, "Metric"], " = ", metrics.table[9, "Score"], "; ",
                                            metrics.table[10, "Metric"], " = ", metrics.table[10, "Score"], ".")) } 
              else {
                plot +
                ggplot2::labs(caption = paste("Performance metrics: \n", metrics.table[1, "Metric"], " = ", metrics.table[1, "Score"], "; ",
                                                metrics.table[2, "Metric"], " = ", metrics.table[2, "Score"], "; ",
                                                metrics.table[3, "Metric"], " = ", metrics.table[3, "Score"], "; ",
                                                metrics.table[4, "Metric"], " = ", metrics.table[4, "Score"], "; ",
                                                metrics.table[5, "Metric"], " = ", metrics.table[5, "Score"], "; \n",
                                                metrics.table[6, "Metric"], " = ", metrics.table[6, "Score"], "; ",
                                                metrics.table[7, "Metric"], " = ", metrics.table[7, "Score"], "; ",
                                                metrics.table[8, "Metric"], " = ", metrics.table[8, "Score"], "; ",
                                                metrics.table[9, "Metric"], " = ", metrics.table[9, "Score"], "; ",
                                                metrics.table[10, "Metric"], " = ", metrics.table[10, "Score"], ".")) } }
      }
                                              
      }
      
      plot    
      } 

