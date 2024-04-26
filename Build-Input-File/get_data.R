## R Script filename = get_data.R
## Purpose: Extract input data and build an AGEPRO input file
## Based on 013_BuildAGEPROinputfile.R by Michelle Sculley
## 28-Feb-2024

## Clear RStudio environment if needed
## rm(list=ls())

##### SET LIBRARIES #####
library(r4ss)
library(plyr)
library(dplyr)
library(purrr)

##### SET Rscripts FOLDER #####
script.dir="C:\\Users\\jon.brodziak\\Desktop\\2024 WCNPO MLS Rebuilding\\Rscripts"

##### SET base SS3 MODEL FOLDER #####
model.dir <- c("C:\\Users\\jon.brodziak\\Desktop\\2024 WCNPO MLS Rebuilding\\base")

##### SET MODEL DOMAIN VARIABLES #####
## Set last year of assessment
endyr <- 2020

## Set time step to be "Year" or "Quarter" for years as quarters 
TimePeriod <- "Year"

## Set number of years in projection 
NYears <- 10

## Set bootstrap file = boot_file
boot_file <- "C:\\Users\\jon.brodziak\\Desktop\\2024 WCNPO MLS Rebuilding\\Bootstrap-numbers-at-age\\2023_WCNPOMLS.bsn"

## Set number of bootstraps (number of rows in boot_file)
NBoot <- 100

## Set multiplier to convert bootstrap file elements to be absolute numbers of fish at age
BootFac = 1000  

## Set number of simulations per bootstrap
NSims <- 100 

##### SET AGEPRO RECRUITMENT MODEL VARIABLES #####
## Set number of recruitment models = 1
NRecModel <- 1 

## Set recruitment model vector with NRecModel elements
## Here the ordered vector RecruitType is set to be model 3
RecruitType <- c(3)

## RecFac is a multiplier to convert units of recruit model output (e.g., 1000 fish) to AGEPRO numbers of fish
RecFac <- 1000

## SSBFac is a divisor to convert kg of SSB in AGEPRO to recruit model input units of SSB (e.g., 1000 mt)
## Note: Set SSBFac <- 1 for empirical recruits per spawner models 2 and 4 given the SS3 extraction code
SSBFac <- 1000 

## Maximum number of recruitment observations in a recruit model
MaxRecObs <- 100

## Set age-0 annual natural mortality rate to convert age-0.0 fish to age-0.5 fish
M0 <- 0.54 

##### Source SS_Agepro.R script #####
source(file.path(script.dir,"SS_to_Agepro.R"))
              
##### Extract SSInput with SS_To_Agepro.R script #####
SSInput <- SS_To_Agepro(model.dir=model.dir, script.dir=script.dir, endyr=2020, TimeStep="Year")

## Copy SSInput into Work to save it for auxiliary analyses
Work <- SSInput

##################### UPDATED CODE 11-JAN-2024 #####################

## Adjust SSInput to the fleets you want to include: Here we choose the fleets with unique selectivities
UniqueFleets<- SSInput$Fishery_SelAtAge %>%
  filter(Yr == 2020) %>%
  distinct(across(-c(Yr, Fleet)), .keep_all = TRUE) %>%
  select(Fleet) %>% pull()

## Identify years in the model
Years <- seq(min(SSInput$Fishery_SelAtAge$Yr),max(SSInput$Fishery_SelAtAge$Yr))

## Identify set of unique fleets by year
matching_indices<-list()
for(j in 1:length(Years)) {
  matching_indices[[j]]<-list()
  for (i in 1:length(UniqueFleets)){
    # Select the target row (row 1 in this case)
    target_row <- SSInput$Fishery_SelAtAge[which(SSInput$Fishery_SelAtAge$Fleet==UniqueFleets[i]&SSInput$Fishery_SelAtAge$Yr==Years[j]), -2]
    
    # Find rows that match the target row
    matching_indices[[j]][[i]] <- which(apply(SSInput$Fishery_SelAtAge[,-2], 1, function(x) all(x %in% target_row)))
  }}

YearAvg <- seq(1977,1993)  ## Define the set of years you want to average over for selectivity and catch at age over

