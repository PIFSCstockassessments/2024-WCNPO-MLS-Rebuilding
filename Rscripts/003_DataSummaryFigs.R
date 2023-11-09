## Create Catch, CPUE, and size comp summary figures
## run 001_LoadModel.R first
library(RColorBrewer, quietly = T, warn.conflicts = F)
library(ggplot2, quietly =T, warn.conflicts = F)
Catch<-base.model$catch[,c("Fleet","Fleet_Name","Yr","Seas","sel_bio")] 
CatchAgg<-aggregate(Catch$sel_bio,by=list(Catch$Yr,Catch$Fleet_Name,Catch$Fleet),sum)
names(CatchAgg)<-c("Yr","Name","Fleet","Obs")
CatchTotal<-aggregate(CatchAgg$Obs,by=list(CatchAgg$Yr),sum)
InputCatch<-base.model$catch[,c("Fleet","Yr","Seas","Obs")]
InputCatch<-reshape2::dcast(InputCatch,Yr+Seas~Fleet)
InputCatch<-subset(InputCatch,InputCatch$Yr>1974)


CatchAgg[which(CatchAgg[,"Fleet"]==1|CatchAgg[,"Fleet"]==6|CatchAgg[, "Fleet"]==7|CatchAgg[,"Fleet"]==10|CatchAgg[,"Fleet"]==11|CatchAgg[,"Fleet"]==12|CatchAgg[,"Fleet"]==17|CatchAgg[,"Fleet"]==18),"Country"]<-"Japan WCNPO"
CatchAgg[which(CatchAgg[,"Fleet"]==3|CatchAgg[,"Fleet"]==8|CatchAgg[,"Fleet"]==9|CatchAgg[,"Fleet"]==15|CatchAgg[,"Fleet"]==16),"Country"]<-"USA WCNPO"
CatchAgg[which(CatchAgg[,"Fleet"]==2|CatchAgg[,"Fleet"]==13|CatchAgg[,"Fleet"]==14),"Country"]<-"Chinese Taipei WCNPO"
CatchAgg[which(CatchAgg[,"Fleet"]==19),"Country"]<-"WCPFC and IATTC WCNPO"
CatchAgg[which(CatchAgg[,"Fleet"]==4),"Country"]<-"IATTC EPO"
CatchAgg[which(CatchAgg[,"Fleet"]==5),"Country"]<-"Japan EPO"
CatchCountry<-aggregate(CatchAgg$Obs,by=list(CatchAgg$Yr,CatchAgg$Country),sum)
names(CatchCountry)<-c("Yr","Country","Obs")
# 
colourCount = length(unique(CatchAgg$Name))
getPalette =colorRampPalette(brewer.pal(11, "Spectral"))
Fill<-getPalette(colourCount)
#png(paste0(plotdir,"\\CatchByFleet.png"),height=4, width=8, units="in",res=200)
CatchByFleet<-ggplot()+
  geom_bar(aes(x=Yr,y=Obs,fill=forcats::fct_rev(Name)),data=CatchAgg,stat="identity",color="black") +
  scale_fill_manual(values = Fill, name="")+
  xlab("Year") +
  ylab("Catch (mt)") +
  theme_bw()
#dev.off()

CatchByCountry_GS<-ggplot()+
  geom_bar(aes(x=Yr,y=Obs,fill=forcats::fct_rev(Country)),data=CatchCountry,stat="identity",color="black") +
  scale_fill_manual(values = c("WCPFC and IATTC WCNPO"="black","USA WCNPO"="grey15","Japan WCNPO"="grey30","Japan EPO"="grey45", "IATTC EPO" = "grey60","Chinese Taipei WCNPO" = "grey 75"))+
  xlab("Year") +
  ylab("Catch (mt)") +
  theme_bw()+
  theme(legend.title=element_blank(), legend.text=element_text(size=8))




colourCount = length(unique(CatchAgg$Country))
getPalette =colorRampPalette(brewer.pal(4, "Spectral"))
Fill<-getPalette(colourCount)
#png(file.path(plotdir,"Summarycatch_Color.png"),height=4, width=8, units="in",res=300)
CatchByCountry_Col<-ggplot()+
  geom_bar(aes(x=Yr,y=Obs,fill=forcats::fct_rev(Country)),data=CatchCountry,stat="identity",color="black") +
  scale_fill_manual(values = Fill, name="")+
  xlab("Year") +
  ylab("Catch (mt)") +
  theme_bw()+
  theme(legend.title=element_blank())
#CatchByCountry_Col
#dev.off()




##CPUEs
CPUE<-base.model$cpue[,c("Fleet","Fleet_name","Yr","Seas","Obs","Exp","SE")]

##observed
ObservedCPUE<-ggplot()+
  geom_point(aes(x=Yr,y=Obs),data=CPUE) +
  geom_errorbar(aes(x=Yr,ymin=Obs-1.96*SE,ymax=Obs+1.96*SE),data=CPUE,width=0) +
  geom_line(aes(x=Yr,y=Obs),data=CPUE) +
  facet_wrap(~Fleet_name, ncol=2, scales="free_y") +
  theme_bw() +
  theme(panel.border = element_rect(color="black",fill=NA,size=1),
        panel.background = element_blank(), strip.background = element_blank()) +
  xlab("Year") + ylab("CPUE") 


ExpectedCPUE<-ggplot()+
  geom_point(aes(x=Yr,y=Obs),data=CPUE) +
  geom_errorbar(aes(x=Yr,ymin=Obs-1.96*SE,ymax=Obs+1.96*SE),data=CPUE,width=0) +
  geom_line(aes(x=Yr,y=Exp),data=CPUE) +
  facet_wrap(~Fleet_name, ncol=1, scales="free_y") +
  theme_bw() +
  theme(panel.border = element_rect(color="black",fill=NA,size=1),
        panel.background = element_blank(), strip.background = element_blank()) +
  xlab("Year") + ylab("CPUE") 