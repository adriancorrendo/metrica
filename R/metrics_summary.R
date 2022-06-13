#' @title Prediction Performance Summary
#' @name metrics_summary
#' @description It estimates a group of metrics characterizing the prediction performance
#' for a continuous predicted-observed dataset. By default, it calculates all available metrics.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs vector with observed values (numeric).
#' @param pred vector with predicted values (numeric).
#' @param orientation argument of class string specifying the axis
#' orientation to estimate slope(B1) and intercept(B0).
#' "PO" is for predicted vs observed, and "OP" for observed vs predicted.
#' Default is orientation = "PO".
#' @param metrics_list vector or list of specific selected metrics. Default is = NULL, 
#' which will estimate all metrics available.
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `data.frame` containing all (or selected) metrics.
#' @details 
#' The user can choose to calculate a single metric, or to calculate all metrics at once.
#' This function creates a data.frame with all (or selected) metrics in the `metrica`-package.
#' If looking for specific metrics, the user can pass a list of desired metrics using the 
#' argument “metrics_list” (e.g. metrics_list = c("R2","MAE", "RMSE", "RSR", "NSE", "KGE")).
#' For the entire list of available metrics with formula, see [online documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' @examples 
#' \donttest{
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 10)
#' df <- data.frame(obs = X, pred = Y)
#' metrics_summary(df, obs = X, pred = Y)
#' }
#' @rdname metrics_summary
#' @importFrom dplyr summarise %>%
#' @importFrom rlang eval_tidy quo 
#' @export 

metrics_summary <-
  function(data=NULL,
           obs,
           pred,
           orientation = "PO",
           na.rm = TRUE,
           metrics_list = NULL){
    
    metrics <- c("B0","B1","r","R2", "Xa","CCC","MAE","RMAE","MAPE","SMAPE",
                 "RAE","RSE","MBE","PBE","PAB","PPB","MSE","RMSE","RRMSE","RSR",
                 "iqRMSE","MLA","MLP","SB","SDSD","LCS","PLA","PLP","Ue","Uc",
                 "Ub","NSE","E1","Erel","KGE","d","d1","d1r","RAC","AC",
                 "lambda", "dcorr", "MIC")
    
    # Create data.frame to store metrics
    newDataFrame <- data.frame(`Metric` = metrics, 
                               Score = 1:length(metrics),
                               row.names = NULL)
    Metric <- NULL
    
    # Run the metrics
    newDataFrame["Score"] <- 
      rlang::eval_tidy(
        data=data,
        rlang::quo(
          c(
            B0 = as.numeric(metrica::B0_sma({{data}},{{obs}},{{pred}}, orientation = orientation)),
            B1 = as.numeric(metrica::B1_sma({{data}},{{obs}},{{pred}}, orientation = orientation)),
            r = as.numeric(metrica::r({{data}},{{obs}},{{pred}})),
            R2 = as.numeric(metrica::R2({{data}},{{obs}},{{pred}})),
            Xa = as.numeric(metrica::Xa({{data}},{{obs}},{{pred}})),
            CCC = as.numeric(metrica::CCC({{data}},{{obs}},{{pred}})),
            MAE =as.numeric(metrica::MAE({{data}},{{obs}},{{pred}})),
            RMAE =as.numeric(metrica::RMAE({{data}},{{obs}},{{pred}})),
            MAPE = as.numeric(metrica::MAPE({{data}},{{obs}},{{pred}})),
            SMAPE =as.numeric(metrica::SMAPE({{data}},{{obs}},{{pred}})),
            RAE =as.numeric(metrica::RAE({{data}},{{obs}},{{pred}})),
            RSE =as.numeric(metrica::RSE({{data}},{{obs}},{{pred}})),
            MBE =as.numeric(metrica::MBE({{data}},{{obs}},{{pred}})),
            PBE = as.numeric(metrica::PBE({{data}},{{obs}},{{pred}})),
            PAB = as.numeric(metrica::PAB({{data}},{{obs}},{{pred}})),
            PPB = as.numeric(metrica::PPB({{data}},{{obs}},{{pred}})),
            MSE = as.numeric(metrica::MSE({{data}},{{obs}},{{pred}})),
            RMSE =as.numeric(metrica::RMSE({{data}},{{obs}},{{pred}})),
            RRMSE =as.numeric(metrica::RRMSE({{data}},{{obs}},{{pred}})),
            RSR = as.numeric(metrica::RSR({{data}},{{obs}},{{pred}})),        
            iqRMSE =as.numeric(metrica::iqRMSE({{data}},{{obs}},{{pred}})),
            MLA =as.numeric(metrica::MLA({{data}},{{obs}},{{pred}})),
            MLP =as.numeric(metrica::MLP({{data}},{{obs}},{{pred}})),
            SB = as.numeric(metrica::SB({{data}},{{obs}},{{pred}})),
            SDSD = as.numeric(metrica::SDSD({{data}},{{obs}},{{pred}})),
            LCS = as.numeric(metrica::LCS({{data}},{{obs}},{{pred}})),
            PLA =as.numeric(metrica::PLA({{data}},{{obs}},{{pred}})),
            PLP =as.numeric(metrica::PLP({{data}},{{obs}},{{pred}})),
            Ue =as.numeric(metrica::Ue({{data}},{{obs}},{{pred}})),
            Uc =as.numeric(metrica::Uc({{data}},{{obs}},{{pred}})),
            Ub =as.numeric(metrica::Ub({{data}},{{obs}},{{pred}})),
            NSE = as.numeric(metrica::NSE({{data}},{{obs}},{{pred}})),
            E1 =as.numeric(metrica::E1({{data}},{{obs}},{{pred}})),
            Erel =as.numeric(metrica::Erel({{data}},{{obs}},{{pred}})),
            KGE = as.numeric(metrica::KGE({{data}},{{obs}},{{pred}})),
            d =as.numeric(metrica::d({{data}},{{obs}},{{pred}})),
            d1 =as.numeric(metrica::d1({{data}},{{obs}},{{pred}})),
            d1r =as.numeric(metrica::d1({{data}},{{obs}},{{pred}})),
            RAC = as.numeric(metrica::RAC({{data}},{{obs}},{{pred}})),
            AC =as.numeric(metrica::AC({{data}},{{obs}},{{pred}})),
            lambda = as.numeric(metrica::lambda({{data}},{{obs}},{{pred}})),
            dcorr = as.numeric(metrica::dcorr({{data}}, {{obs}}, {{pred}})),
            MIC = as.numeric(metrica::MIC({{data}}, {{obs}}, {{pred}}))
          )
        )
      )
    
    # Filter for metrics_list, if provided
    if (!is.null(metrics_list)) {
      newDataFrame <- dplyr::filter(newDataFrame, `Metric` %in% metrics_list)  }
    
    return(newDataFrame)
    
  }