##Average your SelAtAge across years in YearAvg
SSInput$Fishery_SelAtAge<-SSInput$Fishery_SelAtAge %>%
  filter(Fleet %in% UniqueFleets) %>%   ## Filter out the nonunique fleets
  filter(Yr %in% YearAvg)  %>% ## Save the year/years to average the fishery selectivity over
  group_by(Fleet) %>%  ## Average each age by fleet
  summarize(across(c(2:16),mean))

## Set the number of unique fleets in the assessment
SSInput$Nfleets<-length(UniqueFleets)

## Adjust CV matrix to match the number of unique fleets
SSInput$Fishery_SelAtAgeCV<-SSInput$Fishery_SelAtAgeCV[UniqueFleets,]

## Average catch at age across years in YearAvg
SSInput$Catage<-SSInput$Catage %>% 
  filter(Fleet %in% UniqueFleets) %>%   ## Filter out the nonunique fleets
  filter(Yr %in% YearAvg) %>%  ## Save the year/years to average the fishery selectivity over
  group_by(Fleet) %>%  ## Average each age by fleet
  summarize(across(c(2:16),mean))

## Adjust the CV matrix
SSInput$CatageCV<-SSInput$CatageCV[UniqueFleets,]

## For the catch by fleet, produce a list of the rows by year that should be combined for fleets that share selectivity
duplicated_rows<-matching_indices[[1]]
## Summing the fleets' catch and Fs which share selectivities so that they can be used to proportion catch in projections
for (group in duplicated_rows){
  
  col_names<-paste0("sel(B):_",group)
  SSInput$CatchbyFleet[,paste0("sum_",paste(group,collapse="_"))]<-rowSums(SSInput$CatchbyFleet[,col_names,drop=FALSE],na.rm=TRUE)
  col_names2<-paste0("F:_",group)
  SSInput$FbyFleet[,paste0("sum_",paste(group,collapse="_"))]<-rowSums(SSInput$FbyFleet[,col_names2,drop=FALSE],na.rm=TRUE)
}
CatchbyFleet<-SSInput$CatchbyFleet %>%
  select(-starts_with("sel(B):_"))
names(CatchbyFleet)<-c("Yr",UniqueFleets) 

## Calculate the proportion of catch by year and fleet from the combined catch by fleet
ProportionCatch<-CatchbyFleet
for( i in 1:length(Years)) {
  
  TempCatch<-CatchbyFleet[i,-1]
  ProportionCatch[i,c(2:ncol(ProportionCatch))]<-TempCatch/sum(TempCatch) 
}

## Repeat exercise to combine fleet fishing mortalities across years and mirrored selectivity
FbyFleet<-SSInput$FbyFleet %>%
  select(-starts_with("F:_"))
names(FbyFleet)<-c("Yr",UniqueFleets) 

## Calculate the proportion of F by year and fleet from the combined F by fleet
ProportionF<-FbyFleet
for( i in 1:length(Years)) {
  
  TempF<-FbyFleet[i,-1]
  ProportionF[i,c(2:ncol(ProportionF))]<-TempF/sum(TempF) 
}

##From here you can average catch, average F, or average proportion of catch over the years you are interested in
## sticking with the three year average used above:

#CatchbyFleet<- CatchbyFleet %>%
#  filter(Yr %in% YearAvg) %>%
#  summarize(across(c(2:ncol(CatchbyFleet)),\(x) mean(x,na.rm=TRUE)))

#ProportionCatch<- ProportionCatch %>%
#  filter(Yr %in% YearAvg) %>%
#  summarize(across(c(2:ncol(ProportionCatch)),\(x) mean(x,na.rm=TRUE)))

#FbyFleet<- FbyFleet %>%
#  filter(Yr %in% YearAvg) %>%
#  summarize(across(c(2:ncol(FbyFleet)),\(x) mean(x,na.rm=TRUE)))
  
#ProportionF<- ProportionF %>%
#  filter(Yr %in% YearAvg) %>%
#  summarize(across(c(2:ncol(ProportionF)),\(x) mean(x,na.rm=TRUE)))

#