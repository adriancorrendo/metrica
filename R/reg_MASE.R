#' @title Mean Absolute Scaled Error (MASE)
#' @name MASE
#' @description It estimates the mean absolute error using the naive-error approach
#' for a continuous predicted-observed dataset.
#' @param data (Required) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param time (Optional) String with the "name" of the vector containing the time variable
#' to sort observations. "Optional" to ensure an appropriate MASE estimation. 
#' Default: NULL, assumes observations are already sorted by time.
#' @param naive_step A positive number specifying how many observed values to recall
#' back in time when computing the naive expectation. Default = 1 
#' @param oob_mae A numeric value indicating the out-of-bag (out-of-sample) MAE.
#' By default, an _in-sample_ MAE is calculated using the naive forecast method.
#' See Hyndman & Koehler (2006). Default : NULL.
#' @param tidy Logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list; Default : FALSE.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The MASE is especially well suited for time series predictions. 
#' It can be used to compare forecast methods on a single series and also to 
#' compare forecast accuracy between series. 
#' 
#' This metric never gives an infinite or undefined values (unless all observations
#' over time are exactly the same!).
#' 
#' By default, the MASE scales the error based on _in-sample_ MAE from the naive forecast 
#' method (random walk). The in-sample MAE is used in the denominator because it is
#' always available and it effectively scales the errors.Since it is based on 
#' absolute error, it is less sensitive to outliers compared to the classic MSE.
#' 
#' \eqn{MASE = \frac{1}{n}(\frac{|O_i-P_i|}{ \frac{1}{T-1} \sum^T_{t=2}~|O_t - O_{t-1}| })}
#' 
#' If available, users may use and out-of-bag error from an independent dataset, which
#' can be specified with the `oob_mae` arg. and will replace the denominator into the MASE
#' equation.
#' 
#' MASE measures total error (i.e. both lack of accuracy and precision.). The lower 
#' the MASE below 1, the better the prediction quality. MASE = indicates no difference 
#' between the model and the naive forecast (or oob predictions). MASE > 1 indicate 
#' poor performance. 
#' 
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @references 
#' Hyndman, R.J., Koehler, A.B. (2006). 
#' Another look at measures of forecast accuracy. 
#' _ Int. J. Forecast_ \doi{10.3354/cr030079}
#' @examples 
#' \donttest{
#' set.seed(1)
#' # Create a fake dataset
#' X <- rnorm(n = 100, mean = 8, sd = 10)
#' Y <- rnorm(n = 100, mean = 8.2, sd = 15)
#' Z <- seq(1, 100, by = 1)
#' 
#' time_data <- as.data.frame(list("observed" = X, "predicted" = Y, "time" = Z))
#'  
#' MASE(data = time_data, obs = observed, pred = predicted, time = time)
#' }
#' @rdname MASE
#' @importFrom rlang enquo eval_tidy quo
#' @importFrom dplyr %>% arrange mutate 
#' @export 
MASE <- function(data = NULL, obs, pred, time = NULL, 
                 naive_step = 1, oob_mae = NULL, tidy = FALSE, na.rm = TRUE) {
  
  if (is.null(data)) {
       stop("For MASE estimation, the 'data' argument is required. Please, use a data frame containing observed, predicted, and time columns") }
  
  if (!is.null(time)) {
    #  stop("MASE is a metric for timeseries analysis. Please, specify the time argument to arrange observations.") 
  
  observ <- rlang::enquo(obs)
  
  data_arranged <- data %>% mutate(obs = !!observ) %>% dplyr::arrange(time)   
  
  #data_arranged <- data[with(data, order(time)), ]
 
  n <- nrow(data_arranged)
  # 
  # First and last observations to compute error
  init <- naive_step + 1
  final <- n - naive_step
  obs_naive <- data_arranged[["obs"]]
   
  # Errors
  sum_abs_err <- sum( abs(data_arranged[["obs"]] - data_arranged[["pred"]]) ) / n
  mae_naive <- sum( abs(obs_naive[init:n] - obs_naive[1:final]) ) / final }
  
  if (is.null(time)) { 
    
    n <- nrow(data)
     
    # First and last observations to compute error
    init <- naive_step + 1
    final <- n - naive_step
    obs_naive <- data[["obs"]]
    
    # Errors
    sum_abs_err <- sum( abs(data[["obs"]] - data[["pred"]]) ) / n
    mae_naive <- sum( abs(obs_naive[init:n] - obs_naive[1:final]) ) / final }
  
  # If out-of-bag MAE is not provided
  if (is.null(oob_mae)) {MASE <-  (sum_abs_err / mae_naive)}
  
  # If out-of-bag MAE IS provided
  if (!is.null(oob_mae)) {MASE <-  (sum_abs_err / oob_mae)}
  
  if (tidy==TRUE){ return(as.data.frame(MASE)) }
  
  if (tidy==FALSE){ return(list("MASE" = MASE)) }
}
