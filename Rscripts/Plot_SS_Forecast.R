### Script to plot forecasts saved as mvln runs from the 009_Run_Forecast file
## unzip the files in each bootstrap projections folder prior to running this code.

library(ss3diags)
library(r4ss)
library(ggplot2)
library(data.table)
library(reshape2)
library(dplyr)

model.dir<-c("C:\\Users\\Michelle.Sculley\\Documents\\2024 WCNPO MLS Rebuilding\\base")

fore_dirs<-c(file.path(model.dir,"bootstrap projections","LowRec_2400mt"),file.path(model.dir,"bootstrap projections","S-RCurve_2400mt"),file.path(model.dir,"bootstrap projections","LowRec_Fmsy"),file.path(model.dir,"bootstrap projections","S-RCurve_Fmsy"))

mods<-list()    
ModsSum<-list()
SSB<-list()
Catch<-list()
SSBMean<-data.frame(rep(NA,64),rep(NA,64),rep(NA,64),rep(NA,64))
CatchMean<-data.frame(rep(NA,20),rep(NA,20),rep(NA,20),rep(NA,20))

for (i in 1:length(fore_dirs)){

  ## load the models from each folder in the bootstrap projections folder  
        mods[[i]] <- SSgetoutput(keyvec = paste0("_", seq(1, N_boot)), 
                           dirvec = file.path(fore_dirs[i]), verbose = F)
    ## summarize the models
    ModsSum[[i]] <-SSsummarize(mods[[i]])
 
 ## extract SSB and catch values from each bootstrap run
 SSB[[i]]<-ModsSum[[i]]$quants %>% filter(stringr::str_starts(Label,"SSB_"))
 Catch[[i]]<-ModsSum[[i]]$quants %>% filter(stringr::str_starts(Label,"ForeCatch_"))
 
 ## identify which model runs crashed and remove them from the comparison
  dropruns<-as.vector(which(apply(Catch[[i]][,c(1:100)], 2, function(col) any(col < 0)))) 
## calculate the means and Standard deviations for each scenario
SSBMean[,i]<-rowMeans(SSB[[i]][3:66,-c(dropruns,101,102)])
SSBMean[,i+4]<-apply(SSB[[i]][3:66,-c(dropruns,101,102)],1,sd)
CatchMean[,i]<-rowMeans(Catch[[i]][,-c(dropruns,101,102)])
CatchMean[,i+4]<-apply(Catch[[i]][,-c(dropruns,101,102)],1,sd)
}
## add back in the years
SSBMean[,"Year"]<-c(1977:2040)
CatchMean[,"Year"]<-c(2021:2040)
names(SSBMean)<-c("LowCatch_Mean","SRCatch_Mean","LowF_Mean","SRF_Mean","LowCatch_SD","SRCatch_SD","LowF_SD","SRF_SD","Year")
names(CatchMean)<-c("LowCatch_Mean","SRCatch_Mean","LowF_Mean","SRF_Mean","LowCatch_SD","SRCatch_SD","LowF_SD","SRF_SD","Year")


##reshape Catch and SSB mean dataframes to use in ggplot
PlotCatch<-reshape2::melt(CatchMean,id.vars="Year")
PlotCatch<-transform(
  PlotCatch,
  Scenario = gsub("_.*","",variable),
  Measure = gsub(".*_","",variable)
)
PlotCatch<-PlotCatch[,!(names(PlotCatch) %in% c("variable"))]
PlotCatch<-reshape2::dcast(PlotCatch, Scenario + Year  ~ Measure)
Catch_Projections<-ggplot()+
  geom_line(aes(x=Year,y=Mean,color=as.factor(Scenario),linetype=as.factor(Scenario) ),data=PlotCatch)+
  geom_point(aes(x=Year,y=Mean,color=as.factor(Scenario),shape=as.factor(Scenario) ),data=PlotCatch)+
  scale_color_manual(values=c("red","blue","black","grey50"), name="Scenario", labels = c("LowRecruit 2400mt","LowRecruit Fmsy","S/R 2400mt","S/R Fmsy")) +
  scale_linetype_manual(values=c(1, 2, 3, 4),name="Scenario",labels = c("LowRecruit 2400mt","LowRecruit Fmsy","S/R 2400mt","S/R Fmsy"))+
  scale_shape_manual(values=c(15, 16, 17, 4),name="Scenario",labels = c("LowRecruit 2400mt","LowRecruit Fmsy","S/R 2400mt","S/R Fmsy"))+
  scale_fill_manual(values=c("red","blue","black","grey50"), name="Scenario",labels = c("LowRecruit 2400mt","LowRecruit Fmsy","S/R 2400mt","S/R Fmsy")) +
