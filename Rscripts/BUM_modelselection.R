### Positive catches BUM GLMM

Model.Base<-lmer(log(CPUE)~(1|Vessel),data=BUMPos, REML=FALSE)

Model.01<-lmer(log(CPUE)~as.factor(Year)+(1|Vessel),data=BUMPos, REML=FALSE)
Model.02<-lmer(log(CPUE)~as.factor(Quarter)+(1|Vessel),data=BUMPos, REML=FALSE)
Model.03<-lmer(log(CPUE)~as.factor(Month)+(1|Vessel),data=BUMPos, REML=FALSE)
Model.04<-lmer(log(CPUE)~as.factor(Bait)+(1|Vessel),data=BUMPos, REML=FALSE)
Model.05<-lmer(log(CPUE)~BeginSetTime+(1|Vessel),data=BUMPos, REML=FALSE)
Model.06<-lmer(log(CPUE)~HPF+(1|Vessel),data=BUMPos, REML=FALSE)
Model.07<-lmer(log(CPUE)~as.factor(SetType)+(1|Vessel),data=BUMPos, REML=FALSE)
Model.08<-lmer(log(CPUE)~Lat+(1|Vessel),data=BUMPos, REML=FALSE)
Model.09<-lmer(log(CPUE)~Lon+(1|Vessel),data=BUMPos, REML=FALSE)
Model.10<-lmer(log(CPUE)~SST+(1|Vessel),data=BUMPos, REML=FALSE)
Model.11<-lmer(log(CPUE)~PDO+(1|Vessel),data=BUMPos, REML=FALSE)
Model.12<-lmer(log(CPUE)~SOI+(1|Vessel),data=BUMPos, REML=FALSE)
Model.13<-lmer(log(CPUE)~as.factor(Begin)+(1|Vessel),data=BUMPos, REML=FALSE)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$AICtab
ModelSum[[2]]<-summary(Model.02)$AICtab
ModelSum[[3]]<-summary(Model.03)$AICtab
ModelSum[[4]]<-summary(Model.04)$AICtab
ModelSum[[5]]<-summary(Model.05)$AICtab
ModelSum[[6]]<-summary(Model.06)$AICtab
ModelSum[[7]]<-summary(Model.07)$AICtab
ModelSum[[8]]<-summary(Model.08)$AICtab
ModelSum[[9]]<-summary(Model.09)$AICtab
ModelSum[[10]]<-summary(Model.10)$AICtab
ModelSum[[11]]<-summary(Model.11)$AICtab
ModelSum[[12]]<-summary(Model.12)$AICtab
ModelSum[[13]]<-summary(Model.13)$AICtab

ModelSum

Model.01<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+(1|Vessel),data=BUMPos, REML=FALSE)
#Model.02<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Quarter)+(1|Vessel),data=BUMPos, REML=FALSE)
Model.03<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Month)+(1|Vessel),data=BUMPos, REML=FALSE)
Model.04<-lmer(log(CPUE)~as.factor(Bait)+SST^2+(1|Vessel),data=BUMPos, REML=FALSE)
#Model.05<-lmer(log(CPUE)~as.factor(Bait)+BeginSetTime+(1|Vessel),data=BUMPos, REML=FALSE)
#Model.06<-lmer(log(CPUE)~as.factor(Bait)+HPF+(1|Vessel),data=BUMPos, REML=FALSE)
Model.07<-lmer(log(CPUE)~as.factor(Bait)+as.factor(SetType)+(1|Vessel),data=BUMPos, REML=FALSE)
Model.08<-lmer(log(CPUE)~as.factor(Bait)+Lat+(1|Vessel),data=BUMPos, REML=FALSE)
Model.09<-lmer(log(CPUE)~as.factor(Bait)+Lon+(1|Vessel),data=BUMPos, REML=FALSE)
Model.10<-lmer(log(CPUE)~as.factor(Bait)+SST+(1|Vessel),data=BUMPos, REML=FALSE)
Model.11<-lmer(log(CPUE)~as.factor(Bait)+PDO+(1|Vessel),data=BUMPos, REML=FALSE)
Model.12<-lmer(log(CPUE)~as.factor(Bait)+SOI+(1|Vessel),data=BUMPos, REML=FALSE)
Model.13<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Begin)+(1|Vessel),data=BUMPos, REML=FALSE)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$AICtab
ModelSum[[2]]<-summary(Model.02)$AICtab
ModelSum[[3]]<-summary(Model.03)$AICtab
ModelSum[[4]]<-summary(Model.04)$AICtab
ModelSum[[5]]<-summary(Model.05)$AICtab
ModelSum[[6]]<-summary(Model.06)$AICtab
ModelSum[[7]]<-summary(Model.07)$AICtab
ModelSum[[8]]<-summary(Model.08)$AICtab
ModelSum[[9]]<-summary(Model.09)$AICtab
ModelSum[[10]]<-summary(Model.10)$AICtab
ModelSum[[11]]<-summary(Model.11)$AICtab
ModelSum[[12]]<-summary(Model.12)$AICtab
ModelSum[[13]]<-summary(Model.13)$AICtab

