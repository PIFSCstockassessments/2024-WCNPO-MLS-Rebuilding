### Plot Jitter

##Run Jitter
 Jitterwd<-paste0(current.dir,"\\jitter")
 if (Do_Jitter==TRUE){
   #### Change starter file appropriately (can also edit file directly)
   starter <- SS_readstarter(file.path(Jitterwd, 'starter.ss'))
   # Change to use .par file
   starter$init_values_src = 1
   # Change jitter (0.1 is an arbitrary, but common choice for jitter amount)
   starter$jitter_fraction = 0.1
   # write modified starter file
   SS_writestarter(starter, dir=Jitterwd, overwrite=TRUE)
   #### Run jitter using this function
   jit.likes <- SS_RunJitter(mydir=Jitterwd, Njitter=NJitter, Intern=FALSE)
 } else if (Plot_Jitter==TRUE) {
   if(!file.exists(file.path(current.dir, "jitter"))){
     stop("No Jitter runs were found. Please run Jitter first.")
   }
   if(length(list.files(file.path(current.dir, "jitter"), pattern = "Report")) < 1){
     stop("No jitter report files were found. Please run jitter first.")
   } else {
 ### plot Jitter results
 profilemodels <- SSgetoutput(dirvec=Jitterwd, keyvec=1:NJitter, getcovar=FALSE, verbose=FALSE)
 # summarize output
 profilesummary <- SSsummarize(profilemodels)
 # Likelihoods
 likelihoods<-t(as.matrix(profilesummary$likelihoods[1,]))
 R0<-t(as.matrix(profilesummary$pars[which(profilesummary$pars$Label=="SR_LN(R0)"),1:101]))
 JitterPlot<-ggplot()+
   geom_point(aes(x=as.numeric(R0),y=as.numeric(likelihoods))) +
   geom_point(aes(y=base.model$likelihoods_used[1,1], x=base.model$estimated_non_dev_parameters[1,1]), color="red", size=2)+
   theme_bw()+
   theme(axis.text.x=element_text(size=8), axis.title.x=element_text(size=12),
         axis.text.y=element_text(size=8),axis.title.y=element_text(size=12),
         panel.border = element_rect(color="black",fill=NA,size=1)) +
   ylab("Total Likelihood")+
   xlab("ln(R0)") 
 } }