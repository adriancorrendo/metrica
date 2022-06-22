#' @title Prediction Performance Summary
#' @name metrics_summary
#' @description It estimates a group of metrics characterizing the prediction performance
#' for a continuous (regression) or categorical (classification) predicted-observed dataset. 
#' By default, it calculates all available metrics for either regression or classification.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs vector with observed values (numeric).
#' @param pred vector with predicted values (numeric).
#' @param type argument of class string specifying the type of model. For continuous
#' variables use _type = 'regression'_. For categorical variables use _type = 'classification'_.
#' @param metrics_list vector or list of specific selected metrics. Default is = NULL, 
#' which will estimate all metrics available for either regression or classification.
#' @param orientation argument of class string specifying the axis
#' orientation to estimate slope(B1) and intercept(B0). It only applies when type = "regression".
#' "PO" is for predicted vs observed, and "OP" for observed vs predicted.
#' Default is orientation = "PO".
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
#' # Continuous variable (regression)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 10)
#' regression_case <- data.frame(obs = X, pred = Y)
#' 
#' # Get a metrics summary for a regression problem
#' metrics_summary(regression_case, obs = X, pred = Y, type = "regression")
#' 
#' # Categorical variable (classification)
#' binomial_case <- data.frame(labels = sample(c("True","False"), 100, 
#' replace = TRUE), predictions = sample(c("True","False"), 100, replace = TRUE))
#' 
#' #' # Get a metrics summary for a regression problem
#' metrics_summary(binomial_case, obs = labels, pred = predictions,
#' type = "classification")
#' }
#' @rdname metrics_summary
#' @importFrom dplyr summarise %>%
#' @importFrom rlang eval_tidy quo 
#' @export 

