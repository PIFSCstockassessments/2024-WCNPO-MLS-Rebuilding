##### Executive summary data file base script for future Quarto incorporation

### Run 001_LoadModel.R prior to running is script
## MLS Assessment - December 2023
## Items needed from assessment:
  # Annual Catch
  # Annual SSB
  # Annual Summary Biomass
  # Annual SSB/20%SSBF=0
  # Annual SSB/SSBMSY
  # Annual F
  # Annual F/F20%SSBF=0
  # Annual F/FMSY
  # Annual Recruitment
  # Annual SPR
  # SSBMSY
  # 20% SSBF=0
  # FMSY
  # F 20SSBF=0
  # SPR MSY
  # SPR 20%SSBF=0
  # Catch MSY
  # Catch 20%SSBF=0
  # Ave SSB last 3 years
  # Ave F last 3 years
  # Ave Catch Last 3 years
  # Ave SPR last 3 years
  # Kobe plot percentages
  # Biological Parameters
  # Projected catch
  # Projected SSB
  # Projected Recruitment


##Please note, your starter file should have the following settings before running this code: 

## SPR Report basis: 4 - Raw SPR
## Annual F units: 4 - True F for range of ages
## F_std_basis: 0 - Raw annual F

## and the forecast file should be set to: 
## Benchmarks: 1 - calculate Fspr, Fbtgt, Fmsy
## MSY: 2 - calculate FMSY


##Projections are still in Beta - currently only valid for MLS assessment, please comment out before use in other assessments

#### Set working directory of base model, read in model, set up necessary parameters
library(r4ss)
library(ss3diags)



## Set up list 

ExecSumInfo<-list(NA)


## Pull annual time series

# Summary Biomass
SummBio<-base.model$timeseries[,c("Yr","Seas","Bio_all","Bio_smry","SpawnBio","Recruit_0")]
SumBiosmry<-subset(SummBio,Seas==1)[,c("Yr","Bio_smry")]

ExecSumInfo[[1]]<-SumBiosmry

## Summary SSB
SumBioSpawn<-base.model$derived_quants[which(base.model$derived_quants==paste0("SSB_",startyear)):which(base.model$derived_quants==paste0("SSB_",endyear)),2]
SumBioSpawnYr<-seq(startyear,endyear,1)
SumBioSpawn<-data.frame("Year"=SumBioSpawnYr, "SSB" = SumBioSpawn)

ExecSumInfo[[2]]<-SumBioSpawn



## Average SSB last 3 years

AveSSB<-mean(SumBioSpawn[which(SumBioSpawn$Year==(endyear-2)):which(SumBioSpawn$Year==endyear),"SSB"])

ExecSumInfo[[3]]<-c("Ave 3-year SSB"=AveSSB)


## Annual 20% SSBF=0

#dynamic b0 reference point calculation
Dyn_SBBzero<-0.2*mean(base.model$Dynamic_Bzero[(nrow(base.model$Dynamic_Bzero)-nyr):nrow(base.model$Dynamic_Bzero),4])

ExecSumInfo[[4]]<-c("20% SSBF=0"=Dyn_SBBzero)

#Annual ratio calculation
AnnSSB20per<-data.frame("SSB20Per"=(SumBioSpawn$SSB/Dyn_SBBzero),"Year"=seq(startyear,endyear,1))
ExecSumInfo[[5]]<-AnnSSB20per

## Annual SSB/SSBMSY
# Finds SSBMSY
index_Bstd_MSY = which(rnames==paste("SSB_MSY",sep=""))
Bstd_MSY_est = base.model$derived_quants[index_Bstd_MSY:index_Bstd_MSY,2]
ExecSumInfo[[6]]<-c("SSBMSY"=Bstd_MSY_est)

## annual ratio
AnnSSBMSY<-data.frame("Year"=seq(startyear,endyear,1),"SSBMSY"=(SumBioSpawn$SSB/Bstd_MSY_est))
ExecSumInfo[[7]]<-AnnSSBMSY

