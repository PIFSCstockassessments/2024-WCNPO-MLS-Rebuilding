##code for making FLCore figures in comparing CPUE indices for conflict for an assessment
## Developed by Maia Kapur, Version 2 by Michelle Sculley
## NOAA NMFSC PIFSC, March 2018

##Do this once:
##first install FLCore
#install.packages("FLCore", repos="http://flr-project.org/R")
## then install diags
#source("http://flr-project.org/R/instFLR.R") 
#4##use option 1 for diags 


##Then run code:
library(ggplot2, quietly = TRUE)
library(reshape2, quietly = TRUE)
library(plyr, quietly = TRUE)
library(dplyr, quietly = TRUE)
library(gam, quietly = TRUE)
library(GGally, quietly = TRUE)
library(corrplot, quietly = TRUE)
library(data.table, quietly = TRUE)
library(FLCore, quietly = TRUE)
library(diags, quietly = TRUE)

####Explanation of plots created: ######
# The CPUE time series are plotted in Figure 1, to compare trends by stock.
# To look at deviations from the overall trends the residuals from the fits are compared in Figure 2. 
# This allows conflicts between indices (e.g. highlighted by patterns in the residuals), 
# autocorrelation within indices which may be due to year-class effects or the importance of factors 
# not included in the standardisation of the CPUE to be identified. 
# Figure 3 illustrates the correlation between indices; the lower triangle displays the pairwise scatter plots 
# between the indicies with a regression line, the upper triangle the correlation coefficients and the diagonal 
# the range of observations. A single influential point may cause a strong spurious correlation therefore it is 
# important to look at the plots as well as the correlation coefficients. 
# If indices represent the same stock components then it is reasonable to expect them to be correlated, 
# if indices are not correlated or negatively correlated, i.e. they show conflicting trends, this may result in 
# poor fits to the data and bias in the estimates. Therefore it the correlations can be used to select groups 
# that represent a common hypotheses about the evolution of the stock. 
# Figure 4 shows a the results from a hierarchical cluster analysis using a set of dissimilarities. 
# Blue indicates postive correlation and reds indicate negative correlations. The width of the oval 
# indicates the scale of the correlation.
# Next the cross-correlations are plotted in Figure 5, i.e. the correlations between series when they are lagged (by -10 to 10 years). 
# The diagonal shows the autocorrelations as an index is lagged against itself. 
# A strong negative or positive cross-correlation could be due to series being dominated by different age-classes.


##### Run the Analysis #######

##  flts is the names of all the fleets in your datafile
CPUE.mean<-aggregate(base.model$cpue$Obs, by=list(base.model$cpue$Fleet_name),mean)
flts <- CPUE.mean$Group.1

## u is your datafile, it should have a column for year, fleet name and CPUE value
u<-base.model$cpue[,c(4,10,15,2,1)]
names(u)<-c("year","CPUE","CV","Fleet", "Fleet_Num")

scale<-function(x,y,...){
  args=list(...)
  
  if (length(args)==0) group=rep(1,length(x)) else group=args[[1]]  
  
  gm=gam(y~lo(x)+group,data=data.frame(x=x,y=y,group=group))
  
  res=data.frame(hat =predict(gm),
                 y     =gm$y,
                 x     =x,
                 group =group,
                 scl   =c(0,coefficients(gm)[-(1:2)])[as.numeric(as.factor(group))]
  )
  res$y  =res$y  -res$scl
  res$hat=res$hat-res$scl
  
  if (length(args)==1) names(res)[4]=names(args)[1]  
  
  res[,-5]}

my_density <- function(data,mapping,...){
  ggplot(data=data,mapping=mapping)+
    geom_density(...,lwd=1)}

my_bar <- function(data,mapping,...){
  ggplot(data=data,mapping=mapping)+
    geom_bar(...)}

my_smooth <- function(data,mapping,...){
  ggplot(data=data,mapping=mapping)+
    geom_point(...,size=.5)+
    geom_smooth(...,method="lm",se=FALSE)}

my_ccf <- function(cpue) {
  cc = mdply(expand.grid(a = names(cpue), b = names(cpue)),
             function(a, b) {
               #print(paste(a,b))
               res = model.frame(mcf(FLQuants(cpue[c(a, b)])))
               res = subset(res, !is.na(res[, 7]) & !is.na(res[, 8]))
               
               if (dim(res)[1] > 10) {
                 res = data.frame(lag = -10:10,
                                  data = ccf(res[, 7], res[, 8], plot = F,
                                             lag.max = 10)$acf)
                 return(res)
               } else{
                 return(NULL)
               }
             })
}


gm = with(u,
          gam(CPUE ~ lo(year) + Fleet))
