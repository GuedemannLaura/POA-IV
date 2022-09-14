#------------------------------------------------------------------------------------#
R codes in this folder run the application study with bootstrap explain in section 5
#------------------------------------------------------------------------------------#


Description
#----------#

With this code the bootstrap for the application study to calculate Qe can be performed. 

This bootstrap can take an extensive amount of time to run. To speed up the run time the number of bootstraps can be manipulated.
The parameter for this manipulation is B in the line 31 of code "1_main_code_bootstrap.R"

The data used in the original dataset used CPRD primary care patient data of people with Type 2 Diabetes.
Outcome of interest was the experience of an adverse effect (genital infection), comparing patients treated with DPP4 vs. SGLT2 (as second-line treatment).

The file structure including the folders "\graphs", "\results", "\workspace" should not be changed as these folders are used to store the results of the application. 


****NOTE****
As the original dataset used for this section can not be published, a simulated dataset is provided in the subfolder "data". This dataset represents the 
original data structure regarding to the number of measured confounders, but not their correlation structure or time relates aspects. 
This code is aimed to showcast the coding/ calculation of each estimation method and not to gain realistic estimation results. 

The code for generating this dataset can be found in the folder "data" ("generate_data_for_Github.R") along with a README file that explains the variables. 





File structure within this folder 
#-------------------------------# 

"1_main_code_bootstrap.R"

- this is the main application code with bootstrap that needs to be run
- this code sources "1a_application_method_bootsrap.R" for the application of all estimation methods
- this code also generates the test results summarized in Table 8 of the manustrcipt 
- as well as the correlation plot shown in Figure 10 of the manuskript
****NOTE****
no correlation structure was embedded when generating this example data

"1a_application_method_bootsrap.R"
- colection of functions for all estimation methods 


