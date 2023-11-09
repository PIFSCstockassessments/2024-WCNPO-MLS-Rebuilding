#### File to create summary figures for biomass, SSB, F, and MSY
### Run file XX_loadModel.R prior to running this code
library(r4ss,warn.conflicts = F, quietly = T)
library(ss3diags,warn.conflicts = F, quietly = T)
library(ggplot2,warn.conflicts = F, quietly = T)
library(reshape2,warn.conflicts = F, quietly = T)
library(scales,warn.conflicts = F, quietly = T)  
library(RColorBrewer,warn.conflicts = F, quietly = T)
library(gridExtra,warn.conflicts = F, quietly = T)
library(dplyr,warn.conflicts = F, quietly = T)
library(tidyr,warn.conflicts = F, quietly = T)

SummBio<-base.model$timeseries[,c("Yr","Seas","Bio_all","Bio_smry","SpawnBio","Recruit_0")]
SumBioAll<-subset(SummBio,Seas==1)[,c("Yr","Bio_all")]
SumBiosmry<-subset(SummBio,Seas==1)[,c("Yr","Bio_smry")]
SumRecruit<-base.model$derived_quants[which(base.model$derived_quants==paste0("Recr_",startyear)):which(base.model$derived_quants==paste0("Recr_",endyear)),]
SumRecruit$Year<-seq(startyear, endyear,1)
SumBioSpawn<-base.model$derived_quants[which(base.model$derived_quants==paste0("SSB_",startyear)):which(base.model$derived_quants==paste0("SSB_",endyear)),]
SumBioSpawn$Year<-seq(startyear,endyear,1)
SSBTarget<-base.model$derived_quants[which(base.model$derived_quants$Label=="SSB_Btgt"),2]
SSBRatio<-SumBioSpawn$Value/base.model$derived_quants[1,2]
SSBdynRatio<-SumBioSpawn$Value/SSBTarget
Fseries<-base.model$derived_quants[which(base.model$derived_quants==paste0("F_",startyear)):which(base.model$derived_quants==paste0("F_",endyear)),]
Fseries$Year<-seq(startyear,endyear,1)
index_Fstd_MSY = which(rnames==paste("annF_MSY",sep=""))
index_Fstd_Btarget = which(rnames==paste("annF_Btgt",sep=""))
Fstd_MSY_est = base.model$derived_quants[index_Fstd_MSY:index_Fstd_MSY,2]
Fstd_Btgt_est = base.model$derived_quants[index_Fstd_Btarget:index_Fstd_Btarget,2]
index_Bstd_MSY = which(rnames==paste("SSB_MSY",sep=""))
index_Bstd_Btarget = which(rnames==paste("SSB_Btgt",sep=""))
SSBstd_MSY_est = base.model$derived_quants[index_Bstd_MSY:index_Bstd_MSY,2]
SSBstd_Btgt_est = base.model$derived_quants[index_Bstd_Btarget:index_Bstd_Btarget,2]
SumRecruit$LB<-SumRecruit$Value-1.96*SumRecruit$StdDev
SumRecruit$LB<-ifelse(SumRecruit$LB<0,0,SumRecruit$LB)

## create summary biomass figure
BioSumFig<-ggplot()+
  geom_point(aes(x=Yr,y=Bio_smry), data=SumBiosmry,size=2)+
  geom_line(aes(x=Yr,y=Bio_smry), data=SumBiosmry[-1,],size=1)+
  ylab("Biomass (mt, ages 1+)") +
  xlab("Year")+
  theme(axis.text.x=element_text(size=10,face="bold"), axis.title.x=element_text(size=12,face="bold"),
        axis.text.y=element_text(size=10,face="bold"),axis.title.y=element_text(size=12,face="bold"),
        panel.border = element_rect(color="black",fill=NA,size=1),
        panel.background = element_blank())+
  scale_x_continuous(breaks=seq(startyear,endyear,5)) +
  scale_y_continuous(limits = c(0,300000),label = comma)


SSB_Fig<-ggplot()+
  geom_point(aes(x=Year,y=Value), data=SumBioSpawn,size=1)+
  geom_errorbar(aes(x=Year,ymin=Value-1.96*StdDev,ymax=Value+1.96*StdDev),data=SumBioSpawn,size=1)+
  geom_line(aes(x=Year,y=Value),data=SumBioSpawn,size=1)+
  geom_hline(yintercept=0.9*base.model$derived_quants[which(base.model$derived_quants[,1]=="SSB_MSY"),2],color="green",linetype = 2, size=1)+
  ylab("Female Spawning Biomass (mt)") +
  theme(axis.text.x=element_text(size=10), axis.title.x=element_text(size=12),
        axis.text.y=element_text(size=10),axis.title.y=element_text(size=12),
        panel.border = element_rect(color="black",fill=NA,size=1),
        panel.background = element_blank())+
  geom_text(aes(x = 2015,y=base.model$derived_quants[which(base.model$derived_quants[,1]=="SSB_MSY"),2]+1000,label=as.character(expression(SSB[MSY]))),parse=TRUE, size=6) +
  scale_x_continuous(breaks=seq(startyear,endyear,5))

F_Fig<-ggplot()+
  geom_point(aes(x=Year,y=Value), data=Fseries,size=1)+
  geom_errorbar(aes(x=Year,ymin=Value-1.96*StdDev,ymax=Value+1.96*StdDev),data=Fseries,size=1)+
  geom_line(aes(x=Year,y=Value),data=Fseries,size=1)+
  geom_hline(yintercept=Fstd_MSY_est,color="green",linetype = 2, size=1)+
  ylab("Fishing Mortality (Average ages 1-10)") +
  theme(axis.text.x=element_text(size=10), axis.title.x=element_text(size=12),
        axis.text.y=element_text(size=10),axis.title.y=element_text(size=12),
        panel.border = element_rect(color="black",fill=NA,size=1),
        panel.background = element_blank())+
  geom_text(aes(x = 2018,y=Fstd_MSY_est+.02,label=as.character(expression(F[MSY]))),parse=TRUE, size=6) +
  scale_x_continuous(breaks=seq(startyear,endyear,5))


Rec_Fig<-ggplot()+
  geom_point(aes(x=Year,y=Value), data=SumRecruit,size=1)+
  geom_errorbar(aes(x=Year,ymin=LB,ymax=Value+1.96*StdDev),data=SumRecruit,size=1)+
  geom_line(aes(x=Year,y=Value),data=SumRecruit,size=1)+
  ylab("Recruitment (thousands of age-0 recruits)") +
  theme(axis.text.x=element_text(size=10,face="bold"), axis.title.x=element_text(size=12,face="bold"),
        axis.text.y=element_text(size=10,face="bold"),axis.title.y=element_text(size=12,face="bold"),
        panel.border = element_rect(color="black",fill=NA,size=1),
        panel.background = element_blank())+
  scale_x_continuous(breaks=seq(startyear,endyear,5))

## kobe plot



#SSplotKobe(mvn$kb,fill=F,posterior = "kernel",xlab=expression(SSB/SSB[MSY]),ylab=expression(F/F[MSY]),ylim=c(0,1.25),xlim=c(0.75,2.5))
