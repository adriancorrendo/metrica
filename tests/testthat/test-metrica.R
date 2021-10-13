data('wheat')

SDEV <- sdev(wheat$pre)

test_that('no error sdev', {
  expect_false(inherits(SDEV, "try-error"))
})