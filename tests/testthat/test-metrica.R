data('wheat')

metrics.summary.test <- metrics.summary(obs = wheat$obs, pred = wheat$pred,
                                        orientation = "PO")

test_that('no error metrics.summary', {
  expect_false(inherits(metrics.summary.test, "try-error"))
})

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

bland.altman.plot.test <- bland.altman.plot(obs = wheat$obs,
                                            pred = wheat$pred)

test_that('no error bland.altman.plot', {
  expect_false(inherits(bland.altman.plot.test, "try-error"))
})

uSD.test <- uSD(x = wheat$obs)

test_that('no error uSD', {
  expect_false(inherits(uSD.test, "try-error"))
})

var.u.test <- var.u(x = wheat$obs)

test_that('no error var.u', {
  expect_false(inherits(var.u.test, "try-error"))
})

RSS.test <- RSS(obs = wheat$obs, pred = wheat$pred)

test_that('no error RSS', {
  expect_false(inherits(RSS.test, "try-error"))
})

TSS.test <- TSS(obs = wheat$obs)

test_that('no error TSS', {
  expect_false(inherits(TSS.test, "try-error"))
})

RSE.test <- RSE(obs = wheat$obs, pred = wheat$pred)

test_that('no error RSE', {
  expect_false(inherits(RSE.test, "try-error"))
})

RAE.test <- RAE(obs = wheat$obs, pred = wheat$pred)

test_that('no error RAE', {
  expect_false(inherits(RAE.test, "try-error"))
})

R2.test <- R2(obs = wheat$obs, pred = wheat$pred)

test_that('no error R2', {
  expect_false(inherits(R2.test, "try-error"))
})

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

MBE.test <- MBE(obs = wheat$obs, pre = wheat$pred)

test_that('no error MBE', {
  expect_false(inherits(MBE.test, "try-error"))
})

MSE.test <- MSE(obs = wheat$obs, pred = wheat$pred)

test_that('no error MSE', {
  expect_false(inherits(MSE.test, "try-error"))
})

RMSE.test <- RMSE(obs = wheat$obs, pred = wheat$pred)

test_that('no error RMSE', {
  expect_false(inherits(RMSE.test, "try-error"))
})

iqRMSE.test <- iqRMSE(obs = wheat$obs, pred = wheat$pred)

test_that('no error iqRMSE', {
  expect_false(inherits(iqRMSE.test, "try-error"))
})

Xa.test <- Xa(obs = wheat$obs, pred = wheat$pred)

test_that('no error Xa', {
  expect_false(inherits(Xa.test, "try-error"))
})

MLA.test <- MLA(obs = wheat$obs, pred = wheat$pred)

test_that('no error MLA', {
  expect_false(inherits(MLA.test, "try-error"))
})

MLP.test <- MLP(obs = wheat$obs, pred = wheat$pred)

test_that('no error MLP', {
  expect_false(inherits(MLP.test, "try-error"))
})

PLA.test <- PLA(obs = wheat$obs, pred = wheat$pred)

test_that('no error PLA', {
  expect_false(inherits(PLA.test, "try-error"))
})

PLP.test <- PLP(obs = wheat$obs, pred = wheat$pred)

test_that('no error PLP', {
  expect_false(inherits(PLP.test, "try-error"))
})

LCS.test <- LCS(obs = wheat$obs, pred = wheat$pred)

test_that('no error LCS', {
  expect_false(inherits(LCS.test, "try-error"))
})

Uc.test <- Uc(obs = wheat$obs, pred = wheat$pred)

test_that('no error UC', {
  expect_false(inherits(Uc.test, "try-error"))
})

Ue.test <- Ue(obs = wheat$obs, pred = wheat$pred)

test_that('no error Ue', {
  expect_false(inherits(Ue.test, "try-error"))
})

Ub.test <- Ub(obs = wheat$obs, pred = wheat$pred)

test_that('no error Ub', {
  expect_false(inherits(Ub.test, "try-error"))
})

CCC.test <- CCC(obs = wheat$obs, pred = wheat$pred)

test_that('no error CCC', {
  expect_false(inherits(CCC.test, "try-error"))
})

PAB.test <- PAB(obs = wheat$obs, pred = wheat$pred)

test_that('no error PAB', {
  expect_false(inherits(PAB.test, "try-error"))
})

PPB.test <- PPB(obs = wheat$obs, pred = wheat$pred)

test_that('no error PPB', {
  expect_false(inherits(PPB.test, "try-error"))
})

MAE.test <- MAE(obs = wheat$obs, pred = wheat$pred)

test_that('no error MAE', {
  expect_false(inherits(MAE.test, "try-error"))
})

RMAE.test <- RMAE(obs = wheat$obs, pred = wheat$pred)

test_that('no error RMAE', {
  expect_false(inherits(RMAE.test, "try-error"))
})

MAPE.test <- MAPE(obs = wheat$obs, pred = wheat$pred)

test_that('no error MAPE', {
  expect_false(inherits(MAPE.test, "try-error"))
})

SMAPE.test <- SMAPE(obs = wheat$obs, pred = wheat$pred)

test_that('no error SMAPE', {
  expect_false(inherits(SMAPE.test, "try-error"))
})

PBE.test <- PBE(obs = wheat$obs, pred = wheat$pred)

test_that('no error PBE', {
  expect_false(inherits(PBE.test, "try-error"))
})

RSR.test <- RSR(obs = wheat$obs, pred = wheat$pred)

test_that('no error RSR', {
  expect_false(inherits(RSR.test, "try-error"))
})

E1.test <- E1(obs = wheat$obs, pred = wheat$pred)

test_that('no error E1', {
  expect_false(inherits(E1.test, "try-error"))
})

Erel.test <- Erel(obs = wheat$obs, pred = wheat$pred)

test_that('no error Erel', {
  expect_false(inherits(Erel.test, "try-error"))
})

KGE.test <- KGE(obs = wheat$obs, pred = wheat$pred)

test_that('no error KGE', {
  expect_false(inherits(KGE.test, "try-error"))
})

RAC.test <- RAC(obs = wheat$obs, pred = wheat$pred)

test_that('no error RAC', {
  expect_false(inherits(RAC.test, "try-error"))
})

d.test <- d(obs = wheat$obs, pred = wheat$pred)

test_that('no error d', {
  expect_false(inherits(d.test, "try-error"))
})

d1.test <- d1(obs = wheat$obs, pred = wheat$pred)

test_that('no error d1', {
  expect_false(inherits(d1.test, "try-error"))
})

d1r.test <- d1r(obs = wheat$obs, pred = wheat$pred)

test_that('no error d1r', {
  expect_false(inherits(d1r.test, "try-error"))
})

lambda.test <- lambda(obs = wheat$obs, pred = wheat$pred)

test_that('no error lambda', {
  expect_false(inherits(lambda.test, "try-error"))
})

NSE.test <- NSE(obs = wheat$obs, pred = wheat$pred)

test_that('no error NSE', {
  expect_false(inherits(NSE.test, "try-error"))
})