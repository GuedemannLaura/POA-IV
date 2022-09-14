#
# Standard Instrumental Variable Method ----------------------------------------
#



cohort_newIV$delta_hat  <- cohort_newIV$treatment - cohort_newIV$stIV_Xhat
cohort_newIV$delta_hatZ <- cohort_newIV$delta_hat*cohort_newIV$new_IV


CFfit                <- glm(study_period ~ treatment + base_bmi_2treat + base_hba1c_2treat + 
                              base_eGFR_2treat + T2D_duration_2treat + gender + year_2treat + 
                              age_2treat + prior_period + delta_hat + delta_hatZ, 
                              family = binomial("logit"), data = cohort_newIV) 


marCF                <- summary(margins(CFfit, variables = "treatment"))

CF                   <- as.numeric(marCF$AME["treatment"])                    # CF estimate (risk difference scale)
se_CF                <- marCF$SE                                             
lower_CF             <- marCF$lower
upper_CF             <- marCF$upper




