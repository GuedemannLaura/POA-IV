#
# POA-IV Method -----------------------------------------------------------------
#

fit1POAIV             <- glm(X ~ W1 + Y0 + Z + Y0Z_int, family = binomial, data = cohort_sim)
POAIV_Xhat            <- fit1POAIV$fitted 

cohort_sim$POAIV_Xhat <- POAIV_Xhat

  
POAIV_fit           <- glm(Y1 ~ POAIV_Xhat + W1 + Z + Y0, family = binomial(link = "logit"), data = cohort_sim)    
  
marPOAIV              <- summary(margins(POAIV_fit, variables = "POAIV_Xhat"))
POAIV[i]              <- as.numeric(marPOAIV$AME["POAIV_Xhat"])                    # estimate of the POA-IV method (risk difference scale)
se_POAIV[i]           <- marPOAIV$SE                                        
lower_POAIV[i]        <- marPOAIV$lower
upper_POAIV[i]        <- marPOAIV$upper
z_statistics_POAIV[i] <- POAIV[i]/se_POAIV[i]






