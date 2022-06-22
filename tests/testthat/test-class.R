# Test classification metrics

binary <- data.frame(labels = sample(c("TRUE","FALSE"), 100, replace = TRUE),
                     predictions = sample(c("TRUE","FALSE"), 100, replace = TRUE)  )

multiclass <- data.frame(labels = sample(c("Red","Blue", "Green"), 100, replace = TRUE),
                         predictions = sample(c("Red","Blue", "Green"), 100, replace = TRUE) )  


# 1. Confusion matrix table binary
confusion_matrix_1.test <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                                         unit = "count", plot = FALSE)

confusion_matrix_2.test <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                                            unit = "proportion", plot = FALSE)

confusion_matrix_3.test <- confusion_matrix(data = multiclass, obs = labels, pred = predictions, 
                                            unit = "count", plot = TRUE)

confusion_matrix_4.test <- confusion_matrix(data = multiclass, obs = labels, pred = predictions, 
                                            unit = "proportion", plot = TRUE)

# TEST
test_that('no error confusion_matrix_1', {expect_false(inherits(confusion_matrix_1.test, "try-error")) })
test_that('no error confusion_matrix_2', {expect_false(inherits(confusion_matrix_2.test, "try-error")) })
test_that('no error confusion_matrix_3', {expect_false(inherits(confusion_matrix_3.test, "try-error")) })
test_that('no error confusion_matrix_4', {expect_false(inherits(confusion_matrix_4.test, "try-error")) })

