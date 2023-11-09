### Script to plot forecasts saved as mvln runs from the 009_Run_Forecast file


library(ss3diags)
library(r4ss)
library(ggplot2)
library(data.table)
library(reshape2)
library(dplyr)

fore_dir <- file.path(current.dir,"forecast")

if(!file.exists(file.path(fore_dir,"mv_projections.rds"))){ print("No projections file found"); next }



mv_fore   <- data.table( readRDS(file=file.path(fore_dir,"mv_projections.rds")) )

### split the run column to toss the bootstrap number and keep the forecast scenario number to average each forecast run
mv_fore$scenario<-reshape2::colsplit(mv_fore$run,"(?=[\\d+$])(?<=\\p{L})",c("toss","keep"))[,"keep"]
mv_fore$scenario<-reshape2::colsplit(mv_fore$scenario,"(?=[\\d+$])(?<=\\p{L})",c("toss","keep"))[,"keep"]
mv_fore$run2<-mv_fore$run
mv_fore$run<-mv_fore$scenario


##filter out runs that are outside of realistic bounds, the maximum number of recruits from the 1000 mc's from the base model in mvln is 3200
mv_fore<-mv_fore[which(mv_fore$Recr<2000),]
mv_fore<-mv_fore[which(mv_fore$SSB<999999),]

Z <- mv_fore %>%  group_by(year,run) %>% 
  summarize(F=mean(F),SSB=mean(SSB),Catch=mean(Catch))

mv_base<-SSdeltaMVLN(base.model,mc=1000,plot=FALSE)$kb
Y <- mv_base %>%  group_by(year,run) %>% 
  summarize(F=mean(F),SSB=mean(SSB),Catch=mean(Catch))


X<-rbind(as.data.frame(Z[1:5,]),Y[nrow(Y),],Y[nrow(Y),],Y[nrow(Y),],Y[nrow(Y),],Y[nrow(Y),])
X[c(6:10),2]<-c(1:5)

Temp<-aggregate(mv_fore,by=list(mv_fore$year,mv_fore$run),sd)[,c(1:2,9,10,12)]
names(Temp)<-c("year","run","SSBstd","Fstd","Catchstd")
Z<-merge(Z,Temp)



Catch_Projections<-ggplot()+
  geom_line(aes(x=year,y=Catch,color=as.factor(run),linetype=as.factor(run) ),data=Z)+
  geom_point(aes(x=year,y=Catch,color=as.factor(run),shape=as.factor(run) ),data=Z)+
  scale_color_manual(values=c("red","blue","black","grey50","green","black"), name="Scenario", labels = c("FSPR30%","F2008-2010","Fstatusquo","FMSY","F20%SSBF=0")) +
  scale_linetype_manual(values=c(1, 2, 3, 4, 5, 1),name="Scenario",labels = c("FSPR30%","F2008-2010","Fstatusquo","FMSY","F20%SSBF=0"))+
  scale_shape_manual(values=c(15, 16, 17, 3, 4),name="Scenario",labels = c("FSPR30%","F2008-2010","Fstatusquo","FMSY","F20%SSBF=0"))+
  scale_fill_manual(values=c("red","blue","black","grey50","green"), name="Scenario",labels = c("FSPR30%","F2008-2010","Fstatusquo","FMSY","F20%SSBF=0")) +
geom_ribbon(aes(x=year,ymax=Catch+1.96*Catchstd,ymin=Catch-1.96*Catchstd,fill=as.factor(run)),data=Z,alpha=0.05)+
  geom_line(aes(x=year,y=Catch),data=Y)+
  geom_line(aes(x=year,y=Catch,linetype=as.factor(run)),data=X)+
  ylab("Catch (mt)") +
  xlab("Year")+
  theme(axis.text.x=element_text(size=8), axis.title.x=element_text(size=12),
        axis.text.y=element_text(size=8),axis.title.y=element_text(size=12),
        panel.border = element_rect(color="black",fill=NA,size=2),
        panel.background = element_blank())+
  
  scale_x_continuous(breaks=seq(1975,2035,5))+
  scale_y_continuous(limits = c(0,31000))


SSB_Projections<-ggplot()+
  geom_line(aes(x=year,y=SSB,color=as.factor(run),linetype=as.factor(run) ),data=Z)+
  geom_point(aes(x=year,y=SSB,color=as.factor(run),shape=as.factor(run) ),data=Z)+
  scale_color_manual(values=c("red","blue","black","grey50","green","black"),name="Scenario", labels = c("FSPR30%","F2008-2010","Fstatusquo","FMSY","F20%SSBF=0")) +
  scale_linetype_manual(values=c(1, 2, 3, 4, 5, 1),name="Scenario",labels = c("FSPR30%","F2008-2010","Fstatusquo","FMSY","F20%SSBF=0"))+
  scale_shape_manual(values=c(15, 16, 17, 3, 4),name="Scenario",labels = c("FSPR30%","F2008-2010","Fstatusquo","FMSY","F20%SSBF=0"))+
  scale_fill_manual(values=c("red","blue","black","grey50","green"), name="Scenario",labels = c("FSPR30%","F2008-2010","Fstatusquo","FMSY","F20%SSBF=0")) +
  geom_ribbon(aes(x=year,ymax=SSB+1.96*SSBstd,ymin=SSB-1.96*SSBstd,fill=as.factor(run)),data=Z,alpha=0.05)+
  geom_line(aes(x=year,y=SSB),data=Y)+
  geom_line(aes(x=year,y=SSB,linetype=as.factor(run)),data=X)+
  geom_hline(yintercept=ExecSumInfo[[6]],linetype="dashed") +
  ylab("Spawning Stock Biomass (mt)") +
  xlab("Year")+
  theme(axis.text.x=element_text(size=8), axis.title.x=element_text(size=12),
        axis.text.y=element_text(size=8),axis.title.y=element_text(size=12),
        panel.border = element_rect(color="black",fill=NA,size=2),
        panel.background = element_blank())+
  scale_x_continuous(breaks=seq(1975,2035,5))+
    scale_y_continuous(limits=c(0,65000))

