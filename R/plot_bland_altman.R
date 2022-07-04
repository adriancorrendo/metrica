#' @title Bland-Altman plot 
#' @name bland_altman_plot
#' @description It creates a scatter plot of the difference between observed and predicted 
#' values (obs-pred) vs. observed values. 
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param shape_type number indicating the shape type for the data points.
#' @param shape_size number indicating the shape size for the data points.
#' @param shape_color string indicating the shape color for the data points.
#' @param zeroline_type string or integer indicating the zero line-type.
#' @param zeroline_size number indicating the zero line size.
#' @param zeroline_color string indicating the zero line color.
#' @param limitsline_type string or integer indicating the limits (+/- 1.96*SD) line-type.
#' @param limitsline_size number indicating the limits (+/- 1.96*SD) line size.
#' @param limitsline_color string indicating the limits (+/- 1.96*SD) line color.  
#' @param na.rm Logic argument to remove rows with missing values
#' @return an object of class `ggplot`.
#' @details See [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references
#' Bland & Altman (1986).
#' Statistical methods for assessing agreement between two methods of clinical measurement
#' _The Lancet 327(8476), 307-310_ \doi{10.1016/S0140-6736(86)90837-8} 
#' @examples 
#' \donttest{
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 10)
#' bland_altman_plot(obs = X, pred = Y)
#' }
#' @seealso 
#'  \code{\link[ggplot2]{ggplot}},\code{\link[ggplot2]{geom_point}},\code{\link[ggplot2]{aes}}
#' @rdname bland_altman_plot
#' @export 
#' @importFrom ggplot2 ggplot geom_point aes geom_abline labs theme_bw
#' theme
#' @importFrom dplyr %>%
#' @importFrom rlang eval_tidy quo  
bland_altman_plot <- function(data=NULL,
                              obs,
                              pred,
                              shape_type = NULL,
                              shape_size = NULL,
                              shape_color = NULL,
                              zeroline_type = NULL,
                              zeroline_size = NULL,
                              zeroline_color = NULL,
                              limitsline_type = NULL,
                              limitsline_size = NULL,
                              limitsline_color = NULL,
                              na.rm = TRUE){
  plot <- rlang::eval_tidy(
    data = data,
    rlang::quo(
    ggplot2::ggplot(data = data.frame(obs = {{obs}}, 
                                      pred = {{pred}})  %>% 
                      dplyr::mutate(diff = obs - pred),
                    ggplot2::aes(x = obs, y = diff))+
    ggplot2::coord_fixed(xlim = c(round(min(c(min(pred),
                                              min(obs)))),
                                  round(max(c(max(pred),
                                              max(obs)))))
    )+
    # Shape
    ggplot2::geom_point(shape = ifelse(is.null(shape_type), 21, shape_type), 
                          fill = ifelse(is.null(shape_color), "#006d77", shape_color), 
                          size = ifelse(is.null(shape_size), 3, shape_size),
                          alpha = 0.65) +  
    # Zero line
    ggplot2::geom_hline(yintercept = 0, 
                        linetype = ifelse(is.null(zeroline_type), "solid", zeroline_type), 
                        size = ifelse(is.null(zeroline_size), 2, zeroline_size), 
                        col = ifelse(is.null(zeroline_color), "black", zeroline_color))+
    # Boundary lines
    ggplot2::geom_hline(yintercept = 1.96*stats::sd(obs),
                        linetype = ifelse(is.null(limitsline_type), "dashed", limitsline_type), 
                        size = ifelse(is.null(limitsline_size), 2, limitsline_size), 
                        col = ifelse(is.null(limitsline_color), "dark red", limitsline_color))+
    ggplot2::geom_hline(yintercept = -1.96*stats::sd(obs),
                        linetype = ifelse(is.null(limitsline_type), "dashed", limitsline_type), 
                        size = ifelse(is.null(limitsline_size), 2, limitsline_size), 
                        col = ifelse(is.null(limitsline_color), "dark red", limitsline_color))+
    ggplot2::labs(x = "Observed", y = "Observed - Predicted")+
    ggplot2::theme_bw()+
    ggplot2::theme(legend.position = "none",
                   axis.title = ggplot2::element_text(face = "bold", size = ggplot2::rel(1.25)),
                   panel.grid = ggplot2::element_blank())
    )
  )
  return(plot)
}