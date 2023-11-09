### code to run quick checks on SS models for SWO

suppressMessages(suppressWarnings(library(r4ss)))
library(ss3diags, quietly=T, warn.conflicts = F)
library(reshape2, quietly=T, warn.conflicts=F)
library(ggplot2, quietly=T, warn.conflicts=F)
library(gt)
library(gtExtras)
library(gtsummary)

base.dir<-"C://users//michelle.sculley//documents//2023 SWO ASSESS"
model.list<-c("01_Divide F9 size data",
              "02_Drop S4 and S8",
              "03_both 1 and 2",
              "04_change Lmin",
              "05_change settlement month",
              "06_increase CV Lmin",
              "07_lognormal selec", 
              "08_2 4 and 7",
              "09_3 and 7", 
              "10_3 4 7 and 6",
              "11_drop F20 decrease Amin",
              "12_mirrow F9",
              "13_mirrorF9 decrease Amin",
              "14_mirrorF9 decrease Amin Fix eqcat",
              "15_TWN selec")

#current.dir<-paste0(base.dir,"//SA Meeting Runs//",model.list[4])

#current.dir<-paste0(base.dir, "//ModelDev//Current Best")#//F9 Cubic Spline")
#current.dir<-paste0(base.dir,"//ModelDev//NoSex//TWN block//JPN F1 block//DW Size Comp//Split F9 size")
setwd(base.dir)
### Run all
# for ( i in 1:length(model.list)){
#   current.dir<-paste0(base.dir,"//SA Meeting Runs//",model.list[i])
#   
#   base.model<-SS_output(current.dir)#, printstats = FALSE, verbose=FALSE)
# 
# 

# 
# SS_plots(base.model, html = FALSE, png = FALSE, pdf=TRUE, catchasnumbers = TRUE)
# }

#### RUn just one
current.dir<-paste0(base.dir,"//Final Base-case")
plotdir<-paste0(current.dir,"//plots")

base.model<-SS_output(current.dir, printstats = FALSE, verbose=FALSE)
startyear= 1975
endyear = 2021
rnames <- base.model$derived_quants$Label


model.info<-list(
"nyr"=5,  ## indicates how many years you want to average the dynamic B0 over if applicable
"nboot"= 100, ## number of bootstrap files to create
"seed"=123, ##set seed value
"data.file.name"="swo2023_v004.dat",
"ctl.file.name"="swo2023_v007.ctl",
"N_foreyrs"=10,
"init_values" = 1, #read from par = 1, read from ctl file = 0
"F_age_range"=c(1,10),
"F_report_basis" = 0, #0=raw_annual_F; 1=F/Fspr; 2=F/Fmsy; 3=F/Fbtgt; where F means annual_F; values >=11 invoke N multiyr (up to 9!) with 10's digit; >100 invokes log(ratio)
"Min_age_biomass"=1)




  nyr=5  ## indicates how many years you want to average the dynamic B0 over if applicable
  nboot= 100 ## number of bootstrap files to create
  seed=123 ##set seed value
  data.file.name="swo2023_v004.dat"
  ctl.file.name="swo2023_v007.ctl"
  N_foreyrs=10
  init_values = 1 #read from par = 1, read from ctl file = 0
  F_age_range=c(1,10)
  F_report_basis = 0 #0=raw_annual_F; 1=F/Fspr; 2=F/Fmsy; 3=F/Fbtgt; where F means annual_F; values >=11 invoke N multiyr (up to 9!) with 10's digit; >100 invokes log(ratio)
  Min_age_biomass=1

Scenario<-c(1:5)
Fsetting <- c(1,4,4,2,3)  # run = c("FSPR30%","F2008-2010","Fstatusquo","FMSY","F20%SSBF=0")
Fyears <- list(c(2021, 2021, 2018,2020, 1975, 2020),
               c(2021, 2021, 2008,2010, 1975, 2020),
               c(2021, 2021, 2018,2020, 1975, 2020),
               c(2021, 2021, 2018,2020, 1975, 2020),
               c(2021, 2021, 2018,2020, 1975, 2020))
N_foreyrs<-10

