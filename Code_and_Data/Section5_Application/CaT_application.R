#
# corrected as Treated estimate (Multivariable Regression) ---------------------
#


CaT_fit      <- glm(study_period ~ treatment + base_bmi_2treat + base_hba1c_2treat + base_eGFR_2treat + 
                    T2D_duration_2treat + gender + year_2treat + age_2treat + prior_period, 
                    family = binomial("logit"), data = cohort_newIV)   



mar_CaT      <- summary(margins(CaT_fit, variables = "treatment"))

CaT          <- as.numeric(mar_CaT$AME["treatment"])                                   # estimate (risk difference scale)
se_CaT       <- mar_CaT$SE                                                     
lower_CaT    <- mar_CaT$lower
upper_CaT    <- mar_CaT$upper







