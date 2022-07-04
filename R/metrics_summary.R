#' @title Prediction Performance Summary
#' @name metrics_summary
#' @description It estimates a group of metrics characterizing the prediction performance
#' for a continuous (regression) or categorical (classification) predicted-observed dataset. 
#' By default, it calculates all available metrics for either regression or classification.
#' @param data argument to call an existing data frame containing the data (optional).
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
#' @param pos_level (for classification only). Integer, for binary cases, indicating the order (1|2) of the level 
#' corresponding to the positive. Generally, the positive level is the second (2)
#' since following an alpha-numeric order, the most common pairs are 
#' `(Negative | Positive)`, `(0 | 1)`, `(FALSE | TRUE)`. Default : 2.
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
           type = NULL,
           metrics_list = NULL,
           orientation = "PO",
           pos_level = 2,
           na.rm = TRUE
           ){
    
    if (is.null(type) || !(type %in% c("regression", "classification") ) )
      stop("Type of model is either misspelled or not specified. Please, use type = 'regression' or type = 'classification'." )
    
    if (type == "regression"){
      
      metrics <- c("B0","B1","r","R2", "Xa","CCC","MAE","RMAE","MAPE","SMAPE", #"MASE", 
                   "RAE","RSE","MBE","PBE","PAB","PPB","MSE","RMSE","RRMSE", "RSR",
                   "iqRMSE","MLA","MLP", "RMLA", "RMLP", "SB","SDSD","LCS",
                   "PLA", "PLP","Ue","Uc","Ub","NSE","E1","Erel","KGE","d",
                   "d1", "d1r","RAC","AC","lambda", "dcorr", "MIC")
      
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
              B0 = as.numeric(metrica::B0_sma(data = {{data}},obs={{obs}}, pred={{pred}}, orientation = orientation)[[1]]),
              B1 = as.numeric(metrica::B1_sma(data = {{data}},obs={{obs}}, pred={{pred}}, orientation = orientation)[[1]]),
              r = as.numeric(metrica::r(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              R2 = as.numeric(metrica::R2(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              Xa = as.numeric(metrica::Xa(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              CCC = as.numeric(metrica::CCC(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              MAE =as.numeric(metrica::MAE(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              RMAE =as.numeric(metrica::RMAE(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              MAPE = as.numeric(metrica::MAPE(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              SMAPE =as.numeric(metrica::SMAPE(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              # The MASE function doesn't work yet within the summary function.
              #MASE = as.numeric(metrica::MASE(data = {{data}}, {{obs}}, {{pred}}, time = {{time}})[[1]]),
              RAE =as.numeric(metrica::RAE(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              RSE =as.numeric(metrica::RSE(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              MBE =as.numeric(metrica::MBE(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              PBE = as.numeric(metrica::PBE(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              PAB = as.numeric(metrica::PAB(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              PPB = as.numeric(metrica::PPB(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              MSE = as.numeric(metrica::MSE(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              RMSE =as.numeric(metrica::RMSE(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              RRMSE =as.numeric(metrica::RRMSE(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              RSR = as.numeric(metrica::RSR(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),        
              iqRMSE =as.numeric(metrica::iqRMSE(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              MLA =as.numeric(metrica::MLA(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              MLP =as.numeric(metrica::MLP(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              RMLA =as.numeric(metrica::RMLA(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              RMLP =as.numeric(metrica::RMLP(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              SB = as.numeric(metrica::SB(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              SDSD = as.numeric(metrica::SDSD(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              LCS = as.numeric(metrica::LCS(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              PLA =as.numeric(metrica::PLA(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              PLP =as.numeric(metrica::PLP(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              Ue =as.numeric(metrica::Ue(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              Uc =as.numeric(metrica::Uc(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              Ub =as.numeric(metrica::Ub(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              NSE = as.numeric(metrica::NSE(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              E1 =as.numeric(metrica::E1(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              Erel =as.numeric(metrica::Erel(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              KGE = as.numeric(metrica::KGE(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              d =as.numeric(metrica::d(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              d1 =as.numeric(metrica::d1(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              d1r =as.numeric(metrica::d1r(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              RAC = as.numeric(metrica::RAC(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              AC =as.numeric(metrica::AC(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              lambda = as.numeric(metrica::lambda(data = {{data}},obs={{obs}}, pred={{pred}})[[1]]),
              dcorr = as.numeric(metrica::dcorr(data = {{data}}, {{obs}}, {{pred}})[[1]]),
              MIC = as.numeric(metrica::MIC(data = {{data}}, {{obs}}, {{pred}})[[1]])
            )
          )
        )
    }
    
    # Classification ---- 
    if (type == "classification"){
    
    metrics <- c("accuracy", "error_rate", "precision","recall","specificity",
                 "balacc","fscore","agf","gmean", "khat",
                 "mcc", "fmi", "bmi", "csi", "deltap", 
                 "posLr", "negLr", "dor", "npv", "FPR", 
                 "FNR", "FDR", "FOR", "preval", "preval_t",
                 "AUC_roc"
                 )
    
    # Create data.frame to store metrics
    MetricDataFrame <- data.frame(`Metric` = metrics, 
                                  Score = 1:length(metrics),
                                  row.names = NULL)
    Metric <- NULL
    
    # Run the metrics
    MetricDataFrame["Score"] <- 
      rlang::eval_tidy(
        data = data,
        rlang::quo(
          c(#1
            accuracy = as.numeric(metrica::accuracy(data={{data}}, obs={{obs}}, pred={{pred}})[[1]]),
            error_rate = as.numeric(metrica::error_rate(data={{data}}, obs={{obs}}, pred={{pred}})[[1]]),
            precision = as.numeric(metrica::precision(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            recall = as.numeric(metrica::recall(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            specificity = as.numeric(metrica::specificity(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            balacc = as.numeric(metrica::balacc(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            fscore = as.numeric(metrica::fscore(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            agf = as.numeric(metrica::agf(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            gmean = as.numeric(metrica::gmean(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            khat = as.numeric(metrica::khat(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            #11
            mcc = as.numeric(metrica::mcc(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            fmi = as.numeric(metrica::fmi(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            bmi = as.numeric(metrica::bmi(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            csi = as.numeric(metrica::csi(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            deltap = as.numeric(metrica::deltap(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            posLr = as.numeric(metrica::posLr(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            negLr = as.numeric(metrica::negLr(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            dor = as.numeric(metrica::dor(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            npv = as.numeric(metrica::npv(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            FPR = as.numeric(metrica::FPR(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            #21
            FNR = as.numeric(metrica::FNR(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            FDR = as.numeric(metrica::FDR(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            FOR = as.numeric(metrica::FOR(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            preval = as.numeric(metrica::preval(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            preval_t = as.numeric(metrica::preval_t(data={{data}}, obs={{obs}}, pred={{pred}}, pos_level = pos_level)[[1]]),
            AUC_roc = as.numeric(metrica::AUC_roc(data={{data}}, obs={{obs}}, pred={{pred}})[[1]])
            ) 
          ) 
        )
    
    }
    # Filter for metrics_list, if provided
    if (!is.null(metrics_list)) {
      MetricDataFrame <- dplyr::filter(MetricDataFrame, `Metric` %in% metrics_list)  }
    
    return(MetricDataFrame)
      
    }

