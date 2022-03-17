#' @title bland.altman.plot
#' @description Bland-Altman plot.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param na.rm Logic argument to remove rows with missing values
#' @return Object of class `ggplot`.
#' @details Creates a scatter plot of the difference between
#' observed and predicted values (obs-pred) vs. observed values.
#' @examples 
#' \dontrun{
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 10)
#' blandaltman.plot(obs = X, pre = Y)
#' }
#' @seealso 
#'  \code{\link[ggplot2]{ggplot}},\code{\link[ggplot2]{geom_point}},\code{\link[ggplot2]{aes}}
#' @rdname bland.altman.plot
#' @export 
#' @importFrom ggplot2 ggplot geom_point aes geom_abline labs theme_bw
#' theme
#' @importFrom dplyr %>%
#' @importFrom rlang eval_tidy quo  
bland.altman.plot <- function(data=NULL,
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