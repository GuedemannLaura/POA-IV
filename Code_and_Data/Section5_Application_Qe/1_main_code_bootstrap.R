# -----------------------------------------------------------------------------#
# -------------- Section 5 Application with Bootstrap -------------------------#
# -----------------------------------------------------------------------------#

#
# Working Directory and Paths --------------------------------------------------
#

setwd("")                                                                       # insert path to main folder "Code_and_Data"

folder_main_code <- "Section5_Application_Qe"                                   # name of the section folder

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
# Number of bootstraps calculated -----------------------------------------------
#

B <- 500                                                                        # Number of boostraps


#
# Load data --------------------------------------------------------------------
#


load(paste0(path_data, "example_data.Rdata", sep = ""))
cohort_newIV <- example_data

#
# Results matrix for bootstrap -------------------------------------------------
#

bootstrap_results           <- as.data.frame(matrix(NA, nrow = B, ncol = 7))
colnames(bootstrap_results) <- c("CaT", "PSM", "stIV", "CF", "DiD", "POA-IV", "POA-CF")

list_PSM_balance <- list(NULL)


#
# Start of the for loop --------------------------------------------------------
#

set.seed(368392)
for(i in 1: B){

#
# Data preparation for bootstrap -----------------------------------------------
#

N              <- dim(cohort_newIV)[1]
bootstrap_data <- cohort_newIV[sample(1:N, N, replace = T),]


# change year variable to be dichotomous:

bootstrap_data$year_2treat_dich <- as.character(ifelse(bootstrap_data$year_2treat == "2016", 1,0))


# prepare dataset for DiD ---- 

patid              <- c(bootstrap_data$patid, bootstrap_data$patid)
Y                  <- as.factor(c(bootstrap_data$prior_period, bootstrap_data$study_period))
HbA1c              <- c(bootstrap_data$base_hba1c_1treat, bootstrap_data$base_hba1c_2treat)
BMI                <- c(bootstrap_data$base_bmi_1treat, bootstrap_data$base_bmi_2treat)
eGFR               <- c(bootstrap_data$base_eGFR_1treat, bootstrap_data$base_eGFR_1treat)
Year               <- c(bootstrap_data$year_2treat_dich, bootstrap_data$year_2treat_dich)
Age                <- c(bootstrap_data$age_1treat, bootstrap_data$age_2treat)
T2Dduration        <- c(bootstrap_data$T2D_duration_1treat, bootstrap_data$T2D_duration_2treat)
Gender             <- c(bootstrap_data$gender, bootstrap_data$gender)                    # gender does not change between the periods

P                  <- rep(c(0,1), each = dim(bootstrap_data)[1])                         # period indicator
D_treat            <- c(bootstrap_data$treatment, bootstrap_data$treatment)              # treatment group indicator
P_D_treat_int      <- P*D_treat
HbA1c_P_int        <- HbA1c*P
BMI_P_int          <- BMI*P
eGFR_P_int         <- eGFR*P
Year_P_int         <- as.character(as.numeric(as.character(Year))*P)
Age_P_int          <- Age*P
T2Dduration_P_int  <- T2Dduration*P
Gender_P_int       <- as.character((as.numeric(Gender)*P))

DiD_reg_data      <- data.frame(patid, Y, HbA1c, BMI, eGFR, Year, Age, T2Dduration, Gender, P, D_treat, P_D_treat_int,
                                HbA1c_P_int, BMI_P_int, eGFR_P_int, Year_P_int, Age_P_int, T2Dduration_P_int, Gender_P_int)




#
# Application of methods -------------------------------------------------------
#


source(paste0(folder_main_code, "/1a_application_method_bootstrap.R"))


#
# End of for loop --------------------------------------------------------------
#

print(i)
}

#
# Save the bootstrap results ---------------------------------------------------
#

save(bootstrap_results, file = paste0(path_results, "bootstrap_results.Rdata", sep = ""))
save.image(paste0(path_workspaces, "workspace_bootstrap.RData", sep = ""))




#
# Calculation of the Q statistics ----------------------------------------------
# 


all_combinations <- list(
  
  c("CaT", "PSM"),
  c("POA-IV", "POA-CF"),
  c("stIV", "CF"),
  c("CaT", "CF", "DiD", "POA-CF"), 
  c("PSM", "CF", "DiD", "POA-CF"),
  c("CaT", "stIV", "DiD", "POA-IV"),
  c("PSM", "stIV", "DiD", "POA-IV")
  
)

Q_results <- chi2_results <- test_desicions <- p_values <- NULL

for(g in 1: length(all_combinations)){
  
  combination <- all_combinations[[g]]
  Q_results[g]     <- Q_statistics_a(bootstrap_results[, combination])$Q
  chi2_results[g]  <- qchisq(0.95, df = Q_statistics_a(bootstrap_results[, combination])$df)
  p_values[g]     <- Q_statistics_a(bootstrap_results[, combination])$Qp
  test_desicions[g]  <- ifelse(chi2_results[g] < Q_results[g], "H0 rejected, estimates are not similar", "H0 not rejected, estimates are similar")
  
}



#
# Summary of the test decisions ------------------------------------------------
#

test_combinations <- NULL

for(g in 1:length(all_combinations)){
  
  test_combinations[g] <- paste(all_combinations[[g]], collapse=",")
  
}


test_results           <- as.data.frame(cbind(round(Q_results, 3), round(chi2_results,3), test_desicions, round(p_values,4)))
rownames(test_results) <- test_combinations
colnames(test_results) <- c("Q statistics", "chi^2 value", "test decision", "p values")

#
# Save the results of the Q statistics -----------------------------------------
#

save(test_results, file = paste0(path_results, "test_results.Rdata", sep = ""))



#
# Plots ------------------------------------------------------------------------
#


colnames(bootstrap_results) <- c("CaT", "PSM", "IV", "CF", "DiD", "POA-IV", "POA-CF") 


Cairo(file = paste0(path_graphs, "correlation_plot.pdf"), 
      type = "pdf",
      units = "in", 
      width = 10, 
      height = 8, 
      pointsize = 12, 
      dpi = 72)

pairs.panels(bootstrap_results,
             method = "pearson",
             hist.col = "lightgrey",
             smooth = FALSE,
             density = FALSE,
             ellipses = FALSE)


dev.off()


#
# Look at test results ---------------------------------------------------------
#

test_results



