#
# Standard Instrumental Variable Method ----------------------------------------
#


fit1stIV               <- glm(treatment ~ base_bmi_2treat + base_hba1c_2treat + base_eGFR_2treat + 
                              T2D_duration_2treat + gender + year_2treat + age_2treat + prior_period 
                              + new_IV_chr, 
                              family = binomial("logit"), data = cohort_newIV)


stIV_Xhat              <- fitted(fit1stIV)
cohort_newIV$stIV_Xhat <- stIV_Xhat


# Model for the full cohort:

stIVfit                <- glm(study_period ~ stIV_Xhat + base_bmi_2treat + base_hba1c_2treat + base_eGFR_2treat + 
                              T2D_duration_2treat + gender + year_2treat + age_2treat + prior_period, 
                              family = binomial("logit"), data = cohort_newIV) 


marstIV                <- summary(margins(stIVfit, variables = "stIV_Xhat"))

stIV                   <- as.numeric(marstIV$AME["stIV_Xhat"])                    # standard IV estimate (risk difference scale)
se_stIV                <- marstIV$SE                                             
lower_stIV             <- marstIV$lower
upper_stIV             <- marstIV$upper




