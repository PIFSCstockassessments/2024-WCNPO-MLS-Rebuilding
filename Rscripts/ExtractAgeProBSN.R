library(r4ss)



#function(model_dir, N_boot, endyr, seed)
setwd("G:\\Bootstraps\\Rerun")
model_dir = "G:\\Bootstraps\\Rerun"
N_boot = 4
endyr = 2021
seed = 123

source("G:\\Bootstraps\\008_Run_Bootstraps.R")
Run_Bootstraps(model_dir,N_boot,endyr,seed)

### this is a slightly modified version of the r4ss function SSsplitdat
SSsplitdat <-
  function(inpath     = 'working_directory',
           outpath    = 'working_directory',
           inname     = 'data.ss_new',
           outpattern = 'BootData',
           number     = FALSE,
           verbose    = TRUE,
           fillblank  = TRUE,
           MLE        = TRUE,
           inputs     = FALSE,
           notes      = ""
  )
  {
    # this is a function to split bootstrap aggregated in the data.ss_new file
    # which is output from Stock Synthesis into individual data files.
    if(MLE & inputs) stop("can't have both 'MLE' and 'inputs' = TRUE")
    
    if(inpath=="working_directory") inpath=getwd()
    if(outpath=="working_directory") outpath=getwd()
    
    infile    <- paste(inpath,inname,sep='/')
    filelines <- readLines(infile)
    if(fillblank)  filelines[filelines==""] <- "#"
    
    string    <- '#_bootstrap file'
    starts    <- grep(string, filelines)
    ends      <- c(starts[-1]-1,length(filelines)-1)
    
    MLEstring <- '#_expected values with no error added'
    MLEstart  <- grep(MLEstring, filelines)
    MLEend    <- starts[1]-1
    
    if(MLE & length(MLEstart)==0) stop("no MLE values in ",inname,"\n  change 'N bootstrap datafiles' in starter.ss to 2 or greater")
    inputstring <- '#_observed data'
    inputstart  <- grep(inputstring, filelines)
    if(length(MLEstart)==0) inputend <- length(filelines) else inputend <- MLEstart-1
    if(length(inputstart)==0) stop("no values in ",inname,"\n  change 'N bootstrap datafiles' in starter.ss to 1 or greater")
    
    
    if(!MLE & !inputs){
      if(length(starts)==0) stop("no bootstrap values in ",inname,"\n  change 'N bootstrap datafiles' in starter.ss to 3 or greater")
      for(i in 1:length(starts)) {
        outfile <- paste(outpath,'/',outpattern,ifelse(number,i,''),'.dat',sep='')
        outline <- paste('# Data file created from',infile,'to',outfile)
        if(verbose) cat(outline,"\n")
        writeLines(c(outline,filelines[starts[i]:ends[i]]),outfile)
      }
    }else{
      if(MLE){
        outfile <- paste(outpath,'/',outpattern,'.dat',sep='')
        if(notes!="") notes <- paste("#C",notes) else notes <- NULL
        notes <- c(notes,paste('#C MLE data file created from',infile,'to',outfile))
        if(verbose) cat('MLE data file created from',infile,'to',outfile,"\n")
        writeLines(c(notes,filelines[MLEstart:MLEend]),outfile)
      }
      if(inputs){
        outfile <- paste(outpath,'/',outpattern,'.dat',sep='')
        if(notes!="") notes <- paste("#C",notes) else notes <- NULL
        notes <- c(notes,paste('#C data file created from',infile,'to',outfile))
        if(verbose) cat('file with copies of input data created from',infile,'to',outfile,"\n")
        writeLines(c(notes,filelines[inputstart:inputend]),outfile)
      }
    }
  }


