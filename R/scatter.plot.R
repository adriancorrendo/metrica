#' @title scatter.plot
#' @description Scatter plot of Predictions and Observations.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
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
scatter.plot <- function(obs, pred){
  ggplot2::ggplot()+
    ggplot2::coord_fixed(xlim = c(round(min(c(min(pred),
                                              min(obs)))),
                                  round(max(c(max(pred),
                                              max(obs))))),
                         ylim = c(round(min(c(min(pred),
                                              min(obs)))),
                                  round(max(c(max(pred), 
                                              max(obs))))))+
    ggplot2::geom_point(ggplot2::aes(x = obs, y = pred), shape=21,
                        fill = "#861657", alpha = 0.65, size = 3)+
    ggplot2::geom_abline()+
    ggplot2::labs(x = "Observed", y = "Predicted")+
    ggplot2::theme_bw()+
    ggplot2::theme(legend.position = "none",
                   panel.grid = ggplot2::element_blank())
}