## Annual F
Fseries<-base.model$derived_quants[which(base.model$derived_quants==paste0("F_",startyear)):which(base.model$derived_quants==paste0("F_",endyear)),2]
FseriesYear<-seq(startyear,endyear,1)
Fseries<-data.frame("Year"=FseriesYear,"AnnualF"=Fseries)
ExecSumInfo[[8]]<-Fseries

## Average F last 3 years
AveF<-mean(Fseries[which(Fseries$Year==(endyear-2)):which(Fseries$Year==endyear),"AnnualF"])
ExecSumInfo[[9]]<-c("Avg last 3-year F"=AveF)

## Annual F20%SSBF=0
#Find F20%SSBF=0
index_Fstd_20per = which(rnames==paste("annF_Btgt",sep=""))
Fstd_20per_est = base.model$derived_quants[index_Fstd_20per:index_Fstd_20per,2]
ExecSumInfo[[10]]<-c("F 20%SSBF=0"=Fstd_20per_est)

# Calculate Ratio
AnnF20per<-data.frame("Year"=seq(startyear,endyear,1),"F20Per"=Fseries$AnnualF/Fstd_20per_est)
ExecSumInfo[[11]]<-AnnF20per

## Annual Fmsy
index_Fstd_MSY = which(rnames==paste("annF_MSY",sep=""))
Fstd_MSY_est = base.model$derived_quants[index_Fstd_MSY:index_Fstd_MSY,2]
ExecSumInfo[[12]]<-c("FMSY"=Fstd_MSY_est)

AnnFMSY<-data.frame("Year"=seq(startyear,endyear,1),"FMSY"=Fseries$AnnualF/Fstd_MSY_est)
ExecSumInfo[[13]]<-AnnFMSY

## Recruitment

SumRecruit<-base.model$derived_quants[which(base.model$derived_quants==paste0("Recr_",startyear)):which(base.model$derived_quants==paste0("Recr_",endyear)),2]
SumRecruitYear<-seq(startyear, endyear,1)
SumRecruit<-data.frame("Year"=SumRecruitYear,"Recruitment"=SumRecruit)
ExecSumInfo[[14]]<-SumRecruit

## Catch
## Annual Catch
Catch<-aggregate(base.model$catch$sel_bio,by=list(base.model$catch$Yr),sum)
names(Catch)<-c("Year","Catch")
ExecSumInfo[[15]]<-Catch

# Catch 20%SSBF=0
index_Catch_20per = which(rnames==paste("Dead_Catch_Btgt",sep=""))
Catch_20per_est = base.model$derived_quants[index_Catch_20per,2]
ExecSumInfo[[16]]<-c("Catch 20%SSBF=0"=Catch_20per_est)

# Catch MSY
index_Catch_MSY = which(rnames==paste("Dead_Catch_MSY",sep=""))
Catch_MSY_est = base.model$derived_quants[index_Catch_MSY,2]
ExecSumInfo[[17]]<-c("Catch MSY"=Catch_MSY_est)

## Average Catch last 3 years
AveCatch<-mean(Catch[which(Catch$Year==(endyear-2)):which(Catch$Year==endyear),"Catch"])
ExecSumInfo[[18]]<-c("Avg last 3-year catch"=AveCatch)


## SPR
## Annual SPR
SPR<-data.frame("SPR"=(1-base.model$derived_quants[which(rnames==paste0("SPRratio_",startyear)):which(rnames==paste0("SPRratio_",endyear)),"Value"]),"Year"=seq(startyear,endyear,1))
ExecSumInfo[[19]]<-SPR

##Average SPR last 3 years
AveSPR<-mean(SPR[which(SPR$Year==(endyear-2)):which(SPR$Year==endyear),"SPR"])
ExecSumInfo[[20]]<-c("Avg last 3-year SPR"=AveSPR)

## SPR 20%SSBF=0
index_SPR_20per = which(rnames==paste("SPR_Btgt",sep=""))
SPR_20per_est = base.model$derived_quants[index_SPR_20per,2]
ExecSumInfo[[21]]<-c("SPR 20%SSBF=0"=SPR_20per_est)