ModelSum

Model.01<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Quarter)+(1|Vessel),data=BUMPos, REML=FALSE)
Model.02<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Month)+(1|Vessel),data=BUMPos, REML=FALSE)
Model.03<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+SST^2+(1|Vessel),data=BUMPos, REML=FALSE)
Model.04<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(SetType)+(1|Vessel),data=BUMPos, REML=FALSE)
Model.05<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+Lat+(1|Vessel),data=BUMPos, REML=FALSE)
Model.06<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+Lon+(1|Vessel),data=BUMPos, REML=FALSE)
Model.07<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+SST+(1|Vessel),data=BUMPos, REML=FALSE)
Model.08<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+PDO+(1|Vessel),data=BUMPos, REML=FALSE)
Model.09<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+SOI+(1|Vessel),data=BUMPos, REML=FALSE)
Model.10<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+(1|Vessel),data=BUMPos, REML=FALSE)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$AICtab
ModelSum[[2]]<-summary(Model.02)$AICtab
ModelSum[[3]]<-summary(Model.03)$AICtab
ModelSum[[4]]<-summary(Model.04)$AICtab
ModelSum[[5]]<-summary(Model.05)$AICtab
ModelSum[[6]]<-summary(Model.06)$AICtab
ModelSum[[7]]<-summary(Model.07)$AICtab
ModelSum[[8]]<-summary(Model.08)$AICtab
ModelSum[[9]]<-summary(Model.09)$AICtab
ModelSum[[10]]<-summary(Model.10)$AICtab

ModelSum


Model.01<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+(1|Vessel),data=BUMPos, REML=FALSE)
Model.02<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+SST^2+(1|Vessel),data=BUMPos, REML=FALSE)
Model.03<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(SetType)+(1|Vessel),data=BUMPos, REML=FALSE)
Model.04<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+Lat+(1|Vessel),data=BUMPos, REML=FALSE)
Model.05<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+Lon+(1|Vessel),data=BUMPos, REML=FALSE)
Model.06<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+SST+(1|Vessel),data=BUMPos, REML=FALSE)
Model.07<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+PDO+(1|Vessel),data=BUMPos, REML=FALSE)
Model.08<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+SOI+(1|Vessel),data=BUMPos, REML=FALSE)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$AICtab
ModelSum[[2]]<-summary(Model.02)$AICtab
ModelSum[[3]]<-summary(Model.03)$AICtab
ModelSum[[4]]<-summary(Model.04)$AICtab
ModelSum[[5]]<-summary(Model.05)$AICtab
ModelSum[[6]]<-summary(Model.06)$AICtab
ModelSum[[7]]<-summary(Model.07)$AICtab
ModelSum[[8]]<-summary(Model.08)$AICtab

ModelSum

Model.01<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+SST^2+(1|Vessel),data=BUMPos, REML=FALSE)
Model.02<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+(1|Vessel),data=BUMPos, REML=FALSE)
Model.03<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+Lat+(1|Vessel),data=BUMPos, REML=FALSE)
Model.04<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+Lon+(1|Vessel),data=BUMPos, REML=FALSE)
Model.05<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+SST+(1|Vessel),data=BUMPos, REML=FALSE)
Model.06<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+PDO+(1|Vessel),data=BUMPos, REML=FALSE)
Model.07<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+SOI+(1|Vessel),data=BUMPos, REML=FALSE)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$AICtab
ModelSum[[2]]<-summary(Model.02)$AICtab
ModelSum[[3]]<-summary(Model.03)$AICtab
ModelSum[[4]]<-summary(Model.04)$AICtab
ModelSum[[5]]<-summary(Model.05)$AICtab
ModelSum[[6]]<-summary(Model.06)$AICtab
ModelSum[[7]]<-summary(Model.07)$AICtab

ModelSum

