#' @title Density plot of predicted and observed values  
#' @name density_plot
#' @description It draws a density area plot of predictions and observations with alternative
#' axis orientation (P vs. O; O vs. P).
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param n Argument of class numeric specifying the number of data points in each group.
#' @param colors Vector or list with two colors '(low, high)' to paint the density gradient.
#' @param orientation Argument of class string specifying the axis
#' orientation, PO for predicted vs observed, and OP for
#' observed vs predicted. Default is orientation = "PO".
#' @param print_metrics boolean TRUE/FALSE to embed metrics in the plot. Default is FALSE.
#' @param metrics_list vector or list of selected metrics to print on the plot.
#' @param position_metrics vector or list with '(x,y)' coordinates to locate the metrics_table into the plot.
#' Default : c(x = min(obs), y = 1.05*max(pred)).
#' @param print_eq boolean TRUE/FALSE to embed metrics in the plot. Default is FALSE.
#' @param position_eq vector or list with '(x,y)' coordinates to locate the SMA equation into the plot.
#' Default : c(x = 0.70 max(x), y = 1.25*min(y)).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Object of class `ggplot`.
#' @details It creates a density plot of predicted vs. observed values. The plot also includes 
#' the 1:1 line (solid line) and the linear regression line (dashed line). By default, 
#' it places the observed on the x-axis and the predicted on the y-axis (orientation = "PO").
#' This can be inverted by changing the argument orientation = “OP".
#' For more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/vignette1.html)
#' @examples 
#' \donttest{
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 10)
#' density_plot(obs = X, pred = Y)
#' }
#' @seealso 
#'  \code{\link[ggplot2]{ggplot}},\code{\link[ggplot2]{geom_point}},\code{\link[ggplot2]{aes}}
#' @rdname density_plot
#' @importFrom ggplot2 ggplot geom_point aes geom_abline geom_hex
#' coord_fixed theme_bw labs
#' @importFrom dplyr %>%
#' @importFrom rlang eval_tidy quo
#' @export
density_plot <- function(data=NULL,
                       obs,
                       pred,
                       n = 10,
                       colors = c("low"=NULL, "high"=NULL),
                       orientation = "PO",
                       print_metrics = FALSE,
                       metrics_list = NULL, 
                       position_metrics = c("x"=NULL, "y"=NULL),
                       print_eq = TRUE,
                       position_eq = c("x"=NULL, "y"=NULL),
                       na.rm = TRUE){
  
  # STOP. Specify metrics_list
  if (print_metrics == TRUE & is.null(metrics_list)) {
  warning("Please, specify the 'metrics_list' arg. For example, metrics_list = c('R2','RMSE','NSE'). 
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
      metrica::metrics_summary(data = data, obs = {{obs}}, pred = {{pred}}, 
                               type = "regression",
                               orientation = orientation,
                      metrics_list = metrics_list) ) ) %>% 
    # Round numbers for clarity
    dplyr::mutate_if(base::is.numeric,~base::round(.,2))
  
  # Generate plot
  palette <- c(colors["low"], colors["high"])
  plot <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      ggplot2::ggplot(data=data, ggplot2::aes(x = {{obs}}, y = {{pred}}))+
      ggplot2::coord_fixed(xlim = c(round(min(c(min({{pred}}),
                                                min({{obs}})))),
                                    round(max(c(max({{pred}}),
                                                max({{obs}}))))),
                           ylim = c(round(min(c(min({{pred}}),
                                                min({{obs}})))),
                                    round(max(c(max({{pred}}), 
                                                max({{obs}}))))))+
      ggplot2::stat_density_2d(ggplot2::aes_string(fill = '..level..'), geom = "polygon", n = n)+
      { if (!is.null(colors[[1]]))
      ggplot2::scale_fill_gradient(low = palette[[1]], high = palette[[2]]) } +
      ggplot2::geom_abline()+
      ggplot2::geom_abline(linetype = "F1", size = 2,col = "#861657",
                           slope = B1.PO,
                           intercept = B0.PO)+
      # Print SMA equation
      {if (print_eq == TRUE)
          ggpp::annotate(geom="text", 
                         x= ifelse(!is.null(position_eq[["x"]]), position_eq[["x"]], 0.70*max({{obs}}) ) , 
                         y= ifelse(!is.null(position_eq[["y"]]), position_eq[["y"]], 1.25*min({{pred}}) ),
                         # Equation
                         label = paste0("y = ",round(B0.PO, 2),"+",
                                        round(B1.PO,2),"x"), 
                         hjust=0) }+ 
      ggplot2::labs(y = "Predicted", x = "Observed")+
      ggplot2::theme_bw()+
      ggplot2::theme(legend.position = "right",
                     panel.grid = ggplot2::element_blank())
      )
  )
if (orientation == "OP"){
  plot <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      ggplot2::ggplot(data=data, ggplot2::aes(y = {{obs}}, x = {{pred}}))+
      ggplot2::coord_fixed(xlim = c(round(min(c(min({{pred}}),
                                                min({{obs}})))),
                                    round(max(c(max({{pred}}),
                                                max({{obs}}))))),
                           ylim = c(round(min(c(min({{pred}}),
                                                min({{obs}})))),
                                    round(max(c(max({{pred}}), 
                                                max({{obs}}))))))+
        ggplot2::stat_density_2d(ggplot2::aes_string(fill = '..level..'), geom = "polygon", n = n)+
      { if (!is.null(colors[[1]]))
          ggplot2::scale_fill_gradient(low = palette[[1]], high = palette[[2]]) } +
      #viridis::scale_fill_viridis(option = "cividis", direction = -1)+
      ggplot2::geom_abline()+
      ggplot2::geom_abline(linetype = "F1", size = 2,col = "#006d77",
                           slope = B1.OP,
                           intercept = B0.OP)+
      # Print SMA equation
      {if (print_eq == TRUE)
      ggpp::annotate(geom="text",
                     x= ifelse(!is.null(position_eq[["x"]]), position_eq[["x"]], 0.70*max({{pred}}) ), 
                     y= ifelse(!is.null(position_eq[["y"]]), position_eq[["y"]], 1.25*min({{obs}}) ),
                     # Equation
                     label = paste0("y = ",round(B0.OP,2),"+",
                                          round(B1.OP,2),"x"),
                     hjust=0) }+ 
      ggplot2::labs(y = "Observed", x = "Predicted")+
      ggplot2::theme_bw()+
      ggplot2::theme(legend.position = "right",
                     panel.grid = ggplot2::element_blank())
      
    )
  )
}
  # Print metrics table
  if (print_metrics == TRUE){
    plot <- 
      rlang::eval_tidy(data=data,
                       rlang::quo(
                         plot + # Annotate Table
                           ggpp::annotate(geom="table", 
                                          # Position
                                          x= ifelse(!is.null(position_metrics[["x"]]), position_metrics[["x"]], min({{obs}}) ), 
                                          y= ifelse(!is.null(position_metrics[["y"]]), position_metrics[["y"]], 1.05*max({{pred}}) ),
                                          #x = min({{obs}}), 
                                          #y = 1.05*max({{pred}}),
                                          # Call the table
                                          label = metrics.table,
                                          # Align Table (left)
                                          hjust = 0, vjust = 1) ) )
  }
    
  return(plot)
}

