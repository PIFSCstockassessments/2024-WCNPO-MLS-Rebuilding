## filename = 013_BuildAGEPROinputfile.R
## extracting inputs for AGEPRO input files
library(r4ss)
library(plyr)
library(dplyr)
library(purrr)

## variables needed:
endyr = 2020  ## last year of assessment
TimePeriod<-"Year"  # can be "Year" or "Quarter" for quarters as years
NYears<-10  ## number of years in projection

## where are your Rscripts
script.dir="C:\\Users\\Michelle.Sculley\\Documents\\2024 WCNPO MLS Rebuilding\\Rscripts"  

## where is your bootstrap file path
boot_file = "C:\\Users\\Michelle.Sculley\\Documents\\2024 WCNPO MLS Rebuilding\\2023_WCNPOMLS.bsn"  



## use the modifies SS_output function to load all the report file lines needed
model.dir<-c("C:\\Users\\Michelle.Sculley\\Documents\\2024 WCNPO MLS Rebuilding\\base")

source(file.path(script.dir,"SS_to_Agepro.R"))
             
             
SSInput<-SS_To_Agepro(model.dir=model.dir, script.dir=script.dir, endyr=2020, TimeStep="Year")

##dump SSInput into TempInput to preserve it
TempInput<-SSInput
## Adjust SSInput to the fleets you want to include: for this I am only choosing the fleets with unique selectivities, then for the fleets with the same selectivities, adding up the catch proportions for the new fleet:
SSInput<-TempInput #If you need to revert to the original SSInput without rerunning the function

UniqueFleets<- SSInput$Fishery_SelAtAge %>%
filter(Yr == 2020) %>%
distinct(across(-c(Yr, Fleet)), .keep_all = TRUE) %>%
  select(Fleet) %>% pull()

Years <- seq(min(SSInput$Fishery_SelAtAge$Yr),max(SSInput$Fishery_SelAtAge$Yr))


matching_indices<-list()
 for(j in 1:length(Years)) {
  matching_indices[[j]]<-list()
  for (i in 1:length(UniqueFleets)){
# Select the target row (row 1 in this case)
target_row <- SSInput$Fishery_SelAtAge[which(SSInput$Fishery_SelAtAge$Fleet==UniqueFleets[i]&SSInput$Fishery_SelAtAge$Yr==Years[j]), -2]

# Find rows that match the target row
matching_indices[[j]][[i]] <- which(apply(SSInput$Fishery_SelAtAge[,-2], 1, function(x) all(x %in% target_row)))
}}
# Display the indices of matching rows
#print(matching_indices)



YearAvg <- seq(endyr-2,endyr)  ## define which years you want to average you selectivity and catch at age over

SSInput$Fishery_SelAtAge<-SSInput$Fishery_SelAtAge %>%
  filter(Fleet %in% UniqueFleets) %>%   ##filter out only the unique fleets
  filter(Yr %in% YearAvg)  %>% ##save the year/years you want to average the Fishery selectivity over
  group_by(Fleet) %>%  ## average each age by fleet
  summarize(across(c(2:16),mean))


SSInput$Nfleets<-length(UniqueFleets)

SSInput$Fishery_SelAtAgeCV<-SSInput$Fishery_SelAtAgeCV[UniqueFleets,]



SSInput$Catage<-SSInput$Catage %>% 
  filter(Fleet %in% UniqueFleets) %>%   ##filter out only the unique fleets
  filter(Yr %in% YearAvg) %>%  ##save the year/years you want to average the catch at age over
  group_by(Fleet) %>%  ## average each age by fleet
  summarize(across(c(2:16),mean))

SSInput$CatageCV<-SSInput$CatageCV[UniqueFleets,]

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
 ProportionCatch<-CatchbyFleet
 for( i in 1:length(Years)) {
   
   TempCatch<-CatchbyFleet[i,-1]
   ProportionCatch[i,c(2:ncol(ProportionCatch))]<-TempCatch/sum(TempCatch) 
 }
 
 FbyFleet<-SSInput$FbyFleet %>%
   select(-starts_with("F:_"))
 names(FbyFleet)<-c("Yr",UniqueFleets) 

 ##From here you can average catch, average F, or average proportion of catch over the years you are interested in
 ## sticking with the three year average used above:
 
CatchbyFleet<- CatchbyFleet %>%
   filter(Yr %in% YearAvg) %>%
   summarize(across(c(2:ncol(CatchbyFleet)),\(x) mean(x,na.rm=TRUE)))
 
ProportionCatch<- ProportionCatch %>%
  filter(Yr %in% YearAvg) %>%
  summarize(across(c(2:ncol(ProportionCatch)),\(x) mean(x,na.rm=TRUE)))

FbyFleet<- FbyFleet %>%
  filter(Yr %in% YearAvg) %>%
  summarize(across(c(2:ncol(FbyFleet)),\(x) mean(x,na.rm=TRUE)))

### Recruitment input
# You'll need to set a different Recruitment list for each recruitment model choice. They are detailed below:
## SS_To_Agepro has pulled some of the Information from SS for different recruitment scenarios: these include the alpha, beta, and variance parameters for a stock recruitment curve (BH or Richards) and the observed recruitment by year and SSB 