Model.01<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+SST^2+(1|Vessel),data=BUMPos, REML=FALSE)
Model.02<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+Lat+(1|Vessel),data=BUMPos, REML=FALSE)
Model.03<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+Lon+(1|Vessel),data=BUMPos, REML=FALSE)
Model.04<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+SST+(1|Vessel),data=BUMPos, REML=FALSE)
Model.05<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+PDO+(1|Vessel),data=BUMPos, REML=FALSE)
Model.06<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+SOI+(1|Vessel),data=BUMPos, REML=FALSE)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$AICtab
ModelSum[[2]]<-summary(Model.02)$AICtab
ModelSum[[3]]<-summary(Model.03)$AICtab
ModelSum[[4]]<-summary(Model.04)$AICtab
ModelSum[[5]]<-summary(Model.05)$AICtab
ModelSum[[6]]<-summary(Model.06)$AICtab

ModelSum

Model.01<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+Lat+SST^2+(1|Vessel),data=BUMPos, REML=FALSE)
Model.02<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+Lat+Lon+(1|Vessel),data=BUMPos, REML=FALSE)
Model.03<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+Lat+SST+(1|Vessel),data=BUMPos, REML=FALSE)
Model.04<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+Lat+PDO+(1|Vessel),data=BUMPos, REML=FALSE)
Model.05<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+Lat+SOI+(1|Vessel),data=BUMPos, REML=FALSE)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$AICtab
ModelSum[[2]]<-summary(Model.02)$AICtab
ModelSum[[3]]<-summary(Model.03)$AICtab
ModelSum[[4]]<-summary(Model.04)$AICtab
ModelSum[[5]]<-summary(Model.05)$AICtab

ModelSum

Model.01<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+Lat+SST^2+(1|Vessel),data=BUMPos, REML=FALSE)
Model.02<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+Lat+Lon+(1|Vessel),data=BUMPos, REML=FALSE)
Model.03<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+Lat+SST+(1|Vessel),data=BUMPos, REML=FALSE)
Model.04<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+Lat+PDO+(1|Vessel),data=BUMPos, REML=FALSE)
Model.05<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+Lat+SOI+(1|Vessel),data=BUMPos, REML=FALSE)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$AICtab
ModelSum[[2]]<-summary(Model.02)$AICtab
ModelSum[[3]]<-summary(Model.03)$AICtab
ModelSum[[4]]<-summary(Model.04)$AICtab
ModelSum[[5]]<-summary(Model.05)$AICtab

ModelSum
Final.Model<-lmer(log(CPUE)~as.factor(Bait)+as.factor(Year)+as.factor(Begin)+as.factor(Month)+as.factor(SetType)+Lat+Lon+(1|Vessel),data=BUMPos, REML=FALSE)


################ DEEP SET #####################
DeepSet<-subset(BUMPos,SetType=="D")

Model.Base<-lmer(log(CPUE)~(1|Vessel),data=BUMPos, REML=FALSE)

Model.01<-lmer(log(CPUE)~as.factor(Year)+(1|Vessel),data=DeepSet, REML=FALSE)
Model.02<-lmer(log(CPUE)~as.factor(Quarter)+(1|Vessel),data=DeepSet, REML=FALSE)
Model.03<-lmer(log(CPUE)~as.factor(Month)+(1|Vessel),data=DeepSet, REML=FALSE)
Model.04<-lmer(log(CPUE)~as.factor(Bait)+(1|Vessel),data=DeepSet, REML=FALSE)
Model.05<-lmer(log(CPUE)~BeginSetTime+(1|Vessel),data=DeepSet, REML=FALSE)
Model.06<-lmer(log(CPUE)~HPF+(1|Vessel),data=DeepSet, REML=FALSE)
Model.07<-lmer(log(CPUE)~as.factor(SetType)+(1|Vessel),data=DeepSet, REML=FALSE)
Model.08<-lmer(log(CPUE)~Lat+(1|Vessel),data=DeepSet, REML=FALSE)
Model.09<-lmer(log(CPUE)~Lon+(1|Vessel),data=DeepSet, REML=FALSE)
Model.10<-lmer(log(CPUE)~SST+(1|Vessel),data=DeepSet, REML=FALSE)
Model.11<-lmer(log(CPUE)~PDO+(1|Vessel),data=DeepSet, REML=FALSE)
Model.12<-lmer(log(CPUE)~SOI+(1|Vessel),data=DeepSet, REML=FALSE)
Model.13<-lmer(log(CPUE)~as.factor(Begin)+(1|Vessel),data=DeepSet, REML=FALSE)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$AICtab
ModelSum[[2]]<-summary(Model.02)$AICtab
ModelSum[[3]]<-summary(Model.03)$AICtab
ModelSum[[4]]<-summary(Model.04)$AICtab
ModelSum[[5]]<-summary(Model.05)$AICtab
ModelSum[[6]]<-summary(Model.06)$AICtab
ModelSum[[7]]<-summary(Model.07)$AICtab
ModelSum[[8]]<-summary(Model.08)$AICtab
ModelSum[[9]]<-summary(Model.09)$AICtab
ModelSum[[10]]<-summary(Model.10)$AICtab
ModelSum[[11]]<-summary(Model.11)$AICtab
ModelSum[[12]]<-summary(Model.12)$AICtab
ModelSum[[13]]<-summary(Model.13)$AICtab

