#
# DiD Approach ------------------------------------------------------------
#
# Difference in Difference Regression


# Model for the full cohort:

DiD_fit_Z      <- glm(Y ~ P + D_treat + P_D_treat_int + HbA1c + BMI + eGFR + Year + Age + T2Dduration + Gender + 
                         HbA1c_P_int + BMI_P_int + eGFR_P_int + Year_P_int + Age_P_int + T2Dduration_P_int + 
                         Gender_P_int + as.character(IV) + as.character(IV_P_int), 
                         family = binomial("logit"), data = DiD_reg_data)


mar_DiD_Z      <- summary(margins(DiD_fit_Z, variables = "P_D_treat_int"))

DiD_Z          <- as.numeric(mar_DiD_Z$AME["P_D_treat_int"])
se_DiD_Z       <- mar_DiD_Z$SE
lower_DiD_Z    <- mar_DiD_Z$lower
upper_DiD_Z    <- mar_DiD_Z$upper


