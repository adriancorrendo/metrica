# Test import_apsim_out

out.file <- testthat::test_path("examples", "soybean.out")
import_apsim_out.test <- import_apsim_out(filepath = out.file)

test_that('no error import_apsim_out', {
  expect_false(inherits(import_apsim_out.test, "try-error"))
})

# Test import_apsim_db

db.loc <- testthat::test_path("examples")
#empty.loc <- testthat::test_path("empty")
import_apsim_db.test_1 <- import_apsim_db(filename = "soybean.example.db",  folder = db.loc)
import_apsim_db.test_2 <- try(import_apsim_db(filename = "",  folder = db.loc), silent = TRUE)
import_apsim_db.test_3 <- import_apsim_db(filename = "soybean.example.db",  folder = db.loc, value = "all")

# TEST
test_that('no error import_apsim_db', { expect_false(inherits(import_apsim_db.test_1, "try-error")) })
test_that("stop", { expect_true(inherits(import_apsim_db.test_2, "try-error")) })
test_that('no error import_apsim_db', { expect_false(inherits(import_apsim_db.test_3, "try-error")) })

# Data for metrics
data('wheat')

# 1. Metrics summary
metrics_summary.test <- metrics_summary(obs = wheat$obs, pred = wheat$pred, orientation = "PO", type = "regression")
test_that('no error metrics_summary', { expect_false(inherits(metrics_summary.test, "try-error")) })

metrics_summary.test_stop <- try(metrics_summary(obs = wheat$obs, pred = wheat$pred, orientation = "PO"), silent = TRUE)
test_that("stop", { expect_true(inherits(metrics_summary.test_stop, "try-error")) })

# 2. Scatter plot

scatter_plot.test.stop <- scatter_plot(obs = wheat$obs, pred = wheat$pred, print_metrics = TRUE, metrics_list = NULL)
#test_that('stop', code = {expect_error(scatter_plot.test.stop, "stop", ignore.case = TRUE)})
test_that('warning', {expect_warning(scatter_plot.test.stop, NA)})

scatter_plot.test.PO <- scatter_plot(obs = wheat$obs, pred = wheat$pred, orientation = "PO")
test_that('no error scatter_plot', {expect_false(inherits(scatter_plot.test.PO, "try-error")) })

scatter_plot.test.OP <- scatter_plot(obs = wheat$obs, pred = wheat$pred, orientation = "OP")
test_that('no error scatter_plot', {expect_false(inherits(scatter_plot.test.OP, "try-error")) })

scatter_plot.test.metrics <- scatter_plot(obs = wheat$obs, pred = wheat$pred, print_metrics = TRUE, metrics_list = c("R2", "MSE"))
test_that('no error scatter_plot', {expect_false(inherits(scatter_plot.test.metrics, "try-error")) })

# 3. Tiles plot

tiles_plot.test.stop <- tiles_plot(obs = wheat$obs, pred = wheat$pred, print_metrics = TRUE, metrics_list = NULL)
#test_that('stop', code = {expect_error(tiles_plot.test.stop, "stop", ignore.case = TRUE)})
test_that('warning', {expect_warning(tiles_plot.test.stop, NA)})

tiles_plot.test.PO <- tiles_plot(obs = wheat$obs, pred = wheat$pred, orientation = "PO")
test_that('no error tiles_plot', {expect_false(inherits(tiles_plot.test.PO, "try-error")) })

tiles_plot.test.OP <- tiles_plot(obs = wheat$obs, pred = wheat$pred,orientation = "OP")
test_that('no error tiles_plot', {expect_false(inherits(tiles_plot.test.OP, "try-error"))})

tiles_plot.test.metrics <- tiles_plot(obs = wheat$obs, pred = wheat$pred, print_metrics = TRUE, metrics_list = c("R2", "MSE"))
test_that('no error scatter_plot', {expect_false(inherits(tiles_plot.test.metrics, "try-error")) })

