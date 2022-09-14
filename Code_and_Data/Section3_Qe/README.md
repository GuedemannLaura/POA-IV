#-----------------------------------------------------------------#
R codes in this folder run the simulation explained in Section 3 
#-----------------------------------------------------------------#


Description
#----------#

Ths simulation examplifies the Q_e statistics for different scenarios of the simulation outlined in Section 3 of the manuscript.
For the simulatio results represented in Table 3 please run a specific scenario and check the test results in the R code "1_simulation_main_code.R" under the section "Results".

This bootstrap can take an extensive amount of time to run. To speed up the run time the number of bootstraps per simulations and the number of simulation runs can be manipulated.
The parameters for this manipulation are S and B in the lines 56 and 57 of code "1_simulation_main_code.R". 

In order to run the code you need to enter the correct path of the folder in "1_simulation_main_code.R".
It is possible to run this code for scenarios 1-8 of the simulation outlined in Section 3 of the manuscript. The scenario can be chosen in "1_simulation_main_code.R" line 36.

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

"CaT.R", "CaT_boot.R"
- function to calculate the CaT estimate for this simulation and within each bootstrap 

"CF.R", "CF_boot"
- function to calculate the CF estimate for this simulation and within each bootstrap 

"DiD.R", "DiD_boot.R"
- function to calculate the DiD estimate for this simulation and within each bootstrap 

"standard_IV.R", "standard_IV_boot.R"
- function to calculate the standard IV estimate for this simulation and within each bootstrap 