## this is a modified version of the r4ss SS_bootstrap function
SS_bootstrap <- function(){
  # this is not yet a generalized function, just some example code for how to do
  # a parametric bootstrap such as was done for the Pacific hake model in 2006
  # See http://www.pcouncil.org/wp-content/uploads/2006_hake_assessment_FINAL_ENTIRE.pdf
  # A description is on page 41 and Figures 55-56 (pg 139-140) show some results.
  
  # Written by Ian Taylor on 10/11/2012 after discussion with Nancie Cummings
  
  # first set "Number of datafiles to produce" in starter.ss = 100 or some large number
  # re-run model to get data.ss_new file concatenating all bootstrap data files
  
  # Directory where bootstrap will be run.
  # You probably want to use a copy of the directory where you ran it,
  # so as not to overwrite the true results.
  inpath <- 'G:\\Bootstraps'
  
  #setwd(inpath) # change working directory (commented out to avoid violating CRAN policy)
  
  # split apart data.ss_new into multiple data files with names like "BootData1.ss"
  SSsplitdat(inpath=inpath, outpath=inpath, number=TRUE, MLE=FALSE)
  
  N <- 100 # number of bootstrap models to run (less than or equal to setting in starter)
  
  starter <- SS_readstarter(file="starter.ss") # read starter file file="starter.ss"
  file.copy("starter.ss","starter_backup.ss") # make backup
  
  # loop over bootstrap files
  boot_dir <-model_dir
  
  # Directory where bootstrap will be run.
  if(!exists(boot_dir)){
    dir.create(boot_dir)
  }
  
  message(paste0("Creating bootstrap data files in ", boot_dir))
  
  starter <- SS_readstarter(file =  file.path(boot_dir, "starter.ss")) # read starter file
  file.copy(file.path(boot_dir, "starter.ss"), file.path(boot_dir, "starter_backup.ss")) # make backup

  #create the bootstrap data file numbers
  bootn <- seq(1, N_boot, by = 1)
  # loop over bootstrap files
  for (iboot in 1:N_boot) {
    # note what's happening
    cat("\n##### Running bootstrap model number", iboot, " #########\n")
    
  
    starter[["datfile"]] <- paste("BootData", bootn[iboot], ".dat", sep = "")
    starter[["N_bootstraps"]] <- 1
    # replace starter file with modified version
    SS_writestarter(starter, dir = boot_dir, overwrite = TRUE)
    
    # delete any old output files
    file.remove(file.path(boot_dir, "Report.sso"))
    file.remove(file.path(boot_dir, "CompReport.sso"))
    file.remove(file.path(boot_dir, "covar.sso"))
    
    # run model
    r4ss::run(dir = boot_dir, exe = "ss.exe",
              skipfinished = F)
    
    # copy output files (might be good to use "file.exists" command first to check if they exist
    file.copy(file.path(boot_dir, "Report.sso"), paste(boot_dir, "/Report_", iboot, ".sso", sep = ""))
    file.copy(file.path(boot_dir, "CompReport.sso"), paste(boot_dir, "/CompReport_", iboot, ".sso", sep = ""))
    file.copy(file.path(boot_dir, "covar.sso"), paste(boot_dir, "/covar_", iboot, ".sso", sep = ""))
    file.copy(file.path(boot_dir, "warning.sso"), paste(boot_dir, "/warning_", iboot, ".sso", sep = ""))
    # other .sso files could be copied as well
  }
  #  
   bootmodels <- SSgetoutput(keyvec = paste0("_", seq(1, N_boot)), 
                      dirvec = file.path(boot_dir), verbose = F,getcomp=FALSE, getcovar =FALSE)
  
  # read and summarize all models
  # (setting getcomp=FALSE will produce warning
  #  about missing comp file, but use less memory)
  bootsummary <- SSsummarize(bootmodels)
  
  # a bunch of plots that won't work well if there are lots of models
  # SSplotComparisons(bootsummary,png=TRUE)
  # histogram of a single quantity
  hist(as.numeric(bootsummary$quants[bootsummary$quants$Label=="SSB_Virgin",1:N]), main="Bootstrapped Virgin SSB estimates",xlab="SSB")
  hist(as.numeric(bootsummary$pars[grep("R0",bootsummary$pars$Label),1:N]),main="Bootstrapped R0 estimates",xlab="ln(R0)")
  return(bootmodels) 
  
}
install.packages("devtools")
devtools::install_github("r4ss/r4ss")
library(r4ss)
setwd("G:\Bootstraps")
boot_results<- bootmodels #SS_bootstrap()

#bootmodels <- SSgetoutput(keyvec=paste("_",1:100,sep=""), dirvec=inpath, getcomp=FALSE)
NatAge<-as.data.frame(matrix(NA,ncol=15))
library(dplyr)
## for annual timestep
for (i in 1:N){
  tempmodel<-boot_results[[i]]
  NatAge[i,]<-tempmodel$natage %>% 
    filter(Yr==endyr,Seas==1,`Beg/Mid`=="B") %>%
    select(14:ncol(.))
  
}

write.table(NatAge,"2023_WCNPOMLS.bsn", row.names=FALSE,col.names = FALSE)


## for quarterly time step
NatAge<-as.data.frame(matrix(NA,ncol=15*4))
for (i in 1:N){
  tempmodel<-boot_results[[i]]
  NatAge[i,]<-tempmodel$natage %>% 
    filter(Yr==endyr,`Beg/Mid`=="B") %>%
    select(9,14:ncol(.)) %>%
    reshape2::melt(id.vars = c("Seas")) %>%
    select(3) %>%
    as.vector() %>%
    unlist() ## turn it into a vector to read it into the correct line in NatAge
  
}
## removing the NatAge for all but the integer ages

# Create a sequence to identify columns to change to zero
cols_to_change <- seq(from = 3, to = ncol(NatAge), by = 4)
all_cols <- 1:ncol(NatAge)

# Select columns that need to be changed to zero
cols_to_zero <- all_cols[!all_cols %in% cols_to_change]

# Set values to zero for columns not every 4th column
NatAge[, cols_to_zero] <- 0

write.table(NatAge,"2023_WCNPOMLS_Quarters.bsn", row.names=FALSE,col.names = FALSE)
