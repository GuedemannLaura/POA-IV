#-----------------------------------------#
Example Dataset for the application study 
#-----------------------------------------#

****NOTE****
As the original dataset used for this section can not be published, a simulated dataset is provided in the subfolder "data". This dataset represents the 
original data structure regarding to the number of measured confounders, but not their correlation structure or time relates aspects. 
This code is aimed to showcast the coding/ calculation of each estimation method and not to gain realistic estimation results. 



Data Structure  
#--------------# 

patient characteristics and outcome data was collected from two different periods
prior period ("variable_1treat"): 
- all patients are treated with Metformin 
- prior to inititation of study treatment
- period starts with initiation of Metformin and ends just before initiation of study treatment 
 
study period ("variable_2treat"): 
- begins at the start of second-line/ study treatment (DPP4 or SGLT2) and ends at censoring time (please see section 5 of the manuscript for further explanation)
- period after study treatment initiation



Variables  
#--------# 
patid: ID variable for the patients
pracid: ID variable for the physicians (general pracitioners, GP)
study_period: outcome in the study period (0: no genital infection experiences, 1: genital infection experienced)
treatment: treatment indicator vairable (0: DPP4, 1:SGLT2)
base_bmi_1treat, base_bmi_2treat: baseline BMI measurement at the beginning of the prior and study priod respectively (in kg/m^2)
base_hba1c_1treat, base_hba1c_2treat: baseline HbA1c measurement at the beginning of the prior and study priod respectively (in mmol/mol)
base_eGFR_1treat, base_eGFR_2treat: baseline eGFR measurement at the beginning of the prior and study priod respectively (in mL/min)
T2D_duration_1treat: T2D_duration_2treat: duration of Type 2 Diabetes measurd at the beginning of the prior and study period respectively (in years)
gender: gender (0:female, 1:male)
year_2treat: year of the prescription of the second-line treatment (2016-2019)
age_1treat, age_2treat: baseline age measurement at the beginning of the prior and study priod respectively (in years)
prior_period: history of genital infection measured in the prior period (0: no genital infection experiences, 1: genital infection experienced)
new_IV, new_Iv_chr: Instrumental Variable (0,1) on GP level