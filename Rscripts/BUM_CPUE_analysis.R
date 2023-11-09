
setwd("C:/Users/michelle.sculley/Documents/2023 SWO ASSESS")
df<-read.csv("C:\\Users\\michelle.sculley\\Documents\\2023 SWO ASSESS\\SWO_CPUE_94_21.csv", header=TRUE)

library(ggplot2)
library(mgcv)
library(maps)
library(maptools)
library(reshape2)
library(plyr)
library(gridExtra)
library(lme4)
library(labeling)
library(emmeans)
library(statmod)
library(lattice)
library(arm)





BUMCPUE<-data.frame("Year"=df[,"HAUL_YEAR"],"Month"=df[,"HAUL_MONTH"],"Day"=df[,"HAUL_DAY"],"Bait"=df[,"BAIT_CODE"], "BeginSetTime"=df[,"BEGIN_SET_TIME"],"HPF"=df[,"HOOKS_PER_FLOAT"],"Lat"=df[,"LAT"],"CPUE"=df[,"SWO_CPUE"],"Vessel"=df[,"PERMIT_NUMBER"],"Lon"=df[,"LON"]*-1, "SST"=df[,"SSTDEGC"],"PDO"=df[,"PDO_INDEX"],"SOI"=df[,"SOI"],"Target"=df[,"TARGET_SPECIES_CODE"], "Hooks"=df[,"NUMBER_OF_HOOKS_SET"])
BUMCPUE<-subset(BUMCPUE,!is.na(HPF)&!is.na(Bait))
BUMCPUE$Lat1<-ceiling(BUMCPUE$Lat)
BUMCPUE$Lon1<-ceiling(BUMCPUE$Lon)
BUMCPUE$Lat5<-(ceiling(BUMCPUE$Lat/5)*5)-2.5
BUMCPUE$Lon5<-(ceiling(BUMCPUE$Lon/5)*5)-2.5

Q1<-which(BUMCPUE$Month>=1&BUMCPUE$Month<=3)
Q2<-which(BUMCPUE$Month>=4&BUMCPUE$Month<=6)
Q3<-which(BUMCPUE$Month>=7&BUMCPUE$Month<=9)
BUMCPUE$Quarter<-4
BUMCPUE[Q1,"Quarter"]<-1
BUMCPUE[Q2,"Quarter"]<-2
BUMCPUE[Q3,"Quarter"]<-3

BUMCPUE$Begin<-ifelse(BUMCPUE$BeginSetTime>=0&BUMCPUE$BeginSetTime<=600,1,
                      ifelse(BUMCPUE$BeginSetTime>600&BUMCPUE$BeginSetTime<=1200,2,
                             ifelse(BUMCPUE$BeginSetTime>1200&BUMCPUE$BeginSetTime<=1800,3,4)))

BUMCPUE$SetType<-ifelse(BUMCPUE$Year<2004&BUMCPUE$HPF<=10,"S",
                        ifelse(BUMCPUE$Year>=2004&BUMCPUE$HPF<=14,"S","D"))

BUMCPUE<-BUMCPUE[which(BUMCPUE$CPUE<=60),]
BUMCPUE$Target<-trimws(BUMCPUE$Target)
BUMCPUE$Target<-ifelse(BUMCPUE$Target=="B","B", ifelse(BUMCPUE$Target=="T","T","M"))
BUMCPUE$Target<-as.factor(BUMCPUE$Target)


BUMCPUE<-BUMCPUE[complete.cases(BUMCPUE[,c("Year","Quarter","HPF","Bait","Begin","SST","Lat","Lon","PDO","SOI","Vessel")]),]


BUMCPUE$PropPos<-ifelse(BUMCPUE$CPUE>0,1,0)


BUMPos<-subset(BUMCPUE,PropPos==1)



RawCPUESet<-aggregate(BUMCPUE$CPUE, by=list(BUMCPUE$Year,BUMCPUE$SetType),mean)
RawCPUE<-aggregate(BUMCPUE$CPUE, by=list(BUMCPUE$Year),mean)
names(RawCPUESet)<-c("Year","Set","MeanCPUE")
names(RawCPUE)<-c("Year","MeanCPUE")

png("CPUE Stand//NominalCPUE.png")
ggplot() + 
    geom_point(aes(x=Year,y=MeanCPUE,color=Set),data=RawCPUESet) +
    geom_line(aes(x=Year,y=MeanCPUE,color=Set), data=RawCPUESet) +
    geom_point(aes(x=Year,y=MeanCPUE),data=RawCPUE) +
    geom_line(aes(x=Year,y=MeanCPUE), data=RawCPUE) +
    theme_bw() +
    scale_y_continuous(name="Nominal CPUE (fish per 1000 hooks)")