ModelSum

Model.01<-lmer(log(CPUE)~as.factor(Year)+as.factor(Month)+(1|Vessel),data=DeepSet, REML=FALSE)
Model.02<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+(1|Vessel),data=DeepSet, REML=FALSE)
Model.03<-lmer(log(CPUE)~as.factor(Year)+HPF+(1|Vessel),data=DeepSet, REML=FALSE)
Model.04<-lmer(log(CPUE)~as.factor(Year)+Lat+(1|Vessel),data=DeepSet, REML=FALSE)
Model.05<-lmer(log(CPUE)~as.factor(Year)+Lon+(1|Vessel),data=DeepSet, REML=FALSE)
Model.06<-lmer(log(CPUE)~as.factor(Year)+SST+(1|Vessel),data=DeepSet, REML=FALSE)
Model.07<-lmer(log(CPUE)~as.factor(Year)+PDO+(1|Vessel),data=DeepSet, REML=FALSE)
Model.08<-lmer(log(CPUE)~as.factor(Year)+SOI+(1|Vessel),data=DeepSet, REML=FALSE)
Model.09<-lmer(log(CPUE)~as.factor(Year)+as.factor(Begin)+(1|Vessel),data=DeepSet, REML=FALSE)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$AICtab
ModelSum[[2]]<-summary(Model.02)$AICtab
ModelSum[[3]]<-summary(Model.03)$AICtab
ModelSum[[4]]<-summary(Model.04)$AICtab
ModelSum[[5]]<-summary(Model.05)$AICtab
ModelSum[[6]]<-summary(Model.06)$AICtab
ModelSum[[7]]<-summary(Model.07)$AICtab
ModelSum[[8]]<-summary(Model.08)$AICtab
ModelSum[[9]]<-summary(Model.09)$AICtab
ModelSum


Model.01<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+as.factor(Month)+(1|Vessel),data=DeepSet, REML=FALSE)
Model.02<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+HPF+(1|Vessel),data=DeepSet, REML=FALSE)
Model.03<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+Lat+(1|Vessel),data=DeepSet, REML=FALSE)
Model.04<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+Lon+(1|Vessel),data=DeepSet, REML=FALSE)
Model.05<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+SST+(1|Vessel),data=DeepSet, REML=FALSE)
Model.06<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+PDO+(1|Vessel),data=DeepSet, REML=FALSE)
Model.07<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+SOI+(1|Vessel),data=DeepSet, REML=FALSE)
Model.08<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+as.factor(Begin)+(1|Vessel),data=DeepSet, REML=FALSE)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$AICtab
ModelSum[[2]]<-summary(Model.02)$AICtab
ModelSum[[3]]<-summary(Model.03)$AICtab
ModelSum[[4]]<-summary(Model.04)$AICtab
ModelSum[[5]]<-summary(Model.05)$AICtab
ModelSum[[6]]<-summary(Model.06)$AICtab
ModelSum[[7]]<-summary(Model.07)$AICtab
ModelSum[[8]]<-summary(Model.08)$AICtab

ModelSum

Model.01<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+as.factor(Month)+HPF+(1|Vessel),data=DeepSet, REML=FALSE)
Model.02<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+as.factor(Month)+Lat+(1|Vessel),data=DeepSet, REML=FALSE)
Model.03<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+as.factor(Month)+Lon+(1|Vessel),data=DeepSet, REML=FALSE)
Model.04<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+as.factor(Month)+SST+(1|Vessel),data=DeepSet, REML=FALSE)
Model.05<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+as.factor(Month)+PDO+(1|Vessel),data=DeepSet, REML=FALSE)
Model.06<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+as.factor(Month)+SOI+(1|Vessel),data=DeepSet, REML=FALSE)
Model.07<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+as.factor(Month)+as.factor(Begin)+(1|Vessel),data=DeepSet, REML=FALSE)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$AICtab
ModelSum[[2]]<-summary(Model.02)$AICtab
ModelSum[[3]]<-summary(Model.03)$AICtab
ModelSum[[4]]<-summary(Model.04)$AICtab
ModelSum[[5]]<-summary(Model.05)$AICtab
ModelSum[[6]]<-summary(Model.06)$AICtab
ModelSum[[7]]<-summary(Model.07)$AICtab

ModelSum