res = data.frame(
  hat = predict(gm),
  CPUE     = gm$y,
  year     = u$year,
  Fleet = u$Fleet,
  scl   = c(0, coefficients(gm)[-(1:2)])[as.numeric(as.factor(u$Fleet))]
)
res$CPUE  = res$CPUE - res$scl
res$hat = res$hat - res$scl


smooth = base::merge(res, u, by = c("Fleet", "year"), all = T) %>% 
  dplyr::select(year, Fleet, hat, CPUE.x, CV) %>% plyr::rename(c("CPUE.x" = "CPUE"))
#smooth<-smooth[-1,]

## Time series of CPUE indices, continuous black line is a lowess smother showing the average trend by area (i.e. fitted to year for each area with series as a factor)
cpue1 <-  smooth[smooth$Fleet %in% flts[1:4],] %>%
  ggplot( aes(x = year, y = CPUE)) +
  theme_bw() +
  geom_point()+
  geom_smooth(method = 'loess', colour = 'black')+
  # geom_errorbar(aes(x = year, ymin = CPUE - CV, ymax = CPUE +CV)) +
  ylab("Scaled CPUE") +
  facet_grid(Fleet~., scales = "free_y") +
  theme(legend.position="bottom", panel.grid.major = element_blank(),
        strip.text.y = element_text(size = 4),
        strip.background = element_rect(fill="burlywood1"))

cpue2 <-smooth[smooth$Fleet %in% flts[5:8],] %>%
  ggplot( aes(x = year, y = CPUE)) +
  theme_bw() +
  geom_point()+
  geom_smooth(method = 'loess', colour = 'black')+
  # geom_errorbar(aes(x = year, ymin = CPUE - CV, ymax = CPUE +CV)) +
  ylab("Scaled CPUE") +
  facet_grid(Fleet~., scales="free_y") +  
  theme(legend.position="bottom", panel.grid.major = element_blank(),
        strip.text.y = element_text(size = 4),
        strip.background = element_rect(fill="burlywood1"))

#Rmisc::multiplot(cpue1,cpue2, cols = 2)

##  Time series of residuals from the Loess fit.
## add residual to smooth data frame


CPUE_Residuals<-smooth %>% mutate(residual = CPUE - hat) %>%
  ggplot(aes(x = year))+
  theme_bw()+
  geom_hline(aes(yintercept=0), col = 'red')+
  geom_point(aes(y = residual),position=position_dodge(width = 1))+
  geom_line(aes(y = residual),alpha=0.5) +
  geom_linerange(aes(ymin=0,ymax=residual),position=position_dodge(width = 1)) +
  theme(legend.position="bottom")+
  facet_grid(Fleet~.,scale="free_y",space="free_x")+
  theme(legend.position="bottom", panel.grid.major = element_blank(),
        axis.title.x = element_blank(),
        strip.text.y = element_text(size = 10),
        strip.background = element_rect(fill="burlywood1"))


##  Pairwise scatterplots to illustrate correlations among all indices.
mat=reshape2::dcast(u,year~Fleet,value.var="CPUE")
names(mat)=gsub(" ", "_",names(mat))
#mat<-as.data.frame(mat)
CPUE_Pairs<-ggpairs(mat[,-1],
        upper=list(continuous=wrap("cor",size=4, hjust=0.5)),
        lower=list(continuous = wrap(my_smooth)),
        diag=list(continuous="bar")) +
  theme(legend.position="bottom", panel.grid.major = element_blank(),
        strip.text = element_text(size = 6.75),
        strip.background = element_rect(fill="burlywood1"))

## Plot of the correlation matrix for CPUE indices. Blue indicates a positive correlation, and red negative. 
## The order of the indices and the rectanglur boxes are chosen based on a hierarchical cluster analysis using 
##a set of dissimilarities for the indices being clustered.
# cr=cor(mat[,-1],use="pairwise.complete.obs")
# dimnames(cr)=list(gsub("_"," ",names(mat)[-1]),gsub("_"," ",names(mat)[-1]))
# cr[is.na(cr)]=0
# CPUE_Corr<-corrplot(cr,diag=F,order="hclust",addrect=2,  method = "ellipse",  tl.col = 'black', tl.cex = 0.75)  +          
#   theme(legend.position="bottom", panel.grid = element_blank())  

##  Cross correlations between indices to identify potential lags due to year-class effects.
cpue=FLQuants(dlply(u,.(Fleet), with,
                    as.FLQuant(data.frame(year=year,data=CPUE))))

cc=my_ccf(cpue)

CPUE_CrossCorr<-ggplot(cc)+
  geom_linerange(aes(x=lag,ymin=0,ymax=data))+
  facet_grid(a~b)+
  geom_vline(aes(xintercept=0))+
  theme_bw(14)  +
  theme(legend.position="bottom", panel.grid.major = element_blank(),
        strip.text = element_text(size = 9),
        strip.background = element_rect(fill="burlywood1"))

