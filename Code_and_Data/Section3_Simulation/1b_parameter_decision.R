#
# Decision on the Parameters ---------------------------------------------------
#

choice_Beta <- c(0.1, 0)
Beta        <- choice_Beta[j]               # true risk difference 

# Regression Parameter for W1 Model ----

betaW0_W1 <- 1.3

# Regression Parameter for Y0 Model ---- 
beta0_Y0 <- 0.2
betaU_Y0 <- 0.04
betaW_Y0 <- 0.03
betae_Y0 <- 0.05

# Regression Parameter for Y1 Model ----

beta0_Y1  <- 0.3 
betaU_Y1  <- betaU_Y0                  # influence of the unmeasured confounder is the same in both period
betaW_Y1  <- 0.01
betae_Y1  <- 0.01 
betaZ_Y1  <- 0.1 

# Regression Parameter for X Model ----

beta0_X   <- 1
betaU_X   <- 1.5    
betaW0_X  <- 1.5  
betaW1_X  <- 1.5  
betae_X   <- 0.25 
betaY0_X  <- 1.5  
betaZ_X   <- 2.5 