Model.01<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+as.factor(Month)+Lat+HPF+(1|Vessel),data=DeepSet, REML=FALSE)
Model.02<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+as.factor(Month)+Lat+Lon+(1|Vessel),data=DeepSet, REML=FALSE)
Model.03<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+as.factor(Month)+Lat+SST+(1|Vessel),data=DeepSet, REML=FALSE)
Model.04<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+as.factor(Month)+Lat+PDO+(1|Vessel),data=DeepSet, REML=FALSE)
Model.05<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+as.factor(Month)+Lat+SOI+(1|Vessel),data=DeepSet, REML=FALSE)
Model.06<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+as.factor(Month)+Lat+as.factor(Begin)+(1|Vessel),data=DeepSet, REML=FALSE)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$AICtab
ModelSum[[2]]<-summary(Model.02)$AICtab
ModelSum[[3]]<-summary(Model.03)$AICtab
ModelSum[[4]]<-summary(Model.04)$AICtab
ModelSum[[5]]<-summary(Model.05)$AICtab
ModelSum[[6]]<-summary(Model.06)$AICtab
ModelSum

Final.model<-lmer(log(CPUE)~as.factor(Year)+as.factor(Bait)+as.factor(Month)+Lat+(1|Vessel),data=DeepSet, REML=FALSE)

################## Jon's Dataset ##############
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
setwd("C:/Users/michelle.sculley/Documents/2021 BUM ASSESS")
df<-read.csv("BUM.csv")

BUMCPUE2<-data.frame("Year"=df[,"year"],"Month"=df[,"month"],"Bait"=df[,"bait"], "BeginSetTime"=df[,"begin"],"HPF"=df[,"hpf"],"Lat"=df[,"lat"],"Set"=df[,"sector"],"catch"=df[,"blue_marlin"],"Vessel"=df[,"vessel"],"Lon"=df[,"lon"], "SST"=df[,"sst"],"Target"=df[,"target"], "Quarter"=df[,"quarter"], "effort"=df[,"hooks"])
BUMCPUE2$CPUE<-(BUMCPUE2$catch/BUMCPUE2$effort)*1000

BUMCPUE2$Lat1<-ceiling(BUMCPUE2$Lat)
BUMCPUE2$Lon1<-ceiling(BUMCPUE2$Lon)
BUMCPUE2$Lat5<-(ceiling(BUMCPUE2$Lat/5)*5)-2.5
BUMCPUE2$Lon5<-(ceiling(BUMCPUE2$Lon/5)*5)-2.5


BUMCPUE2$Begin<-ifelse(BUMCPUE2$BeginSetTime>=0&BUMCPUE2$BeginSetTime<=600,1,
                      ifelse(BUMCPUE2$BeginSetTime>600&BUMCPUE2$BeginSetTime<=1200,2,
                             ifelse(BUMCPUE2$BeginSetTime>1200&BUMCPUE2$BeginSetTime<=1800,3,4)))

BUMCPUE2$SetType<-ifelse(BUMCPUE2$Year<2004&BUMCPUE2$HPF<=10,"S",
                        ifelse(BUMCPUE2$Year>=2004&BUMCPUE2$HPF<=14,"S","D"))



BUMCPUE2$PropPos<-ifelse(BUMCPUE2$CPUE>0,1,0)


BUMPos2<-subset(BUMCPUE2,PropPos==1)

Model.Base<-lmer(log(CPUE)~(1|Vessel),data=BUMPos, REML=FALSE)