tiles_plot.test_colors <- tiles_plot(obs = wheat$obs, pred = wheat$pred, orientation = "PO", colors = c(low = "red", high = "blue") )
test_that('no error tiles_plot', {expect_false(inherits(tiles_plot.test_colors, "try-error")) })

tiles_plot.test_colors_OP <- tiles_plot(obs = wheat$obs, pred = wheat$pred, orientation = "OP", colors = c(low = "red", high = "blue") )
test_that('no error tiles_plot', {expect_false(inherits(tiles_plot.test_colors_OP, "try-error")) })

# 4. Density plot

density_plot.test.stop <- density_plot(obs = wheat$obs, pred = wheat$pred, print_metrics = TRUE)
#test_that('stop', code = {expect_error(density_plot.test.stop, "stop", ignore.case = TRUE)}) 
test_that('warning', {expect_warning(density_plot.test.stop, NA)})

density_plot.test.PO <- density_plot(obs = wheat$obs, pred = wheat$pred, orientation = "PO")
test_that('no error density_plot', {expect_false(inherits(density_plot.test.PO, "try-error"))})

density_plot.test.OP <- density_plot(obs = wheat$obs, pred = wheat$pred, orientation = "OP")
test_that('no error density_plot', {expect_false(inherits(density_plot.test.OP, "try-error"))})

density_plot.test_colors <- density_plot(obs = wheat$obs, pred = wheat$pred, orientation = "PO", colors = c(low = "red", high = "blue") )
test_that('no error density_plot', {expect_false(inherits(density_plot.test_colors, "try-error")) })

density_plot.test_colors_OP <- density_plot(obs = wheat$obs, pred = wheat$pred, orientation = "OP", colors = c(low = "red", high = "blue") )
test_that('no error density_plot', {expect_false(inherits(density_plot.test_colors_OP, "try-error")) })

# 5. Bland-Altman plot
bland_altman_plot.test <- bland_altman_plot(obs = wheat$obs, pred = wheat$pred)
test_that('no error bland_altman_plot', { expect_false(inherits(bland_altman_plot.test, "try-error")) })

# 6. uSD
uSD.test <- uSD(x = wheat$obs)
test_that('no error uSD', { expect_false(inherits(uSD.test, "try-error")) })

uSD.test.tidy <- uSD(x = wheat$obs, tidy = TRUE)
test_that('no error uSD', { expect_false(inherits(uSD.test.tidy , "try-error")) })

# 7. var_u
var_u.test <- var_u(x = wheat$obs)
test_that('no error var_u', { expect_false(inherits(var_u.test, "try-error")) })

var_u.test.tidy <- var_u(x = wheat$obs, tidy = TRUE)
test_that('no error var_u', { expect_false(inherits(var_u.test.tidy , "try-error")) })

# 8. RSS
RSS.test <- RSS(obs = wheat$obs, pred = wheat$pred)
test_that('no error RSS', { expect_false(inherits(RSS.test, "try-error")) })