# 2a. Accuracy
accuracy_1.test <- accuracy(data = binary, obs = labels, pred = predictions, tidy = FALSE)
accuracy_2.test <- accuracy(data = binary, obs = labels, pred = predictions, tidy = TRUE)
accuracy_3.test <- accuracy(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
accuracy_4.test <- accuracy(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)

# TEST
test_that('no error accuracy_1', {expect_false(inherits(accuracy_1.test, "try-error")) })
test_that('no error accuracy_2', {expect_false(inherits(accuracy_2.test, "try-error")) })
test_that('no error accuracy_3', {expect_false(inherits(accuracy_3.test, "try-error")) })
test_that('no error accuracy_4', {expect_false(inherits(accuracy_4.test, "try-error")) })

# 2b. Error rate
error_rate_1.test <- error_rate(data = binary, obs = labels, pred = predictions, tidy = FALSE)
error_rate_2.test <- error_rate(data = binary, obs = labels, pred = predictions, tidy = TRUE)
error_rate_3.test <- error_rate(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
error_rate_4.test <- error_rate(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)

# TEST
test_that('no error error_rate_1', {expect_false(inherits(error_rate_1.test, "try-error")) })
test_that('no error error_rate_2', {expect_false(inherits(error_rate_2.test, "try-error")) })
test_that('no error error_rate_3', {expect_false(inherits(error_rate_3.test, "try-error")) })
test_that('no error error_rate_4', {expect_false(inherits(error_rate_4.test, "try-error")) })

# 3. Precision
precision_1.test <- precision(data = binary, obs = labels, pred = predictions, tidy = FALSE)
precision_2.test <- precision(data = binary, obs = labels, pred = predictions, tidy = TRUE)
precision_3.test <- precision(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
precision_4.test <- precision(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
precision_5.test <- precision(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = TRUE)
precision_6.test <- precision(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, atom = TRUE)

# TEST
test_that('no error precision_1', {expect_false(inherits(precision_1.test, "try-error")) })
test_that('no error precision_2', {expect_false(inherits(precision_2.test, "try-error")) })
test_that('no error precision_3', {expect_false(inherits(precision_3.test, "try-error")) })
test_that('no error precision_4', {expect_false(inherits(precision_4.test, "try-error")) })
test_that('no error precision_5', {expect_false(inherits(precision_5.test, "try-error")) })
test_that('no error precision_6', {expect_false(inherits(precision_6.test, "try-error")) })

# 4. Recall
recall_1.test <- recall(data = binary, obs = labels, pred = predictions, tidy = FALSE, atom = FALSE)
recall_2.test <- recall(data = binary, obs = labels, pred = predictions, tidy = TRUE, atom = FALSE)
recall_3.test <- recall(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = FALSE)
recall_4.test <- recall(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, atom = FALSE)
recall_5.test <- recall(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = TRUE)
recall_6.test <- recall(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, atom = TRUE)

# TEST
test_that('no error recall_1', {expect_false(inherits(recall_1.test, "try-error")) })
test_that('no error recall_2', {expect_false(inherits(recall_2.test, "try-error")) })
test_that('no error recall_3', {expect_false(inherits(recall_3.test, "try-error")) })
test_that('no error recall_4', {expect_false(inherits(recall_4.test, "try-error")) })
test_that('no error recall_5', {expect_false(inherits(recall_5.test, "try-error")) })
test_that('no error recall_6', {expect_false(inherits(recall_6.test, "try-error")) })


# 5. Specificity
specificity_1.test <- specificity(data = binary, obs = labels, pred = predictions, tidy = FALSE)
specificity_2.test <- specificity(data = binary, obs = labels, pred = predictions, tidy = TRUE)
specificity_3.test <- specificity(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
specificity_4.test <- specificity(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)

# TEST
test_that('no error specificity_1', {expect_false(inherits(specificity_1.test, "try-error")) })
test_that('no error specificity_2', {expect_false(inherits(specificity_2.test, "try-error")) })
test_that('no error specificity_3', {expect_false(inherits(specificity_3.test, "try-error")) })
test_that('no error specificity_4', {expect_false(inherits(specificity_4.test, "try-error")) })

# 6. F-score
fscore_1.test <- fscore(data = binary, obs = labels, pred = predictions, tidy = FALSE)
fscore_2.test <- fscore(data = binary, obs = labels, pred = predictions, tidy = TRUE)
fscore_3.test <- fscore(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
fscore_4.test <- fscore(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)

# TEST
test_that('no error fscore_1', {expect_false(inherits(fscore_1.test, "try-error")) })
test_that('no error fscore_2', {expect_false(inherits(fscore_2.test, "try-error")) })
test_that('no error fscore_3', {expect_false(inherits(fscore_3.test, "try-error")) })
test_that('no error fscore_4', {expect_false(inherits(fscore_4.test, "try-error")) })

# 7. Cohen's-Kappa
cohen_kappa_1.test <- cohen_kappa(data = binary, obs = labels, pred = predictions, tidy = FALSE)
cohen_kappa_2.test <- cohen_kappa(data = binary, obs = labels, pred = predictions, tidy = TRUE)
cohen_kappa_3.test <- cohen_kappa(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
cohen_kappa_4.test <- cohen_kappa(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)

# TEST
test_that('no error cohen_kappa_1', {expect_false(inherits(cohen_kappa_1.test, "try-error")) })
test_that('no error cohen_kappa_2', {expect_false(inherits(cohen_kappa_2.test, "try-error")) })
test_that('no error cohen_kappa_3', {expect_false(inherits(cohen_kappa_3.test, "try-error")) })
test_that('no error cohen_kappa_4', {expect_false(inherits(cohen_kappa_4.test, "try-error")) })

# 8. Balanced Accuracy
baccu_1.test <- baccu(data = binary, obs = labels, pred = predictions, tidy = FALSE)
baccu_2.test <- baccu(data = binary, obs = labels, pred = predictions, tidy = TRUE)
baccu_3.test <- baccu(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
baccu_4.test <- baccu(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)

# TEST
test_that('no error baccu_1', {expect_false(inherits(baccu_1.test, "try-error")) })
test_that('no error baccu_2', {expect_false(inherits(baccu_2.test, "try-error")) })
test_that('no error baccu_3', {expect_false(inherits(baccu_3.test, "try-error")) })
test_that('no error baccu_4', {expect_false(inherits(baccu_4.test, "try-error")) })

# 9. Fowlkes-Mallows Index
fmi_1.test <- fmi(data = binary, obs = labels, pred = predictions, tidy = FALSE)
fmi_2.test <- fmi(data = binary, obs = labels, pred = predictions, tidy = TRUE)
fmi_3.test <- fmi(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)

# TEST
test_that('no error fmi_1', {expect_false(inherits(fmi_1.test, "try-error")) })
test_that('no error fmi_2', {expect_false(inherits(fmi_2.test, "try-error")) })
test_that('warning fmi_3', {expect_false(inherits(fmi_3.test, "warning")) })

# 10. Matthews Correlation Coefficient
mcc_1.test <- mcc(data = binary, obs = labels, pred = predictions, tidy = FALSE)
mcc_2.test <- mcc(data = binary, obs = labels, pred = predictions, tidy = TRUE)
mcc_3.test <- mcc(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)

# TEST
test_that('no error mcc_1', {expect_false(inherits(mcc_1.test, "try-error")) })
test_that('no error mcc_2', {expect_false(inherits(mcc_2.test, "try-error")) })
test_that('warning mcc_3', {expect_false(inherits(mcc_3.test, "warning")) })

# 11. Classification Metrics Summary
metrics_summary_1.test <- metrics_summary(data = binary, obs = labels, pred = predictions, type = "classification")

# TEST
test_that('no error metrics_summary_1', {expect_false(inherits(metrics_summary_1.test, "try-error")) })