metrics_summary <-
  function(data=NULL,
           obs,
           pred,
           type,
           metrics_list = NULL,
           orientation = "PO",
           na.rm = TRUE
           ){
    
    if (is.null(type) || !(type %in% c("regression", "classification") ) )
      stop("Type of model is either misspelled or not specified. Please, use type = 'regression' or type = 'classification'." )
    
    if (type == "regression"){
    
    metrics <- c("B0","B1","r","R2", "Xa","CCC","MAE","RMAE","MAPE","SMAPE",
                 "RAE","RSE","MBE","PBE","PAB","PPB","MSE","RMSE","RRMSE","RSR",
                 "iqRMSE","MLA","MLP","SB","SDSD","LCS","PLA","PLP","Ue","Uc",
                 "Ub","NSE","E1","Erel","KGE","d","d1","d1r","RAC","AC",
                 "lambda", "dcorr", "MIC")
    
    # Create data.frame to store metrics
    MetricDataFrame <- data.frame(`Metric` = metrics, 
                                  Score = 1:length(metrics),
                                  row.names = NULL)
    Metric <- NULL
    
    # Run the metrics
    MetricDataFrame["Score"] <- 
      rlang::eval_tidy(
        data=data,
        rlang::quo(
          c(
            B0 = as.numeric(metrica::B0_sma(data = {{data}},obs={{obs}}, pred={{pred}}, orientation = orientation)),
            B1 = as.numeric(metrica::B1_sma(data = {{data}},obs={{obs}}, pred={{pred}}, orientation = orientation)),
            r = as.numeric(metrica::r(data = {{data}},obs={{obs}}, pred={{pred}})),
            R2 = as.numeric(metrica::R2(data = {{data}},obs={{obs}}, pred={{pred}})),
            Xa = as.numeric(metrica::Xa(data = {{data}},obs={{obs}}, pred={{pred}})),
            CCC = as.numeric(metrica::CCC(data = {{data}},obs={{obs}}, pred={{pred}})),
            MAE =as.numeric(metrica::MAE(data = {{data}},obs={{obs}}, pred={{pred}})),
            RMAE =as.numeric(metrica::RMAE(data = {{data}},obs={{obs}}, pred={{pred}})),
            MAPE = as.numeric(metrica::MAPE(data = {{data}},obs={{obs}}, pred={{pred}})),
            SMAPE =as.numeric(metrica::SMAPE(data = {{data}},obs={{obs}}, pred={{pred}})),
            RAE =as.numeric(metrica::RAE(data = {{data}},obs={{obs}}, pred={{pred}})),
            RSE =as.numeric(metrica::RSE(data = {{data}},obs={{obs}}, pred={{pred}})),
            MBE =as.numeric(metrica::MBE(data = {{data}},obs={{obs}}, pred={{pred}})),
            PBE = as.numeric(metrica::PBE(data = {{data}},obs={{obs}}, pred={{pred}})),
            PAB = as.numeric(metrica::PAB(data = {{data}},obs={{obs}}, pred={{pred}})),
            PPB = as.numeric(metrica::PPB(data = {{data}},obs={{obs}}, pred={{pred}})),
            MSE = as.numeric(metrica::MSE(data = {{data}},obs={{obs}}, pred={{pred}})),
            RMSE =as.numeric(metrica::RMSE(data = {{data}},obs={{obs}}, pred={{pred}})),
            RRMSE =as.numeric(metrica::RRMSE(data = {{data}},obs={{obs}}, pred={{pred}})),
            RSR = as.numeric(metrica::RSR(data = {{data}},obs={{obs}}, pred={{pred}})),        
            iqRMSE =as.numeric(metrica::iqRMSE(data = {{data}},obs={{obs}}, pred={{pred}})),
            MLA =as.numeric(metrica::MLA(data = {{data}},obs={{obs}}, pred={{pred}})),
            MLP =as.numeric(metrica::MLP(data = {{data}},obs={{obs}}, pred={{pred}})),
            SB = as.numeric(metrica::SB(data = {{data}},obs={{obs}}, pred={{pred}})),
            SDSD = as.numeric(metrica::SDSD(data = {{data}},obs={{obs}}, pred={{pred}})),
            LCS = as.numeric(metrica::LCS(data = {{data}},obs={{obs}}, pred={{pred}})),
            PLA =as.numeric(metrica::PLA(data = {{data}},obs={{obs}}, pred={{pred}})),
            PLP =as.numeric(metrica::PLP(data = {{data}},obs={{obs}}, pred={{pred}})),
            Ue =as.numeric(metrica::Ue(data = {{data}},obs={{obs}}, pred={{pred}})),
            Uc =as.numeric(metrica::Uc(data = {{data}},obs={{obs}}, pred={{pred}})),
            Ub =as.numeric(metrica::Ub(data = {{data}},obs={{obs}}, pred={{pred}})),
            NSE = as.numeric(metrica::NSE(data = {{data}},obs={{obs}}, pred={{pred}})),
            E1 =as.numeric(metrica::E1(data = {{data}},obs={{obs}}, pred={{pred}})),
            Erel =as.numeric(metrica::Erel(data = {{data}},obs={{obs}}, pred={{pred}})),
            KGE = as.numeric(metrica::KGE(data = {{data}},obs={{obs}}, pred={{pred}})),
            d =as.numeric(metrica::d(data = {{data}},obs={{obs}}, pred={{pred}})),
            d1 =as.numeric(metrica::d1(data = {{data}},obs={{obs}}, pred={{pred}})),
            d1r =as.numeric(metrica::d1r(data = {{data}},obs={{obs}}, pred={{pred}})),
            RAC = as.numeric(metrica::RAC(data = {{data}},obs={{obs}}, pred={{pred}})),
            AC =as.numeric(metrica::AC(data = {{data}},obs={{obs}}, pred={{pred}})),
            lambda = as.numeric(metrica::lambda(data = {{data}},obs={{obs}}, pred={{pred}})),
            dcorr = as.numeric(metrica::dcorr(data = {{data}}, {{obs}}, {{pred}})),
            MIC = as.numeric(metrica::MIC(data = {{data}}, {{obs}}, {{pred}}))
          )
        )
      )
    }
    
    # Classification ---- 
    if (type == "classification"){
    
    metrics <- c("accuracy", "error_rate", "precision","recall","specificity", "baccu","fscore","cohen_kappa","mcc","fmi")
    
    # Create data.frame to store metrics
    MetricDataFrame <- data.frame(`Metric` = metrics, 
                                  Score = 1:length(metrics),
                                  row.names = NULL)
    Metric <- NULL
    
    # Run the metrics
    MetricDataFrame["Score"] <- 
      rlang::eval_tidy(
        data=data,
        rlang::quo(
          c(accuracy = as.numeric(metrica::accuracy(data={{data}}, obs={{obs}}, pred={{pred}})),
            error_rate = as.numeric(metrica::error_rate(data={{data}}, obs={{obs}}, pred={{pred}})),
            precision = as.numeric(metrica::precision(data={{data}}, obs={{obs}}, pred={{pred}})),
            recall = as.numeric(metrica::recall(data={{data}}, obs={{obs}}, pred={{pred}})),
            specificity = as.numeric(metrica::specificity(data={{data}}, obs={{obs}}, pred={{pred}})),
            baccu = as.numeric(metrica::baccu(data={{data}}, obs={{obs}}, pred={{pred}})),
            fscore = as.numeric(metrica::fscore(data={{data}}, obs={{obs}}, pred={{pred}})),
            cohen_kappa = as.numeric(metrica::cohen_kappa(data={{data}}, obs={{obs}}, pred={{pred}})),
            mcc = as.numeric(metrica::mcc(data={{data}}, obs={{obs}}, pred={{pred}})),
            fmi = as.numeric(metrica::fmi(data={{data}}, obs={{obs}}, pred={{pred}}))
            ) 
          ) 
        )
    
    }
    # Filter for metrics_list, if provided
    if (!is.null(metrics_list)) {
      MetricDataFrame <- dplyr::filter(MetricDataFrame, `Metric` %in% metrics_list)  }
    
    return(MetricDataFrame)
      
    }

