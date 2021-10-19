#' @title metrics.summary
#' @description Scatter plot of Predictions and Observations.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param orientation Argument of class string specifying the axis
#' orientation to estimate slope(B1) and intercept(B0).
#' "PO" is for predicted vs observed, and "OP" for observed vs predicted.
#' Default is orientation = "PO".
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return Object of class `tibble`.
#' @details Creates a table with one colum per metric.
#' @examples 
#' \dontrun{
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- rnorm(n = 100, mean = 0, sd = 10)
#' metrics.summary(obs = X, pre = Y)
#' }
#' @rdname metrics.summary
#' @importFrom dplyr summarise
#' @importFrom tidyr pivot_longer everything
#' @export 
metrics.summary <-
  function(obs,
           pred,
           orientation = "PO",
           na.rm = TRUE){ 
    data.frame(obs = obs,
               pred = pred) |>
      summarise(
        B0 = as.numeric(metrica::B0.sma(obs,pred, orientation = orientation)),
        B1 = as.numeric(metrica::B1.sma(obs,pred, orientation = orientation)),
        R2 = as.numeric(metrica::R2(obs,pred)),
        CCC = as.numeric(metrica::CCC(obs,pred)),
        MAE =as.numeric(metrica::MAE(obs,pred)),
        MAPE = as.numeric(metrica::MAPE(obs,pred)),
        SMAPE =as.numeric(metrica::SMAPE(obs,pred)),
        RAE =as.numeric(metrica::RAE(obs,pred)),
        RSE =as.numeric(metrica::RSE(obs,pred)),
        MBE =as.numeric(metrica::MBE(obs,pred)),
        PBE = as.numeric(metrica::PBE(obs,pred)),
        PAB = as.numeric(metrica::PAB(obs,pred)),
        PPB = as.numeric(metrica::PPB(obs,pred)),
        MSE = as.numeric(metrica::MSE(obs,pred)),
        RMSE =as.numeric(metrica::RMSE(obs,pred)),
        RRMSE =as.numeric(metrica::RRMSE(obs,pred)),
        RSR = as.numeric(metrica::RSR(obs,pred)),
        iqRMSE =as.numeric(metrica::iqRMSE(obs,pred)),
        MLA =as.numeric(metrica::MLA(obs,pred)),
        MLP =as.numeric(metrica::MLP(obs,pred)),
        SB = as.numeric(metrica::SB(obs,pred)),
        SDSD = as.numeric(metrica::SDSD(obs,pred)),
        LCS = as.numeric(metrica::LCS(obs,pred)),
        PLA =as.numeric(metrica::PLA(obs,pred)),
        PLP =as.numeric(metrica::PLP(obs,pred)),
        Ue =as.numeric(metrica::Ue(obs,pred)),
        Uc =as.numeric(metrica::Uc(obs,pred)),
        Ub =as.numeric(metrica::Ub(obs,pred)),
        NSE = as.numeric(metrica::NSE(obs,pred)),
        E1 =as.numeric(metrica::E1(obs,pred)),
        Erel =as.numeric(metrica::Erel(obs,pred)),
        KGE = as.numeric(metrica::KGE(obs,pred)),
        d1 =as.numeric(metrica::d1(obs,pred)),
        RAC = as.numeric(metrica::RAC(obs,pred)),
        AC =as.numeric(metrica::AC(obs,pred)),
        lambda = as.numeric(metrica::lambda(obs,pred))
      ) |> 
      tidyr::pivot_longer(tidyr::everything(),
                          names_to = "Metric",
                          values_to = "value") 
  }



