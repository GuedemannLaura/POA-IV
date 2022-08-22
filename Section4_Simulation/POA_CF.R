#
# POA-CF Method -----------------------------------------------------------------
#

cohort_sim$POA_deltahat  <- cohort_sim$X - cohort_sim$POAIV_Xhat
cohort_sim$POA_deltahatZ <- cohort_sim$POA_deltahat*cohort_sim$Z



if(scenario == 2){
  
  POACF_fit   <- glm(Y1 ~ X + W1 + Y0 + Z + POA_deltahat + POA_deltahatZ, family = binomial(link = "logit"), data = cohort_sim)    
  
}else{
  
  POACF_fit   <- glm(Y1 ~ X + W1 + Z + POA_deltahat + POA_deltahatZ, family = binomial(link = "logit"), data = cohort_sim)    
  
}


marPOACF              <- summary(margins(POACF_fit, variables = "X"))
POACF[i]              <- as.numeric(marPOACF$AME["X"])                    # estimate of the POA-CF method (risk difference scale)
se_POACF[i]           <- marPOACF$SE                                        
lower_POACF[i]        <- marPOACF$lower
upper_POACF[i]        <- marPOACF$upper
z_statistics_POACF[i] <- POACF[i]/se_POACF[i]





