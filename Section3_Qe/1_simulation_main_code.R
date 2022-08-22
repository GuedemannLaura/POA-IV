#------------------------------------------------------------------------------#
#------------------------ Section 3 Qe ----------------------------------------#
#------------------------------------------------------------------------------#

#
# Working Directory and Paths --------------------------------------------------
#

setwd("")                                                                       # insert path to main folder of this project

folder_main_code <- "Section3_Qe"                                               # insert name of the section folder

source("paths.R")

#
# Load required Packages -------------------------------------------------------
#

source("R_packages.R")

#
# Load functions ---------------------------------------------------------------
#


source("functions.R")


#
# Decision on the Scenario and set seed ----------------------------------------
#


# possible scenarios for this simulation: c(1,2,3,4,5,6,7,8)

source(paste0(folder_main_code, "/1a_decision_on_scenario.R"))


if(scenario == 3 |scenario == 4 | scenario == 7 | scenario == 8){
  
  with_Z <- TRUE
  
}else{
  
  with_Z <- FALSE
  
}

seed_choice <- c(6015, 17170, 9511, 22107, 985, 4575, 25709, 19871)

set.seed(seed_choice[scenario])

S <- 500  # Number of simulation runs 
B <- 500  # Number of boostrap in each simulation run



#
# Decision on the Parameters ---------------------------------------------------
#


source(paste0(folder_main_code, "/1b_parameter_decision.R"))


#
# Results Vectors --------------------------------------------------------------
#

CaT_B  <- se_CaT_B  <- lower_CaT_B  <- upper_CaT_B  <- rep(NA, times = S)
CF_B   <- se_CF_B   <- lower_CF_B   <- upper_CF_B   <- rep(NA, times = S)
DiD_B  <- se_DiD_B  <- lower_DiD_B  <- upper_DiD_B  <- rep(NA, times = S)


Q_CaT_CF  <-  chi2_CaT_CF  <- testQ_CaT_CF  <- Q2_CaT_CF  <- testQ2_CaT_CF  <- NULL
Q_CaT_DiD <-  chi2_CaT_DiD <- testQ_CaT_DiD <- Q2_CaT_DiD <- testQ2_CaT_DiD <- NULL
Q_CF_DiD  <-  chi2_CF_DiD  <- testQ_CF_DiD  <- Q2_CF_DiD  <- testQ2_CF_DiD  <- NULL


#
# Start of the loop: Simulation ------------------------------------------------
# 

