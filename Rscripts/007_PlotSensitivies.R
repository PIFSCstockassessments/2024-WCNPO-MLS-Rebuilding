### plot sensitivity runs
## run 001_LoadModel.R and 003_DataSummaryFigs.R before running

library(r4ss)

Sensbase<-paste0(current.dir,"\\Sensitivities")
SensList<-c("\\1_base_case_highM",
            "\\2_base_case_lowM",
            "\\3_base_case_h070",
            "\\4_Sensitivity_h081",
            "\\5_Sensitivity_h099",
            "\\6_Sensitivity_large_Amax",
            "\\7_Sensitivity_Sun_Growth",
            "\\8_Sensitivity_high_L50",
            "\\9_Sensitivity_low_L50",
            "\\10_Sensitivity_L50_Wang2003",
            "\\11_Sensitivity_Drop_VNCN_catch",
            "\\12_Use_NP_catch",
            "\\13_Use_OrphanCatch",
            "\\14_Change_Amin_1",
            "\\15_Change_S6_lambda0",
            "\\16_TWN doubleNorm Selec",
            "\\17_Add F9 Size Data",
            "\\18a_Only S2",
            "\\18b_Only S4",
            "\\18c_Only S5",
            "\\18d_Only S7",
            "\\18e_Only S8",
            "\\18f_Only S7 and S8",
            "\\19_All CPUE")
SensDir<-vector()
for (i in 1:length(SensList)){SensDir[i]<-paste0(Sensbase,SensList[i])}
SensMods<-SSgetoutput(dirvec=SensDir, verbose=FALSE)
#SensModsSum<-SSsummarize(SensMods)



NatM_sens<-SSsummarize(list(base.model,SensMods[[1]],SensMods[[2]]))

h_sens<-SSsummarize(list(base.model,SensMods[[3]],SensMods[[4]],SensMods[[5]]))
# h_sens<-SSsummarize(list(base.model,SensMods[[3]],SensMods[[4]]))
# SSplotComparisons(h_sens,png=TRUE, plotdir = plotdir, legendlabels=c("base case","Model 3","Model 4"),subplots = c(1,7), shadealpha = 0, filenameprefix = "SensSteep2_")

Growth_sens<-SSsummarize(list(base.model,SensMods[[6]], SensMods[[7]]))
# Growth_sens<-SSsummarize(list(base.model, SensMods[[7]]))
# SSplotComparisons(Growth_sens,png=TRUE, plotdir = plotdir, legendlabels=c("base case","Model 7"), subplots = c(1,5,7),  shadealpha = 0, filenameprefix="SensGrowth2_")


Mat_sens<-SSsummarize(list(base.model,SensMods[[8]],SensMods[[9]],SensMods[[10]]))


Catch_sens<-SSsummarize(list(base.model,SensMods[[11]],SensMods[[12]],SensMods[[13]]))

Model_sens<-SSsummarize(list(base.model,SensMods[[14]],SensMods[[15]],SensMods[[16]],SensMods[[17]]))

  
CPUE_Sens<-SSsummarize(list(base.model,SensMods[[18]],SensMods[[19]],SensMods[[20]],SensMods[[21]],SensMods[[22]],SensMods[[23]],SensMods[[24]]))

SSplotComparisons(NatM_sens,png=TRUE,plot=FALSE, plotdir=plotdir, legendlabels=c("base case","Model 1","Model 2"),  subplots = c(1,7),shadealpha = 0, filenameprefix = "SensNatM_")

SSplotComparisons(h_sens,png=TRUE,plot=FALSE, plotdir = plotdir, legendlabels=c("base case","Model 3","Model 4","Model 5"),subplots = c(1,7), shadealpha = 0, filenameprefix = "SensSteep_")

SSplotComparisons(Growth_sens,png=TRUE, plot=FALSE, plotdir = plotdir, legendlabels=c("base case","Model 6","Model 7"), subplots = c(1,7),  shadealpha = 0, filenameprefix="SensGrowth_")

SSplotComparisons(Mat_sens,png=TRUE, plot=FALSE, plotdir = plotdir, legendlabels=c("base case","Model 8","Model 9","Model 10"), subplots = c(1,7), shadealpha = 0, filenameprefix = "SensMat_")

SSplotComparisons(Catch_sens,png=TRUE, plot=FALSE, plotdir = plotdir, legendlabels=c("base case","Model 11","Model 12","Model 13"), subplots = c(1,7),shadealpha = 0, filenameprefix="SensCatch_") 

SSplotComparisons(Model_sens,png=TRUE, plot=FALSE, plotdir = plotdir, legendlabels=c("base case","Model 14","Model 15","Model 16","Model 17"), subplots = c(1,7),shadealpha = 0, filenameprefix="SensModel_") 

SSplotComparisons(CPUE_Sens,png=TRUE, plot=FALSE, plotdir = plotdir, legendlabels=c("base case","Model 18a","Model 18b","Model 18c","Model 18d","Model 18e","Model 18f","Model 19"), subplots = c(1,7),  shadealpha = 0, filenameprefix = "SensCPUE_")


x_max = 15
x_min = 0
y_max = 1.25
y_min = 0

rnames <- base.model$derived_quants$Label

