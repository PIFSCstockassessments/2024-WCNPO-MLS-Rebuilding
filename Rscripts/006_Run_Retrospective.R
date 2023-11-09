#><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>
# Run Retrospective analysis 
#><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>

# Install r4ss
# devtools::install_github('r4ss/r4ss')
# Load Libray
library(r4ss)
library(gridExtra)
library(ggplot2)
#><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>
# Preparations
#><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>><>


# Step 1. Identify the base directory
dirname.base = current.dir
#  file.path(current.dir,"Diagnostics","Retros")

# Names of DAT and CONTROL files
DAT = data.file.name
CTL =  ctl.file.name

# # Step 2. Identify the directory where a completed model run is located
 dirname.completed.model.run <- dirname.base
# dirname.completed.model.run
# 
# # Step 3. Create a subdirectory for the Retrospectives
 dirname.Retrospective <- paste0(dirname.base,'/Retros')
 #dir.create(path=dirname.Retrospective, showWarnings = TRUE, recursive = TRUE)
 setwd(dirname.Retrospective)
# 
#
 if (Do_Retros==TRUE){
# # Step 4.
 #----------------- copy model run files ----------------------------------------
  file.copy(paste(dirname.completed.model.run,       "starter.ss_new", sep="/"),
            paste(dirname.Retrospective, "starter.ss", sep="/"))
  file.copy(paste(dirname.completed.model.run,       "control.ss_new", sep="/"),
            paste(dirname.Retrospective, CTL, sep="/"))
  file.copy(paste(dirname.completed.model.run,       "data_echo.ss_new", sep="/"),
            paste(dirname.Retrospective, DAT, sep="/"))	
  file.copy(paste(dirname.completed.model.run,       "forecast.ss", sep="/"),
            paste(dirname.Retrospective, "forecast.ss", sep="/"))
  file.copy(paste(dirname.completed.model.run,       "SS.exe", sep="/"),
            paste(dirname.Retrospective, "ss.exe", sep="/"))
  file.copy(paste(dirname.completed.model.run,       "ss.par", sep="/"),
            paste(dirname.Retrospective, "ss.par", sep="/"))
#  file.copy(paste(dirname.completed.model.run,       "wtatage.ss", sep="/"),
#            paste(dirname.Retrospective, "wtatage.ss", sep="/"))
# 
# #------------Make Changes to the Starter.ss file (DC Example) ------------------------------- 
  starter <- readLines(paste(dirname.Retrospective, "/starter.ss", sep=""))
# # 
# # # 1) Starter File changes to speed up model runs
# # # Run Display Detail
 # [8] "2 # run display detail (0,1,2)" 
  linen <- grep("# run display detail", starter)
  starter[linen] <- paste0( 1 , " # run display detail (0,1,2)" )
  write(starter, paste(dirname.Retrospective, "starter.ss", sep="/"))
# # 
# #------------ r4SS retrospective calculations------------------------------- 
# 
# # Step 5. Run the retrospective analyses with r4SS function "retro"
# # Here Switched off Hessian extras "-nohess" (much faster)
# 
  retro(dir=dirname.Retrospective, oldsubdir="", newsubdir="", years=start.retro:-end.retro,extras = "-nohess")
 }
 
  if (Plot_Retros==TRUE){
    if(!file.exists(file.path(current.dir, "Retros"))){
      stop("No retrospecitve runs were found. Please change Do_Retros = TRUE first.")
      } else {
# Step 6. Read "SS_doRetro" output
retroModels <- SSgetoutput(dirvec=file.path(dirname.Retrospective, paste("retro",start.retro:-end.retro,sep="")), verbose=FALSE)

# Step 7. save as Rdata file for ss3diags
#save(retroModels,file=file.path(dirname.Retrospective,paste0("Retro_",Run,".rdata")))


## plot your results
retroSummary <- SSsummarize(retroModels, verbose=FALSE)
endyrvec <- retroSummary$endyrs + 0:-5


SummaryBio<-retroSummary$SpawnBio
names(SummaryBio)<-c("basecase","retro-1","retro-2","retro-3","retro-4","retro-5","Label","Yr")
SummaryBio<-melt(SummaryBio,id.vars=c("Label","Yr"))
SummaryBio<-subset(SummaryBio,Yr>=startyear)
RemoveVector<-c(which(SummaryBio$variable=="retro-1"&SummaryBio$Yr==endyear),which(SummaryBio$variable=="retro-2"&SummaryBio$Yr>=endyear-1),which(SummaryBio$variable=="retro-3"&SummaryBio$Yr>=endyear-2),which(SummaryBio$variable=="retro-4"&SummaryBio$Yr>=endyear-3),which(SummaryBio$variable=="retro-5"&SummaryBio$Yr>=endyear-4))
SummaryBio<-SummaryBio[-RemoveVector,]

Retro_Bio<-ggplot() +
  geom_line(aes(x=Yr,y=value,color=variable),data=SummaryBio, size=1) +
  theme(panel.border = element_rect(color="black",fill=NA,size=1),
        panel.background = element_blank(), strip.background = element_blank(),
        legend.position = "none") +
  scale_color_manual(values = c("basecase" = "black","retro-1" = "red", "retro-2"="orange","retro-3"="yellow","retro-4"="green","retro-5"="blue", "basecase"="black")) + xlab("Year") + ylab("Spawning Biomass (mt)") +
  geom_line(aes(x=Yr,y=value),data=subset(SummaryBio,variable=="basecase"),color="black", size=1.25)



### Other figures using SPR not F
SPR<-retroSummary$SPRratio
names(SPR)<-c("basecase","retro-1","retro-2","retro-3","retro-4","retro-5","Label","Yr")
SPR<-melt(SPR,id.vars=c("Label","Yr"))
SPR<-subset(SPR,Yr>=startyear)
RemoveVector<-c(which(SPR$variable=="retro-1"&SPR$Yr==endyear),which(SPR$variable=="retro-2"&SPR$Yr>=endyear-1),which(SPR$variable=="retro-3"&SPR$Yr>=endyear-2),which(SPR$variable=="retro-4"&SPR$Yr>=endyear-3),which(SPR$variable=="retro-5"&SPR$Yr>=endyear-4))
SPR<-SPR[-RemoveVector,]

Retro_SPR<-ggplot() +
  geom_line(aes(x=Yr,y=value,color=variable),data=SPR, size=1) +
  theme(panel.border = element_rect(color="black",fill=NA,size=1),
        panel.background = element_blank(), strip.background = element_blank(),
        legend.position = "none") +
  scale_color_manual(values = c("basecase" = "black","retro-1" = "red", "retro-2"="orange","retro-3"="yellow","retro-4"="green","retro-5"="blue", "basecase"="black")) + xlab("Year") + ylab("1-SPR") +
  geom_line(aes(x=Yr,y=value),data=subset(SPR,variable=="basecase"),color="black", size=1.25) +
  scale_y_continuous(limits = c(0,1))
# grid.arrange(a,b,ncol=2)
MohnsRho<-SShcbias(retroSummary)

    }}
 
 
