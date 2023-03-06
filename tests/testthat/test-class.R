# Test classification metrics
library(metrica)
library(dplyr)
library(testthat)

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
precision_1.test <- precision(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
precision_2.test <- precision(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
precision_3.test <- precision(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
precision_4.test <- precision(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
precision_5.test <- precision(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = TRUE)
precision_6.test <- precision(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, atom = TRUE)
precision_7.test <- precision(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
precision_8.test <- precision(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)

# TEST
test_that('no error precision_1', {expect_false(inherits(precision_1.test, "try-error")) })
test_that('no error precision_2', {expect_false(inherits(precision_2.test, "try-error")) })
test_that('no error precision_3', {expect_false(inherits(precision_3.test, "try-error")) })
test_that('no error precision_4', {expect_false(inherits(precision_4.test, "try-error")) })
test_that('no error precision_5', {expect_false(inherits(precision_5.test, "try-error")) })
test_that('no error precision_6', {expect_false(inherits(precision_6.test, "try-error")) })
test_that('no error precision_5', {expect_false(inherits(precision_7.test, "try-error")) })
test_that('no error precision_6', {expect_false(inherits(precision_8.test, "try-error")) })

# 4. Recall
recall_1.test <- recall(data = binary, obs = labels, pred = predictions, tidy = FALSE, atom = FALSE, pos_level = 1)
recall_2.test <- recall(data = binary, obs = labels, pred = predictions, tidy = TRUE, atom = FALSE, pos_level = 1)
recall_3.test <- recall(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = FALSE)
recall_4.test <- recall(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, atom = FALSE)
recall_5.test <- recall(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = TRUE)
recall_6.test <- recall(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, atom = TRUE)
recall_7.test <- recall(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
recall_8.test <- recall(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)

# TEST
test_that('no error recall_1', {expect_false(inherits(recall_1.test, "try-error")) })
test_that('no error recall_2', {expect_false(inherits(recall_2.test, "try-error")) })
test_that('no error recall_3', {expect_false(inherits(recall_3.test, "try-error")) })
test_that('no error recall_4', {expect_false(inherits(recall_4.test, "try-error")) })
test_that('no error recall_5', {expect_false(inherits(recall_5.test, "try-error")) })
test_that('no error recall_6', {expect_false(inherits(recall_6.test, "try-error")) })
test_that('no error recall_7', {expect_false(inherits(recall_7.test, "try-error")) })
test_that('no error recall_8', {expect_false(inherits(recall_8.test, "try-error")) })

# 4.b
sensitivity_1.test <- sensitivity(data = binary, obs = labels, pred = predictions, tidy = FALSE, atom = FALSE, pos_level = 1)
sensitivity_2.test <- sensitivity(data = binary, obs = labels, pred = predictions, tidy = TRUE, atom = FALSE, pos_level = 1)
sensitivity_3.test <- sensitivity(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = FALSE)
sensitivity_4.test <- sensitivity(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, atom = FALSE)
sensitivity_5.test <- sensitivity(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = TRUE)
sensitivity_6.test <- sensitivity(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, atom = TRUE)
sensitivity_7.test <- sensitivity(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
sensitivity_8.test <- sensitivity(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)

# TEST
test_that('no error sensitivity_1', {expect_false(inherits(sensitivity_1.test, "try-error")) })
test_that('no error sensitivity_2', {expect_false(inherits(sensitivity_2.test, "try-error")) })
test_that('no error sensitivity_3', {expect_false(inherits(sensitivity_3.test, "try-error")) })
test_that('no error sensitivity_4', {expect_false(inherits(sensitivity_4.test, "try-error")) })
test_that('no error sensitivity_5', {expect_false(inherits(sensitivity_5.test, "try-error")) })
test_that('no error sensitivity_6', {expect_false(inherits(sensitivity_6.test, "try-error")) })
test_that('no error sensitivity_7', {expect_false(inherits(sensitivity_7.test, "try-error")) })
test_that('no error sensitivity_8', {expect_false(inherits(sensitivity_8.test, "try-error")) })

# 4.c
TPR_1.test <- TPR(data = binary, obs = labels, pred = predictions, tidy = FALSE, atom = FALSE, pos_level = 1)
TPR_2.test <- TPR(data = binary, obs = labels, pred = predictions, tidy = TRUE, atom = FALSE, pos_level = 1)
TPR_3.test <- TPR(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = FALSE)
TPR_4.test <- TPR(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, atom = FALSE)
TPR_5.test <- TPR(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = TRUE)
TPR_6.test <- TPR(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, atom = TRUE)
TPR_7.test <- TPR(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
TPR_8.test <- TPR(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)

# TEST
test_that('no error TPR_1', {expect_false(inherits(TPR_1.test, "try-error")) })
test_that('no error TPR_2', {expect_false(inherits(TPR_2.test, "try-error")) })
test_that('no error TPR_3', {expect_false(inherits(TPR_3.test, "try-error")) })
test_that('no error TPR_4', {expect_false(inherits(TPR_4.test, "try-error")) })
test_that('no error TPR_5', {expect_false(inherits(TPR_5.test, "try-error")) })
test_that('no error TPR_6', {expect_false(inherits(TPR_6.test, "try-error")) })
test_that('no error TPR_7', {expect_false(inherits(TPR_7.test, "try-error")) })
test_that('no error TPR_8', {expect_false(inherits(TPR_8.test, "try-error")) })

# 4.d
hitrate_1.test <- hitrate(data = binary, obs = labels, pred = predictions, tidy = FALSE, atom = FALSE, pos_level = 1)
hitrate_2.test <- hitrate(data = binary, obs = labels, pred = predictions, tidy = TRUE, atom = FALSE, pos_level = 1)
hitrate_3.test <- hitrate(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = FALSE)
hitrate_4.test <- hitrate(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, atom = FALSE)
hitrate_5.test <- hitrate(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = TRUE)
hitrate_6.test <- hitrate(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, atom = TRUE)
hitrate_7.test <- hitrate(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
hitrate_8.test <- hitrate(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)

# TEST
test_that('no error hitrate_1', {expect_false(inherits(hitrate_1.test, "try-error")) })
test_that('no error hitrate_2', {expect_false(inherits(hitrate_2.test, "try-error")) })
test_that('no error hitrate_3', {expect_false(inherits(hitrate_3.test, "try-error")) })
test_that('no error hitrate_4', {expect_false(inherits(hitrate_4.test, "try-error")) })
test_that('no error hitrate_5', {expect_false(inherits(hitrate_5.test, "try-error")) })
test_that('no error hitrate_6', {expect_false(inherits(hitrate_6.test, "try-error")) })
test_that('no error hitrate_7', {expect_false(inherits(hitrate_7.test, "try-error")) })
test_that('no error hitrate_8', {expect_false(inherits(hitrate_8.test, "try-error")) })

# 5. Specificity
specificity_1.test <- specificity(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
specificity_2.test <- specificity(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
specificity_3.test <- specificity(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
specificity_4.test <- specificity(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
specificity_5.test <- specificity(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
specificity_6.test <- specificity(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
specificity_7.test <- specificity(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = TRUE)

# TEST
test_that('no error specificity_1', {expect_false(inherits(specificity_1.test, "try-error")) })
test_that('no error specificity_2', {expect_false(inherits(specificity_2.test, "try-error")) })
test_that('no error specificity_3', {expect_false(inherits(specificity_3.test, "try-error")) })
test_that('no error specificity_4', {expect_false(inherits(specificity_4.test, "try-error")) })
test_that('no error specificity_5', {expect_false(inherits(specificity_5.test, "try-error")) })
test_that('no error specificity_6', {expect_false(inherits(specificity_6.test, "try-error")) })
test_that('no error specificity_7', {expect_false(inherits(specificity_7.test, "try-error")) })

# 5.b
selectivity_1.test <- selectivity(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
selectivity_2.test <- selectivity(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
selectivity_3.test <- selectivity(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
selectivity_4.test <- selectivity(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
selectivity_5.test <- selectivity(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
selectivity_6.test <- selectivity(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
selectivity_7.test <- selectivity(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = TRUE)

# TEST
test_that('no error selectivity_1', {expect_false(inherits(selectivity_1.test, "try-error")) })
test_that('no error selectivity_2', {expect_false(inherits(selectivity_2.test, "try-error")) })
test_that('no error selectivity_3', {expect_false(inherits(selectivity_3.test, "try-error")) })
test_that('no error selectivity_4', {expect_false(inherits(selectivity_4.test, "try-error")) })
test_that('no error selectivity_5', {expect_false(inherits(selectivity_5.test, "try-error")) })
test_that('no error selectivity_6', {expect_false(inherits(selectivity_6.test, "try-error")) })
test_that('no error selectivity_7', {expect_false(inherits(selectivity_7.test, "try-error")) })

# 5.c
TNR_1.test <- TNR(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
TNR_2.test <- TNR(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
TNR_3.test <- TNR(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
TNR_4.test <- TNR(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
TNR_5.test <- TNR(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
TNR_6.test <- TNR(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
TNR_7.test <- TNR(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = TRUE)

# TEST
test_that('no error TNR_1', {expect_false(inherits(TNR_1.test, "try-error")) })
test_that('no error TNR_2', {expect_false(inherits(TNR_2.test, "try-error")) })
test_that('no error TNR_3', {expect_false(inherits(TNR_3.test, "try-error")) })
test_that('no error TNR_4', {expect_false(inherits(TNR_4.test, "try-error")) })
test_that('no error TNR_5', {expect_false(inherits(TNR_5.test, "try-error")) })
test_that('no error TNR_6', {expect_false(inherits(TNR_6.test, "try-error")) })
test_that('no error TNR_7', {expect_false(inherits(TNR_7.test, "try-error")) })

# 6. F-score
fscore_1.test <- fscore(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
fscore_2.test <- fscore(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
fscore_3.test <- fscore(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
fscore_4.test <- fscore(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
fscore_5.test <- fscore(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
fscore_6.test <- fscore(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
fscore_7.test <- fscore(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = TRUE)

# TEST
test_that('no error fscore_1', {expect_false(inherits(fscore_1.test, "try-error")) })
test_that('no error fscore_2', {expect_false(inherits(fscore_2.test, "try-error")) })
test_that('warning', {expect_warning(fscore_3.test, NA)})
test_that('warning', {expect_warning(fscore_4.test, NA)})
test_that('no error fscore_5', {expect_false(inherits(fscore_5.test, "try-error")) })
test_that('no error fscore_6', {expect_false(inherits(fscore_6.test, "try-error")) })
test_that('no error fscore_7', {expect_false(inherits(fscore_7.test, "try-error")) })

# 7. K-hat or Cohen's-Kappa
khat_1.test <- khat(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
khat_2.test <- khat(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
khat_3.test <- khat(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
khat_4.test <- khat(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
khat_5.test <- khat(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
khat_6.test <- khat(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)

# TEST
test_that('no error khat_1', {expect_false(inherits(khat_1.test, "try-error")) })
test_that('no error khat_2', {expect_false(inherits(khat_2.test, "try-error")) })
test_that('no error khat_3', {expect_false(inherits(khat_3.test, "try-error")) })
test_that('no error khat_4', {expect_false(inherits(khat_4.test, "try-error")) })
test_that('no error khat_5', {expect_false(inherits(khat_5.test, "try-error")) })
test_that('no error khat_6', {expect_false(inherits(khat_6.test, "try-error")) })

# 8. Balanced Accuracy
balacc_1.test <- balacc(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
balacc_2.test <- balacc(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
balacc_3.test <- balacc(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
balacc_4.test <- balacc(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
balacc_5.test <- balacc(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
balacc_6.test <- balacc(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)

# TEST
test_that('no error balacc_1', {expect_false(inherits(balacc_1.test, "try-error")) })
test_that('no error balacc_2', {expect_false(inherits(balacc_2.test, "try-error")) })
test_that('no error balacc_3', {expect_false(inherits(balacc_3.test, "try-error")) })
test_that('no error balacc_4', {expect_false(inherits(balacc_4.test, "try-error")) })
test_that('no error balacc_5', {expect_false(inherits(balacc_5.test, "try-error")) })
test_that('no error balacc_6', {expect_false(inherits(balacc_6.test, "try-error")) })

# 9. Fowlkes-Mallows Index
fmi_1.test <- fmi(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
fmi_2.test <- fmi(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
fmi_3.test <- fmi(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
fmi_4.test <- fmi(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
fmi_5.test <- fmi(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
fmi_6.test <- fmi(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)

# TEST
test_that('no error fmi_1', {expect_false(inherits(fmi_1.test, "try-error")) })
test_that('no error fmi_2', {expect_false(inherits(fmi_2.test, "try-error")) })
test_that('warning', {expect_warning(fmi_3.test, NA)})
test_that('warning', {expect_warning(fmi_4.test, NA)})
test_that('no error fmi_5', {expect_false(inherits(fmi_5.test, "try-error")) })
test_that('no error fmi_5', {expect_false(inherits(fmi_6.test, "try-error")) })

# 10. Matthews Correlation Coefficient
mcc_1.test <- mcc(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
mcc_2.test <- mcc(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
mcc_3.test <- mcc(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
mcc_4.test <- mcc(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
mcc_5.test <- mcc(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
mcc_6.test <- mcc(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)

# TEST
test_that('no error mcc_1', {expect_false(inherits(mcc_1.test, "try-error")) })
test_that('no error mcc_2', {expect_false(inherits(mcc_2.test, "try-error")) })
test_that('no error mcc_3', {expect_false(inherits(mcc_3.test, "try-error")) })
test_that('no error mcc_4', {expect_false(inherits(mcc_4.test, "try-error")) })
test_that('no error mcc_5', {expect_false(inherits(mcc_5.test, "try-error")) })
test_that('no error mcc_6', {expect_false(inherits(mcc_6.test, "try-error")) })

# 11. BMI, Informedness, Youden's J-index
bmi_1.test <- bmi(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
bmi_2.test <- bmi(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
bmi_3.test <- bmi(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
bmi_4.test <- bmi(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
bmi_5.test <- bmi(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
bmi_6.test <- bmi(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
bmi_7.test <- bmi(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2, atom = TRUE)

# TEST
test_that('no error bmi_1', {expect_false(inherits(bmi_1.test, "try-error")) })
test_that('no error bmi_2', {expect_false(inherits(bmi_2.test, "try-error")) })
test_that('no error bmi_3', {expect_false(inherits(bmi_3.test, "try-error")) })
test_that('no error bmi_4', {expect_false(inherits(bmi_4.test, "try-error")) })
test_that('no error bmi_5', {expect_false(inherits(bmi_5.test, "try-error")) })
test_that('no error bmi_6', {expect_false(inherits(bmi_6.test, "try-error")) })
test_that('no error bmi_7', {expect_false(inherits(bmi_7.test, "try-error")) })

# 12. AGF
agf_1.test <- agf(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
agf_2.test <- agf(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
agf_3.test <- agf(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
agf_4.test <- agf(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
agf_5.test <- agf(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
agf_6.test <- agf(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
agf_7.test <- agf(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = TRUE)

# TEST
test_that('no error agf_1', {expect_false(inherits(agf_1.test, "try-error")) })
test_that('no error agf_2', {expect_false(inherits(agf_2.test, "try-error")) })
test_that('warning', {expect_warning(agf_3.test, NA)})
test_that('warning', {expect_warning(agf_4.test, NA)})
test_that('no error agf_5', {expect_false(inherits(agf_5.test, "try-error")) })
test_that('no error agf_6', {expect_false(inherits(agf_6.test, "try-error")) })
test_that('no error agf_7', {expect_false(inherits(agf_7.test, "try-error")) })

# 13. Gmean
gmean_1.test <- gmean(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
gmean_2.test <- gmean(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
gmean_3.test <- gmean(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
gmean_4.test <- gmean(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
gmean_5.test <- gmean(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
gmean_6.test <- gmean(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
gmean_7.test <- gmean(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2, atom = TRUE)

# TEST
test_that('no error gmean_1', {expect_false(inherits(gmean_1.test, "try-error")) })
test_that('no error gmean_2', {expect_false(inherits(gmean_2.test, "try-error")) })
test_that('no error gmean_3', {expect_false(inherits(gmean_3.test, "try-error")) })
test_that('no error gmean_4', {expect_false(inherits(gmean_4.test, "try-error")) })
test_that('no error gmean_5', {expect_false(inherits(gmean_5.test, "try-error")) })
test_that('no error gmean_6', {expect_false(inherits(gmean_6.test, "try-error")) })
test_that('no error gmean_7', {expect_false(inherits(gmean_7.test, "try-error")) })

# 14. npv
npv_1.test <- npv(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
npv_2.test <- npv(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
npv_3.test <- npv(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
npv_4.test <- npv(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
npv_5.test <- npv(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
npv_6.test <- npv(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
npv_7.test <- npv(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = TRUE)

# TEST
test_that('no error npv_1', {expect_false(inherits(npv_1.test, "try-error")) })
test_that('no error npv_2', {expect_false(inherits(npv_2.test, "try-error")) })
test_that('no error npv_3', {expect_false(inherits(npv_3.test, "try-error")) })
test_that('no error npv_4', {expect_false(inherits(npv_4.test, "try-error")) })
test_that('no error npv_5', {expect_false(inherits(npv_5.test, "try-error")) })
test_that('no error npv_6', {expect_false(inherits(npv_6.test, "try-error")) })
test_that('no error npv_6', {expect_false(inherits(npv_7.test, "try-error")) })

# 15. posLr
posLr_1.test <- posLr(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
posLr_2.test <- posLr(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
posLr_3.test <- posLr(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
posLr_4.test <- posLr(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
posLr_5.test <- posLr(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
posLr_6.test <- posLr(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
posLr_7.test <- posLr(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2, atom = TRUE)

# TEST
test_that('no error posLr_1', {expect_false(inherits(posLr_1.test, "try-error")) })
test_that('no error posLr_2', {expect_false(inherits(posLr_2.test, "try-error")) })
test_that('no error posLr_3', {expect_false(inherits(posLr_3.test, "try-error")) })
test_that('no error posLr_4', {expect_false(inherits(posLr_4.test, "try-error")) })
test_that('no error posLr_5', {expect_false(inherits(posLr_5.test, "try-error")) })
test_that('no error posLr_6', {expect_false(inherits(posLr_6.test, "try-error")) })
test_that('no error posLr_7', {expect_false(inherits(posLr_7.test, "try-error")) })

# 16. negLr
negLr_1.test <- negLr(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
negLr_2.test <- negLr(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
negLr_3.test <- negLr(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
negLr_4.test <- negLr(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
negLr_5.test <- negLr(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
negLr_6.test <- negLr(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
negLr_7.test <- negLr(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2, atom = TRUE)

# TEST
test_that('no error negLr_1', {expect_false(inherits(negLr_1.test, "try-error")) })
test_that('no error negLr_2', {expect_false(inherits(negLr_2.test, "try-error")) })
test_that('no error negLr_3', {expect_false(inherits(negLr_3.test, "try-error")) })
test_that('no error negLr_4', {expect_false(inherits(negLr_4.test, "try-error")) })
test_that('no error negLr_5', {expect_false(inherits(negLr_5.test, "try-error")) })
test_that('no error negLr_6', {expect_false(inherits(negLr_6.test, "try-error")) })
test_that('no error negLr_7', {expect_false(inherits(negLr_7.test, "try-error")) })

# 17. dor
dor_1.test <- dor(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
dor_2.test <- dor(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
dor_3.test <- dor(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
dor_4.test <- dor(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
dor_5.test <- dor(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
dor_6.test <- dor(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
dor_7.test <- dor(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2, atom = TRUE)

# TEST
test_that('no error dor_1', {expect_false(inherits(dor_1.test, "try-error")) })
test_that('no error dor_2', {expect_false(inherits(dor_2.test, "try-error")) })
test_that('no error dor_3', {expect_false(inherits(dor_3.test, "try-error")) })
test_that('no error dor_4', {expect_false(inherits(dor_4.test, "try-error")) })
test_that('no error dor_5', {expect_false(inherits(dor_5.test, "try-error")) })
test_that('no error dor_6', {expect_false(inherits(dor_6.test, "try-error")) })
test_that('no error dor_7', {expect_false(inherits(dor_7.test, "try-error")) })

# 18. preval
preval_1.test <- preval(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
preval_2.test <- preval(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
preval_3.test <- preval(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
preval_4.test <- preval(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
preval_5.test <- preval(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
preval_6.test <- preval(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
preval_7.test <- preval(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2, atom = TRUE)
preval_8.test <- preval(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2, atom = TRUE)

# TEST
test_that('no error preval_1', {expect_false(inherits(preval_1.test, "try-error")) })
test_that('no error preval_2', {expect_false(inherits(preval_2.test, "try-error")) })
test_that('warning', {expect_warning(preval_3.test, NA)})
test_that('warning', {expect_warning(preval_4.test, NA)})
test_that('no error preval_5', {expect_false(inherits(preval_5.test, "try-error")) })
test_that('no error preval_6', {expect_false(inherits(preval_6.test, "try-error")) })
test_that('no error preval_7', {expect_false(inherits(preval_6.test, "try-error")) })
test_that('no error preval_8', {expect_false(inherits(preval_6.test, "try-error")) })

# 19. preval_t
preval_t_1.test <- preval_t(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
preval_t_2.test <- preval_t(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
preval_t_3.test <- preval_t(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
preval_t_4.test <- preval_t(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
preval_t_5.test <- preval_t(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
preval_t_6.test <- preval_t(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
preval_t_7.test <- preval_t(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2, atom = TRUE)
preval_t_8.test <- preval_t(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2, atom = TRUE)

# TEST
test_that('no error preval_t_1', {expect_false(inherits(preval_t_1.test, "try-error")) })
test_that('no error preval_t_2', {expect_false(inherits(preval_t_2.test, "try-error")) })
test_that('warning', {expect_warning(preval_t_3.test, NA)})
test_that('warning', {expect_warning(preval_t_4.test, NA)})
test_that('no error preval_t_5', {expect_false(inherits(preval_t_5.test, "try-error")) })
test_that('no error preval_t_6', {expect_false(inherits(preval_t_6.test, "try-error")) })
test_that('no error preval_t_7', {expect_false(inherits(preval_t_8.test, "try-error")) })
test_that('no error preval_t_8', {expect_false(inherits(preval_t_8.test, "try-error")) })

# 20. FOR
FOR_1.test <- FOR(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
FOR_2.test <- FOR(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
FOR_3.test <- FOR(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
FOR_4.test <- FOR(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
FOR_5.test <- FOR(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
FOR_6.test <- FOR(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
FOR_7.test <- FOR(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = TRUE)

# TEST
test_that('no error FOR_1', {expect_false(inherits(FOR_1.test, "try-error")) })
test_that('no error FOR_2', {expect_false(inherits(FOR_2.test, "try-error")) })
test_that('no error FOR_3', {expect_false(inherits(FOR_3.test, "try-error")) })
test_that('no error FOR_4', {expect_false(inherits(FOR_4.test, "try-error")) })
test_that('no error FOR_5', {expect_false(inherits(FOR_5.test, "try-error")) })
test_that('no error FOR_6', {expect_false(inherits(FOR_6.test, "try-error")) })
test_that('no error FOR_7', {expect_false(inherits(FOR_7.test, "try-error")) })

# 21. FPR
FPR_1.test <- FPR(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
FPR_2.test <- FPR(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
FPR_3.test <- FPR(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
FPR_4.test <- FPR(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
FPR_5.test <- FPR(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
FPR_6.test <- FPR(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
FPR_7.test <- FPR(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = TRUE)

# TEST
test_that('no error FPR_1', {expect_false(inherits(FPR_1.test, "try-error")) })
test_that('no error FPR_2', {expect_false(inherits(FPR_2.test, "try-error")) })
test_that('no error FPR_3', {expect_false(inherits(FPR_3.test, "try-error")) })
test_that('no error FPR_4', {expect_false(inherits(FPR_4.test, "try-error")) })
test_that('no error FPR_5', {expect_false(inherits(FPR_5.test, "try-error")) })
test_that('no error FPR_6', {expect_false(inherits(FPR_6.test, "try-error")) })
test_that('no error FPR_7', {expect_false(inherits(FPR_7.test, "try-error")) })

# 22. FNR
FNR_1.test <- FNR(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
FNR_2.test <- FNR(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
FNR_3.test <- FNR(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
FNR_4.test <- FNR(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
FNR_5.test <- FNR(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
FNR_6.test <- FNR(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
FNR_7.test <- FNR(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, atom = TRUE)


# TEST
test_that('no error FNR_1', {expect_false(inherits(FNR_1.test, "try-error")) })
test_that('no error FNR_2', {expect_false(inherits(FNR_2.test, "try-error")) })
test_that('no error FNR_3', {expect_false(inherits(FNR_3.test, "try-error")) })
test_that('no error FNR_4', {expect_false(inherits(FNR_4.test, "try-error")) })
test_that('no error FNR_5', {expect_false(inherits(FNR_5.test, "try-error")) })
test_that('no error FNR_6', {expect_false(inherits(FNR_6.test, "try-error")) })
test_that('no error FNR_7', {expect_false(inherits(FNR_7.test, "try-error")) })

# 23. FDR
FDR_1.test <- FDR(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
FDR_2.test <- FDR(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
FDR_3.test <- FDR(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
FDR_4.test <- FDR(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
FDR_5.test <- FDR(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
FDR_6.test <- FDR(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
FDR_7.test <- FDR(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = TRUE)

# TEST
test_that('no error FDR_1', {expect_false(inherits(FDR_1.test, "try-error")) })
test_that('no error FDR_2', {expect_false(inherits(FDR_2.test, "try-error")) })
test_that('no error FDR_3', {expect_false(inherits(FDR_3.test, "try-error")) })
test_that('no error FDR_4', {expect_false(inherits(FDR_4.test, "try-error")) })
test_that('no error FDR_5', {expect_false(inherits(FDR_5.test, "try-error")) })
test_that('no error FDR_6', {expect_false(inherits(FDR_6.test, "try-error")) })
test_that('no error FDR_6', {expect_false(inherits(FDR_7.test, "try-error")) })

# 24. CSI
csi_1.test <- csi(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
csi_2.test <- csi(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
csi_3.test <- csi(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
csi_4.test <- csi(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
csi_5.test <- csi(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
csi_6.test <- csi(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
csi_7.test <- csi(data = multiclass, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2, atom = TRUE)

# TEST
test_that('no error csi_1', {expect_false(inherits(csi_1.test, "try-error")) })
test_that('no error csi_2', {expect_false(inherits(csi_2.test, "try-error")) })
test_that('no error csi_3', {expect_false(inherits(csi_3.test, "try-error")) })
test_that('no error csi_4', {expect_false(inherits(csi_4.test, "try-error")) })
test_that('no error csi_5', {expect_false(inherits(csi_5.test, "try-error")) })
test_that('no error csi_6', {expect_false(inherits(csi_6.test, "try-error")) })
test_that('no error csi_7', {expect_false(inherits(csi_7.test, "try-error")) })

# 25. deltap
deltap_1.test <- deltap(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 1)
deltap_2.test <- deltap(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 1)
deltap_3.test <- deltap(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
deltap_4.test <- deltap(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
deltap_5.test <- deltap(data = binary, obs = labels, pred = predictions, tidy = FALSE, pos_level = 2)
deltap_6.test <- deltap(data = binary, obs = labels, pred = predictions, tidy = TRUE, pos_level = 2)
deltap_7.test <- deltap(data = multiclass, obs = labels, pred = predictions, tidy = FALSE, atom = TRUE)

# TEST
test_that('no error deltap_1', {expect_false(inherits(deltap_1.test, "try-error")) })
test_that('no error deltap_2', {expect_false(inherits(deltap_2.test, "try-error")) })
test_that('no error deltap_3', {expect_false(inherits(deltap_3.test, "try-error")) })
test_that('no error deltap_4', {expect_false(inherits(deltap_4.test, "try-error")) })
test_that('no error deltap_5', {expect_false(inherits(deltap_5.test, "try-error")) })
test_that('no error deltap_6', {expect_false(inherits(deltap_6.test, "try-error")) })
test_that('no error deltap_7', {expect_false(inherits(deltap_7.test, "try-error")) })

# 26. AUC_roc
AUC_roc_1.test <- AUC_roc(data = binary, obs = labels, pred = predictions, tidy = FALSE)
AUC_roc_2.test <- AUC_roc(data = binary, obs = labels, pred = predictions, tidy = TRUE)
AUC_roc_3.test <- AUC_roc(data = multiclass, obs = labels, pred = predictions, tidy = FALSE)
AUC_roc_4.test <- AUC_roc(data = multiclass, obs = labels, pred = predictions, tidy = TRUE)
# TEST
test_that('no error AUC_roc_1', {expect_false(inherits(AUC_roc_1.test, "try-error")) })
test_that('no error AUC_roc_2', {expect_false(inherits(AUC_roc_2.test, "try-error")) })
test_that('no error AUC_roc_3', {expect_false(inherits(AUC_roc_3.test, "try-error")) })
test_that('no error AUC_roc_4', {expect_false(inherits(AUC_roc_4.test, "try-error")) })


# 25. Classification Metrics Summary
metrics_summary_1.test <- metrics_summary(data = binary, obs = labels, pred = predictions, type = "classification")

# TEST
test_that('no error metrics_summary_1', {expect_false(inherits(metrics_summary_1.test, "try-error")) })


#################

selected_metrics_1 <- c("accuracy")
selected_metrics_2 <- c("accuracy", "precision")
selected_metrics_3 <- c("accuracy", "precision", "recall")
selected_metrics_4 <- c("accuracy", "precision", "recall", "khat")
selected_metrics_5 <- c("accuracy", "precision", "recall", "khat","mcc")
selected_metrics_6 <- c("accuracy", "precision", "recall", "khat","mcc", "fscore")
selected_metrics_7 <- c("accuracy", "precision", "recall", "khat","mcc", "fscore", "agf")
selected_metrics_8 <- c("accuracy", "precision", "recall", "khat","mcc", "fscore", "agf", "npv")
selected_metrics_9 <- c("accuracy", "precision", "recall", "khat","mcc", "fscore", "agf", "npv", "FPR")
selected_metrics_10 <- c("accuracy", "precision", "recall", "khat","mcc", "fscore", "agf", "npv", "FPR", "FNR")

cm_bin_1 <- confusion_matrix(data = binary, obs = labels, pred = predictions,
                             plot = TRUE,
                             colors = c(low="#ffe8d6" , high="#892b64"), 
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_1,
                             position_metrics = "bottom", 
                             unit = "proportion")

cm_bin_2 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                             plot = TRUE,
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_2,
                             position_metrics = "bottom")

cm_bin_3 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                             plot = TRUE,
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_3,
                             position_metrics = "bottom")

cm_bin_4 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                             plot = TRUE,
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_4,
                             position_metrics = "bottom")

cm_bin_5 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                             plot = TRUE,
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_5,
                             position_metrics = "bottom")

cm_bin_6 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                             plot = TRUE,
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_6,
                             position_metrics = "bottom")

cm_bin_7 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                             plot = TRUE,
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_7,
                             position_metrics = "bottom")

cm_bin_8 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                             plot = TRUE,
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_8,
                             position_metrics = "bottom")

cm_bin_9 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                             plot = TRUE,
                             colors = c(low="#ffe8d6" , high="#892b64"), 
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_9,
                             position_metrics = "bottom")

cm_bin_10 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                             plot = TRUE,
                             colors = c(low="#ffe8d6" , high="#892b64"), 
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_10,
                             position_metrics = "bottom")


# TEST
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_1, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_2, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_3, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_4, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_5, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_6, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_7, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_8, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_9, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_10, "try-error")) })


cm_bin_top_1 <- confusion_matrix(data = binary, obs = labels, pred = predictions,
                             plot = TRUE,
                             colors = c(low="#ffe8d6" , high="#892b64"), 
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_1,
                             position_metrics = "top")

cm_bin_top_2 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                             plot = TRUE,
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_2,
                             position_metrics = "top")

cm_bin_top_3 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                             plot = TRUE,
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_3,
                             position_metrics = "top")

cm_bin_top_4 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                             plot = TRUE,
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_4,
                             position_metrics = "top")

cm_bin_top_5 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                             plot = TRUE,
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_5,
                             position_metrics = "top")

cm_bin_top_6 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                             plot = TRUE,
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_6,
                             position_metrics = "top")

cm_bin_top_7 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                             plot = TRUE,
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_7,
                             position_metrics = "top")

cm_bin_top_8 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                             plot = TRUE,
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_8,
                             position_metrics = "top")

cm_bin_top_9 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                             plot = TRUE,
                             colors = c(low="#ffe8d6" , high="#892b64"), 
                             print_metrics = TRUE,
                             metrics_list = selected_metrics_9,
                             position_metrics = "top")

cm_bin_top_10 <- confusion_matrix(data = binary, obs = labels, pred = predictions, 
                              plot = TRUE,
                              colors = c(low="#ffe8d6" , high="#892b64"), 
                              print_metrics = TRUE,
                              metrics_list = selected_metrics_10,
                              position_metrics = "top")

# TEST
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_top_1, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_top_2, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_top_3, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_top_4, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_top_5, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_top_6, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_top_7, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_top_8, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_top_9, "try-error")) })
test_that('no error confusion_matrix_1', {expect_false(inherits(cm_bin_top_10, "try-error")) })