dev.off()



DeepSet<-subset(BUMPos,SetType=="D")


png("CPUE Stand\\PosCPUEhistogram_byset.png",height=6, width=10, units="in", res=200)
ggplot()+
    geom_histogram(aes(x=CPUE, fill=SetType),data=BUMPos, bins=30, color="black", position="dodge") + theme_bw() + scale_fill_manual(values=c("blue","red"))
dev.off()

RawCPUEDeep<-aggregate(DeepSet$CPUE, by=list(DeepSet$Year),mean)
names(RawCPUEDeep)<-c("Year","MeanCPUE")

RawsdDeep<-aggregate(DeepSet$CPUE, by=list(DeepSet$Year),sd)
names(RawsdDeep)<-c("Year","SD")

NomCPUE<-merge(RawCPUEDeep,RawsdDeep,by=c("Year"))
NomCPUE$Max<-NomCPUE$MeanCPUE+1.96*NomCPUE$SD
NomCPUE$Min<-NomCPUE$MeanCPUE-1.96*NomCPUE$SD

BUMUnique5<-unique(BUMCPUE[,c("Year","Lat5","Lon5","Vessel")])
UniqueCount5<-plyr::count(BUMUnique5,vars=c("Year","Lat5","Lon5"))
BUMCPUE<-merge(BUMCPUE,UniqueCount5,by=c("Year","Lat5","Lon5"))
BUMCPUE$Include5<-ifelse(BUMCPUE$freq<3,0,1)
BUMMapping5<-subset(BUMCPUE,Include5==1)

## Hawaii map
us<-readShapePoly("G:\\Swordfish\\tl_2016_us_state.shp")
hawaii<-subset(us,NAME=="Hawaii")
hawaiiMap<-fortify(hawaii)
Spatial1.5<-aggregate(BUMMapping5$CPUE,by=list(BUMMapping5$SetType,BUMMapping5$Lat5,BUMMapping5$Lon5),mean)
names(Spatial1.5)=c("Set","Lat","Lon","CPUE")

png("CPUE Stand\\CPUEbySet.png",height=6, width=10, units="in", res=200)
ggplot() +
    geom_point(aes(y=Lat,x=Lon,fill=CPUE),data=Spatial1.5,size=10, shape=21, color="grey25") +
#    geom_polygon(data=hawaiiMap,aes(x=long,y=lat,group=group)) +
    scale_fill_gradient2(low='blue',high='yellow2',mid="white", midpoint=3)  +
    theme(panel.background = element_blank(),  panel.grid.major = element_line(colour = "grey50"),
          panel.grid.minor = element_line(colour = "grey50"),
          strip.background = element_blank()) +
#    scale_x_continuous(limits=c(-175,-140),minor_breaks=seq(-190,-120,5)) +
 #   scale_y_continuous(limits=c(10,30),minor_breaks=seq(-5,45,5)) +
    coord_fixed(1) +
    facet_wrap(~Set)
dev.off()


AnnualSpatial1.5<-aggregate(BUMMapping5$CPUE,by=list(BUMMapping5$Year,BUMMapping5$SetType,BUMMapping5$Lat5,BUMMapping5$Lon5),mean)
names(AnnualSpatial1.5)=c("Year","Set","Lat","Lon","CPUE")

png("CPUE Stand\\DeepCPUEbyYear.png",height=6, width=10, units="in", res=200)

ggplot() +
    geom_point(aes(y=Lat,x=Lon,color=CPUE),data=subset(AnnualSpatial1.5,Set=="S"),size=4) +
    #geom_polygon(data=hawaiiMap,aes(x=long,y=lat,group=group),color="white") +
    # scale_color_gradient2(low='gray0',high='gray90',mid='gray50', midpoint=0.5) +
    theme(panel.background = element_blank(),  panel.grid.major = element_line(colour = "grey50"),
          panel.grid.minor = element_line(colour = "grey50"),
          strip.background = element_blank()) +
    #scale_x_continuous(minor_breaks=seq(-190,-120,5)) +
    #scale_y_continuous(minor_breaks=seq(0,45,5)) +
    coord_fixed(1) +
    facet_wrap(~Year, nrow=4)
dev.off()

MonthSet<-aggregate(BUMCPUE$CPUE,by=list(BUMCPUE$Month,BUMCPUE$SetType),mean)
names(MonthSet)=c("Month","Set","CPUE")
MonthSetSD<-aggregate(BUMCPUE$CPUE,by=list(BUMCPUE$Month,BUMCPUE$SetType),sd)
names(MonthSetSD)=c("Month","Set","SD")
MonthSet<-merge(MonthSet,MonthSetSD,by=c("Month","Set"))