RSS.test.tidy <- RSS(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error RSS', { expect_false(inherits(RSS.test.tidy , "try-error")) })

# 9. TSS
TSS.test <- TSS(obs = wheat$obs)
test_that('no error TSS', { expect_false(inherits(TSS.test, "try-error")) })

TSS.test.tidy <- TSS(obs = wheat$obs, tidy = TRUE)
test_that('no error TSS', { expect_false(inherits(TSS.test.tidy , "try-error")) })

# 10. RSE
RSE.test <- RSE(obs = wheat$obs, pred = wheat$pred)
test_that('no error RSE', { expect_false(inherits(RSE.test, "try-error")) })

RSE.test.tidy <- RSE(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error RSE', { expect_false(inherits(RSE.test.tidy , "try-error")) })

# 11. RAE
RAE.test <- RAE(obs = wheat$obs, pred = wheat$pred)
test_that('no error RAE', { expect_false(inherits(RAE.test, "try-error")) })

RAE.test.tidy <- RAE(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error RAE', { expect_false(inherits(RAE.test.tidy , "try-error")) })

# 12. r
r.test_tidy <- r(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error r', {expect_false(inherits(r.test_tidy, "try-error"))})

# 13. R2
R2.test <- R2(obs = wheat$obs, pred = wheat$pred)
test_that('no error R2', {expect_false(inherits(R2.test, "try-error")) })

R2.test.tidy <- R2(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error R2', {expect_false(inherits(R2.test.tidy , "try-error")) })

# 14. B0
B0_sma.test.PO <- B0_sma(obs = wheat$obs, pred = wheat$pred, orientation = "PO")
test_that('no error B0_sma', {expect_false(inherits(B0_sma.test.PO, "try-error")) })

B0_sma.test.OP <- B0_sma(obs = wheat$obs, pred = wheat$pred, orientation = "OP")
test_that('no error B0_sma', {expect_false(inherits(B0_sma.test.OP, "try-error"))})

B0_sma.test.PO_tidy <- B0_sma(obs = wheat$obs, pred = wheat$pred, orientation = "PO", tidy = TRUE)
test_that('no error B0_sma', {expect_false(inherits(B0_sma.test.PO_tidy, "try-error")) })

B0_sma.test.OP_tidy <- B0_sma(obs = wheat$obs, pred = wheat$pred, orientation = "OP", tidy = TRUE)
test_that('no error B0_sma', {expect_false(inherits(B0_sma.test.OP_tidy, "try-error"))})

# 15. B1
B1_sma.test.PO <- B1_sma(obs = wheat$obs, pred = wheat$pred, orientation = "PO")
test_that('no error B1_sma', {expect_false(inherits(B1_sma.test.PO, "try-error"))})

B1_sma.test.OP <- B1_sma(obs = wheat$obs, pred = wheat$pred, orientation = "OP")
test_that('no error B1_sma', {expect_false(inherits(B1_sma.test.OP, "try-error"))})

B1_sma.test.PO_tidy <- B1_sma(obs = wheat$obs, pred = wheat$pred_tidy, orientation = "PO", tidy = TRUE)
test_that('no error B1_sma', {expect_false(inherits(B1_sma.test.PO, "try-error"))})

B1_sma.test.OP_tidy <- B1_sma(obs = wheat$obs, pred = wheat$pred, orientation = "OP", tidy = TRUE)
test_that('no error B1_sma', {expect_false(inherits(B1_sma.test.OP_tidy, "try-error"))})

# 16. MBE
MBE.test <- MBE(obs = wheat$obs, pre = wheat$pred)
test_that('no error MBE', { expect_false(inherits(MBE.test, "try-error"))})

MBE.test.tidy <- MBE(obs = wheat$obs, pre = wheat$pred, tidy = TRUE)
test_that('no error MBE', { expect_false(inherits(MBE.test.tidy , "try-error"))})

# 17. MSE
MSE.test <- MSE(obs = wheat$obs, pred = wheat$pred)
test_that('no error MSE', { expect_false(inherits(MSE.test, "try-error"))})

MSE.test.tidy <- MSE(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error MSE', { expect_false(inherits(MSE.test.tidy , "try-error"))})

# 18. RMSE
RMSE.test <- RMSE(obs = wheat$obs, pred = wheat$pred)
test_that('no error RMSE', {expect_false(inherits(RMSE.test, "try-error"))})

RMSE.test.tidy <- RMSE(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error RMSE', {expect_false(inherits(RMSE.test.tidy , "try-error"))})

# 19. iqRMSE
iqRMSE.test <- iqRMSE(obs = wheat$obs, pred = wheat$pred)
test_that('no error iqRMSE', {expect_false(inherits(iqRMSE.test, "try-error"))})

iqRMSE.test.tidy <- iqRMSE(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error iqRMSE', {expect_false(inherits(iqRMSE.test.tidy , "try-error"))})

# 20. Xa
Xa.test <- Xa(obs = wheat$obs, pred = wheat$pred)
test_that('no error Xa', {expect_false(inherits(Xa.test, "try-error"))})

Xa.test.tidy <- Xa(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error Xa', {expect_false(inherits(Xa.test.tidy , "try-error"))})

# 21. MLA
MLA.test <- MLA(obs = wheat$obs, pred = wheat$pred)
test_that('no error MLA', {expect_false(inherits(MLA.test, "try-error"))})

MLA.test.tidy <- MLA(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error MLA', {expect_false(inherits(MLA.test.tidy , "try-error"))})

# 22. MLP
MLP.test <- MLP(obs = wheat$obs, pred = wheat$pred)
test_that('no error MLP', {expect_false(inherits(MLP.test, "try-error"))})

MLP.test.tidy <- MLP(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error MLP', {expect_false(inherits(MLP.test.tidy , "try-error"))})

# 23. RMLA
RMLA.test <- RMLA(obs = wheat$obs, pred = wheat$pred)
test_that('no error RMLA', {expect_false(inherits(RMLA.test, "try-error"))})

RMLA.test.tidy <- RMLA(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error RMLA', {expect_false(inherits(RMLA.test.tidy , "try-error"))})

# 24. RMLP
RMLP.test <- RMLP(obs = wheat$obs, pred = wheat$pred)
test_that('no error RMLP', {expect_false(inherits(RMLP.test, "try-error"))})

RMLP.test.tidy <- RMLP(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error RMLP', {expect_false(inherits(RMLP.test.tidy , "try-error"))})

# 25. PLA
PLA.test <- PLA(obs = wheat$obs, pred = wheat$pred)
test_that('no error PLA', {expect_false(inherits(PLA.test, "try-error"))})

PLA.test.tidy <- PLA(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error PLA', {expect_false(inherits(PLA.test.tidy , "try-error"))})

# 26. PLP
PLP.test <- PLP(obs = wheat$obs, pred = wheat$pred)
test_that('no error PLP', {expect_false(inherits(PLP.test, "try-error"))})

PLP.test.tidy <- PLP(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error PLP', {expect_false(inherits(PLP.test.tidy , "try-error"))})

# 27. LCS
LCS.test <- LCS(obs = wheat$obs, pred = wheat$pred)
test_that('no error LCS', {expect_false(inherits(LCS.test, "try-error"))})

LCS.test.tidy <- LCS(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error LCS', {expect_false(inherits(LCS.test.tidy , "try-error"))})

# 28. Uc
Uc.test <- Uc(obs = wheat$obs, pred = wheat$pred)
test_that('no error UC', {expect_false(inherits(Uc.test, "try-error"))})

Uc.test.tidy <- Uc(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error UC', {expect_false(inherits(Uc.test.tidy , "try-error"))})

# 29. Ue
Ue.test <- Ue(obs = wheat$obs, pred = wheat$pred)
test_that('no error Ue', {expect_false(inherits(Ue.test, "try-error"))})

Ue.test.tidy <- Ue(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error Ue', {expect_false(inherits(Ue.test.tidy , "try-error"))})

# 30. Ub
Ub.test <- Ub(obs = wheat$obs, pred = wheat$pred)
test_that('no error Ub', {expect_false(inherits(Ub.test, "try-error"))})

Ub.test.tidy <- Ub(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error Ub', {expect_false(inherits(Ub.test.tidy , "try-error"))})

# 31. CCC
CCC.test <- CCC(obs = wheat$obs, pred = wheat$pred)
test_that('no error CCC', {expect_false(inherits(CCC.test, "try-error"))})

CCC.test.tidy <- CCC(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error CCC', {expect_false(inherits(CCC.test.tidy , "try-error"))})

# 32. PAB
PAB.test <- PAB(obs = wheat$obs, pred = wheat$pred)
test_that('no error PAB', {expect_false(inherits(PAB.test, "try-error"))})

PAB.test.tidy <- PAB(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error PAB', {expect_false(inherits(PAB.test.tidy , "try-error"))})

# 33. PPB
PPB.test <- PPB(obs = wheat$obs, pred = wheat$pred)
test_that('no error PPB', {expect_false(inherits(PPB.test, "try-error"))})

PPB.test.tidy <- PPB(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error PPB', {expect_false(inherits(PPB.test.tidy , "try-error"))})

# 34. MAE
MAE.test <- MAE(obs = wheat$obs, pred = wheat$pred)
test_that('no error MAE', {expect_false(inherits(MAE.test, "try-error"))})

MAE.test.tidy <- MAE(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error MAE', {expect_false(inherits(MAE.test.tidy , "try-error"))})

# 35. RMAE
RMAE.test <- RMAE(obs = wheat$obs, pred = wheat$pred)
test_that('no error RMAE', {expect_false(inherits(RMAE.test, "try-error"))})

RMAE.test.tidy <- RMAE(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error RMAE', {expect_false(inherits(RMAE.test.tidy , "try-error"))})

# 36. MAPE
MAPE.test <- MAPE(obs = wheat$obs, pred = wheat$pred)
test_that('no error MAPE', {expect_false(inherits(MAPE.test, "try-error"))})

MAPE.test.tidy <- MAPE(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error MAPE', {expect_false(inherits(MAPE.test.tidy , "try-error"))})

# 37. SMAPE
SMAPE.test <- SMAPE(obs = wheat$obs, pred = wheat$pred)
test_that('no error SMAPE', {expect_false(inherits(SMAPE.test, "try-error"))})

SMAPE.test.tidy <- SMAPE(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error SMAPE', {expect_false(inherits(SMAPE.test.tidy , "try-error"))})

# 38. PBE
PBE.test <- PBE(obs = wheat$obs, pred = wheat$pred)
test_that('no error PBE', {expect_false(inherits(PBE.test, "try-error"))})

PBE.test.tidy <- PBE(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error PBE', {expect_false(inherits(PBE.test.tidy , "try-error"))})

# 39. RSR
RSR.test <- RSR(obs = wheat$obs, pred = wheat$pred)
test_that('no error RSR', {expect_false(inherits(RSR.test, "try-error"))})

RSR.test.tidy <- RSR(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error RSR', {expect_false(inherits(RSR.test.tidy , "try-error"))})

# 40. NSE
NSE.test <- NSE(obs = wheat$obs, pred = wheat$pred)
test_that('no error NSE', {expect_false(inherits(NSE.test, "try-error"))})

NSE.test.tidy <- NSE(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error NSE', {expect_false(inherits(NSE.test.tidy , "try-error"))})

# 41. E1
E1.test <- E1(obs = wheat$obs, pred = wheat$pred)
test_that('no error E1', {expect_false(inherits(E1.test, "try-error"))})

E1.test.tidy <- E1(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error E1', {expect_false(inherits(E1.test.tidy , "try-error"))})

# 42. Erel
Erel.test <- Erel(obs = wheat$obs, pred = wheat$pred)
test_that('no error Erel', {expect_false(inherits(Erel.test, "try-error"))})

Erel.test.tidy <- Erel(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error Erel', {expect_false(inherits(Erel.test.tidy , "try-error"))})

# 43. KGE
KGE.test <- KGE(obs = wheat$obs, pred = wheat$pred)
test_that('no error KGE', {  expect_false(inherits(KGE.test, "try-error")) })

KGE.test.tidy <- KGE(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error KGE', {  expect_false(inherits(KGE.test.tidy , "try-error")) })

# 44. RAC
RAC.test <- RAC(obs = wheat$obs, pred = wheat$pred)
test_that('no error RAC', {  expect_false(inherits(RAC.test, "try-error")) })

RAC.test.tidy <- RAC(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error RAC', {  expect_false(inherits(RAC.test.tidy , "try-error")) })

# 45. d
d.test <- d(obs = wheat$obs, pred = wheat$pred)
test_that('no error d', {  expect_false(inherits(d.test, "try-error")) })

d.test.tidy <- d(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error d', {  expect_false(inherits(d.test.tidy , "try-error")) })

# 46. d1
d1.test <- d1(obs = wheat$obs, pred = wheat$pred)
test_that('no error d1', { expect_false(inherits(d1.test, "try-error")) })

d1.test.tidy <- d1(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error d1', { expect_false(inherits(d1.test.tidy , "try-error")) })

# 47. d1r
d1r.test <- d1r(obs = wheat$obs, pred = wheat$pred)
test_that('no error d1r', { expect_false(inherits(d1r.test, "try-error")) })

d1r.test.tidy <- d1r(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error d1r', { expect_false(inherits(d1r.test.tidy , "try-error")) })

# 48. AC
AC.test <- AC(obs = wheat$obs, pred = wheat$pred)
test_that('no error AC', {expect_false(inherits(AC.test, "try-error"))})

AC.test.tidy <- AC(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error AC', {expect_false(inherits(AC.test.tidy , "try-error"))})

# 49. lambda
lambda.test <- lambda(obs = wheat$obs, pred = wheat$pred)
test_that('no error lambda', {expect_false(inherits(lambda.test, "try-error"))})

lambda.test.tidy <- lambda(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error lambda', {expect_false(inherits(lambda.test.tidy , "try-error"))})

# 50. dcorr
dcorr.test <- dcorr(obs = wheat$obs, pred = wheat$pred)
test_that('no error dcorr', { expect_false(inherits(dcorr.test, "try-error")) })

dcorr.test.tidy <- dcorr(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error dcorr', { expect_false(inherits(dcorr.test.tidy , "try-error")) })

# 51. MIC
MIC.test <- MIC(obs = wheat$obs, pred = wheat$pred)
test_that('no error MIC', { expect_false(inherits(MIC.test, "try-error")) })

MIC.test.tidy <- MIC(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error MIC', { expect_false(inherits(MIC.test.tidy , "try-error")) })

# 52. SDSD
SDSD.test <- SDSD(obs = wheat$obs, pred = wheat$pred)
test_that('no error SDSD', {expect_false(inherits(SDSD.test, "try-error"))})

SDSD.test_tidy <- SDSD(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error SDSD', {expect_false(inherits(SDSD.test_tidy, "try-error"))})

# 53. SB
SB.test_tidy <- SB(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error SB', {expect_false(inherits(SB.test_tidy, "try-error"))})

# 54. RRMSE
RRMSE.test_tidy <- RRMSE(obs = wheat$obs, pred = wheat$pred, tidy = TRUE)
test_that('no error RRMSE', {expect_false(inherits(RRMSE.test_tidy, "try-error"))})

# 55. MASE 
chickpea_time <- metrica::chickpea %>% dplyr::arrange(pred) %>% 
  dplyr::mutate(time = seq(1,39, by =1)) %>% 
  dplyr::mutate(obs = pred *1.1 + rnorm(n=39, mean = 0, sd = 60))

MASE.test <- MASE(data = chickpea_time, obs = obs, pred = pred, time = time)
test_that('no error MASE', {expect_false(inherits(MASE.test, "try-error"))})

MASE.test.tidy <- MASE(data = chickpea_time, obs = obs, pred = pred, time = time, tidy = TRUE)
test_that('no error MASE', {expect_false(inherits(MASE.test.tidy, "try-error"))})

MASE.test_stop_data <- try(MASE(obs = obs, pred = pred, time = time), silent = TRUE)
test_that('stop', {expect_true(inherits(MASE.test_stop_data, "try-error"))})

MASE.test_stop_time <- try(MASE(data = chickpea_time, obs = obs, pred = pred), silent = TRUE)
test_that('stop', {expect_true(inherits(MASE.test_stop_time, "try-error"))})

MASE.test_2 <- MASE(data = chickpea_time, obs = obs, pred = pred, time = time, oob_mae = 50)
test_that('no error MASE', {expect_false(inherits(MASE.test_2, "try-error")) })
