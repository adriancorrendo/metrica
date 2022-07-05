#' @title Scatter plot of predicted and observed values 
#' @name scatter_plot
#' @description It draws a scatter plot of predictions and observations with alternative
#' axis orientation (P vs. O; O vs. P).
#' @param data (Optional) argument to call an existing data frame with the data. 
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param orientation Argument of class string specifying the axis
#' orientation, PO for predicted vs observed, and OP for
#' observed vs predicted. Default is orientation = "PO".
#' @param print_metrics boolean TRUE/FALSE to embed metrics in the plot. 
#' Default is FALSE.
#' @param metrics_list vector or list of selected metrics to print on the plot.
#' @param position_metrics vector or list with '(x,y)' coordinates to locate the 
#' metrics_table into the plot.
#' Default : c(x = min(obs), y = 1.05*max(pred)).
#' @param print_eq boolean TRUE/FALSE to embed metrics in the plot. Default is FALSE.
#' @param position_eq vector or list with '(x,y)' coordinates to locate the 
#' SMA equation into the plot.
#' Default : c(x = 0.70 max(x), y = 1.25*min(y)).
#' @param eq_color string indicating the color of the SMA-regression text.
#' @param shape_type integer indicating the shape type for the data points.
#' @param shape_size number indicating the shape size for the data points.
#' @param shape_color string indicating the shape color for the data points.
#' @param regline_type string or integer indicating the SMA-regression line-type.
#' @param regline_size number indicating the SMA-regression line size.
#' @param regline_color string indicating the SMA-regression line color. 
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `ggplot`.
#' @details It creates a scatter plot of predicted vs. observed values. The plot also includes 
#' the 1:1 line (solid line) and the linear regression line (dashed line). By default, 
#' it places the observed on the x-axis and the predicted on the y-axis (orientation = "PO").
#' This can be inverted by changing the argument orientation = “OP".
#' For more details, see [online-documentation](https://adriancorrendo.github.io/metrica/)
#' @examples 
#' \donttest{
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 10)
#' scatter_plot(obs = X, pre = Y)
#' }
#' @seealso 
#'  \code{\link[ggplot2]{ggplot}},\code{\link[ggplot2]{geom_point}},\code{\link[ggplot2]{aes}}
#' @rdname scatter_plot
#' @importFrom ggplot2 ggplot geom_point aes geom_abline labs theme_bw theme
#' @importFrom dplyr %>%
#' @importFrom rlang eval_tidy quo
#' @export
scatter_plot <- function(data = NULL, 
                         obs,
                         pred,
                         orientation = "PO",
                         print_metrics = FALSE,
                         metrics_list = NULL,
                         position_metrics = c("x"=NULL, "y"=NULL),
                         print_eq = TRUE,
                         position_eq = c("x"=NULL, "y"=NULL),
                         eq_color = NULL,
                         shape_type = NULL,
                         shape_size = NULL,
                         shape_color = NULL,
                         regline_type = NULL,
                         regline_size = NULL,
                         regline_color = NULL,
                         na.rm = TRUE){
  
  # STOP. Specify metrics_list
  if (print_metrics == TRUE & is.null(metrics_list)) {
    warning("Please, specify the 'metrics_list' arg. For example, metrics_list = c('R2','RMSE','NSE'). 
       Choose wisely, not more than 6 recommended to maintain an appropriate visualization") }
  
  # Get SMA slope and intercepts for printing
  B1.PO <- rlang::eval_tidy(
    data = data,
    rlang::quo( #metrica::B1_sma(data, obs = {{obs}}, pred = {{pred}}, orientation = "PO")
      sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))/
        sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}}))  
      ) )
  B0.PO <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      #metrica::B0_sma(data, obs = {{obs}}, pred = {{pred}}, orientation = "PO")
      mean({{pred}}) - (B1.PO*mean({{obs}}))    
      )  )
  B1.OP <-rlang::eval_tidy(
    data = data,
    rlang::quo(
      #metrica::B1_sma(data, obs = {{obs}}, pred = {{pred}}, orientation = "OP")
      sqrt(sum(({{obs}} - mean({{obs}}))^2)/length({{obs}})) /
        sqrt(sum(({{pred}} - mean({{pred}}))^2)/length({{pred}}))  
      )  )
  B0.OP <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      #metrica::B0_sma(data, obs = {{obs}}, pred = {{pred}}, orientation = "OP")
      mean({{obs}}) - (B1.OP*mean({{pred}}))  
      )  )
  
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
        # Shape
        ggplot2::geom_point(shape = ifelse(is.null(shape_type), 21, shape_type), 
                            fill = ifelse(is.null(shape_color), "#073b4c", shape_color), 
                            size = ifelse(is.null(shape_size), 3, shape_size),
                            alpha = 0.65) +
        # 1:1 line
        ggplot2::geom_abline()+
        # SMA line
        ggplot2::geom_abline(linetype = ifelse(is.null(regline_type), "F1", regline_type), 
                             size = ifelse(is.null(regline_size), 2, regline_size), 
                             col = ifelse(is.null(regline_color), "#f46036", regline_color), 
                             slope = B1.PO,
                             intercept = B0.PO) +
        # Print SMA equation
        {if (print_eq == TRUE)
          ggpp::annotate(geom="text", colour = ifelse(is.null(eq_color), "black", eq_color),
                         x= ifelse(!is.null(position_eq[["x"]]), position_eq[["x"]], 0.70*max({{obs}}) ) , 
                         y= ifelse(!is.null(position_eq[["y"]]), position_eq[["y"]], 1.25*min({{pred}}) ),
                         # Equation
                         label = paste0("y = ",round(B0.PO, 2),"+",
                                        round(B1.PO,2),"x"), 
                         hjust=0) }+ 
        ggplot2::labs(x = "Observed", y = "Predicted")+
        ggplot2::theme_bw()+
        ggplot2::theme(legend.position = "none",
                       axis.title = ggplot2::element_text(face = "bold", size = ggplot2::rel(1.25)),
                       panel.grid = ggplot2::element_blank())
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
          # Shape
          ggplot2::geom_point(shape = ifelse(is.null(shape_type), 21, shape_type), 
                              fill = ifelse(is.null(shape_color), "#f46036", shape_color), 
                              size = ifelse(is.null(shape_size), 3, shape_size),
                              alpha = 0.65) +
          # 1:1 line
          ggplot2::geom_abline()+
          # SMA line
          ggplot2::geom_abline(linetype = ifelse(is.null(regline_type), "F1", regline_type), 
                               size = ifelse(is.null(regline_size), 2, regline_size), 
                               col = ifelse(is.null(regline_color), "#073b4c", regline_color), 
                               slope = B1.PO,
                               intercept = B0.PO) +
          # Print SMA equation
          {if (print_eq == TRUE)
            ggpp::annotate(geom="text", colour = ifelse(is.null(eq_color), "black", eq_color),
                           x= ifelse(!is.null(position_eq[["x"]]), position_eq[["x"]], 0.70*max({{pred}}) ), 
                           y= ifelse(!is.null(position_eq[["y"]]), position_eq[["y"]], 1.25*min({{obs}}) ),
                           # Equation
                           label = paste0("y = ",round(B0.OP,2),"+",
                                          round(B1.OP,2),"x"),
                           hjust=0) }+ 
          ggplot2::labs(y = "Observed", x = "Predicted")+
          ggplot2::theme_bw()+
          ggplot2::theme(legend.position = "none",
                         axis.title = ggplot2::element_text(face = "bold", size = ggplot2::rel(1.25)),
                         panel.grid = ggplot2::element_blank())
      )
    )
  } #IF END
  # Print metrics table
  if (print_metrics == TRUE){
    
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
    
    plot <- 
      rlang::eval_tidy(data=data,
                       rlang::quo(
                         plot + # Annotate Table
                           ggpp::annotate(geom="table", 
                                          # Position
                                          x= ifelse(!is.null(position_metrics[["x"]]), position_metrics[["x"]], min({{obs}}) ), 
                                          y= ifelse(!is.null(position_metrics[["y"]]), position_metrics[["y"]], 1.05*max({{pred}}) ),
                                          # Call the table
                                          label = metrics.table,
                                          # Align Table (left)
                                          hjust = 0, vjust = 1) ) )
    
    
  }
  return(plot)
}