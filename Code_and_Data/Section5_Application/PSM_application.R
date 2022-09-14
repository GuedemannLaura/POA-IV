#
# Propensity Score Matching (PSM) ----------------------------------------------
#

# needs to be applied on a complete case dataset

# create matched sample ----

mod_match <- matchit(as.factor(treatment)~as.factor(gender) + as.factor(prior_period) + age_1treat + 
                       base_bmi_1treat + base_hba1c_1treat + base_eGFR_1treat + T2D_duration_1treat + year_2treat, 
                       method = "nearest", data = cohort_newIV)



matched_data <- match.data(mod_match)  


# Estimation of the treatment effect ---- 

# here: like CaT but propensity score matched
PSM_fit <- glm(study_period ~ treatment + base_bmi_2treat + base_hba1c_2treat + base_eGFR_2treat + 
               T2D_duration_2treat + gender + year_2treat + age_2treat + prior_period, 
               family = binomial("logit"), data = matched_data) 


mar_PSM      <- summary(margins(PSM_fit, variables = "treatment"))

PSM          <- as.numeric(mar_PSM$AME["treatment"])                                   # estimate (risk difference scale)
se_PSM       <- mar_PSM$SE                                                     
lower_PSM    <- mar_PSM$lower
upper_PSM    <- mar_PSM$upper