Model.01<-lmer(log(CPUE)~as.factor(Year)+(1|Vessel),data=DeepSet, REML=FALSE)
Model.02<-lmer(log(CPUE)~as.factor(Quarter)+(1|Vessel),data=DeepSet, REML=FALSE)
Model.03<-lmer(log(CPUE)~as.factor(Month)+(1|Vessel),data=DeepSet, REML=FALSE)
Model.04<-lmer(log(CPUE)~as.factor(Bait)+(1|Vessel),data=DeepSet, REML=FALSE)
Model.05<-lmer(log(CPUE)~BeginSetTime+(1|Vessel),data=DeepSet, REML=FALSE)
Model.06<-lmer(log(CPUE)~as.factor(HPF)+(1|Vessel),data=DeepSet, REML=FALSE)
Model.07<-lmer(log(CPUE)~as.factor(SetType)+(1|Vessel),data=DeepSet, REML=FALSE)
Model.08<-lmer(log(CPUE)~Lat+(1|Vessel),data=DeepSet, REML=FALSE)
Model.09<-lmer(log(CPUE)~Lon+(1|Vessel),data=DeepSet, REML=FALSE)
Model.10<-lmer(log(CPUE)~SST+(1|Vessel),data=DeepSet, REML=FALSE)
Model.11<-lmer(log(CPUE)~PDO+(1|Vessel),data=DeepSet, REML=FALSE)
Model.12<-lmer(log(CPUE)~SOI+(1|Vessel),data=DeepSet, REML=FALSE)
Model.13<-lmer(log(CPUE)~as.factor(Begin)+(1|Vessel),data=DeepSet, REML=FALSE)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$AICtab
ModelSum[[2]]<-summary(Model.02)$AICtab
ModelSum[[3]]<-summary(Model.03)$AICtab
ModelSum[[4]]<-summary(Model.04)$AICtab
ModelSum[[5]]<-summary(Model.05)$AICtab
ModelSum[[6]]<-summary(Model.06)$AICtab
ModelSum[[7]]<-summary(Model.07)$AICtab
ModelSum[[8]]<-summary(Model.08)$AICtab
ModelSum[[9]]<-summary(Model.09)$AICtab
ModelSum[[10]]<-summary(Model.10)$AICtab
ModelSum[[11]]<-summary(Model.11)$AICtab
ModelSum[[12]]<-summary(Model.12)$AICtab
ModelSum[[13]]<-summary(Model.13)$AICtab

ModelSum


############# Deep set negative bionomial models ##############
DeepSet2<-subset(BUMCPUE,SetType=="D")

