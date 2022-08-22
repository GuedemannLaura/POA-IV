#
# DiD Approach -----------------------------------------------------------------
#

# Difference in Difference Regression 

DiD_fit      <- glm(Y ~ P + D_treat + P_D_treat_int + W + W_P_int + Z_did + Z_P_int, family = binomial("logit"), data = DiD_reg_data)

mar_DiD      <- summary(margins(DiD_fit, variables = "P_D_treat_int"))

DiD[i]              <- as.numeric(mar_DiD$AME["P_D_treat_int"])
se_DiD[i]           <- mar_DiD$SE
lower_DiD[i]        <- mar_DiD$lower
upper_DiD[i]        <- mar_DiD$upper
z_statistics_DiD[i] <- DiD[i]/se_DiD[i]
