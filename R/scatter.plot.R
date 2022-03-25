#' @title scatter.plot
#' @description Scatter plot of Predictions and Observations.
#' @param data (Optional) argument to call an existing data frame with the data. 
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param orientation Argument of class string specifying the axis
#' orientation, PO for predicted vs observed, and OP for
#' observed vs predicted. Default is orientation = "PO".
#' @param print.metrics boolean TRUE/FALSE to embed metrics in the plot. Default is FALSE.
#' @param metrics.list vector or list of selected metrics to print on the plot.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Object of class `ggplot`.
#' @details Creates a scatter plot of predicted vs. observed values.
#' @examples 
#' \dontrun{
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 10)
#' scatter.plot(obs = X, pre = Y)
#' }
#' @seealso 
#'  \code{\link[ggplot2]{ggplot}},\code{\link[ggplot2]{geom_point}},\code{\link[ggplot2]{aes}}
#' @rdname scatter.plot
#' @importFrom ggplot2 ggplot geom_point aes geom_abline labs theme_bw
#' theme
#' @importFrom dplyr %>%
#' @importFrom rlang eval_tidy quo
#' @export
scatter.plot <- function(data = NULL, 
                         obs,
                         pred,
                         orientation = "PO",
                         print.metrics = FALSE,
                         metrics.list = NULL,
                         na.rm = TRUE){
  
  # STOP. Specify metrics.list
  if (print.metrics == TRUE & is.null(metrics.list)) {
    stop("Please, specify the 'metrics.list' arg. For example, metrics.list = c('R2','RMSE','NSE'). 
       Choose wisely, not more than 6 recommended to maintain an appropriate visualization") }
  
  # Get SMA slope and intercepts for printing
  B1.PO <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))/
        sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))  ) )
  B0.PO <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      mean({{pred}}) - (B1.PO*mean({{obs}}))    )  )
  B1.OP <-rlang::eval_tidy(
    data = data,
    rlang::quo(
      sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}})) /
        sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))  )  )
  B0.OP <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      mean({{obs}}) - (B1.OP*mean({{pred}}))  )  )
  
  # Generate metrics summary
  metrics.table <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    metrica::metrics.summary(data = data, obs = {{obs}}, pred = {{pred}}, 
                             orientation = orientation,
                    metrics.list = metrics.list) ) ) %>% 
    # Round numbers for clarity
    dplyr::mutate_if(base::is.numeric,~base::round(.,2)) 
  
  # Generate plot
  plot <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      ggplot2::ggplot(data = data, ggplot2::aes(x = {{obs}}, y = {{pred}}))+
        ggplot2::coord_fixed(xlim = c(round(min(c(min({{pred}}),
                                                  min({{obs}})))),
                                      round(max(c(max({{pred}}),
                                                  max({{obs}}))))),
                             ylim = c(round(min(c(min({{pred}}),
                                                  min({{obs}})))),
                                      round(max(c(max({{pred}}), 
                                                  max({{obs}}))))))+
        ggplot2::geom_point(shape=21,
                            fill = "#073b4c", alpha = 0.65, size = 3)+
        ggplot2::geom_abline()+
        ggplot2::geom_abline(linetype = "F1", size = 2,col = "#f46036",
                             slope = B1.PO,
                             intercept = B0.PO)+
        ggplot2::labs(x = "Observed", y = "Predicted")+
        ggplot2::theme_bw()+
        ggplot2::theme(legend.position = "none",
                       panel.grid = ggplot2::element_blank())+
        # Add SMA equation
        ggpp::annotate(geom="text", 
                       x=0.70*max({{obs}}), 
                       y= 1.25*min({{pred}}),
                       # Equation
                       label = paste0("y = ",round(B0.PO, 2),"+",
                                      round(B1.PO,2),"x"), 
                       hjust=0)
    )
  )
  if (orientation == "OP"){
    plot <- rlang::eval_tidy(
      data=data,
      rlang::quo(
        ggplot2::ggplot(data = data, ggplot2::aes(y = {{obs}}, x = {{pred}}))+
          ggplot2::coord_fixed(xlim = c(round(min(c(min({{pred}}),
                                                    min({{obs}})))),
                                        round(max(c(max({{pred}}),
                                                    max({{obs}}))))),
                               ylim = c(round(min(c(min({{pred}}),
                                                    min({{obs}})))),
                                        round(max(c(max({{pred}}), 
                                                    max({{obs}}))))))+
          ggplot2::geom_point(shape=21,
                              fill = "#f46036", alpha = 0.65, size = 3)+
          ggplot2::geom_abline()+
          ggplot2::geom_abline(linetype = "F1", size = 2,col = "#073b4c",
                               slope = B1.OP,
                               intercept = B0.OP)+
          ggplot2::labs(y = "Observed", x = "Predicted")+
          ggplot2::theme_bw()+
          ggplot2::theme(legend.position = "none",
                         panel.grid = ggplot2::element_blank())+
          # Add SMA equation
          ggpp::annotate(geom="text", 
                         x=0.70*max({{obs}}), 
                         y= 1.25*min({{pred}}),
                         # Equation
                         label = paste0("y = ",round(B0.OP,2),"+",
                                        round(B1.OP,2),"x"), 
                         hjust=0)
      )
    )
  } #IF END
  
  if (print.metrics == TRUE){
    plot <- 
      rlang::eval_tidy(data=data,
                       rlang::quo(
                       plot + # Annotate Table
                         ggpp::annotate(geom="table", 
                                        # Position
                                        x = min({{obs}}), 
                                        y = 1.05*max({{pred}}),
                                        # Call the table
                                        label = metrics.table,
                                        # Align Table (left)
                                        hjust = 0, vjust = 1) ) )
      
      
  }
  return(plot)
}