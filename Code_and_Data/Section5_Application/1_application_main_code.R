#------------------------------------------------------------------------------#
#----------------------- Section 5 application --------------------------------#
#------------------------------------------------------------------------------#


#
# Paths ------------------------------------------------------------------------
#

setwd("")                                                                       # insert path to main folder "Code_and_Data"

folder_main_code <- "Section5_Application"                                      # name of the section folder

source("paths.R")

#
# Load required Packages -------------------------------------------------------
#

source("R_packages.R")


#
# Load data --------------------------------------------------------------------
#


load(paste0(path_data, "example_data.Rdata", sep = ""))
cohort_newIV <- example_data



#
# Prepare data for application -------------------------------------------------
#

# change year variable to be dichotomous:

cohort_newIV$year_2treat_dich <- as.character(ifelse(cohort_newIV$year_2treat == "2016", 1,0))


# prepare dataset for DiD ---- 

patid              <- c(cohort_newIV$patid, cohort_newIV$patid)
Y                  <- c(cohort_newIV$prior_period, cohort_newIV$study_period)
HbA1c              <- c(cohort_newIV$base_hba1c_1treat, cohort_newIV$base_hba1c_2treat)
BMI                <- c(cohort_newIV$base_bmi_1treat, cohort_newIV$base_bmi_2treat)
eGFR               <- c(cohort_newIV$base_eGFR_1treat, cohort_newIV$base_eGFR_1treat)
Year               <- c(cohort_newIV$year_2treat_dich, cohort_newIV$year_2treat_dich)
Age                <- c(cohort_newIV$age_1treat, cohort_newIV$age_2treat)
T2Dduration        <- c(cohort_newIV$T2D_duration_1treat, cohort_newIV$T2D_duration_2treat)
Gender             <- c(cohort_newIV$gender, cohort_newIV$gender)                    # gender does not change between the periods

P                  <- rep(c(0,1), each = dim(cohort_newIV)[1])                       # period indicator
D_treat            <- c(cohort_newIV$treatment, cohort_newIV$treatment)              # treatment group indicator
P_D_treat_int      <- P*D_treat
HbA1c_P_int        <- HbA1c*P
BMI_P_int          <- BMI*P
eGFR_P_int         <- eGFR*P
Year_P_int         <- as.character(as.numeric(as.character(Year))*P)
Age_P_int          <- Age*P
T2Dduration_P_int  <- T2Dduration*P
Gender_P_int       <- as.character((as.numeric(Gender)*P))
IV                 <- c(cohort_newIV$new_IV, cohort_newIV$new_IV)
IV_P_int           <- IV*P

DiD_reg_data      <- data.frame(patid, Y, HbA1c, BMI, eGFR, Year, Age, T2Dduration, Gender, P, D_treat, P_D_treat_int,
                                 HbA1c_P_int, BMI_P_int, eGFR_P_int, Year_P_int, Age_P_int, T2Dduration_P_int, Gender_P_int,
                                IV, IV_P_int)



#
# Application of methods -------------------------------------------------------
#

# Corrected as Treated (CaT) ----

source(paste0(folder_main_code, "/CaT_application.R"))
source(paste0(folder_main_code, "/CaT_Z_application.R"))

# Propensity Score Matching (PSM) ----

source(paste0(folder_main_code, "/PSM_application.R"))

# standard IV (stIV) -----

source(paste0(folder_main_code, "/standard_IV_application.R"))

# Control function approach ----

source(paste0(folder_main_code, "/CF_application.R"))

# Difference-in-Difference (DiD) ----

source(paste0(folder_main_code, "/DiD_application.R"))
source(paste0(folder_main_code, "/DiD_Z_application.R"))

# prior outcome augmented IV (POA-IV) ----

source(paste0(folder_main_code, "/POAIV_application.R"))

# prior outcome augmented CF (POA-CF) ----

source(paste0(folder_main_code, "/POACF_application.R"))



#
# Collect results --------------------------------------------------------------
# 

source(paste0(folder_main_code, "/1a_results_collection.R"))


#
# IV strength ------------------------------------------------------------------
#

## standard IV
# summary(fit1stIV)$coef

F_statistics_stIV <- summary(fit1stIV)$coef[10,3]^2
F_statistics_stIV

## control function apprpach
# summary(fit1stIV)$coef
# uses the same first stage regression model as stIV


## POA-IV
# summary(fit1POAIV)$coef

F_statistics_POAIV <- summary(fit1POAIV)$coef[10,3]^2
F_statistics_POAIV

## POA-CF
# summary(fit1POAIV)$coef
# uses the same first stage regression model as POA-IV


#
# Save results -----------------------------------------------------------------
#

save(results, file = paste0(path_results, "results.Rdata", sep = ""))
save.image(paste0(path_workspaces, "workspace_application.RData", sep = ""))












