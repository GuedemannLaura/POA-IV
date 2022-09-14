#
# Control function approach ----------------------------------------------------
#

bootstrap_data$deltahat  <- bootstrap_data$X - bootstrap_data$stIV_Xhat
bootstrap_data$deltahatZ <- bootstrap_data$deltahat*Z


if(scenario == 2){
  
  CFfit                <- glm(Y1 ~ X + W1 + deltahat + deltahatZ, data = bootstrap_data) 
  
}else{
  
  CFfit                <- glm(Y1 ~ X + W1 + Y0 + deltahat + deltahatZ, data = bootstrap_data) 
  
}

marCF              <- summary(margins(CFfit, variables = "X"))

CF[j]              <- as.numeric(marCF$AME["X"])                    # CF estimate (risk difference scale)
se_CF[j]           <- marCF$SE                                             
lower_CF[j]        <- marCF$lower
upper_CF[j]        <- marCF$upper




