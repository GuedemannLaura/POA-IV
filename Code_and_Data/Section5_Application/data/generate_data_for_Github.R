#
# Generate dataset for Github --------------------------------------------------
#



#
# Working Directory and Paths --------------------------------------------------
#

setwd("")                                                                       # insert path to main folder "Code_and_Data" 

folder_main_code <- "Section5_Application"                                      # name of the section folder


source("paths.R")

#
# Load required Packages -------------------------------------------------------
#

source("R_packages.R")

#
# Generate data ----------------------------------------------------------------
#


# 400 physicians (GP: general practitioner)
# 20 patients per GP

set.seed(4444)

n_GP         <- 400
GP_size      <- rep(20, times = n_GP) 
pracid        <- rep(seq(1:n_GP), times = GP_size)                              # ID variable of GP
n            <- sum(GP_size)                                                    # sample size (number of patients in the cohort)
Z_GP         <- rbern(n_GP, prob = 0.5)
Z            <- rep(Z_GP, times = GP_size)
patid        <- seq(1,n)                                                        # ID variable patients 

study_period        <- as.factor(rbern(n, prob = 0.3))
treatment           <- rbern(n, prob = 0.45)
base_bmi_2treat     <- rnorm(n, mean = 35, sd = 6)
base_bmi_1treat     <- rnorm(n, mean = 33, sd = 6)
base_hba1c_2treat   <- rnorm(n, mean = 72, sd = 16)
base_hba1c_1treat   <- rnorm(n, mean = 70, sd = 16)
base_eGFR_2treat    <- rnorm(n, mean = 90, sd = 20)
base_eGFR_1treat    <- rnorm(n, mean = 88, sd = 20)
T2D_duration_2treat <- abs(round(rnorm(n, mean = 6, sd = 4), 0))
T2D_duration_1treat <- round((sample(seq(from = 0.001, to = 0.9, by = 0.001), n , replace = T)*T2D_duration_2treat), 0)
gender              <- as.character(rbern(n, prob = 0.49))
year_2treat         <- sample(c(2016, 2017,2018,2019), n, replace = T)
age_2treat          <- round(rnorm(n, mean = 60, sd = 10), 0)
age_1treat          <- round((sample(seq(from = 0.001, to = 0.9, by = 0.001), n , replace = T)*age_2treat), 0)
prior_period        <- as.factor(rbern(n, prob = 0.15))
new_IV              <- Z
new_IV_chr          <- as.character(Z)

example_data <- data.frame(patid, pracid, study_period, treatment, 
                           base_bmi_2treat, base_bmi_1treat, base_hba1c_2treat, base_hba1c_1treat, 
                           base_eGFR_2treat, base_eGFR_1treat, T2D_duration_2treat, T2D_duration_1treat, 
                           gender, year_2treat, age_2treat, age_1treat, prior_period, new_IV, new_IV_chr)



#
# save dataset -----------------------------------------------------------------
#


save(example_data, file = paste0(path_data, "example_data.Rdata", sep = ""))


