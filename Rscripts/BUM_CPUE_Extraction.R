setwd("C:\\Users\\michelle.sculley\\Documents\\2023 SWO ASSESS")

logbook<-read.csv("HI_LL_1994-2019_DETAIL.csv", header=TRUE)
logbook2<-read.csv("HI_LL_1994-2019_HDR.csv", header=TRUE)

logbook.final<-merge(logbook,logbook2, by.x=c("HDR_LANDYR","HDR_TRIPNUM","HDR_SERIALNUM2"),by.y=c("LANDYR","TRIPNUM","SERIALNUM2"))

length(unique(logbook.final$HDR_SERIALNUM2))

## If the haul year was 1998 or later, the logbook page number (aka the logbook page serial number) is the identifier. Otherwise generate & add concactenated variable using paste0()

logbook.final$HDR_SERIALNUM2 = as.numeric(logbook.final$HDR_SERIALNUM2)
logbook.final$UNIQUE_SET_ID = ifelse(logbook.final[,'HAUL_YEAR'] > 1997, logbook.final$HDR_SERIALNUM2, paste0(as.character(as.numeric(logbook.final[,'HAUL_YEAR'])), as.character(as.numeric(logbook.final[,'HDR_TRIPNUM'])),as.character(as.numeric(logbook.final[,'HDR_SERIALNUM2']))))

length(unique(logbook.final$UNIQUE_SET_ID))


logbook0 = logbook.final

## take out operational-only columns (no catch info) and remove duplicates so you have a single row of set-level information for each UNIQUE_SET_ID
operational <- subset(logbook0, !duplicated(logbook0[,'UNIQUE_SET_ID'])) 
df<-logbook0

df$HOOKS_PER_FLOAT =  ifelse(is.na(df$MAXIMUM_HOOKS_PER_FLOAT) & is.na(df$MINIMUM_HOOKS_PER_FLOAT), NA, df$MAXIMUM_HOOKS_PER_FLOAT)
summary(df$HOOKS_PER_FLOAT)        

df$LATITUDE = df$BEGIN_SET_LATITUDE.x
df$LONGITUDE = df$BEGIN_SET_LONGITUDE.x
df<-df[-which(df$LATITUDE==0&df$LONGITUDE==0),]

df$BUM_CPUE = (df$NUMBER_OF_FISH_KEPT/df$NUMBER_OF_HOOKS_SET.x)*1000  ##CPUE is in fish per 1000 hooks
head(subset(df, BUM_CPUE > 0))$BUM_CPUE
nrow(subset(df, BUM_CPUE != 0))
hist(df$BUM_CPUE, xlim = c(0,150))


df1<-df
df<-df1
df$BUM_CPUE<-ifelse(is.na(df$BUM_CPUE),0,df$BUM_CPUE)
df<-subset(df,!is.na(SET_YEAR))
df<-subset(df,!is.na(LONGITUDE))

df<-subset(df,NUMBER_OF_HOOKS_SET.x>=200)

df$BEGIN_SET_TIME<-ifelse(df$BEGIN_SET_TIME<1200,paste(0,df$BEGIN_SET_TIME,sep=""),df$BEGIN_SET_TIME)
 df$SET_MONTH<-ifelse(df$SET_MONTH<10,paste(0,df$SET_MONTH,sep=""),df$SET_MONTH)
 df$SET_DAY<-ifelse(df$SET_DAY<10,paste(0,df$SET_DAY,sep=""),df$SET_DAY)
  df$BEGIN_HAUL_TIME<-ifelse(df$BEGIN_HAUL_TIME<1200,paste(0,df$BEGIN_HAUL_TIME,sep=""),df$BEGIN_HAUL_TIME)
 df$HAUL_MONTH<-ifelse(df$HAUL_MONTH<10,paste(0,df$HAUL_MONTH,sep=""),df$HAUL_MONTH)
 df$HAUL_DAY<-ifelse(df$HAUL_DAY<10,paste(0,df$HAUL_DAY,sep=""),df$HAUL_DAY)
 df$BEGIN_TIME<-paste(df$SET_MONTH,"/",df$SET_DAY,"/",df$SET_YEAR," ",df$BEGIN_SET_TIME,sep="")


