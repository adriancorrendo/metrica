#' @title Bland-Altman plot 
#' @name bland_altman_plot
#' @description It creates a scatter plot of the difference between observed and predicted 
#' values (obs-pred) vs. observed values. 
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
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
    ggplot2::geom_point(shape=21,
                        fill = "#006d77", alpha = 0.65, size = 3)+
    ggplot2::geom_hline(yintercept = 0, col = "navy",
                        linetype = "solid", size = 2)+
    ggplot2::geom_hline(yintercept = 1.96*stats::sd(obs),
                        col = "dark red", linetype = "dashed", size = 1.25)+
    ggplot2::geom_hline(yintercept = -1.96*stats::sd(obs),
                        col = "dark red", linetype = "dashed", size = 1.25)+
    ggplot2::labs(x = "Observed", y = "Observed - Predicted")+
    ggplot2::theme_bw()+
    ggplot2::theme(legend.position = "none",
                   panel.grid = ggplot2::element_blank())
    )
  )
  return(plot)
}