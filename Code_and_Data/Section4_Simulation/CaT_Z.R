#
# CaT Method (Multivariable Regression) --------------------------------------
#


if(scenario == 2){
  
  CaT_fit     <- glm(Y1 ~ X + W1 + Z + Y0, family = binomial("logit"), data = cohort_sim)
  
}else{
  
  CaT_fit     <- glm(Y1 ~ X + W1 + Z, family = binomial("logit"), data = cohort_sim)
  
}


mar_CaT       <- summary(margins(CaT_fit, variables = "X"))

CaT[i]              <- as.numeric(mar_CaT$AME["X"])                           # estimate (risk difference scale)
se_CaT[i]           <- mar_CaT$SE                                                     
lower_CaT[i]        <- mar_CaT$lower
upper_CaT[i]        <- mar_CaT$upper
z_statistics_CaT[i] <- CaT[i]/se_CaT[i]



