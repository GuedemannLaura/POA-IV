#------------------------------------------------------------------------------#
#------------------ Section 4 Simulation (binary outcome) ---------------------#
#------------------------------------------------------------------------------#

#
# Working Directory and Paths --------------------------------------------------
#

setwd("")                                                                       # insert path to main folder of this project

folder_main_code <- "Section4_Simulation"                                       # insert name of the section folder


source("paths.R")

#
# Load required Packages -------------------------------------------------------
#

source("R_packages.R")


#
# Decision on the Scenario and set seed ----------------------------------------
#


scenario <- 1                         # can take on values c(1,2,3)

seed_choice <- c(6015, 17170, 9511, 22107)

set.seed(seed_choice[scenario])

#
# Start of the outer loop ------------------------------------------------------
#

for(j in 1:2){


#
# Decision on the Parameters ---------------------------------------------------
#

source(paste0(folder_main_code, "/1a_parameter_decision.R"))
  

#
# Results Vectors --------------------------------------------------------------
#


# Simulation Outcomes 

CaT    <- se_CaT    <- lower_CaT    <- upper_CaT   <- z_statistics_CaT   <- NULL
stIV   <- se_stIV   <- lower_stIV   <- upper_stIV  <- z_statistics_stIV  <- NULL
CF     <- se_CF     <- lower_CF     <- upper_CF    <- z_statistics_CF    <- NULL 
POAIV  <- se_POAIV  <- lower_POAIV  <- upper_POAIV <- z_statistics_POAIV <- NULL
POACF  <- se_POACF  <- lower_POACF  <- upper_POACF <- z_statistics_POACF <- NULL
DiD    <- se_DiD    <- lower_DiD    <- upper_DiD   <- z_statistics_DiD   <- NULL


Ye0_outofbounds <- Ye1_outofbounds <- NULL


#
# Start of the inner loop: Simulation ------------------------------------------
# 

S <- 1000 

for(i in 1:S){
  
  
#
# Data Generation --------------------------------------------------------------
#
  
source(paste0(folder_main_code, "/1b_data_generation.R"))
  

#
# Create Datasets -------------------------------------------------------------
#
 
cohort_sim <- data.frame(patient_ID, Z, W0, W1, U, X, Y0, Y1, Y0Z_int) 

patid         <- c(cohort_sim$patient_ID, cohort_sim$patient_ID)
Y             <- c(cohort_sim$Y0, cohort_sim$Y1)
W             <- c(cohort_sim$W0, cohort_sim$W1)
P             <- rep(c(0,1), each = n)                                          # period indicator
Z_did         <- c(cohort_sim$Z, cohort_sim$Z)
D_treat       <- c(cohort_sim$X, cohort_sim$X)                                  # treatment group indicator
P_D_treat_int <- P*D_treat
W_P_int       <- W*P                                                            # interaction term for difference in difference regression
Z_P_int       <- Z_did*P

DiD_reg_data <- data.frame(patid, Y, W, P, Z_did, D_treat, P_D_treat_int, W_P_int, Z_P_int)

 

#
# Application of Methods -------------------------------------------------------
#

# CaT Method (Multivariable Regression) ----
source(paste0(folder_main_code, "/CaT_Z.R"))


# Standard Instrumental Variable Method ----
source(paste0(folder_main_code, "/standard_IV.R"))

# Control function approach ----
source(paste0(folder_main_code, "/CF.R"))

# POA-IV approach ----
source(paste0(folder_main_code, "/POA_IV.R"))

# POA-CF approach ----
source(paste0(folder_main_code, "/POA_CF.R"))

# DiD Approach ----
source(paste0(folder_main_code, "/DiD_Z.R"))



#
# End of the inner loop: Simulation --------------------------------------------
#


print(i)
}


#
# Collection, Summary and Storage of the Simulation Results -------------------- 
#

source(paste0(folder_main_code, "/1c_production_simulation_results.R"))

#
# End of the outer loop --------------------------------------------------------
#

print(paste0("end inner loop ",j, sep = " "))

}








