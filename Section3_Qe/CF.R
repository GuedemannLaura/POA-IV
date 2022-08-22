#
# Control function approach ----------------------------------------------------
#

cohort_sim$deltahat  <- cohort_sim$X - cohort_sim$stIV_Xhat
cohort_sim$deltahatZ <- cohort_sim$deltahat*Z

CFfit                <- glm(Y1 ~ X + W1 + deltahat + deltahatZ, data = cohort_sim) 

marCF                <- summary(margins(CFfit, variables = "X"))

CF_o                 <- as.numeric(marCF$AME["X"])                    # CF estimate (risk difference scale)




