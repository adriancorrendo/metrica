#' @title scatter.metrics
#' @description Creates a scatterplot with an embedded table displaying up to 5 metrics and the regression line
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param metrics Vector with up to 5 metrics to be displayed on the plot. Defaults to "R2","RMSE","MAE","NSE", and "CCC".
#'
#' @return Object of class `ggplot`
#' @export
#' @importFrom ggplot2 ggplot geom_point aes geom_abline labs theme_bw
#' theme
#' @importFrom dplyr %>%
#' @importFrom ggpp annotate
#' @examples
scatter.metrics <- function(data = NULL, 
                            obs, 
                            pred,
                            metrics=c("R2","RMSE","MAE","NSE","CCC")) {
  
  # Plot
  plot <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      metrica::scatter.plot(data = {{data}},
                            obs = {{obs}},
                            pred = {{pred}})
    )
  )
  
  # Metrics summary long
  metrics.sum <- rlang::eval_tidy(
    data = data,
    rlang::quo(metrica::metrics.summary(data = {{data}},
                                        obs = {{obs}}, 
                                        pred = {{pred}})
    )
  )
  
  # Reduced performance table for ggplot
  perf.table <- metrics.sum %>%
    # Apply a filter to keep only the selected metrics
    dplyr::filter(Metric %in% metrics) %>% 
    # Round numbers for clarity
    dplyr::mutate_if(base::is.numeric,~base::round(.,2)) %>%
    dplyr::mutate(Metric=base::factor(Metric,
                                      levels=metrics))
  
  # SMA coefficients
  B0 <- metrics.sum %>%
    dplyr::filter(Metric == "B0") %>%
    dplyr::select(Score) %>%
    base::as.numeric() %>%
    base::round(2)
  
  B1 <- metrics.sum %>% 
    dplyr::filter(Metric == "B1") %>%
    dplyr::select(Score) %>%
    base::as.numeric() %>%
    base::round(2)
  
  # Plot + selected metrics + SMA coefficients
  scatter.metrics.plot <- rlang::eval_tidy(
    data = data,
    rlang::quo( plot + 
                  # Annotate Table
                  ggpp::annotate(geom="table", 
                                 # Position
                                 x = min({{obs}}), 
                                 y = 1.05*max({{pred}}),
                                 # Call the table
                                 label = perf.table,
                                 # Align Table (left)
                                 hjust = 0, vjust = 1)+
                  # Add SMA equation
                  ggpp::annotate(geom="text", 
                                x=0.75*max({{obs}}), 
                                y= 1.25*min({{pred}}),
                                # Equation
                                label = paste0("y = ",B0,"+",B1,"x"), 
                                hjust=0)
    )
  )
  
  return(scatter.metrics.plot)
  
}