png("CPUE Stand\\NominalCPUEbyMonth.png",height=6, width=10, units="in", res=200)

ggplot()+
    geom_point(aes(x=Month,y=CPUE, color=Set), data=MonthSet) +
    geom_line(aes(x=Month,y=CPUE, color=Set), data=MonthSet) +
    #  geom_errorbar(aes(ymin=CPUE-SD,ymax=CPUE+SD,x=Month,color=Set),data=MonthSet) +
    theme(panel.background = element_blank(),  panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), 
          panel.border=element_rect(color="gray50",fill=NA),
          legend.title=element_blank(),
          plot.title =element_text(hjust=0.5)) +
    ggtitle("Nominal CPUE") +
    scale_color_manual(values=c("blue","red"), labels=c("Deep","Shallow")) +
    scale_x_continuous(breaks=seq(1,12,1), labels=c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec")) +
facet_wrap(~Set, nrow=2,scales="free_y")
dev.off()


Targetlabels<-c("M"="Mixed Set","B"="Billfish Set", "T"="Tuna Set")




##All data
ggplot()+
    geom_point(aes(x=Year,y=BeginSetTime,color=Target),data=BUMCPUE, position = "jitter") +
    scale_color_manual(values=c("T"="blue","B"="red", "M"="purple")) + theme_bw()

##Positives only
ggplot()+
    geom_point(aes(x=Year,y=BeginSetTime,color=Target),data=BUMPos, position = "jitter") +
    scale_color_manual(values=c("T"="blue","B"="red", "M"="purple")) + theme_bw()

## all Data
a<-ggplot()+
    geom_point(aes(y=CPUE,x=SST),data=DeepSet)+
    geom_smooth(aes(y=CPUE,x=SST),data=DeepSet, method="gam") + theme_bw()

b<-ggplot()+
    geom_point(aes(y=CPUE,x=SOI),data=DeepSet)+
    geom_smooth(aes(y=CPUE,x=SOI),data=DeepSet, method="gam") + theme_bw()

c<-ggplot()+
    geom_point(aes(y=CPUE,x=PDO),data=DeepSet)+
    geom_smooth(aes(y=CPUE,x=PDO),data=DeepSet, method="gam") + theme_bw()


png("CPUE Stand//EnvironmentalCovariatesvsCPUE.png", height=8, width=8, units = "in", res=200)
grid.arrange(a,b,c,nrow=2)
dev.off()

f<-ggplot()+
    geom_point(aes(y=CPUE,x=Lat),data=DeepSet)+
    geom_smooth(aes(y=CPUE,x=Lat),data=DeepSet, method="gam") + theme_bw()

g<-ggplot()+
    geom_point(aes(y=CPUE,x=Lon),data=DeepSet)+
    geom_smooth(aes(y=CPUE,x=Lon),data=DeepSet, method="gam") + theme_bw()
png("CPUE Stand//LatandLonvsPositiveCPUE.png", height=4, width=6, units = "in", res=200)
grid.arrange(f,g,nrow=1)
dev.off()

f<-ggplot()+
    geom_point(aes(y=CPUE,x=BeginSetTime),data=DeepSet)+
    theme_bw()

g<-ggplot()+
    geom_boxplot(aes(y=CPUE,group=Begin, x=Begin),data=DeepSet)+
    theme_bw()

i<-ggplot()+
    geom_boxplot(aes(y=CPUE,group=as.factor(Bait), x=as.factor(Bait)),data=DeepSet)+
    xlab("Bait Type")  +
    theme_bw() + theme(axis.text.x=element_text(size=6))

h<-ggplot()+
    geom_boxplot(aes(y=CPUE,group=as.factor(HPF), x=as.factor(HPF)),data=DeepSet)+
    xlab("Hooks Per Float")  +
    theme_bw() + theme(axis.text.x=element_text(size=6))


png("CPUE Stand//PositiveCPUEvsOperationalVars.png",height=6,width=10, units="in", res=200)
grid.arrange(f,g,i,h,nrow=2)
dev.off()


Final.ModelAll<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+Lat+Lon+(1|Vessel),data=BUMPos, REML=FALSE)

