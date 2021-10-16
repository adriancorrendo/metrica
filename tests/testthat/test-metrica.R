data('wheat')

sdev.test <- sdev(wheat$pre)

test_that('no error sdev', {
  expect_false(inherits(sdev.test, "try-error"))
})

R2.test <- R2(obs = wheat$obs, pred = wheat$pre)

test_that('no error R2', {
  expect_false(inherits(R2.test, "try-error"))
})

SSx.test <- SSx(wheat$pre)

test_that('no error SSx', {
  expect_false(inherits(SSx.test, "try-error"))
})

MBE.test <- MBE(obs = wheat$obs, pre = wheat$pre)

test_that('no error MBE', {
  expect_false(inherits(MBE.test, "try-error"))
})

MSE.test <- MSE(obs = wheat$obs, pred = wheat$pre)

test_that('no error MSE', {
  expect_false(inherits(MSE.test, "try-error"))
})

RMSE.test <- RMSE(obs = wheat$obs, pred = wheat$pre)

test_that('no error RMSE', {
  expect_false(inherits(RMSE.test, "try-error"))
})

Xa.test <- Xa(obs = wheat$obs, pred = wheat$pre)

test_that('no error Xa', {
  expect_false(inherits(Xa.test, "try-error"))
})

MLA.test <- MLA(obs = wheat$obs, pred = wheat$pre)

test_that('no error MLA', {
  expect_false(inherits(MLA.test, "try-error"))
})

MLP.test <- MLP(obs = wheat$obs, pred = wheat$pre)

test_that('no error MLP', {
  expect_false(inherits(MLP.test, "try-error"))
})

PLA.test <- PLA(obs = wheat$obs, pred = wheat$pre)

test_that('no error PLA', {
  expect_false(inherits(PLA.test, "try-error"))
})

PLP.test <- PLP(obs = wheat$obs, pred = wheat$pre)

test_that('no error PLP', {
  expect_false(inherits(PLP.test, "try-error"))
})

Uc.test <- Uc(obs = wheat$obs, pred = wheat$pre)

test_that('no error UC', {
  expect_false(inherits(Uc.test, "try-error"))
})

Ue.test <- Ue(obs = wheat$obs, pred = wheat$pre)

test_that('no error Ue', {
  expect_false(inherits(Ue.test, "try-error"))
})

Ub.test <- Ub(obs = wheat$obs, pred = wheat$pre)

test_that('no error Ub', {
  expect_false(inherits(Ub.test, "try-error"))
})

CCC.test <- CCC(obs = wheat$obs, pred = wheat$pre)

test_that('no error CCC', {
  expect_false(inherits(CCC.test, "try-error"))
})

PAB.test <- PAB(obs = wheat$obs, pred = wheat$pre)

test_that('no error PAB', {
  expect_false(inherits(PAB.test, "try-error"))
})

PPB.test <- PPB(obs = wheat$obs, pred = wheat$pre)

test_that('no error PPB', {
  expect_false(inherits(PPB.test, "try-error"))
})

MAE.test <- MAE(obs = wheat$obs, pred = wheat$pre)

test_that('no error MAE', {
  expect_false(inherits(MAE.test, "try-error"))
})

MAPE.test <- MAPE(obs = wheat$obs, pred = wheat$pre)

test_that('no error MAPE', {
  expect_false(inherits(MAPE.test, "try-error"))
})

SMAPE.test <- SMAPE(obs = wheat$obs, pred = wheat$pre)

test_that('no error SMAPE', {
  expect_false(inherits(SMAPE.test, "try-error"))
})

PBE.test <- PBE(obs = wheat$obs, pred = wheat$pre)

test_that('no error PBE', {
  expect_false(inherits(PBE.test, "try-error"))
})

RSR.test <- RSR(obs = wheat$obs, pred = wheat$pre)

test_that('no error RSR', {
  expect_false(inherits(RSR.test, "try-error"))
})

E1.test <- E1(obs = wheat$obs, pred = wheat$pre)

test_that('no error E1', {
  expect_false(inherits(E1.test, "try-error"))
})

Erel.test <- Erel(obs = wheat$obs, pred = wheat$pre)

test_that('no error Erel', {
  expect_false(inherits(Erel.test, "try-error"))
})

KGE.test <- KGE(obs = wheat$obs, pred = wheat$pre)

test_that('no error KGE', {
  expect_false(inherits(KGE.test, "try-error"))
})

RAC.test <- RAC(obs = wheat$obs, pred = wheat$pre)

test_that('no error RAC', {
  expect_false(inherits(RAC.test, "try-error"))
})

d1.test <- d1(obs = wheat$obs, pred = wheat$pre)

test_that('no error d1', {
  expect_false(inherits(d1.test, "try-error"))
})

DLambda.test <- DLambda(obs = wheat$obs, pred = wheat$pre)

test_that('no error DLambda', {
  expect_false(inherits(DLambda.test, "try-error"))
})

NSE.test <- NSE(obs = wheat$obs, pred = wheat$pre)

test_that('no error NSE', {
  expect_false(inherits(NSE.test, "try-error"))
})