index_SSB_MSY = which(rnames==paste("SSB_MSY",sep=""))
index_Fstd_MSY = which(rnames==paste("annF_MSY",sep=""))
index_SSB_btgt = which(rnames=="SSB_Btgt")
index_Fstd_btgt = which(rnames=="annF_Btgt")
indexSSBstd = which(rnames==paste0("SSB_",endyear))
index_Fstd = which(rnames==paste0("F_",endyear))

year_vec = min(base.model$sprseries$Yr):(max(base.model$sprseries$Yr)-1)
if (refpoint=="MSY"){
SSB_btgt_est =  base.model$derived_quants[index_SSB_MSY,2]
Fstd_btgt_est = base.model$derived_quants[index_Fstd_MSY,2]
SSBratio = base.model$derived_quants[indexSSBstd,2]/base.model$derived_quants[index_SSB_MSY,2]
Fratio = base.model$derived_quants[index_Fstd,2]/base.model$derived_quants[index_Fstd_MSY,2]

} else if (refpoint =="btgt"){
SSB_btgt_est = B0Ref  
Fstd_btgt_est = base.model$derived_quants[index_Fstd_btgt,2]
SSBratio = base.model$derived_quants[indexSSBstd,2]/SSB_btgt_est
Fratio = base.model$derived_quants[index_Fstd,2]/Fstd_btgt_est
}


#############################
terminal <- function(model,endyear,refpoint){
  rnames <- model$derived_quants$Label
  
  index_SSB_MSY = which(rnames==paste("SSB_MSY",sep=""))
  index_Fstd_MSY = which(rnames==paste("annF_MSY",sep=""))
  index_SSB_btgt = which(rnames==paste("SSB_Btgt",sep=""))
  index_Fstd_btgt = which(rnames==paste("annF_Btgt",sep=""))
  index_SSBend = which(rnames==paste0("SSB_",endyear))
  index_Fstd = which(rnames==paste0("F_",endyear))
  DynamicB0<-mean(model$Dynamic_Bzero[which(model$Dynamic_Bzero$Yr>=(endyear-nyr)),"SSB_nofishing"])
 # B0Ref<-DynamicB0*0.2
  

  if (refpoint == "Btgt"){
    #SSB_btgt_est = B0Ref
    SSB_virgin=model$derived_quants[which(model$derived_quants$Label=="SSB_Virgin"),2]
   # Btgt_ratio = B0Ref/SSB_virgin
    Fstd_btgt_est = model$derived_quants[index_Fstd_btgt:index_Fstd_btgt,2]
    SSBratio = model$derived_quants[index_SSBend,2]/SSB_btgt_est
  Fratio = model$derived_quants[index_Fstd,2]/Fstd_btgt_est
  terminal_point = c(SSBratio,Fratio)
  return(terminal_point)
  #print(B0Ref)
  #print(Btgt_ratio)
  } else if (refpoint=="MSY") {
    SSB_btgt_est = model$derived_quants[index_SSB_MSY,2]
    Fstd_btgt_est= model$derived_quants[index_Fstd_MSY,2]
    SSBratio = model$derived_quants[index_SSBend,2]/SSB_btgt_est
    Fratio = model$derived_quants[index_Fstd,2]/Fstd_btgt_est
    terminal_point = c(SSBratio,Fratio)
    return(terminal_point)
    #print(B0Ref)
    
}
  }
#############################

# require(plotrix)
# plot(c(x_min,x_max),c(y_min,y_max),type="n", ylab="", xlab="")
# mtext(side=1, expression(SSB/SSB[Btgt]),line=2.5, cex=1)  
# mtext(side=2, expression(F/F[Btgt]),line=2.5, cex=1)  
# 
# polygon(c(x_min,1,1,x_min), c(1,1,x_min,x_min)) #,col="khaki1"
# polygon(c(1,x_max,x_max,1), c(1,1,0,0))#,col="palegreen"
# polygon(c(0,1,1,0), c(1,1,y_max,y_max)) #,col="salmon"
# polygon(c(1,x_max,x_max,1), c(1,1,y_max,y_max)) ##,col="khaki1"
# 
# SSBratio = base.model$derived_quants[which(base.model$derived_quants$Label==paste0("SSB_",endyear)),2]/SSB_btgt_est
# Fratio = base.model$derived_quants[index_Fstd,2]/Fstd_btgt_est
# 
# draw.circle(SSBratio,Fratio,0.03,col="grey")
# text(SSBratio,Fratio,labels="B",cex=0.8)
# 
# #model<-list(model_1,model_2,model_3,model_4,model_5,model_6,model_7,model_8,model_9,model_10,model_11, model_12, model_13, model_14)
# for (i in 1:17){
#   # tempmodel<-SensMods[[i]]  
#   # temp_points = terminal(tempmodel,endyear)
#   # print(temp_points)
#   # draw.circle(temp_points[1],temp_points[2],0.03)
#   # text(temp_points[1],temp_points[2],labels=c(i),cex=0.8)
#   draw.circle(KobePoints[i,"SSBratio"],KobePoints[i,"Fratio"],0.03)
#   text(KobePoints[i,"SSBratio"],KobePoints[i,"Fratio"],labels=c(KobePoints[i,"Number"]),cex=0.8)
#   
# }
# 
