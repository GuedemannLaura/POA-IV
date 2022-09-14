#
# DiD Approach ------------------------------------------------------------
#
# Difference in Difference Regression


DiD_fit      <- glm(Y ~ P + D_treat + P_D_treat_int + HbA1c + BMI + eGFR + Year + Age + T2Dduration + Gender + 
                         HbA1c_P_int + BMI_P_int + eGFR_P_int + Year_P_int + Age_P_int + T2Dduration_P_int + Gender_P_int, 
                         family = binomial("logit"), data = DiD_reg_data)


mar_DiD      <- summary(margins(DiD_fit, variables = "P_D_treat_int"))

DiD          <- as.numeric(mar_DiD$AME["P_D_treat_int"])
se_DiD       <- mar_DiD$SE
lower_DiD    <- mar_DiD$lower
upper_DiD    <- mar_DiD$upper


