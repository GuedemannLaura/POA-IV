#--------------------------------------------------------------------#
R codes in this folder run the application study explain in section 5
#--------------------------------------------------------------------#


Description
#----------#

This application study exemplifies the application of all discussed methods on an observational dataset. 
The data used in the original dataset used CPRD primary care patient data of people with Type 2 Diabetes.
Outcome of interest was the experience of an adverse effect (genital infection), comparing patients treated with DPP4 vs. SGLT2 (as second-line treatment).

The main code to run is "1_application_main_code.R" which accesses all other R codes in this folder. 
The file structure including the folders "\graphs", "\results", "\workspace" should not be changed as these folders are used to store the results of the application. 


****NOTE****
As the original dataset used for this section can not be published, a simulated dataset is provided in the subfolder "data". This dataset represents the 
original data structure regarding to the number of measured confounders, but not their correlation structure or time relates aspects. 
This code is aimed to showcast the coding/ calculation of each estimation method and not to gain realistic estimation results. 

The code for generating this dataset can be found in the folder "data" ("generate_data_for_Github.R") along with a README file that explains the variables. 





File structure within this folder 
#-------------------------------# 

"1_application_main_code.R"

- this is the main application code that needs to be run
- this file accesses all other R files in this folder except "2_results_visualization.R"
- this code generates the results of Table 6 and Table 7

"1f_results_collection.R"
- some code to collect the results of all estimation method in the dataframe "results"


"2_results_visualization.R"
- this code needs to be run after "1_application_main_code.R"
- it generates Figure 5

"CaT_application.R", "CaT_Z_application.R"
- function to calculate the CaT estimate for this application
- with and without Z included as measured confounders   

"CF_application.R"
- function to calculate the CF estimate for this application

"DiD_application.R", "DiD_Z_application.R"
- function to calculate the DiD estimate for this application
- with and without Z included as measured confounders  

"standard_IV_application.R"
- function to calculate the standard IV estimate for this application

"POAIV_application.R", "POACF_application.R"
- function to calculate the prior augmented IV estimate for this application
- implemented as IV and control function approach

"PSM_application.R"
- function to calculate the PSM estimate for this application
- this code produces the love plot shown in Figre 9 of the manuskript


