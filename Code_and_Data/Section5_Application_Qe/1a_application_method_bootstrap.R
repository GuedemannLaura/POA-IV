#
# Application of methods for bootstrap -----------------------------------------
#

# CaT ----

CaT_fit                   <- glm(study_period ~ treatment + base_bmi_2treat + base_hba1c_2treat + base_eGFR_2treat + 
                                 T2D_duration_2treat + gender + year_2treat + age_2treat + 
                                   prior_period, 
                                 family = binomial("logit"), data = bootstrap_data) 

mar_CaT                   <- summary(margins(CaT_fit, variables = "treatment"))
bootstrap_results$CaT[i]  <- as.numeric(mar_CaT$AME["treatment"])   


# PSM ----

# must be applied on complete case dataset


mod_match     <- matchit(as.factor(treatment)~as.factor(gender) + as.factor(prior_period) + age_1treat + 
                         base_bmi_1treat + base_hba1c_1treat + base_eGFR_1treat + T2D_duration_1treat + year_2treat, 
                         method = "nearest", data = bootstrap_data)

matched_data  <- match.data(mod_match)  

PSM_fit       <- glm(study_period ~ treatment + base_bmi_2treat + base_hba1c_2treat + base_eGFR_2treat + 
                     T2D_duration_2treat + gender + year_2treat + age_2treat + 
                       prior_period, 
                     family = binomial("logit"), data = matched_data) 

mar_PSM                     <- summary(margins(PSM_fit, variables = "treatment"))

bootstrap_results$PSM[i]    <- as.numeric(mar_PSM$AME["treatment"])

list_PSM_balance[[i]]       <- summary(mod_match)

# stIV ----

fit1stIV               <- glm(treatment ~ base_bmi_2treat + base_hba1c_2treat + base_eGFR_2treat + 
                              T2D_duration_2treat + gender + year_2treat + age_2treat + new_IV_chr, 
                              family = binomial("logit"), data = bootstrap_data)

stIV_Xhat              <- fitted(fit1stIV)
bootstrap_data$stIV_Xhat <- stIV_Xhat

stIVfit                <- glm(study_period ~ stIV_Xhat + base_bmi_2treat + base_hba1c_2treat + base_eGFR_2treat + 
                              T2D_duration_2treat + gender + year_2treat + age_2treat +
                                prior_period, 
                              family = binomial("logit"), data = bootstrap_data) 

marstIV                    <- summary(margins(stIVfit, variables = "stIV_Xhat"))
bootstrap_results$stIV[i]  <- as.numeric(marstIV$AME["stIV_Xhat"])


# CF ----

bootstrap_data$delta_hat  <- bootstrap_data$treatment - bootstrap_data$stIV_Xhat
bootstrap_data$delta_hatZ <- bootstrap_data$delta_hat*bootstrap_data$new_IV


CFfit                <- glm(study_period ~ treatment + base_bmi_2treat + base_hba1c_2treat + 
                              base_eGFR_2treat + T2D_duration_2treat + gender + year_2treat + 
                              age_2treat + prior_period + delta_hat + delta_hatZ, 
                            family = binomial("logit"), data = bootstrap_data) 


marCF                <- summary(margins(CFfit, variables = "treatment"))

bootstrap_results$CF[i] <- as.numeric(marCF$AME["treatment"])                    # CF estimate (risk difference scale)


# DiD ---- 

DiD_fit      <- glm(Y ~ P + D_treat + P_D_treat_int + HbA1c + BMI + eGFR + Year + Age + T2Dduration + Gender + 
                    HbA1c_P_int + BMI_P_int + eGFR_P_int + Year_P_int + Age_P_int + T2Dduration_P_int + Gender_P_int, 
                    family = binomial("logit"), data = DiD_reg_data)


mar_DiD                     <- summary(margins(DiD_fit, variables = "P_D_treat_int"))

bootstrap_results$DiD[i]    <- as.numeric(mar_DiD$AME["P_D_treat_int"])


# POAIV ----


fit1POAIV               <-  glm(treatment ~ base_bmi_2treat + base_hba1c_2treat + base_eGFR_2treat + T2D_duration_2treat + gender + 
                                  year_2treat + age_2treat + new_IV_chr + as.character((as.numeric(prior_period)*new_IV)), 
                                family = binomial("logit"), data = bootstrap_data)

POAIV_Xhat              <- fit1POAIV$fitted 

bootstrap_data$POAIV_Xhat <- POAIV_Xhat

POAIV_fit               <- glm(study_period ~ POAIV_Xhat + base_bmi_2treat + base_hba1c_2treat + base_eGFR_2treat +  
                                 T2D_duration_2treat + gender + year_2treat + age_2treat + prior_period + new_IV_chr, 
                               family = binomial(link = "logit"),data = bootstrap_data)  

marPOAIV                     <- summary(margins(POAIV_fit, variables = "POAIV_Xhat"))
bootstrap_results$"POA-IV"[i]   <- as.numeric(marPOAIV$AME["POAIV_Xhat"]) 


# POACF ----

bootstrap_data$POACF_delta_hat  <- bootstrap_data$treatment - bootstrap_data$POAIV_Xhat
bootstrap_data$POACF_delta_hatZ <- bootstrap_data$POACF_delta_hat*bootstrap_data$new_IV


POACF_fit               <- glm(study_period ~ treatment + base_bmi_2treat + base_hba1c_2treat + base_eGFR_2treat +  
                                 T2D_duration_2treat + gender + year_2treat + age_2treat + prior_period +
                                 POACF_delta_hat + POACF_delta_hatZ + new_IV_chr, 
                               family = binomial(link = "logit"),data = bootstrap_data)  

marPOACF                <- summary(margins(POACF_fit, variables = "treatment"))
bootstrap_results$"POA-CF"[i]    <- as.numeric(marPOACF$AME["treatment"]) 


