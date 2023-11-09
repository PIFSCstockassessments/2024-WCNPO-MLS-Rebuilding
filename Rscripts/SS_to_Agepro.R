# Function to extract input data needed from the SS model to use in an agepro projection model
# Required inputs are: 
# model.dir is the directory where the completed SS model is found
# script.dir is the directory where the supporting .R files are found
# endyr is the last year of the assessment model
# TimeStep indicates is you are running AGEPRO with a yearly time step or as quarters as years. indicated "Year" or "Quarter"





SS_To_Agepro<-function(model.dir = "base",
                       script.dir = "Rscripts",
                       endyr = 2020,
                       TimeStep = "Year"){

source(file.path(script.dir,"SS_outputforAGEPRO.R"))



base.model<-SS_outputForAGEPRO(model.dir, script.dir=script.dir,verbose=FALSE, printstats=FALSE)
#indicate if you are doing yearly or years as quarters
Out<-list()


Out[["Nfleets"]]<-length(which(base.model$fleet_type==1))

## If using a BH recruitment (options 5 or 10), you need alpha, beta, and variance
## note that B0 is kilograms of biomass and R0 is numbers of fish

## from the agepro reference guide: alpha = (4hR0)/(5h-1)
Out[["alpha"]]= (4 *  base.model$parameters[which(base.model$parameters$Label=="SR_BH_steep"),"Value"] * (1000*base.model$derived_quants[which(base.model$derived_quants$Label=="Recr_Virgin"),"Value"]) ) /( ( 5 * base.model$parameters[which(base.model$parameters$Label=="SR_BH_steep"),"Value"] ) - 1 )

## beta= (B0*(1-h))/(5h-1)
Out[["beta"]] = (1000*(base.model$derived_quants[which(base.model$derived_quants$Label=="SSB_Virgin"),"Value"]) * (1- base.model$parameters[which(base.model$parameters$Label=="SR_BH_steep"),"Value"])) / ( (5*base.model$parameters[which(base.model$parameters$Label=="SR_BH_steep"),"Value"])-1)

#variance is sigmaR
Out[["BH_var"]]<-base.model$parameters[which(base.model$parameters$Label=="SR_sigmaR"),"Value"]
 Out[["RecruitmentObs"]]<- base.model$recruit[,c("Yr","SpawnBio","pred_recr","dev")]

## by year
if(TimeStep=="Year"){
  Out[["MaxAge"]]=base.model$accuage
  
  
  ## Maturity
  
  ## maturity at age, starting at age 1
  #length at age then use maturity ogive to calculate maturity at age
  ## Pmature(L) = 1 / (1 + exp(beta*(L-L50)))
  
  
  Out[["MatAtAge"]]<-1 / (1+ exp(base.model$parameters[which(base.model$parameters$Label=="Mat_slope_Fem_GP_1"),"Value"]*(base.model$growthseries[1,6:ncol(base.model$growthseries)]-base.model$parameters[which(base.model$parameters$Label=="Mat50%_Fem_GP_1"),"Value"])))
  Out[["MatAtAgeCV"]]<-rep(0.01,Out$MaxAge)
  
  ## Fishery Selectivity at age
  
  ## by year
  
  Out[["Fishery_SelAtAge"]] <- base.model$ageselex %>%
    filter(Factor == "Asel2", Yr == endyr, Seas == 1) %>%
    select(9:ncol(.))
  
  ##Fishery_seleatage coefficient of variation, set to a standard 0.1
  Out[["Fishery_SelAtAgeCV"]]<-matrix(0.1,nrow=Out$Nfleets,ncol=Out$MaxAge)
  
  Out[["NatMort_atAge"]] <- base.model$Natural_Mortality %>%
    slice(1) %>%
    select(6:ncol(.))
  Out[["NatMort_atAgeCV"]]<-rep(0.1,Out$MaxAge)
  
  
  ## weights at age
  
  # Jan-1
  
  # using start year because for some reason endyear isn't showing up in the report data.
  
  Out[["Jan_WAA"]] <- base.model$growthseries %>%
    filter(Yr == endyr, Seas == 1, SubSeas == 1) %>%
    select(6:ncol(.)) %>%
    unlist()
  Out[["Jan_WAACV"]]<-rep(0.1,Out$MaxAge)
  
  ## SSB
  
  ## mid-year
  
  Out[["MidYr_WAA"]] <- base.model$growthseries %>%
    filter(Yr == endyr, Seas == 3, SubSeas == 1) %>%
    select(6:ncol(.)) %>%
    unlist()
  
  Out[["MidYr_WAACV"]]<-rep(0.1,Out$MaxAge)
  ## Catch at age - by fleet
  
  Out[["Catage"]] <- base.model$ageselex %>%
    filter(Factor == "bodywt", Yr == endyr, Seas == 1, Fleet <= 25) %>%
    select(2, 9:ncol(.))
  Out[["CatageCV"]]<-as.data.frame(matrix(0.1,nrow=Out$Nfleets,ncol=(ncol(Out$Catage)-1)))

  ## Last year's catch by fleet in biomass (to calculate the proportion of total catch)
  
  Out[["CatchbyFleet"]]<-base.model$timeseries %>%
    filter(Yr==endyr) %>%
    select(starts_with("sel(B):_")) %>% 
    colSums() 
  Out[["CatchbyFleet"]]<-Out[["CatchbyFleet"]]/sum(Out[["CatchbyFleet"]])
    
    
  
  } else {  ## Years as quarters
  
  ## Maturity
  
  ## maturity at age, starting at age 1
  #length at age then use maturity ogive to calculate maturity at age
  ## Pmature(L) = 1 / (1 + exp(beta*(L-L50)))
    Out[["MaxAge"]]=base.model$accuage*4
    
  
  Out[["MatAtAge"]]<-1 / (1+ exp(base.model$parameters[which(base.model$parameters$Label=="Mat_slope_Fem_GP_1"),"Value"]*(seq(1,Out$MaxAge/4,0.25)-base.model$parameters[which(base.model$parameters$Label=="Mat50%_Fem_GP_1"),"Value"])))
  Out[["MatAtAgeCV"]]<-rep(0.01,Out$MaxAge)
  
  
  ## Fishery Selectivity at age
  
  Out[["Fishery_SelAtAge"]] <- base.model$ageselex %>%
    filter(Factor == "Asel2", Yr == endyr)
  
  ##Fishery_seleatage coefficient of variation, set to a standard 0.1
  
  Out[["Fishery_SelAtAgeCV"]]<-matrix(0.1,nrow=Out$Nfleets,ncol=Out$MaxAge)
  
  
  Out[["NatMort_atAge"]] <- base.model$Natural_Mortality %>%
    select(6:ncol(.)) %>%
    reshape2::melt() %>%
    select(value)
  
  Out[["NatMort_atAgeCV"]]<-rep(0.1,Out$MaxAge)
  ## weights at age
  
  # Jan-1
  
  Out[["Jan_WAA"]] <- base.model$growthseries %>%
    filter(Yr == endyr, SubSeas == 1) %>%
    select(6:ncol(.)) %>%
    melt() %>%
    select(2) %>%
    as.vector()
  Out[["Jan_WAACV"]]<-rep(0.1,Out$MaxAge)  
  ## SSB
  
  ## mid-year
  Out[["MidYr_WAA"]] <- base.model$growthseries %>%
    filter(Yr == endyr, SubSeas == 2) %>%
    select(6:ncol(.)) %>%
    melt() %>%
    select(2) %>%
    as.vector()
  Out[["MidYr_WAACV"]]<-rep(0.1,Out$MaxAge)  
  
  ## Catch  - by fleet
  Out[["Catage"]] <- base.model$ageselex %>%
    filter(Factor == "bodywt", Yr == endyr, Fleet <= 25) %>%
    select(2, 4, 9:ncol(.)) %>%
    melt(id.vars = c("Seas", "Fleet")) %>%
    dcast(Fleet ~ variable + Seas)
  Out[["CatageCV"]]<-as.data.frame(matrix(0.1,nrow=Out$Nfleets,ncol=(ncol(Out$Catage)-1)))
  
  Out[["CatchbyFleet"]]<-base.model$timeseries %>%
    filter(Yr==endyr) %>%
    select(starts_with("sel(B):_"))
  Out[["CatchbyFleet"]]<-Out[["CatchbyFleet"]]/rowSums(Out[["CatchbyFleet"]])
  
}
 return(Out)
}