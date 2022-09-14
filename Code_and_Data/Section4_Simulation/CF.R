#
# Control function approach ----------------------------------------------------
#

cohort_sim$deltahat  <- cohort_sim$X - cohort_sim$stIV_Xhat
cohort_sim$deltahatZ <- cohort_sim$deltahat*Z


if(scenario == 2){
  
  CFfit                <- glm(Y1 ~ X + W1 + deltahat + deltahatZ, data = cohort_sim) 
  
}else{
  
  CFfit                <- glm(Y1 ~ X + W1 + Y0 + deltahat + deltahatZ, data = cohort_sim) 
  
}

marCF                <- summary(margins(CFfit, variables = "X"))

CF[i]              <- as.numeric(marCF$AME["X"])                    # CF estimate (risk difference scale)
se_CF[i]           <- marCF$SE                                             
lower_CF[i]        <- marCF$lower
upper_CF[i]        <- marCF$upper
z_statistics_CF[i] <- CF[i]/se_CF[i]




