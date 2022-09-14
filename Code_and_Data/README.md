#------------------------------------------------------------------------------------------------------#
# codes and data for the manuscript:
# Triangulating Instrumental Variable, confounder adjustment and Difference-in-Difference methods 
# for comparative effectiveness research in observational data
# 
# Authors: Laura Güdemann, John M. Dennis, Andrew P. McGovern, Lauren R. Rodgers, Beverley M. Shields, 
#          William Henley, Jack Bowden on behalf of the MASTERMIND consortium
#------------------------------------------------------------------------------------------------------#

The R codes are organised in the Section of the manuscript.
There is one main R code stored within each section folder, along supporting codes. 
README files in every folder explain how to run the main R code and find the results. 
Please do not alter the folder structure of this project. 

All main codes within each secion folder accesses the R codes "functions.R", "paths.R" and "R_packages.R"


File and folder structure within this folder 
#-------------------------------------------#

"functions.R"
- collection of all costumized functions written for all simulations and the application study 

"paths.R"
- collection of file paths used over all simulations and the application study for load the data and to store results 

"R_packages.R"
- all packages needed for the simulation study and the application
****NOTE****
Please install all packages before running any of the other codes.

Folder: "Section3_Qe"
- all R codes needed to run the Bootstap application calculating generalized Qe and performing heterogeneity tests 
- based on the simulated data and scenarios explained in section 3

Folder: "Section3_Simulation"
- all R codes to run the simulation study (8 scenarios) explained in section 3 

Folder: "Section4_Simulation"
- all R codes to run the simulation study (3 scenarios) explained in section 4  

Folder: "Section5_Application"
- all R codes to perfom the aplication study explained in section 5, on an example dataset 

Folder: "Section5_Application_Qe"
- all R codes to perform the bootstrapped application study to calculated Qe including the calculation of the test results