lsmean.CPUE<-lsmeans(Final.ModelAll,c("Year"))
fittedvalues<-summary(lsmean.CPUE)
predicted.CPUE<-exp(fittedvalues$lsmean+(var(fittedvalues$lsmean)/2))
variance.CPUE<-exp(2*fittedvalues["SE"])*exp(fittedvalues["SE"]^2)*(exp(fittedvalues["SE"]^2)-1)
final.dataAll<-cbind.data.frame(fittedvalues$Year, predicted.CPUE, variance.CPUE, variance.CPUE^0.5)
names(final.dataAll)<-c("Year","CPUE","Variance", "Stdev")
final.dataAll$UL<-final.dataAll$CPUE+1.96*final.dataAll$Stdev
final.dataAll$LL<-final.dataAll$CPUE-1.96*final.dataAll$Stdev

Final.ModelDeep<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+as.factor(Month)+Lat+(1|Vessel),data=DeepSet, REML=FALSE)

lsmean.CPUE<-lsmeans(Final.ModelDeep,c("Year"))
fittedvalues<-summary(lsmean.CPUE)
predicted.CPUE<-exp(fittedvalues$lsmean+(var(fittedvalues$lsmean)/2))
variance.CPUE<-exp(2*fittedvalues["SE"])*exp(fittedvalues["SE"]^2)*(exp(fittedvalues["SE"]^2)-1)
final.dataDeep<-cbind.data.frame(fittedvalues$Year, predicted.CPUE.Adj,variance.CPUE,variance.CPUE^0.5)
names(final.dataDeep)<-c("Year","CPUE","Variance", "Stdev")
final.dataDeep$UL<-final.dataDeep$CPUE+1.96*final.dataDeep$Stdev
final.dataDeep$LL<-final.dataDeep$CPUE-1.96*final.dataDeep$Stdev
predicted.CPUE.Adj<-predicted.CPUE*exp(-0.5*(fittedvalues$SE^2))

png("DeepVSAllStandCPUE.png", height=4,width=8,units="in", res=200)
ggplot()+
    geom_point(aes(x=Year,y=CPUE),data=final.dataAll, color="black") +
    geom_line(aes(x=Year,y=CPUE),data=final.dataAll, color="black") +
    geom_line(aes(x=Year,y=LL), data=final.dataAll, color="black", linetype="dashed")+
    geom_line(aes(x=Year,y=UL), data=final.dataAll, color="black", linetype="dashed") +
    geom_point(aes(x=Year,y=CPUE),data=final.dataDeep, color="red") +
    geom_line(aes(x=Year,y=CPUE),data=final.dataDeep, color="red") +
    geom_line(aes(x=Year,y=LL), data=final.dataDeep, color="red", linetype="dashed")+
    geom_line(aes(x=Year,y=UL), data=final.dataDeep, color="red", linetype="dashed") +
    theme_bw()
dev.off()

###opted to go with deep since the model explains 32% of deviance vs 21% for all data. Trends are essentially the same. (all is more variable prior to 2000).

##Figures
OldCPUE<-data.frame("Year"=seq(1995,2019,1),"CPUE"=c(0.51,0.57,0.48,0.47,0.14,0.45,0.3,0.14,0.23,0.17,0.12,0.23,0.05,0.12,0.11,0.07,0.01,0.16,0.07,0.11,NA,NA,NA,NA,NA))
plot(Final.ModelDeep)
    Year      CPUE
1  1995 1.2384661
2  1996 1.0534315
3  1997 0.9731764
4  1998 1.0337007
5  1999 0.9192277
6  2000 0.7667140
7  2001 1.2996885
8  2002 0.8237448
9  2003 0.9198498
10 2004 0.7611102
11 2005 0.6994156
12 2006 0.7566846
13 2007 0.6480354
14 2008 0.6373576
15 2009 0.6398302
16 2010 0.6064883
17 2011 0.6518308
18 2012 0.5621471
19 2013 0.5751791
20 2014 0.6203325
21 2015 0.6627060
22 2016 0.5829303
23 2017 0.5987573
24 2018 0.6128836
25 2019 0.6457516

fitted.values<-fitted(Final.ModelDeep)
residuals<-Final.ModelDeep@frame$`log(CPUE)`-(fitted.values*exp(-0.5*(var(fitted.values))))