geom_ribbon(aes(x=Year,ymax=Mean+1.96*SD,ymin=Mean-1.96*SD,fill=as.factor(Scenario)),data=PlotCatch,alpha=0.05)+
  ylab("Catch (mt)") +
  xlab("Year")+
  theme(axis.text.x=element_text(size=8), axis.title.x=element_text(size=12),
        axis.text.y=element_text(size=8),axis.title.y=element_text(size=12),
        panel.border = element_rect(color="black",fill=NA,linewidth=2),
        panel.background = element_blank())+
  
  scale_x_continuous(breaks=seq(2018,2040,5))+
  scale_y_continuous(limits = c(0,6000))



PlotSSB<-reshape2::melt(SSBMean,id.vars="Year")
PlotSSB<-transform(
  PlotSSB,
  Scenario = gsub("_.*","",variable),
  Measure = gsub(".*_","",variable)
)
PlotSSB<-PlotSSB[,!(names(PlotSSB) %in% c("variable"))]
PlotSSB<-reshape2::dcast(PlotSSB, Scenario + Year  ~ Measure)
SSB_Projections<-ggplot()+
  geom_line(aes(x=Year,y=Mean,color=as.factor(Scenario),linetype=as.factor(Scenario) ),data=PlotSSB)+
  geom_point(aes(x=Year,y=Mean,color=as.factor(Scenario),shape=as.factor(Scenario) ),data=PlotSSB)+
  scale_color_manual(values=c("red","blue","black","grey50"), name="Scenario", labels = c("LowRecruit 2400mt","LowRecruit Fmsy","S/R 2400mt","S/R Fmsy")) +
  scale_linetype_manual(values=c(1, 2, 3, 4),name="Scenario",labels = c("LowRecruit 2400mt","LowRecruit Fmsy","S/R 2400mt","S/R Fmsy"))+
  scale_shape_manual(values=c(15, 16, 17, 4),name="Scenario",labels = c("LowRecruit 2400mt","LowRecruit Fmsy","S/R 2400mt","S/R Fmsy"))+
  scale_fill_manual(values=c("red","blue","black","grey50"), name="Scenario",labels = c("LowRecruit 2400mt","LowRecruit Fmsy","S/R 2400mt","S/R Fmsy")) +
  geom_ribbon(aes(x=Year,ymax=Mean+1.96*SD,ymin=Mean-1.96*SD,fill=as.factor(Scenario)),data=PlotSSB,alpha=0.05)+
  ylab("SSB (mt)") +
  xlab("Year")+
  theme(axis.text.x=element_text(size=8), axis.title.x=element_text(size=12),
        axis.text.y=element_text(size=8),axis.title.y=element_text(size=12),
        panel.border = element_rect(color="black",fill=NA,linewidth=2),
        panel.background = element_blank())+
  
  scale_x_continuous(breaks=seq(1975,2040,5))+
  scale_y_continuous(limits = c(0,17000))

## print the figures in the viewer, or print them to a file

png(file.path(model.dir,"bootstrap projections","CatchProjections.png"),height=4, width=6, units="in",res=200)
Catch_Projections
dev.off()

png(file.path(model.dir,"bootstrap projections","SSBProjections.png"),height=4, width=6, units="in",res=200)
SSB_Projections
dev.off()

## write the means and SD to a file
write.csv(CatchMean,file.path(model.dir,"bootstrap projections","SS3_Catch_Projections.csv"))
write.csv(SSBMean,file.path(model.dir,"bootstrap projections","SS3_SSB_Projections.csv"))