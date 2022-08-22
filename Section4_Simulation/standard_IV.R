#
# Standard Instrumental Variable Method ----------------------------------------
#


fit1stIV             <- glm(X ~ W1 + Z, family = binomial("logit"), data = cohort_sim)   
stIV_Xhat            <- fitted(fit1stIV)
cohort_sim$stIV_Xhat <- stIV_Xhat


if(scenario == 2){
  
  stIVfit     <- glm(Y1 ~ stIV_Xhat + W1 + Y0, data = cohort_sim) 
  
}else{
  
  stIVfit     <- glm(Y1 ~ stIV_Xhat + W1, data = cohort_sim) 
  
}

marstIV              <- summary(margins(stIVfit, variables = "stIV_Xhat"))

stIV[i]              <- as.numeric(marstIV$AME["stIV_Xhat"])                    # standard IV estimate (risk difference scale)
se_stIV[i]           <- marstIV$SE                                             
lower_stIV[i]        <- marstIV$lower
upper_stIV[i]        <- marstIV$upper
z_statistics_stIV[i] <- stIV[i]/se_stIV[i]