df$END_TIME<-paste(df$HAUL_MONTH,"/",df$HAUL_DAY,"/",df$HAUL_YEAR," ",df$BEGIN_HAUL_TIME,sep="")
df<-subset(df,!is.na(BEGIN_TIME))
df<-subset(df,!is.na(END_TIME))
df$BEGIN_TIME<-strptime(df$BEGIN_TIME,"%m/%d/%Y %H%M")
df$END_TIME<-strptime(df$END_TIME,"%m/%d/%Y %H%M")
df$SOAK_TIME<-difftime(df$END_TIME,df$BEGIN_TIME)/3600 ##converts to hours
df<-subset(df,!is.na(SOAK_TIME))  
df<-subset(df,SOAK_TIME>0&SOAK_TIME<48)

df<-df[,c("AREA","BAIT_CODE","BEGIN_HAUL_TIME","BEGIN_SET_LATITUDE.x","BEGIN_SET_LONGITUDE.x","BEGIN_SET_TIME","BEGIN_TIME","BUM_CPUE","COMMERCIAL_MARINE_LICENSE_NUM","DATASET_CODE","END_HAUL_TIME","END_SET_TIME","END_TIME","ENGLISH_NAME","FAO_CODE","FLEET.x","HAUL_DAY","HAUL_DT","HAUL_MONTH","HAUL_YEAR","HDR_LANDYR","HDR_SERIALNUM2","HDR_TRIPNUM","HOOKS_PER_FLOAT","LATITUDE","LONGITUDE","MAINLINE_LENGTH","MAXIMUM_HOOKS_PER_FLOAT","MINIMUM_HOOKS_PER_FLOAT","NIGHT_SETTING","NUMBER_OF_FISH_KEPT","NUMBER_OF_FISK_RELEASED","NUMBER_OF_HOOKS_SET.x","NUMBER_OF_LIGHT_STICKS.x","PERMIT_NUMBER.x","REGION","SEA_SURFACE_TEMPERATURE","SET_DAY","SET_MONTH","SET_TYPE.x","SET_YEAR","SIDE_SET","SOAK_TIME","SPECIES_CODE","TARGET_SPECIES_CODE","UNIQUE_SET_ID","VESSEL_NAME.x","WEIGHTED_GEAR","WIND_DIRECTION")]

write.csv(df, "BUM_Logbook_CPUE_10_2020.csv")

df<-read.csv("BUM_Logbook_CPUE_10_2020.csv")
###### Add Enviromental data
library(lubridate)
library(httr)
library(ggplot2)
library(geosphere)
library(knitr)
library(dplyr)
df$LON2 = ifelse(df$LONGITUDE < 0, df$LONGITUDE*-1, df$LONGITUDE )
df.agg = aggregate(cbind(LATITUDE,LON2) ~ HAUL_MONTH + HAUL_YEAR, data = df, FUN = mean)
### This will provide SST through 2018
base.url = 'https://oceanwatch.pifsc.noaa.gov/erddap/griddap/CRW_sst_v1_0_monthly.csvp?analysed_sst[('
for(i in 1:nrow(df.agg)){
    HAULMO = ifelse(df.agg$HAUL_MONTH < 10, paste0(0,df.agg$HAUL_MONTH), df.agg$HAUL_MONTH)[i] ## designate month to download
    HAULYR = df.agg$HAUL_YEAR[i]
    HAULLAT = df.agg$LATITUDE[i]
    HAULLON = df.agg$LON2[i]
    ## ping server
    GET(paste0(base.url,
               HAULYR,'-',HAULMO,'-01T00:00:00Z):1:(',HAULYR,'-',HAULMO,'-01T00:00:00Z)][(',HAULLAT-0.2,'):1:(',HAULLAT+0.2,')][(',HAULLON-0.2,'):1:(',HAULLON+0.2,')]'),
        write_disk(paste0(getwd(),'/ERRDAP/',i,'-9419-sst.csv'), overwrite = T))
}