## For model 1 - this isn't set up yet

## Model 2

#Recruitment is a list with two objects: Nobs with is the number of observations, recruits is a dataframe with two columns, recruitment and SSB

Recruitment<-list()
Recruitment$Recr_Model<-2
Recruitment$Recr_Prob <- rep(1,NYears)
Recruitment$Nobs<-20  ## I set this to the last twenty years of the assessment but it can be changed to any timeframe
firstyr<-2001 ## change these to match the year range you want
lastyr<-2020 
Recruitment$Recruits<-SSInput$RecruitmentObs %>% 
  filter(Yr %in% firstyr:lastyr) %>%
  select(SpawnBio,pred_recr)


## Model 3

# Recruitment is a list with two objects: Nobs is the number of observations, and recruits is a vector of observed recruitment

## Model 4 and 15

# Recruitment is a list with 4 objects: Nobs is a vector with the number of observations in each recruitment level, Level1obs is a dataframe of recruitment and SSB for the level one recruitment observations, Level2Obs is a dataframe of recruitment and SSB for the level two recruitment observations, and SSBBreak is the SSB break limit between the two recruitment levels

## Models 5, 6, 7,10, 11, and 12

#Recruitment is a list with 3 to 5 objects: alpha and beta which are the S/R parameters, Kparm (only for models 7 and 12) is the K parameter, var is the recruitment variance, and for 10, 11 and 12, Phi is the Phi parameter, and LastResid is the last recruitment residual for the auto-correlated error
Recruitment<-list()
Recruitment$Recr_Model<-5
Recruitment$Recr_Prob<-rep(1,NYears)
Recruitment$alpha <-SSInput$alpha
Recruitment$beta <- SSInput$beta
Recruitment$var <- SSInput$BH_var





## Model 8 and 13

# Recruitment is a list with 2 (model 8) or 4 objects (model 13): the mean and standard deviation (stdev) of the lognormal distribution, and for model 13, Phi and LastResid which is the value of the last recruitment residual

## Model 14

# Recruitment is a list with two objects: Nobs is the number of observations and Obs is a vector of observed recruitment

Recruitment<-list()
Recruitment$Recr_Model<-14
Recruitment$Recr_Prob<-rep(1,NYears)
Recruitment$Nobs<- 20 ## Assuming the number of observations is the last 20 years of recruitment
Recruitment$Obs<-SSInput$RecruitmentObs %>%
  filter(Yr %in% (endyr-Recruitment$Nobs):endyr) %>%
  select(pred_recr)

## Model 16, 17, 18, and 19

# Recruitment is an object with 5 objects: Ncoeff is the number of coefficients, var is the variance, Intercept is the y-intercept, coeff is a vector containing the value of each coefficient, and Observations is a dataframe where each row the observations for each coefficient and each column is a year of the projection

## Model 20

# Recruitment is a vector of the fixed recruitment for each year.

## Model 21

# Recruitment is a list containing 3 objects: Nobs is the number of observations, Obs is a vector of observed recruitments, and SSBHingeValue is the value at which the linear decline to zero begins.



## Harvest is the harvest strategy you want to use: first column is the harvest specification, then one column for each fleet for each year. Landings (catch) = 1, F-Mult (F) = 0, Removals = ?

## Here is an example assuming constant catch over the number of years of the model where catch is partitianed based upon the relative catch by fleet in the last year of the assessment, this is calculated in SSInput$CatchbyFleet
TotalCatch<-3000

FleetRemovals<-t(sapply(ProportionCatch, function(p) rep(p*TotalCatch,NYears)))

Harvest<-list("Type"=c(rep(1,NYears)),"Harvest"=FleetRemovals)


source(file.path(script.dir,"AGEPRO_Input.R"))


## Now write the input file:

AGEPRO_INP(output.dir = "C:\\Users\\Michelle.Sculley\\Documents\\2024 WCNPO MLS Rebuilding\\Test2",
                    boot_file = boot_file,
                    SS_Out = SSInput,
                    ModelName="Test2",
                    ProjStart = 2021,
                    NYears = 10,
                    MinAge = 1,
                    Nsims = 100,
                    NRecr_models = 1,
                    Discards = 0,
                    set.seed = 123,
                    ScaleFactor = c(1000,1000,1000),  #population scaling factor, recruitment scaling factor, SSB scaling factor
                    UserSpecified = c(0,-1,0,0,0,0,0),
                    TimeVary = c(0,0,0,0,0,0,0),
                    FemaleFrac=0.5,
                    Recruitment=Recruitment,
                    Harvest=Harvest,
                    doRebuild=TRUE,
                    RebuildTargetSSB = 3000,
                    RebuildTargetYear = 2030,
                    PercentConfidence = 60,
                    LandingType = 1,
                    ThresholdReport = TRUE,
                    RefPointSSB = 3000,
                    RefPointJan1 = 0,
                    RefPointMidYr = 0,
                    RefPointF = 0.6,
                    SetBounds = TRUE,
                    MaxWeight = 250,
                    MaxNatM = 1,
                    SumReport = 1,
                    AuxFiles = 0,
                    RExport = 0,
                    SetScale = TRUE,
                    PercentileReport = TRUE,
                    Percentile = 50)
