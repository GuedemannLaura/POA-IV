#
# Collection, Summary and Storage of the Simulation Results -------------------- 
#


method_names <- c("CaT", "IV", "CF", "DiD", "POA-IV", "POA-CF")

if(Beta != 0){ 
  
  # Collect the simulation results ----
  
  # point estimates results ---- 
  
  point_estimates_results                <- data.frame(CaT, stIV, CF, DiD, POAIV, POACF)
  colnames(point_estimates_results)      <- method_names
  
  mean_point_estimates_results           <- as.data.frame(apply(point_estimates_results, 2, mean))
  colnames(mean_point_estimates_results) <- "point_estimates"
  
  # variance of the point estimates results ---- 
  
  mean_variance_results           <- as.data.frame(apply(point_estimates_results, 2, var))
  colnames(mean_variance_results) <- "variance"
  
  # lower confidence interval limit results ----
  
  lower_CI_results                <- data.frame(lower_CaT, lower_stIV, lower_CF, lower_DiD, lower_POAIV, lower_POACF)
  colnames(lower_CI_results)      <- method_names
  
  mean_lower_CI_results           <- as.data.frame(apply(lower_CI_results, 2, mean))
  colnames(mean_lower_CI_results) <- "lower_CI"
  
  # upper confidence interval limit results ----
  
  upper_CI_results                <- data.frame(upper_CaT, upper_stIV, upper_CF, upper_DiD, upper_POAIV, upper_POACF)
  colnames(upper_CI_results)      <- method_names
  
  mean_upper_CI_results           <- as.data.frame(apply(upper_CI_results, 2, mean))
  colnames(mean_upper_CI_results) <- "upper_CI"
  
  
  # Calculate outcome measures ----
  # Morris et al. 2018, Statistics in Medicine 
  
  # bias ---- 
  
  bias_results                    <- point_estimates_results - Beta
  
  mean_bias_results               <- as.data.frame(apply(bias_results, 2, mean))
  colnames(mean_bias_results)     <- "bias"
  
  # Monte Carlo SE of the bias ----
  
  MCSE_bias_results <- as.data.frame(t(cbind(
    
    sqrt(sum(((point_estimates_results$CaT-mean_point_estimates_results[1,1])^2))/(S*(S-1))),
    sqrt(sum(((point_estimates_results$IV-mean_point_estimates_results[2,1])^2))/(S*(S-1))),
    sqrt(sum(((point_estimates_results$CF-mean_point_estimates_results[3,1])^2))/(S*(S-1))),
    sqrt(sum(((point_estimates_results$DiD-mean_point_estimates_results[4,1])^2))/(S*(S-1))),
    sqrt(sum(((point_estimates_results$"POA-IV"-mean_point_estimates_results[5,1])^2))/(S*(S-1))),
    sqrt(sum(((point_estimates_results$"POA-CF"-mean_point_estimates_results[6,1])^2))/(S*(S-1)))
  )))
  
  colnames(MCSE_bias_results) <- "MCSE_MSE"
  rownames(MCSE_bias_results) <- method_names
  
  # standard deviation (SD) ---- 
  
  SD_results           <- as.data.frame(apply(point_estimates_results, 2, sd))
  colnames(SD_results) <- "SD"
  
  # standard error (SE) ----
  
  SE_results           <- as.data.frame(SD_results/sqrt(S))
  colnames(SE_results) <- "SE"
  
  # mean squared error (MSE) ----
  
  MSE_results           <- as.data.frame(apply(point_estimates_results, 2, function(x) (sum(((x-Beta)^2)))/S))
  colnames(MSE_results) <- "MSE"  
  
  # Monte Carlo SE of the MSE ----
  
  MCSE_MSE_results <- as.data.frame(t(cbind(
    
    sqrt(((sum((((point_estimates_results$CaT-mean_point_estimates_results[1,1])^2) - MSE_results[1,1])^2))/(S*(S-1)))),
    sqrt(((sum((((point_estimates_results$IV-mean_point_estimates_results[2,1])^2) - MSE_results[2,1])^2))/(S*(S-1)))),
    sqrt(((sum((((point_estimates_results$CF-mean_point_estimates_results[3,1])^2) - MSE_results[3,1])^2))/(S*(S-1)))),
    sqrt(((sum((((point_estimates_results$DiD-mean_point_estimates_results[4,1])^2) - MSE_results[4,1])^2))/(S*(S-1)))),
    sqrt(((sum((((point_estimates_results$"POA-IV"-mean_point_estimates_results[5,1])^2) - MSE_results[5,1])^2))/(S*(S-1)))),
    sqrt(((sum((((point_estimates_results$"POA-CF"-mean_point_estimates_results[6,1])^2) - MSE_results[6,1])^2))/(S*(S-1))))
  )))
  
  colnames(MCSE_MSE_results) <- "MCSE_MSE"
  rownames(MCSE_MSE_results) <- method_names
  
  
  # coverage ----
  
  
  coverage_results <- as.data.frame(t(cbind(
    mean(Beta <= upper_CI_results$CaT          & Beta >= lower_CI_results$CaT),
    mean(Beta <= upper_CI_results$IV           & Beta >= lower_CI_results$IV),
    mean(Beta <= upper_CI_results$CF           & Beta >= lower_CI_results$CF),
    mean(Beta <= upper_CI_results$DiD          & Beta >= lower_CI_results$DiD),
    mean(Beta <= upper_CI_results$"POA-IV"        & Beta >= lower_CI_results$"POA-IV"),
    mean(Beta <= upper_CI_results$"POA-CF"        & Beta >= lower_CI_results$"POA-CF")
  )))
  
  colnames(coverage_results) <- "coverage"
  rownames(coverage_results) <- method_names
  
  # Monte Carlo SE of the coverage ----
  
  MCSE_coverage_results <- as.data.frame(t(cbind(
    
    sqrt(((coverage_results$coverage[1]*(1- coverage_results$coverage[1]))/S)),
    sqrt(((coverage_results$coverage[2]*(1- coverage_results$coverage[2]))/S)),
    sqrt(((coverage_results$coverage[3]*(1- coverage_results$coverage[3]))/S)),
    sqrt(((coverage_results$coverage[4]*(1- coverage_results$coverage[4]))/S)),
    sqrt(((coverage_results$coverage[5]*(1- coverage_results$coverage[5]))/S)),
    sqrt(((coverage_results$coverage[6]*(1- coverage_results$coverage[6]))/S))
  )))
  
  colnames(MCSE_coverage_results) <- "MCSE_coverage"
  rownames(MCSE_coverage_results) <- method_names
  
  
  # Save the results ---- 
  
  save(point_estimates_results, file = paste0(path_results, "Scenario_", scenario, "/", "point_estimates_results", "_scenario_", scenario, ".Rdata", sep ="")) 
  save(mean_point_estimates_results, file = paste0(path_results, "Scenario_", scenario, "/", "mean_point_estimates_results", "_scenario_", scenario, ".Rdata", sep ="")) 
  
  save(mean_variance_results, file = paste0(path_results, "Scenario_", scenario, "/", "mean_variance_results", "_scenario_", scenario, ".Rdata", sep ="")) 
  
  save(lower_CI_results, file = paste0(path_results, "Scenario_", scenario, "/", "lower_CI", "_scenario_", scenario, ".Rdata", sep ="")) 
  save(mean_lower_CI_results, file = paste0(path_results, "Scenario_", scenario, "/", "mean_lower_CI_results", "_scenario_", scenario, ".Rdata", sep ="")) 
  
  save(upper_CI_results, file = paste0(path_results, "Scenario_", scenario, "/", "upper_CI", "_scenario_", scenario, ".Rdata", sep ="")) 
  save(mean_upper_CI_results, file = paste0(path_results, "Scenario_", scenario, "/", "mean_upper_CI_results", "_scenario_", scenario, ".Rdata", sep ="")) 
  
  save(bias_results, file = paste0(path_results, "Scenario_", scenario, "/", "bias_results", "_scenario_", scenario, ".Rdata", sep ="")) 
  save(mean_bias_results, file = paste0(path_results, "Scenario_", scenario, "/", "mean_bias_results", "_scenario_", scenario, ".Rdata", sep ="")) 
  save(MCSE_bias_results, file = paste0(path_results, "Scenario_", scenario, "/", "MCSE_bias_results", "_scenario_", scenario, ".Rdata", sep ="")) 
  
  save(SE_results, file = paste0(path_results, "Scenario_", scenario, "/", "SE_results", "_scenario_", scenario, ".Rdata", sep ="")) 
  
  save(MSE_results, file = paste0(path_results, "Scenario_", scenario, "/", "MSE_results", "_scenario_", scenario, ".Rdata", sep ="")) 
  save(MCSE_MSE_results, file = paste0(path_results, "Scenario_", scenario, "/", "MCSE_MSE_results", "_scenario_", scenario, ".Rdata", sep ="")) 
  
  save(coverage_results, file = paste0(path_results, "Scenario_", scenario, "/", "coverage_results", "_scenario_", scenario, ".Rdata", sep ="")) 
  save(MCSE_coverage_results, file = paste0(path_results, "Scenario_", scenario, "/", "MCSE_coverage_results", "_scenario_", scenario, ".Rdata", sep ="")) 
  
  
  # Save workspace ----
  
  save.image(paste0(path_workspaces, "workspace_scenario_", scenario, ".RData", sep = ""))
  
  print("Beta  != 0, T1E will not be calculated, and workspace will be saved")
  
  
  
}else{
  
  print("Beta = 0, only T1E will be calculated, but workspace will not be saved")
  
  # type 1 error (T1E) ----

  # lower confidence interval limit results:
  
  lower_CI_results                <- data.frame(lower_CaT, lower_stIV, lower_CF, lower_DiD, lower_POAIV, lower_POACF)
  colnames(lower_CI_results)      <- method_names
  
  mean_lower_CI_results           <- as.data.frame(apply(lower_CI_results, 2, mean))
  colnames(mean_lower_CI_results) <- "lower_CI"
  
  # upper confidence interval limit results:
  
  upper_CI_results                <- data.frame(upper_CaT, upper_stIV, upper_CF, upper_DiD, upper_POAIV, upper_POACF)
  colnames(upper_CI_results)      <- method_names
  
  mean_upper_CI_results           <- as.data.frame(apply(upper_CI_results, 2, mean))
  colnames(mean_upper_CI_results) <- "upper_CI"
  
  # T1E ----
  
  T1E_results <- as.data.frame(t(cbind(
    1-mean(0 <= upper_CI_results$CaT          & 0 >= lower_CI_results$CaT),
    1-mean(0 <= upper_CI_results$IV           & 0 >= lower_CI_results$IV),
    1-mean(0 <= upper_CI_results$CF           & 0 >= lower_CI_results$CF),
    1-mean(0 <= upper_CI_results$DiD          & 0 >= lower_CI_results$DiD),
    1-mean(0 <= upper_CI_results$"POA-IV"        & 0 >= lower_CI_results$"POA-IV" ),
    1-mean(0 <= upper_CI_results$"POA-CF"        & 0 >= lower_CI_results$"POA-CF")
  )))
  
  colnames(T1E_results) <- "T1E"
  rownames(T1E_results) <- method_names
  
  # Monte Carlo SE of the T1E rate ----
  
  MCSE_T1E_results <- as.data.frame(t(cbind(
    
    sqrt(((T1E_results$T1E[1]*(1- T1E_results$T1E[1]))/S)),
    sqrt(((T1E_results$T1E[2]*(1- T1E_results$T1E[2]))/S)),
    sqrt(((T1E_results$T1E[3]*(1- T1E_results$T1E[3]))/S)),
    sqrt(((T1E_results$T1E[4]*(1- T1E_results$T1E[4]))/S)),
    sqrt(((T1E_results$T1E[5]*(1- T1E_results$T1E[5]))/S)),
    sqrt(((T1E_results$T1E[6]*(1- T1E_results$T1E[6]))/S))
  )))
  
  colnames(MCSE_T1E_results) <- "MCSE_T1E"
  rownames(MCSE_T1E_results) <- method_names
  
  # Save the results ---- 
  
  save(T1E_results, file = paste0(path_results, "Scenario_", scenario, "/", "T1E_results", "_scenario_", scenario, ".Rdata", sep ="")) 
  save(MCSE_T1E_results, file = paste0(path_results, "Scenario_", scenario, "/", "MCSE_T1E_results", "_scenario_", scenario, ".Rdata", sep ="")) 
  
  
}
