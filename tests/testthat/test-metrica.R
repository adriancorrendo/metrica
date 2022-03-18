# Test import.apsim.out

out.file <- testthat::test_path("examples", "soybean.out")
import.apsim.out.test <- import.apsim.out(filepath = out.file)

test_that('no error import.apsim.out', {
  expect_false(inherits(import.apsim.out.test, "try-error"))
})

# Test import.apsim.db

db.loc <- testthat::test_path("examples")
import.apsim.db.test <- import.apsim.db(file = "soybean.example.db",  src.dir = db.loc)

test_that('no error import.apsim.db', {
  expect_false(inherits(import.apsim.db.test, "try-error"))
})

# Data for metrics
data('wheat')

# 1. Metrics summary
metrics.summary.test <- metrics.summary(obs = wheat$obs, pred = wheat$pred,
                                        orientation = "PO")

test_that('no error metrics.summary', {
  expect_false(inherits(metrics.summary.test, "try-error"))
})

# 2. Scatter plot
scatter.plot.test.PO <- scatter.plot(obs = wheat$obs, pred = wheat$pred,
                                  orientation = "PO")

test_that('no error scatter.plot', {
  expect_false(inherits(scatter.plot.test.PO, "try-error"))
})

scatter.plot.test.OP <- scatter.plot(obs = wheat$obs, pred = wheat$pred,
                                     orientation = "OP")

test_that('no error scatter.plot', {
  expect_false(inherits(scatter.plot.test.OP, "try-error"))
})

# 3. Tiles plot
tiles.plot.test.PO <- tiles.plot(obs = wheat$obs, pred = wheat$pred,
                                  orientation = "PO")

test_that('no error tiles.plot', {
  expect_false(inherits(tiles.plot.test.PO, "try-error"))
})

tiles.plot.test.OP <- tiles.plot(obs = wheat$obs, pred = wheat$pred,
                                 orientation = "OP")

test_that('no error tiles.plot', {
  expect_false(inherits(tiles.plot.test.OP, "try-error"))
})

# 4. Bland-Altman plot
bland.altman.plot.test <- bland.altman.plot(obs = wheat$obs,
                                            pred = wheat$pred)

test_that('no error bland.altman.plot', {
  expect_false(inherits(bland.altman.plot.test, "try-error"))
})

# 5. uSD
uSD.test <- uSD(x = wheat$obs)

test_that('no error uSD', {
  expect_false(inherits(uSD.test, "try-error"))
})

# 6. var.u
var.u.test <- var.u(x = wheat$obs)

test_that('no error var.u', {
  expect_false(inherits(var.u.test, "try-error"))
})

# 7. RSS
RSS.test <- RSS(obs = wheat$obs, pred = wheat$pred)

test_that('no error RSS', {
  expect_false(inherits(RSS.test, "try-error"))
})

# 8. TSS
TSS.test <- TSS(obs = wheat$obs)

test_that('no error TSS', {
  expect_false(inherits(TSS.test, "try-error"))
})

# 9. RSE
RSE.test <- RSE(obs = wheat$obs, pred = wheat$pred)

test_that('no error RSE', {
  expect_false(inherits(RSE.test, "try-error"))
})

# 10. RAE
RAE.test <- RAE(obs = wheat$obs, pred = wheat$pred)

test_that('no error RAE', {
  expect_false(inherits(RAE.test, "try-error"))
})

# 11. R2
R2.test <- R2(obs = wheat$obs, pred = wheat$pred)

test_that('no error R2', {
  expect_false(inherits(R2.test, "try-error"))
})

# 12. B0
B0.sma.test.PO <- B0.sma(obs = wheat$obs, pred = wheat$pred,
                         orientation = "PO")

test_that('no error B0.sma', {
  expect_false(inherits(B0.sma.test.PO, "try-error"))
})

B0.sma.test.OP <- B0.sma(obs = wheat$obs, pred = wheat$pred,
                         orientation = "OP")

test_that('no error B0.sma', {
  expect_false(inherits(B0.sma.test.OP, "try-error"))
})

# 13. B1
B1.sma.test.PO <- B1.sma(obs = wheat$obs, pred = wheat$pred,
                         orientation = "PO")

test_that('no error B1.sma', {
  expect_false(inherits(B1.sma.test.PO, "try-error"))
})

B1.sma.test.OP <- B1.sma(obs = wheat$obs, pred = wheat$pred,
                         orientation = "OP")

test_that('no error B1.sma', {
  expect_false(inherits(B1.sma.test.OP, "try-error"))
})

# 14. MBE
MBE.test <- MBE(obs = wheat$obs, pre = wheat$pred)

test_that('no error MBE', {
  expect_false(inherits(MBE.test, "try-error"))
})

# 15. MSE
MSE.test <- MSE(obs = wheat$obs, pred = wheat$pred)

test_that('no error MSE', {
  expect_false(inherits(MSE.test, "try-error"))
})

# 15. RMSE
RMSE.test <- RMSE(obs = wheat$obs, pred = wheat$pred)

test_that('no error RMSE', {
  expect_false(inherits(RMSE.test, "try-error"))
})

# 16. iqRMSE
iqRMSE.test <- iqRMSE(obs = wheat$obs, pred = wheat$pred)

test_that('no error iqRMSE', {
  expect_false(inherits(iqRMSE.test, "try-error"))
})