### Set up to run/plot 
Do_Jitter<-FALSE
NJitter<-100
Plot_Jitter<-TRUE
Do_Bootstraps<-FALSE
Do_Forecast<-FALSE
Do_Sensitivity<-FALSE
Plot_Sensitivity<-TRUE
Do_Retros<-FALSE
start.retro <- 0 
end.retro   <- 5 
Plot_Retros<-TRUE
nSens<-24
refpoint="MSY"
#SS_plots(base.model, html = TRUE, png = TRUE, pdf=FALSE, catchasnumbers = TRUE)



                                                                          # # For cpue
# png(paste0(plotdir,"//CPUERunsTest.png"),height=8,width=8, units="in",res=200)
# sspar(mfrow=c(4,2),plot.cex = 0.8)
# SSplotRunstest(base.model,subplots="cpue",add=T,cex.main = 0.8) # use add=T to maintain plot set up
# dev.off()
# # Add Joint Residual plot and use ploting option
# SSplotJABBAres(base.model,subplots="cpue",add=T,legendcex = 0.5,ylimAdj = 2)
# 
# png(paste0(plotdir,"//LengthRunsTest.png"),height=8,width=8, units="in",res=200)
# sspar(mfrow=c(4,2),plot.cex = 0.8)
# SSplotRunstest(base.model,subplots="len",add=T,cex.main = 0.8) # use add=T to maintain plot set up
# dev.off()
# 
# 

# CPUE.annual<-base.model$cpue[,c("Fleet_name","Yr","Obs")]
# CPUE.annual<-dcast(CPUE.annual,Yr~Fleet_name)
# for (i in 1:8){
#   CPUE.annual[,i+1]<-CPUE.annual[,i+1]/CPUE.mean[i,2]
# }
# CPUE.annual<-melt(CPUE.annual, id.var="Yr", na.rm=TRUE)
# ggplot()+
#   geom_point(aes(x=Yr,y=value,fill=variable),data=CPUE.annual) +
#   geom_line(aes(x=Yr,y=value,color=variable),data=CPUE.annual) +
#   theme_bw() 
#   
# head(base.model$lendbase)
# 
# lendbase<-base.model$lendbase
# 
# Bins <- sort(unique(lendbase[["Bin"]]))
# nbins <- length(Bins)
# df <- data.frame(
#   Nsamp_adj = lendbase[["Nsamp_adj"]],
#   effN = lendbase[["effN"]],
#   obs = lendbase[["Cum_obs"]] * lendbase[["Nsamp_adj"]],
#   exp = lendbase[["Exp"]] * lendbase[["Nsamp_adj"]]
# )
# if ("Nsamp_DM" %in% names(lendbase) && any(!is.na(lendbase[["Nsamp_DM"]]))) {
#   df[["Nsamp_DM"]] <- lendbase[["Nsamp_DM"]]
# }
# 
# agg <- aggregate(
#   x = df,
#   by = list(
#     bin = lendbase[["Bin"]], f = lendbase[["Fleet"]],
#     sex = lendbase[["sex"]], mkt = lendbase[["Part"]]
#   ),
#   FUN = sum
# )
# agg <- agg[agg[["f"]] %in% fleets, ]
# agg[["obs"]] <- agg[["obs"]] / agg[["Nsamp_adj"]]
# agg[["exp"]] <- agg[["exp"]] / agg[["Nsamp_adj"]]
# which(round(agg$obs,1)==1.00)
# agg[which(round(agg$obs,1)==1.00),]
# 
# # note: sample sizes will be different for each bin if tail compression is used
# #       printed sample sizes in plot will be maximum, which may or may not
# #       represent sum of sample sizes over all years/ages
# 
# # loop over fleets
# for (f in unique(agg[["f"]])) {
#   # loop over fleets within market
#   for (mkt in unique(agg[["mkt"]][agg[["f"]] == f])) {
#     sub <- agg[["f"]] == f & agg[["mkt"]] == mkt
#     agg[["Nsamp_adj"]][sub] <- max(agg[["Nsamp_adj"]][sub])
#     if ("Nsamp_DM" %in% names(agg) && any(!is.na(agg[["Nsamp_DM"]]))) {
#       agg[["Nsamp_DM"]][sub] <- max(agg[["Nsamp_DM"]][sub], na.rm = TRUE)
#     } else {
#       if (any(!is.na(agg[["effN"]][sub]))) {
#         agg[["effN"]][sub] <- max(agg[["effN"]][sub], na.rm = TRUE)
#       } else {
#         agg[["effN"]][sub] <- NA
#       }
#     }
#   }
# }
