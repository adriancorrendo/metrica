data('wheat')

SDEV <- sdev(wheat$pre)

test_that('no error sdev', {
  expect_false(inherits(SDEV, "try-error"))
})

SSx <- SSx(wheat$pre)

test_that('no error SSx', {
  expect_false(inherits(SSx, "try-error"))
})

MBE <- MBE(obs = wheat$obs, pre = wheat$pre)

test_that('no error MBE', {
  expect_false(inherits(MBE, "try-error"))
})

MSE <- MSE(obs = wheat$obs, pre = wheat$pre)

test_that('no error MSE', {
  expect_false(inherits(MSE, "try-error"))
})

RMSE <- RMSE(obs = wheat$obs, pre = wheat$pre)

test_that('no error RMSE', {
  expect_false(inherits(RMSE, "try-error"))
})

Xa <- Xa(obs = wheat$obs, pre = wheat$pre)

test_that('no error Xa', {
  expect_false(inherits(Xa, "try-error"))
})