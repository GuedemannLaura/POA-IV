#
# Data Generation --------------------------------------------------------------
#

n_GP         <- 50
GP_size      <- rep(100, times = n_GP) 
GP_ID        <- rep(seq(1:n_GP), times = GP_size)           # ID variable of GP
n            <- sum(GP_size)                                # sample size (number of patients in the cohort )
Z_GP         <- rbern(n_GP, prob = 0.5)
Z            <- rep(Z_GP, times = GP_size)
patient_ID   <- seq(1,n)                                    # ID variable patients 
U            <- rnorm(n)                                    # unknown confounder
W0           <- rnorm(n)                                    # measured confounder in prior period
W1           <- betaW0_W1*W0 + rnorm(n)                     # measured confounder in study period
eY0          <- rnorm(n, 4, 1)        
eX           <- rnorm(n, 4, 1)
eY1          <- rnorm(n, 4, 1)



# Generate Side Effect in Prior Period Y0 (from linear probability model) ----

if(unmeasured_confounding == TRUE){
  Ye0       <- beta0_Y0 + betaU_Y0*U + betaW_Y0*W0 + betae_Y0*eY0
}else{
  Ye0       <- beta0_Y0 + betaW_Y0*W0 + betae_Y0*eY0
}

Ye0[Ye0<=0] <- 0
Ye0[Ye0>=1] <- 1
Y0          <- rbinom(n,1,Ye0)

# Generate X ---- 

if(DiD_violation == FALSE & unmeasured_confounding == FALSE){
  etaX <-  beta0_X + betaZ_X*Z + betaW1_X*W1 + betaW0_X*W0 + betae_X*eX

}else if (DiD_violation == FALSE & unmeasured_confounding == TRUE){
  etaX <-  beta0_X + betaZ_X*Z + betaU_X*U + betaW1_X*W1 + betaW0_X*W0 + betae_X*eX
  
}else if(DiD_violation == TRUE & unmeasured_confounding == FALSE){
  etaX <- beta0_X + betaZ_X*Z + betaW1_X*W1 + betaW0_X*W0 + betaY0_X*Y0 + betae_X*eX
  
}else if(DiD_violation == TRUE & unmeasured_confounding == TRUE){
  etaX <- beta0_X + betaZ_X*Z + betaU_X*U + betaW1_X*W1 + betaW0_X*W0 + betaY0_X*Y0 + betae_X*eX
  
}

pX   <- exp(etaX)/(1+exp(etaX))
X    <- rbinom(n,1,pX)


# Generate Side Effect in Study Period Y1 (from a linear probability model) ----

if(IV_violation == FALSE & unmeasured_confounding == FALSE){
  Ye1  <- beta0_Y1 + Beta*X + betaW_Y1*W1 + betae_Y1*eY1
  
}else if (IV_violation == FALSE & unmeasured_confounding == TRUE){
  Ye1  <- beta0_Y1 + betaU_Y1*U + Beta*X + betaW_Y1*W1 + betae_Y1*eY1
  
}else if(IV_violation == TRUE & unmeasured_confounding == FALSE){
  Ye1  <- beta0_Y1 + Beta*X + betaW_Y1*W1 + betaZ_Y1*Z + betae_Y1*eY1
  
}else if(IV_violation == TRUE & unmeasured_confounding == TRUE){
  Ye1  <- beta0_Y1 + betaU_Y1*U + Beta*X + betaW_Y1*W1 + betaZ_Y1*Z + betae_Y1*eY1
  
}

Ye1[Ye1<=0] <- 0
Ye1[Ye1>=1] <- 1
Y1          <- rbinom(n,1,Ye1)
