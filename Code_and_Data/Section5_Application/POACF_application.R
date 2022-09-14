#
# POA-CF -------------------------------------------------------------------------
#



cohort_newIV$POACF_delta_hat  <- cohort_newIV$treatment - cohort_newIV$POAIV_Xhat
cohort_newIV$POACF_delta_hatZ <- cohort_newIV$POACF_delta_hat*cohort_newIV$new_IV
  

POACF_fit               <- glm(study_period ~ treatment + base_bmi_2treat + base_hba1c_2treat + base_eGFR_2treat +  
                              T2D_duration_2treat + gender + year_2treat + age_2treat + prior_period +
                                POACF_delta_hat + POACF_delta_hatZ + new_IV_chr, 
                              family = binomial(link = "logit"),data = cohort_newIV)  

marPOACF                <- summary(margins(POACF_fit, variables = "treatment"))
POACF                   <- as.numeric(marPOACF$AME["treatment"])                    # estimate of the POA-CF method (risk difference scale)
se_POACF                <- marPOACF$SE                                        
lower_POACF             <- marPOACF$lower
upper_POACF             <- marPOACF$upper