residuals2<-residuals(Final.ModelDeep,type="response")*exp(-0.5*var(fitted.values))
residuals<-data.frame("residuals"=residuals2,"Year"=Final.ModelDeep@frame$`as.factor(Year)`)
## Need to convert this to ggplot
plot(predicted.CPUE~fittedvalues$Year)
## QQ norm plots
qqnorm(residuals(Final.ModelDeep))
qqline(residuals(Final.ModelDeep))
NominalCPUE<-aggregate(DeepSet2$CPUE,by=list(DeepSet2$Year),mean)
names(NominalCPUE)<-c("Year","CPUE")
png("CPUE Stand/NominalandStandardizedCPUE.png",height=4, width=6, units="in",res=300)
ggplot() +
    geom_point(aes(x=Year,y=MeanCPUE),data=NomCPUE,color="grey70")+  
    geom_point(aes(x=Year,y=CPUE),data=final.dataDeep,color="black") +
    geom_line(aes(x=Year,y=MeanCPUE),data=NomCPUE,color="grey70")+  
    geom_line(aes(x=Year,y=CPUE),data=final.dataDeep,color="black") +
    geom_line(aes(x=Year,y=UL),data=final.dataDeep, color="black",linetype="dashed") +
    geom_line(aes(x=Year,y=LL),data=final.dataDeep, color="black",linetype="dashed") +
    theme_bw() +
    ylim(0,1.4)
dev.off()


#residuals vs Bait
x3<-data.frame(seq(1,length(levels(Final.ModelDeep@frame$`as.factor(Bait)`))+1),0)
names(x3)<-c("quarter","zero")
c<-ggplot(data.frame(x1=Final.ModelDeep@frame$`as.factor(Bait)`,pearson=residuals(Final.ModelDeep,type="pearson")),
          aes(x=x1,y=pearson)) +
    geom_boxplot() +
    geom_line(aes(x=quarter,y=zero),data=x3)+
    theme_bw() +
    xlab("Bait Type")


#residuals vs Year
x3<-data.frame(seq(0,length(levels(as.factor(DeepSet$Year)))+1),c(0))
names(x3)<-c("quarter","zero")
d<-ggplot(data.frame(x1=Final.ModelDeep@frame$`as.factor(Year)`,pearson=residuals(Final.ModelDeep,type="pearson")),
          aes(x=x1,y=pearson)) +
    geom_boxplot() +
    geom_line(aes(x=quarter,y=zero),data=x3)+
    theme_bw() +
    theme(axis.text.x=element_text(size=6))+
    xlab("Year")



#residuals vs Lat
x3<-data.frame(seq(10,30),c(0))
names(x3)<-c("quarter","zero")
f<-ggplot(data.frame(x1=Final.ModelDeep@frame$`Lat`,pearson=residuals(Final.ModelDeep,type="pearson")),
          aes(x=x1,y=pearson)) +
    geom_point() +
    geom_line(aes(x=quarter,y=zero),data=x3)+
    theme_bw() + xlab("Lat")

## Month vs residuals
x3<-data.frame(seq(0,length(levels(as.factor(DeepSet$Month)))+1),c(0))
names(x3)<-c("quarter","zero")
a<-ggplot(data.frame(x1=Final.ModelDeep@frame$`as.factor(Month)`,pearson=residuals(Final.ModelDeep,type="pearson")),
          aes(x=x1,y=pearson)) +
    geom_boxplot() +
    geom_line(aes(x=quarter,y=zero),data=x3)+
    theme_bw() +
    theme(axis.text.x=element_text(size=6))+
    xlab("Month")

png("CPUE Stand/Deep_Residuals.png",height=6,width=12,units="in",res=200)
grid.arrange(d,a,c,f)
dev.off()

## Pearson residuals
png("CPUE Stand/ResidualPlot.png",height=4,width=4, units="in", res=300)
plot(Final.ModelDeep)
dev.off()
png("CPUE Stand/ResidualPlots2.png",height=4,width=8, units="in", res=300)
par(mfrow=c(1,2))
hist(residuals(Final.ModelDeep,type="pearson"))
qqnorm(residuals(Final.ModelDeep))
qqline(residuals(Final.ModelDeep))
dev.off()
## Leverage plot
png("CPUE Stand/LeveragePlot.png",height=4,width=4, units="in", res=300)
ggplot(data.frame(lev=hatvalues(Final.ModelDeep),pearson=residuals(Final.ModelDeep,type="pearson")),
       aes(x=lev,y=pearson)) +
    geom_point() +
    theme_bw()
dev.off()
par(mfrow=c(1,1))


cor(DeepSet2[,c("CPUE","Year","Month","Quarter","Lat","Lon","SST","PDO","BaitType","BeginSetTime","HPF","SOI","Begin")])
cor.test(DeepSet2$CPUE,DeepSet2$Lat)
cor.test(DeepSet2$CPUE,DeepSet2$Lon)
cor.test(DeepSet2$CPUE,DeepSet2$SST)
cor.test(DeepSet2$CPUE,DeepSet2$PDO)
cor.test(DeepSet2$CPUE,DeepSet2$SOI)
cor.test(DeepSet2$CPUE,DeepSet2$BeginSetTime)