# 17. Xa
Xa.test <- Xa(obs = wheat$obs, pred = wheat$pred)

test_that('no error Xa', {
  expect_false(inherits(Xa.test, "try-error"))
})

# 18. MLA
MLA.test <- MLA(obs = wheat$obs, pred = wheat$pred)

test_that('no error MLA', {
  expect_false(inherits(MLA.test, "try-error"))
})

# 18. MLP
MLP.test <- MLP(obs = wheat$obs, pred = wheat$pred)

test_that('no error MLP', {
  expect_false(inherits(MLP.test, "try-error"))
})

# 19. PLA
PLA.test <- PLA(obs = wheat$obs, pred = wheat$pred)

test_that('no error PLA', {
  expect_false(inherits(PLA.test, "try-error"))
})

# 20. PLP
PLP.test <- PLP(obs = wheat$obs, pred = wheat$pred)

test_that('no error PLP', {
  expect_false(inherits(PLP.test, "try-error"))
})

# 21. LCS
LCS.test <- LCS(obs = wheat$obs, pred = wheat$pred)

test_that('no error LCS', {
  expect_false(inherits(LCS.test, "try-error"))
})

# 22. Uc
Uc.test <- Uc(obs = wheat$obs, pred = wheat$pred)

test_that('no error UC', {
  expect_false(inherits(Uc.test, "try-error"))
})

# 23. Ue
Ue.test <- Ue(obs = wheat$obs, pred = wheat$pred)

test_that('no error Ue', {
  expect_false(inherits(Ue.test, "try-error"))
})

# 24. Ub
Ub.test <- Ub(obs = wheat$obs, pred = wheat$pred)

test_that('no error Ub', {
  expect_false(inherits(Ub.test, "try-error"))
})

# 25. CCC
CCC.test <- CCC(obs = wheat$obs, pred = wheat$pred)

test_that('no error CCC', {
  expect_false(inherits(CCC.test, "try-error"))
})

# 26. PAB
PAB.test <- PAB(obs = wheat$obs, pred = wheat$pred)

test_that('no error PAB', {
  expect_false(inherits(PAB.test, "try-error"))
})

# 27. PPB
PPB.test <- PPB(obs = wheat$obs, pred = wheat$pred)

test_that('no error PPB', {
  expect_false(inherits(PPB.test, "try-error"))
})

# 28. MAE
MAE.test <- MAE(obs = wheat$obs, pred = wheat$pred)

test_that('no error MAE', {
  expect_false(inherits(MAE.test, "try-error"))
})

# 29. RMAE
RMAE.test <- RMAE(obs = wheat$obs, pred = wheat$pred)

test_that('no error RMAE', {
  expect_false(inherits(RMAE.test, "try-error"))
})

# 30. MAPE
MAPE.test <- MAPE(obs = wheat$obs, pred = wheat$pred)

test_that('no error MAPE', {
  expect_false(inherits(MAPE.test, "try-error"))
})

# 31. SMAPE
SMAPE.test <- SMAPE(obs = wheat$obs, pred = wheat$pred)

test_that('no error SMAPE', {
  expect_false(inherits(SMAPE.test, "try-error"))
})

# 32. PBE
PBE.test <- PBE(obs = wheat$obs, pred = wheat$pred)

test_that('no error PBE', {
  expect_false(inherits(PBE.test, "try-error"))
})

# 33. RSR
RSR.test <- RSR(obs = wheat$obs, pred = wheat$pred)

test_that('no error RSR', {
  expect_false(inherits(RSR.test, "try-error"))
})

# 34. NSE
NSE.test <- NSE(obs = wheat$obs, pred = wheat$pred)

test_that('no error NSE', {
  expect_false(inherits(NSE.test, "try-error"))
})

# 35. E1
E1.test <- E1(obs = wheat$obs, pred = wheat$pred)

test_that('no error E1', {
  expect_false(inherits(E1.test, "try-error"))
})

# 36. Erel
Erel.test <- Erel(obs = wheat$obs, pred = wheat$pred)

test_that('no error Erel', {
  expect_false(inherits(Erel.test, "try-error"))
})

# 37. KGE
KGE.test <- KGE(obs = wheat$obs, pred = wheat$pred)

test_that('no error KGE', {
  expect_false(inherits(KGE.test, "try-error"))
})

# 38. RAC
RAC.test <- RAC(obs = wheat$obs, pred = wheat$pred)

test_that('no error RAC', {
  expect_false(inherits(RAC.test, "try-error"))
})

# 39. d
d.test <- d(obs = wheat$obs, pred = wheat$pred)

test_that('no error d', {
  expect_false(inherits(d.test, "try-error"))
})

# 40. d1
d1.test <- d1(obs = wheat$obs, pred = wheat$pred)

test_that('no error d1', {
  expect_false(inherits(d1.test, "try-error"))
})

# 41. d1r
d1r.test <- d1r(obs = wheat$obs, pred = wheat$pred)

test_that('no error d1r', {
  expect_false(inherits(d1r.test, "try-error"))
})

# 38. AC
AC.test <- AC(obs = wheat$obs, pred = wheat$pred)

test_that('no error AC', {
  expect_false(inherits(AC.test, "try-error"))
})

# 42. lambda
lambda.test <- lambda(obs = wheat$obs, pred = wheat$pred)

test_that('no error lambda', {
  expect_false(inherits(lambda.test, "try-error"))
})

