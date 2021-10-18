#' @title tiles.plot
#' @description Scatter plot of Predictions and Observations.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param bins Argument of class numeric specifying the number
#' of tile color groups.
#' @return Object of class `ggplot`.
#' @details Creates a scatter plot of sim vs. obs.
#' @examples 
#' \dontrun{
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 10)
#' tiles.plot(obs = X, pre = Y)
#' }
#' @seealso 
#'  \code{\link[ggplot2]{ggplot}},\code{\link[ggplot2]{geom_point}},\code{\link[ggplot2]{aes}}
#' @rdname tiles.plot
#' @export 
#' @importFrom ggplot2 ggplot geom_point aes geom_abline geom_hex
#' coord_fixed theme_bw labs
#' @importFrom viridis scale_fill_viridis
tiles.plot <- function(obs, pred, bins = 10){
  ggplot2::ggplot()+
    ggplot2::coord_fixed(xlim = c(round(min(c(min(pred),
                                              min(obs)))),
                                  round(max(c(max(pred),
                                              max(obs))))),
                         ylim = c(round(min(c(min(pred),
                                              min(obs)))),
                                  round(max(c(max(pred), 
                                              max(obs))))))+
    ggplot2::geom_hex(ggplot2::aes(x = obs, y = pred),
             bins = bins, color = "grey20", size=0.15)+
    viridis::scale_fill_viridis(option = "viridis", direction = -1)+
    ggplot2::geom_abline()+
    ggplot2::labs(x = "Observed", y = "Predicted")+
    ggplot2::theme_bw()+
    ggplot2::theme(legend.position = "none",
                   panel.grid = ggplot2::element_blank())
}
