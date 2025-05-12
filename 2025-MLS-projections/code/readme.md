# **2025-MLS-projections/code**

### **Purpose**

> The "code"" folder stores R scripts, input files, and AGEPRO executable for running rebuilding projections under CMM 2024-06 for WCNPO striped marlin

### **Files**

> -   **2025_MLS_scenarioX.inp** are the AGEPRO input files for the rebuilding scenarios under CMM 2024-06.
> -   **agepro_MLS_rebuild.exe** is the AGEPRO executable for running the WCNPO striped marlin rebuilding projections To run a rebuilding scenarioX, enter "agepro_MLS_rebuild.exe 2025_MLS_scenarioX.inp" on the command line.
> -   **make_2025_MLS_scenario.R** are the R scripts to create the AGEPRO input files for each scenario with 1 recruitment model.
> -   **make_3_RECRUIT.R** is the R script to change a 1-model recruitment input file to a 3-model recruitment model based on the "3-RECRUIT.TXT" file and this file needs to edited to set the input and output file names on lines 8 and 10.
> -   **make_rdat_fleet_names.R** is the R script to add the correct fleet name syntax to the AGEPRO output R file and this file needs to edited to set the input and output file names on lines 2 and 4. This R script corrects a bug in the output R created by AGEPRO for a multifleet projection model. The AGEPRO output R file is used to create graphs from R scripts in the "output/Base Runs/ScenarioX" folders
