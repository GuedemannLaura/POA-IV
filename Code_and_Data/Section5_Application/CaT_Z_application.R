#
# corrected as Treated estimate (Multivariable Regression) ---------------------
#

CaT_fit_Z      <- glm(study_period ~ treatment + base_bmi_2treat + base_hba1c_2treat + base_eGFR_2treat + 
                    T2D_duration_2treat + gender + year_2treat + age_2treat + new_IV + prior_period, 
                    family = binomial("logit"), data = cohort_newIV)   



mar_CaT_Z      <- summary(margins(CaT_fit_Z, variables = "treatment"))

CaT_Z          <- as.numeric(mar_CaT_Z$AME["treatment"])                                   # estimate (risk difference scale)
se_CaT_Z       <- mar_CaT_Z$SE                                                     
lower_CaT_Z    <- mar_CaT_Z$lower
upper_CaT_Z    <- mar_CaT_Z$upper







