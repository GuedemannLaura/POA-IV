#
# CaT Method (Multivariable Regression) --------------------------------------
#


if(with_Z == FALSE){
  
  CaT_fit    <- glm(Y1 ~ X + W1, family = binomial("logit"), data = cohort_sim)
  
}else{
  
  CaT_fit    <- glm(Y1 ~ X + W1 + Z, family = binomial("logit"), data = cohort_sim)
  
}
   

mar_CaT      <- summary(margins(CaT_fit, variables = "X"))

CaT_o        <- as.numeric(mar_CaT$AME["X"])                                   # estimate (risk difference scale)






