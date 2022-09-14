#
# Standard Instrumental Variable Method ----------------------------------------
#

fit1stIV             <- glm(X ~ W1 + Z, family = binomial("logit"), data = cohort_sim)   
stIV_Xhat            <- fitted(fit1stIV)
cohort_sim$stIV_Xhat <- stIV_Xhat

#stIVfit              <- glm(Y1 ~ stIV_Xhat + W1, data = cohort_sim) 

#marstIV              <- summary(margins(stIVfit, variables = "stIV_Xhat"))

#stIV_o               <- as.numeric(marstIV$AME["stIV_Xhat"])                    # standard IV estimate (risk difference scale)





