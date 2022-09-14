#
# prior outcome augmented Instrumental Variable Method -------------------------
#

fit1POAIV               <-  glm(treatment ~ base_bmi_2treat + base_hba1c_2treat + base_eGFR_2treat + T2D_duration_2treat + gender + 
                                 year_2treat + age_2treat + new_IV_chr + as.character((as.numeric(prior_period)*new_IV)), 
                               family = binomial("logit"), data = cohort_newIV)

POAIV_Xhat              <- fit1POAIV$fitted 


cohort_newIV$POAIV_Xhat <- POAIV_Xhat

POAIV_fit               <- glm(study_period ~ POAIV_Xhat + base_bmi_2treat + base_hba1c_2treat + base_eGFR_2treat +  
                              T2D_duration_2treat + gender + year_2treat + age_2treat + prior_period + new_IV_chr, 
                              family = binomial(link = "logit"),data = cohort_newIV)  

marPOAIV                <- summary(margins(POAIV_fit, variables = "POAIV_Xhat"))
POAIV                   <- as.numeric(marPOAIV$AME["POAIV_Xhat"])                    # estimate of the POA-IV method (risk difference scale)
se_POAIV                <- marPOAIV$SE                                        
lower_POAIV             <- marPOAIV$lower
upper_POAIV             <- marPOAIV$upper






