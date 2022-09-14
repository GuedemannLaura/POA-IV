#
# Decision on the Scenario -----------------------------------------------------
#


if(scenario == 1){
  unmeasured_confounding <- FALSE
  IV_violation           <- FALSE
  DiD_violation          <- FALSE
  
}else if(scenario == 2){
  unmeasured_confounding <- FALSE 
  IV_violation           <- FALSE
  DiD_violation          <- TRUE
  
}else if(scenario == 3){
  unmeasured_confounding <- FALSE
  IV_violation           <- TRUE 
  DiD_violation          <- FALSE  
  
}else if(scenario == 4){
  unmeasured_confounding <- FALSE
  IV_violation           <- TRUE
  DiD_violation          <- TRUE
  
}else if(scenario == 5){
  unmeasured_confounding <- TRUE
  IV_violation           <- FALSE
  DiD_violation          <- FALSE
  
}else if(scenario == 6){
  unmeasured_confounding <- TRUE
  IV_violation           <- FALSE
  DiD_violation          <- TRUE
  
}else if(scenario == 7){
  unmeasured_confounding <- TRUE
  IV_violation           <- TRUE
  DiD_violation          <- FALSE
  
}else if(scenario == 8){
  unmeasured_confounding <- TRUE
  IV_violation           <- TRUE
  DiD_violation          <- TRUE
  
}