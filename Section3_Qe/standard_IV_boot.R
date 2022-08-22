#
# Standard Instrumental Variable Method ----------------------------------------
#

fit1stIV             <- glm(X ~ W1 + Z, family = binomial("logit"), data = bootstrap_data)   
stIV_Xhat            <- fitted(fit1stIV)
bootstrap_data$stIV_Xhat <- stIV_Xhat

#stIVfit              <- glm(Y1 ~ stIV_Xhat + W1 + Y0, data = bootstrap_data) 

#marstIV              <- summary(margins(stIVfit, variables = "stIV_Xhat"))

#stIV[j]              <- as.numeric(marstIV$AME["stIV_Xhat"])                    # standard IV estimate (risk difference scale)
#se_stIV[j]           <- marstIV$SE                                             
#lower_stIV[j]        <- marstIV$lower
#upper_stIV[j]        <- marstIV$upper