#*******************************************************************
#  Retrospective Analysis with Hindcasting
#*******************************************************************

# load retroModels produced with "Run_Retrospective_bum.R"
#load(file=file.path(getwd(),paste0("Retro_",Run),paste0("Retro_",Run,".rdata")),verbose=T)

# Summarize the list of retroModels
#retroSummary <- r4ss::SSsummarize(retroModels)

# # Now Check Retrospective Analysis with one-step ahead Forecasts

#dev.print(jpeg,paste0(plotdir,"/RetroForecast_",Run,".jpg"), width = 8, height = 9, res = 300, units = "in")


# # 
# # # Do Hindcast with Cross-Validation of CPUE observations
#  sspar(mfrow=c(3,2))
#  SSplotHCxval(retroSummary,add=T, cex.main=0.5) # CPUE
#  dev.print(jpeg,paste0(plotdir,"/HCxvalIndex_",Run,".jpg"), width = 16, height = 10, res = 300, units = "in")
# # 
# # # Also test new feature of Hindcast with Cross-Validation for mean length
#  sspar(mfrow=c(3,2))
#  # Use new converter fuction SSretroComps() for size comps
#  hccomps = SSretroComps(retroModels)
#  # Plot
#  SSplotHCxval(hccomps,add=T,subplots = "len",legendloc="bottomright",legendcex=0.8)
#  dev.print(jpeg,paste0(plotdir,"/HCxvalLen_",Run,".jpg"), width = 8, height = 10, res = 300, units = "in")
# # 
# # # Get mase stats from hindcasting
#  SSmase(retroSummary,quants="cpue")
#  SSmase(hccomps,quants="len")
# 
