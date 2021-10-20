#' @title scatter.plot
#' @description Scatter plot of Predictions and Observations.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param orientation Argument of class string specifying the axis
#' orientation, PO for predicted vs observed, and OP for
#' observed vs predicted. Default is orientation = "PO".
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
#' @export 
#' @importFrom ggplot2 ggplot geom_point aes geom_abline labs theme_bw
#' theme
#' @importFrom dplyr %>%
scatter.plot <- function(obs,
                         pred,
                         orientation = "PO",
                         na.rm = TRUE){
  plot <-
    data.frame(pred = pred, obs = obs) %>%
      ggplot2::ggplot(ggplot2::aes(x = obs, y = pred))+
      ggplot2::coord_fixed(xlim = c(round(min(c(min(pred),
                                                min(obs)))),
                                    round(max(c(max(pred),
                                                max(obs))))),
                           ylim = c(round(min(c(min(pred),
                                                min(obs)))),
                                    round(max(c(max(pred), 
                                                max(obs))))))+
      ggplot2::geom_point(shape=21,
                          fill = "#073b4c", alpha = 0.65, size = 3)+
      ggplot2::geom_abline()+
      ggplot2::geom_abline(linetype = "F1", size = 2,col = "#f46036",
                           slope = metrica::B1.sma(obs,pred,orientation=orientation),
                           intercept = metrica::B0.sma(obs,pred,orientation=orientation))+
      ggplot2::labs(x = "Observed", y = "Predicted")+
      ggplot2::theme_bw()+
      ggplot2::theme(legend.position = "none",
                     panel.grid = ggplot2::element_blank())
if (orientation == "OP"){
  plot <-
      data.frame(pred = pred, obs = obs) %>%
      ggplot2::ggplot(ggplot2::aes(y = obs, x = pred))+
      ggplot2::coord_fixed(xlim = c(round(min(c(min(pred),
                                                min(obs)))),
                                    round(max(c(max(pred),
                                                max(obs))))),
                           ylim = c(round(min(c(min(pred),
                                                min(obs)))),
                                    round(max(c(max(pred), 
                                                max(obs))))))+
      ggplot2::geom_point(shape=21,
                          fill = "#f46036", alpha = 0.65, size = 3)+
      ggplot2::geom_abline()+
      ggplot2::geom_abline(linetype = "F1", size = 2,col = "#073b4c",
                           slope = metrica::B1.sma(obs,pred,orientation=orientation),
                           intercept = metrica::B0.sma(obs,pred,orientation=orientation))+
      ggplot2::labs(y = "Observed", x = "Predicted")+
      ggplot2::theme_bw()+
      ggplot2::theme(legend.position = "none",
                     panel.grid = ggplot2::element_blank())
} #IF END 
  return(plot)
}