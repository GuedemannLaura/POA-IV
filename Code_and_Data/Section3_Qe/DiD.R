#
# DiD Approach -----------------------------------------------------------------
#

# Difference in Difference Regression

if(with_Z == FALSE){
  
  DiD_fit  <- glm(Y ~ P + D_treat + P_D_treat_int + W + W_P_int, family = binomial("logit"), data = DiD_reg_data_o)
  
}else{
  
  DiD_fit      <- glm(Y ~ P + D_treat + P_D_treat_int + W + W_P_int + Z_did + Z_P_int, family = binomial("logit"), data = DiD_reg_data_o)
  
}


mar_DiD      <- summary(margins(DiD_fit, variables = "P_D_treat_int"))

DiD_o        <- as.numeric(mar_DiD$AME["P_D_treat_int"])