for(i in 1:S){
  

  Ests           <- matrix(nrow=1,ncol=3)
  colnames(Ests) <- c("CaT", "CF", "DiD")
    
#
# Data Generation --------------------------------------------------------------
#
  

source(paste0(folder_main_code, "/1c_data_generation.R"))
  
  cohort_sim <- data.frame(patient_ID, Z, W0, W1, U, X, Y0, Y1) 
  
  patid         <- c(cohort_sim$patient_ID, cohort_sim$patient_ID)
  Y             <- c(cohort_sim$Y0, cohort_sim$Y1)
  W             <- c(cohort_sim$W0, cohort_sim$W1)
  P             <- rep(c(0,1), each = n)                                          # period indicator
  Z_did         <- c(cohort_sim$Z, cohort_sim$Z)
  D_treat       <- c(cohort_sim$X, cohort_sim$X)                                  # treatment group indicator
  P_D_treat_int <- P*D_treat
  W_P_int       <- W*P                                                            # interaction term for difference in difference regression
  Z_P_int       <- Z_did*P
  
  DiD_reg_data_o <- data.frame(patid, Y, W, P, Z_did, D_treat, P_D_treat_int, W_P_int, Z_P_int)
  
  
  
#
# Calculation of the estimates from original data ------------------------------
#

  # CaT Method (Multivariable Regression) ----
  source(paste0(folder_main_code, "/CaT.R"))
  
  
  # standard IV approach ----
  source(paste0(folder_main_code, "/standard_IV.R"))
  
  # Control function approach ----
  source(paste0(folder_main_code, "/CF.R"))
  
  # DiD Approach ----
  source(paste0(folder_main_code, "/DiD.R"))
  
  Ests[1,] = c(CaT_o,CF_o,DiD_o) 



# 
# Bootstrap outcomes ----------------------------------------------------------- 
#

CaT  <- se_CaT  <- lower_CaT  <- upper_CaT  <- rep(NA, times = B)
CF   <- se_CF   <- lower_CF   <- upper_CF   <- rep(NA, times = B)
DiD  <- se_DiD  <- lower_DiD  <- upper_DiD  <- rep(NA, times = B)



#
# Start of the Bootstrap -------------------------------------------------------
#


for(j in 1:B){

#
# Bootrapped data --------------------------------------------------------------
#

bootstrap_data <- cohort_sim[sample(1:n, n, replace = T),]

# dataset for DiD: 

patid         <- c(bootstrap_data$patient_ID, bootstrap_data$patient_ID)
Y             <- c(bootstrap_data$Y0, bootstrap_data$Y1)
W             <- c(bootstrap_data$W0, bootstrap_data$W1)
P             <- rep(c(0,1), each = n)                                          # period indicator
Z_did         <- c(bootstrap_data$Z, bootstrap_data$Z)
D_treat       <- c(bootstrap_data$X, bootstrap_data$X)                          # treatment group indicator
P_D_treat_int <- P*D_treat
W_P_int       <- W*P                                                            # interaction term for difference in difference regression
Z_P_int       <- Z_did*P

DiD_reg_data  <- data.frame(patid, Y, W, P, Z_did, D_treat, P_D_treat_int, W_P_int, Z_P_int)


#
# Application of Methods -------------------------------------------------------
#


# CaT Method (Multivariable Regression) ----
source(paste0(folder_main_code, "/CaT_boot.R"))


# standard IV approach ----
source(paste0(folder_main_code, "/standard_IV_boot.R"))

# Control function approach ----
source(paste0(folder_main_code, "/CF_boot.R"))

# DiD Approach ----
source(paste0(folder_main_code, "/DiD_boot.R"))


#
# End of the bootstrap ---------------------------------------------------------
#


print(paste0("Bootstrap j = ", j, " of Simulation run i = ", i, " complete")) 
}


#
# Calculation of Q and testing -------------------------------------------------
#


bootstrap_results <- data.frame(CaT, CF, DiD)

Ests2             <- matrix(nrow=1,ncol=3)

Ests2[1,]         <- apply(bootstrap_results,2,mean)
colnames(Ests2)   <- c("CaT", "CF", "DiD")

#
# Calculate the Q statistics ---------------------------------------------------
#

# Qe for CaT and CF ----

Q_CaT_CF[i]     <- Q_statistics(x = bootstrap_results[c("CaT","CF")], E = Ests[ ,c("CaT","CF")], E2 = Ests2[,c("CaT","CF")], nE = 2)$Q
chi2_CaT_CF[i]  <- qchisq(0.95, df = 1)
testQ_CaT_CF[i] <- ifelse(chi2_CaT_CF[i] < Q_CaT_CF[i], "H0 rejected, estimates are not similar", "H0 not rejected, estimates are similar")

Q2_CaT_CF[i]     <- Q_statistics(x = bootstrap_results[c("CaT","CF")], E = Ests[ ,c("CaT","CF")], E2 = Ests2[,c("CaT","CF")], nE = 2)$Q2
testQ2_CaT_CF[i] <- ifelse(chi2_CaT_CF[i] < Q2_CaT_CF[i], "H0 rejected, estimates are not similar", "H0 not rejected, estimates are similar")


# Qe for CaT and DiD ----

Q_CaT_DiD[i]     <- Q_statistics(x = bootstrap_results[c("CaT","DiD")], E = Ests[ ,c("CaT","DiD")], E2 = Ests2[,c("CaT","DiD")], nE = 2)$Q
chi2_CaT_DiD[i]  <- qchisq(0.95, df = 1)
testQ_CaT_DiD[i] <- ifelse(chi2_CaT_DiD[i] < Q_CaT_DiD[i], "H0 rejected, estimates are not similar", "H0 not rejected, estimates are similar")

Q2_CaT_DiD[i]     <- Q_statistics(x = bootstrap_results[c("CaT","DiD")], E = Ests[ ,c("CaT","DiD")], E2 = Ests2[,c("CaT","DiD")], nE = 2)$Q2
testQ2_CaT_DiD[i] <- ifelse(chi2_CaT_DiD[i] < Q2_CaT_DiD[i], "H0 rejected, estimates are not similar", "H0 not rejected, estimates are similar")


# Qe for CF and DiD ----

Q_CF_DiD[i]     <- Q_statistics(x = bootstrap_results[c("CF","DiD")], E = Ests[ ,c("CF","DiD")], E2 = Ests2[,c("CF","DiD")], nE = 2)$Q
chi2_CF_DiD[i]  <- qchisq(0.95, df = 1)
testQ_CF_DiD[i] <- ifelse(chi2_CF_DiD[i] < Q_CF_DiD[i], "H0 rejected, estimates are not similar", "H0 not rejected, estimates are similar")

Q2_CF_DiD[i]     <- Q_statistics(x = bootstrap_results[c("CF","DiD")], E = Ests[ ,c("CF","DiD")], E2 = Ests2[ ,c("CF","DiD")], nE = 2)$Q2
testQ2_CF_DiD[i] <- ifelse(chi2_CF_DiD[i] < Q2_CF_DiD[i], "H0 rejected, estimates are not similar", "H0 not rejected, estimates are similar")



#
# End of the loop: Simulation --------------------------------------------------
#


print(paste0("Simulation run i = ", i, " complete"))
}



#
# Save the workspace -----------------------------------------------------------
#

save.image(paste0(path_workspaces, "simulation_workspace_scenario_",scenario,".RData"))

#
# Results ----------------------------------------------------------------------
#

table(testQ_CaT_CF)/length(testQ_CaT_CF)*100
table(testQ2_CaT_CF)/length(testQ2_CaT_CF)*100

table(testQ_CaT_DiD)/length(testQ_CaT_DiD)*100
table(testQ2_CaT_DiD)/length(testQ2_CaT_DiD)*100

table(testQ_CF_DiD)/length(testQ_CF_DiD)*100
table(testQ2_CF_DiD)/length(testQ2_CF_DiD)*100





  
  






