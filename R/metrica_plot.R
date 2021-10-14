#' @title metrica_plot
#' @description Scatter plot of Predictions and Observations.
#' @param obs Vector with observed values (numeric).
#' @param pre Vector with predicted values (numeric).
#' @return Object of class `ggplot`.
#' @details Creates a scatter plot of sim vs. obs.
#' @examples 
#' \dontrun{
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 10)
#' metrica_plot(obs = X, pre = Y)
#' }
#' @seealso 
#'  \code{\link[ggplot2]{ggplot}},\code{\link[ggplot2]{geom_point}},\code{\link[ggplot2]{aes}}
#' @rdname metrica_plot
#' @export 
#' @importFrom ggplot2 ggplot geom_point aes geom_abline
metrica_plot <- function(obs, pre){
  ggplot2::ggplot()+
    ggplot2::geom_point(ggplot2::aes(x = obs, y = pre))+
    ggplot2::geom_abline()
}