## SPR MSY
index_SPR_MSY = which(rnames==paste("SPR_MSY",sep=""))
SPR_MSY_est = base.model$derived_quants[index_SPR_MSY,2]
ExecSumInfo[[22]]<-c("SPR MSY"=SPR_MSY_est)

## Extract kobe plot percentages
#mvn = SSdeltaMVLN(base.model, Fref="MSY")
# Kobe<-SSplotKobe(mvn$kb,fill=F,posterior = "kernel",verbose=FALSE)
# ExecSumInfo[[23]]<-Kobe

## Extract Biological Parameters

paramLabels<-base.model$parameters$Label

## Growth

Growth<-data.frame("L1_F"=base.model$parameters[which(paramLabels=="L_at_Amin_Fem_GP_1"),"Value"],
                   "L2_F"=base.model$parameters[which(paramLabels=="L_at_Amax_Fem_GP_1"),"Value"],
                   "K_F"=base.model$parameters[which(paramLabels=="VonBert_K_Fem_GP_1"),"Value"],
                   "CVyoung_F"=base.model$parameters[which(paramLabels=="CV_young_Fem_GP_1"),"Value"],
                   "CVold_F"=base.model$parameters[which(paramLabels=="CV_old_Fem_GP_1"),"Value"],
                   "Wtlen a_F"=base.model$parameters[which(paramLabels=="Wtlen_1_Fem_GP_1"),"Value"],
                   "Wtlen b_F"=base.model$parameters[which(paramLabels=="Wtlen_2_Fem_GP_1"),"Value"],
                   "L1_M"=base.model$parameters[which(paramLabels=="L_at_Amin_Mal_GP_1"),"Value"],
                   "L2_M"=base.model$parameters[which(paramLabels=="L_at_Amax_Mal_GP_1"),"Value"],
                   "K_M"=base.model$parameters[which(paramLabels=="VonBert_K_Mal_GP_1"),"Value"],
                   "CVyoung_M"=base.model$parameters[which(paramLabels=="CV_young_Mal_GP_1"),"Value"],
                   "CVold_M"=base.model$parameters[which(paramLabels=="CV_old_Mal_GP_1"),"Value"],
                   "Wtlen a_M"=base.model$parameters[which(paramLabels=="Wtlen_1_Mal_GP_1"),"Value"],
                   "Wtlen b_M"=base.model$parameters[which(paramLabels=="Wtlen_2_Mal_GP_1"),"Value"])

ExecSumInfo[[23]]<-Growth
## Maturity

Maturity<-data.frame("L50"=base.model$parameters[which(paramLabels=="Mat50%_Fem_GP_1"),"Value"],
                   "Slope"=base.model$parameters[which(paramLabels=="Mat_slope_Fem_GP_1"),"Value"],
                   "Egg/kg int"=base.model$parameters[which(paramLabels=="Eggs/kg_inter_Fem_GP_1"),"Value"],
                   "Egg/kg slope"=base.model$parameters[which(paramLabels=="Eggs/kg_slope_wt_Fem_GP_1"),"Value"])

ExecSumInfo[[24]]<-Maturity

## Stock Recruitment

SR<-data.frame("ln(R0)"=base.model$parameters[which(paramLabels=="SR_LN(R0)"),"Value"],
                   "Steepness"=base.model$parameters[which(paramLabels=="SR_BH_steep"),"Value"],
                   "SigmaR"=base.model$parameters[which(paramLabels=="SR_sigmaR"),"Value"])

ExecSumInfo[[25]]<-SR

## Projections

# Note: This section needs to be cleaned up and automated a bit, but for the sake of time I'm just putting in the first round of "figure out how to pull all this stuff from the files", next step will be to streamline it, then automate it
# 
# save.image(file="Exec_Sum_Data.RData")
# 
# sink("ExecSum.txt")
# print(ExecSumInfo)
# sink()

