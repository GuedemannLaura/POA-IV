#
# CaT Method (Multivariable Regression) --------------------------------------
#


if(with_Z == FALSE){
  
  CaT_fit    <- glm(Y1 ~ X + W1, family = binomial("logit"), data = bootstrap_data)
  
}else{
  
  CaT_fit    <- glm(Y1 ~ X + W1 + Z, family = binomial("logit"), data = bootstrap_data)
  
}
   

mar_CaT      <- summary(margins(CaT_fit, variables = "X"))

CaT[j]       <- as.numeric(mar_CaT$AME["X"])                                   # estimate (risk difference scale)
se_CaT[j]    <- mar_CaT$SE                                                     
lower_CaT[j] <- mar_CaT$lower
upper_CaT[j] <- mar_CaT$upper