Model.01<-glm(Catch~as.factor(Year)-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.02<-glm(Catch~as.factor(Quarter)-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.03<-glm(Catch~as.factor(Month)-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.04<-glm(Catch~as.factor(Bait)-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.05<-glm(Catch~BeginSetTime-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.06<-glm(Catch~HPF-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.07<-glm(Catch~Lat-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.08<-glm(Catch~Lon-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.09<-glm(Catch~SST-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.10<-glm(Catch~PDO-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.11<-glm(Catch~SOI-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.12<-glm(Catch~as.factor(Begin)-offset(log(Hooks)),data=DeepSet2, family=poisson)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$deviance
ModelSum[[2]]<-summary(Model.02)$deviance
ModelSum[[3]]<-summary(Model.03)$deviance
ModelSum[[4]]<-summary(Model.04)$deviance
ModelSum[[5]]<-summary(Model.05)$deviance
ModelSum[[6]]<-summary(Model.06)$deviance
ModelSum[[7]]<-summary(Model.07)$deviance
ModelSum[[8]]<-summary(Model.08)$deviance
ModelSum[[9]]<-summary(Model.09)$deviance
ModelSum[[10]]<-summary(Model.10)$deviance
ModelSum[[11]]<-summary(Model.11)$deviance
ModelSum[[12]]<-summary(Model.12)$deviance

ModelSum

Model.01<-glm(Catch~as.factor(Year)+as.factor(Quarter)-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.02<-glm(Catch~as.factor(Year)+as.factor(Month)-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.03<-glm(Catch~as.factor(Year)+as.factor(Bait)-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.04<-glm(Catch~as.factor(Year)+BeginSetTime-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.05<-glm(Catch~as.factor(Year)+HPF-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.06<-glm(Catch~as.factor(Year)+Lat-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.07<-glm(Catch~as.factor(Year)+Lon-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.08<-glm(Catch~as.factor(Year)+SST-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.09<-glm(Catch~as.factor(Year)+PDO-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.10<-glm(Catch~as.factor(Year)+SOI-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.11<-glm(Catch~as.factor(Year)+as.factor(Begin)-offset(log(Hooks)),data=DeepSet2, family=poisson)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$deviance
ModelSum[[2]]<-summary(Model.02)$deviance
ModelSum[[3]]<-summary(Model.03)$deviance
ModelSum[[4]]<-summary(Model.04)$deviance
ModelSum[[5]]<-summary(Model.05)$deviance
ModelSum[[6]]<-summary(Model.06)$deviance
ModelSum[[7]]<-summary(Model.07)$deviance
ModelSum[[8]]<-summary(Model.08)$deviance
ModelSum[[9]]<-summary(Model.09)$deviance
ModelSum[[10]]<-summary(Model.10)$deviance
ModelSum[[11]]<-summary(Model.11)$deviance

ModelSum


Model.01<-glm(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.02<-glm(Catch~as.factor(Year)+as.factor(Bait)+HPF-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.03<-glm(Catch~as.factor(Year)+as.factor(Bait)+Lat-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.04<-glm(Catch~as.factor(Year)+as.factor(Bait)+Lon-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.05<-glm(Catch~as.factor(Year)+as.factor(Bait)+SST-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.06<-glm(Catch~as.factor(Year)+as.factor(Bait)+PDO-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.07<-glm(Catch~as.factor(Year)+as.factor(Bait)+SOI-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.08<-glm(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Begin)-offset(log(Hooks)),data=DeepSet2, family=poisson)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$deviance
ModelSum[[2]]<-summary(Model.02)$deviance
ModelSum[[3]]<-summary(Model.03)$deviance
ModelSum[[4]]<-summary(Model.04)$deviance
ModelSum[[5]]<-summary(Model.05)$deviance
ModelSum[[6]]<-summary(Model.06)$deviance
ModelSum[[7]]<-summary(Model.07)$deviance
ModelSum[[8]]<-summary(Model.08)$deviance


ModelSum

Model.01<-glm(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+HPF-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.02<-glm(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+Lat-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.03<-glm(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+Lon-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.04<-glm(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+SST-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.05<-glm(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+PDO-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.06<-glm(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+SOI-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.07<-glm(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+as.factor(Begin)-offset(log(Hooks)),data=DeepSet2, family=poisson)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$deviance
ModelSum[[2]]<-summary(Model.02)$deviance
ModelSum[[3]]<-summary(Model.03)$deviance
ModelSum[[4]]<-summary(Model.04)$deviance
ModelSum[[5]]<-summary(Model.05)$deviance
ModelSum[[6]]<-summary(Model.06)$deviance
ModelSum[[7]]<-summary(Model.07)$deviance


ModelSum

Model.01<-glm(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+HPF+Lat-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.02<-glm(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+HPF+Lon-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.03<-glm(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+HPF+SST-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.04<-glm(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+HPF+PDO-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.05<-glm(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+HPF+SOI-offset(log(Hooks)),data=DeepSet2, family=poisson)
Model.06<-glm(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+HPF+as.factor(Begin)-offset(log(Hooks)),data=DeepSet2, family=poisson)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$deviance
ModelSum[[2]]<-summary(Model.02)$deviance
ModelSum[[3]]<-summary(Model.03)$deviance
ModelSum[[4]]<-summary(Model.04)$deviance
ModelSum[[5]]<-summary(Model.05)$deviance
ModelSum[[6]]<-summary(Model.06)$deviance

ModelSum

Final.ModelP<-glm(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+HPF+Lat-offset(log(Hooks)),data=DeepSet2, family=poisson)

## neg binomial

Model.01<-glm.nb(Catch~as.factor(Year)-offset(log(Hooks)),data=DeepSet2)
Model.02<-glm.nb(Catch~as.factor(Quarter)-offset(log(Hooks)),data=DeepSet2)
Model.03<-glm.nb(Catch~as.factor(Month)-offset(log(Hooks)),data=DeepSet2)
Model.04<-glm.nb(Catch~as.factor(Bait)-offset(log(Hooks)),data=DeepSet2)
Model.05<-glm.nb(Catch~BeginSetTime-offset(log(Hooks)),data=DeepSet2)
Model.06<-glm.nb(Catch~HPF-offset(log(Hooks)),data=DeepSet2)
Model.07<-glm.nb(Catch~Lat-offset(log(Hooks)),data=DeepSet2)
Model.08<-glm.nb(Catch~Lon-offset(log(Hooks)),data=DeepSet2)
Model.09<-glm.nb(Catch~SST-offset(log(Hooks)),data=DeepSet2)
Model.10<-glm.nb(Catch~PDO-offset(log(Hooks)),data=DeepSet2)
Model.11<-glm.nb(Catch~SOI-offset(log(Hooks)),data=DeepSet2)
Model.12<-glm.nb(Catch~as.factor(Begin)-offset(log(Hooks)),data=DeepSet2)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$deviance
ModelSum[[2]]<-summary(Model.02)$deviance
ModelSum[[3]]<-summary(Model.03)$deviance
ModelSum[[4]]<-summary(Model.04)$deviance
ModelSum[[5]]<-summary(Model.05)$deviance
ModelSum[[6]]<-summary(Model.06)$deviance
ModelSum[[7]]<-summary(Model.07)$deviance
ModelSum[[8]]<-summary(Model.08)$deviance
ModelSum[[9]]<-summary(Model.09)$deviance
ModelSum[[10]]<-summary(Model.10)$deviance
ModelSum[[11]]<-summary(Model.11)$deviance
ModelSum[[12]]<-summary(Model.12)$deviance

ModelSum

Model.01<-glm.nb(Catch~as.factor(Year)+as.factor(Month)-offset(log(Hooks)),data=DeepSet2)
Model.02<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)-offset(log(Hooks)),data=DeepSet2)
Model.03<-glm.nb(Catch~as.factor(Year)+HPF-offset(log(Hooks)),data=DeepSet2)
Model.04<-glm.nb(Catch~as.factor(Year)+Lat-offset(log(Hooks)),data=DeepSet2)
Model.05<-glm.nb(Catch~as.factor(Year)+Lon-offset(log(Hooks)),data=DeepSet2)
Model.06<-glm.nb(Catch~as.factor(Year)+SST-offset(log(Hooks)),data=DeepSet2)
Model.07<-glm.nb(Catch~as.factor(Year)+PDO-offset(log(Hooks)),data=DeepSet2)
Model.08<-glm.nb(Catch~as.factor(Year)+SOI-offset(log(Hooks)),data=DeepSet2)
Model.09<-glm.nb(Catch~as.factor(Year)+as.factor(Begin)-offset(log(Hooks)),data=DeepSet2)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$deviance
ModelSum[[2]]<-summary(Model.02)$deviance
ModelSum[[3]]<-summary(Model.03)$deviance
ModelSum[[4]]<-summary(Model.04)$deviance
ModelSum[[5]]<-summary(Model.05)$deviance
ModelSum[[6]]<-summary(Model.06)$deviance
ModelSum[[7]]<-summary(Model.07)$deviance
ModelSum[[8]]<-summary(Model.08)$deviance
ModelSum[[9]]<-summary(Model.09)$deviance

ModelSum

Model.01<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)-offset(log(Hooks)),data=DeepSet2)
Model.02<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+HPF-offset(log(Hooks)),data=DeepSet2)
Model.03<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+Lat-offset(log(Hooks)),data=DeepSet2)
Model.04<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+Lon-offset(log(Hooks)),data=DeepSet2)
Model.05<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+SST-offset(log(Hooks)),data=DeepSet2)
Model.06<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+PDO-offset(log(Hooks)),data=DeepSet2)
Model.07<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+SOI-offset(log(Hooks)),data=DeepSet2)
Model.08<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Begin)-offset(log(Hooks)),data=DeepSet2)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$deviance
ModelSum[[2]]<-summary(Model.02)$deviance
ModelSum[[3]]<-summary(Model.03)$deviance
ModelSum[[4]]<-summary(Model.04)$deviance
ModelSum[[5]]<-summary(Model.05)$deviance
ModelSum[[6]]<-summary(Model.06)$deviance
ModelSum[[7]]<-summary(Model.07)$deviance
ModelSum[[8]]<-summary(Model.08)$deviance

ModelSum

Model.01<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+HPF-offset(log(Hooks)),data=DeepSet2)
Model.02<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+Lat-offset(log(Hooks)),data=DeepSet2)
Model.03<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+Lon-offset(log(Hooks)),data=DeepSet2)
Model.04<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+SST-offset(log(Hooks)),data=DeepSet2)
Model.05<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+PDO-offset(log(Hooks)),data=DeepSet2)
Model.06<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+SOI-offset(log(Hooks)),data=DeepSet2)
Model.07<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+as.factor(Begin)-offset(log(Hooks)),data=DeepSet2)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$deviance
ModelSum[[2]]<-summary(Model.02)$deviance
ModelSum[[3]]<-summary(Model.03)$deviance
ModelSum[[4]]<-summary(Model.04)$deviance
ModelSum[[5]]<-summary(Model.05)$deviance
ModelSum[[6]]<-summary(Model.06)$deviance
ModelSum[[7]]<-summary(Model.07)$deviance

ModelSum

Model.01<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+HPF+Lat-offset(log(Hooks)),data=DeepSet2)
Model.02<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+HPF+Lon-offset(log(Hooks)),data=DeepSet2)
Model.03<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+HPF+SST-offset(log(Hooks)),data=DeepSet2)
Model.04<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+HPF+PDO-offset(log(Hooks)),data=DeepSet2)
Model.05<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+HPF+SOI-offset(log(Hooks)),data=DeepSet2)
Model.06<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+HPF+as.factor(Begin)-offset(log(Hooks)),data=DeepSet2)

ModelSum<-list(NA)
ModelSum[[1]]<-summary(Model.01)$deviance
ModelSum[[2]]<-summary(Model.02)$deviance
ModelSum[[3]]<-summary(Model.03)$deviance
ModelSum[[4]]<-summary(Model.04)$deviance
ModelSum[[5]]<-summary(Model.05)$deviance
ModelSum[[6]]<-summary(Model.06)$deviance

ModelSum

Final.ModelNB<-glm.nb(Catch~as.factor(Year)+as.factor(Bait)+as.factor(Month)+HPF+Lat-offset(log(Hooks)),data=DeepSet2)