p <- proc.time() 
## go through sst files
list.files('C:/Users/michelle.sculley/Documents/2021 BUM ASSESS/ERRDAP/', pattern = "*sst.csv", full.names = TRUE) %>%
    ## open each CSV, ignore header
    lapply(FUN = read.csv, header = T, na.strings = 'NaN') %>%
    ## bind them together
    bind_rows %>%
    ## skip NAs
    na.omit %>%
    ## write the large file
    write.csv("C:/Users/michelle.sculley/Documents/2021 BUM ASSESS/sstBind.csv", row.names = FALSE) 
proc.time() - p

sstraw = read.csv('C:/Users/michelle.sculley/Documents/2021 BUM ASSESS/sstBind.csv')
 names(sstraw) = c('UTC','LAT','LON','SSTDEGC')
 sstraw$DATE = as.Date(sstraw$UTC)
 sstraw$YEAR = year(sstraw$DATE)
 sstraw$MONTH = month(sstraw$DATE)
 tail(sstraw)
 write.csv(sstraw,'C:/Users/michelle.sculley/Documents/2021 BUM ASSESS/sstBind.csv', row.names = F)

bind.sst = function(data, sst){
    agglist = list()
    utp = data %>% group_by(HAUL_YEAR,HAUL_MONTH) %>% dplyr::summarise()
    
    for(u in 1:nrow(utp)){
        subDATA = subset(data, HAUL_MONTH == utp$HAUL_MONTH[u] & HAUL_YEAR == utp$HAUL_YEAR[u])
        subSST = subset(sst, MONTH == utp$HAUL_MONTH[u] & YEAR == utp$HAUL_YEAR[u])
        ## error trap for unmatched subscripts - happens with cloud cover. Will just bounce to next iteration
        if(nrow(subSST) == 0) {
            print(paste0(utp$HAUL_MONTH[u]," ",utp$HAUL_YEAR[u]," dropped; absence of SST coverage; ", nrow(subDATA),' record(s) in all')) 
            next }
        D = distm(subDATA[,c('LON2','LATITUDE')], subSST[,c('LON','LAT')])
        subfun = unlist(apply(D,1,which.min))
        agg0 = cbind(subDATA, subSST[subfun,])
        agglist[[u]] = agg0
    }
    bigdata = do.call(rbind, agglist)
    bigdata
    drops = nrow(df) - nrow(bigdata)
    print(paste0(drops,' total records dropped, ', round(drops/nrow(df)*100, digits = 3)," % of total" )) ## see how many were dropped
    return(bigdata)
}
p = proc.time()


df_sst = bind.sst(df,sstraw)
proc.time() - p
head(df_sst)
ggplot(df_sst, aes(x = LON2*-1, y = LATITUDE, col = SSTDEGC)) +
    theme_bw() +
    facet_wrap(~HAUL_MONTH) + 
    geom_point()

### Add PDO, SOI, ONI

pdoi = read.csv('PDO Index.csv', header = T)
df_sst_pdoi = merge(df_sst,pdoi,by.x = c('HAUL_YEAR','HAUL_MONTH'), by.y = c('YEAR', 'MONTH'))

soi = read.csv('SOI.csv', header = T)
df_sst_pdoi_soi = merge(df_sst_pdoi,soi,by.x = c('HAUL_YEAR','HAUL_MONTH'), by.y = c('YEAR', 'MONTH'))


nino = read.table('ONI.txt',header=TRUE)
df_sst_pdoi_soi_oni = merge(df_sst_pdoi_soi,nino[,c("YR","MON","ANOM")],by.x = c('HAUL_YEAR','HAUL_MONTH'), by.y = c('YR', 'MON')) 

write.csv(df_sst_pdoi_soi_oni, "BUMCPUE_Env.csv")
