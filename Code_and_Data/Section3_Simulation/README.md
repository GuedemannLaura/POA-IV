#-----------------------------------------------------------------#
R codes in this folder run the simulation explained in Section 3 
#-----------------------------------------------------------------#


Description
#----------#

Ths simulation compares the performance of the CaT, IV, CF and DiD estimate under 8 different scenarios of assumption violations.
Please run the simulation code for each scenario first before analysing the simulation results. 

In order to run the simulation you need to enter the correct path of the folder in "1_simulation_main_code".
The scenarios 1-8 of this simulation are run seperately. In order to change the scenario you will need to change the scenario value in line 28 in the file "1a_decision_on_scenario.R"

The file structure including the folders "\graphs", "\results", "\workspace" should not be changed as these folders are used to store the results for each scenario. 



File structure within this folder 
#-------------------------------# 

"1_simulation_main_code.R"

- this is the main simulation code that needs to be run
- this file accesses all other R files in this folder except "2_analysis_of_the_simulation_results.R"

"1a_decision_on_scenario.R"
- the scenarios are defined in this file

"1b_parameter_decision.R"
- model parameter to generate population data

"1c_data_generation.R"
- functions to generate population data

"1d_production_simulation_results.R"
- functions calculating all resuts of the simulation such as bias, MSE, ...

"2_analysis_of_the_simulation_results.R"
- this code is used to generate figure 3 of the manuscript 
- you will need to insert your path to the main folder of this project and indicate the scenario you want to plot 

"CaT.R"
- function to calculate the CaT estimate for this simulation  

"CF.R"
- function to calculate the CF estimate for this simulation 

"DiD.R"
- function to calculate the DiD estimate for this simulation 

"standard_IV.R"
- function to calculate the standard IV estimate for this simulation 





