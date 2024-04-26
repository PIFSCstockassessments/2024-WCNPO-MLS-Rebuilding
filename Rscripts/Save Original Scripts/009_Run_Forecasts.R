#' @param model_dir directory where bootstraps are run
#' @param N_foreyrs number of forecast years
#' @param FixedCatchSeq Sequence of catch containing start, end, and steps of the Fixed Catch values to forecast (ex. start=0, end=1.7 mt, by=0.1)
#' @param seed seed for reproducing random number generator sequences 
#' @param Fsetting Forecast setting (-1=none; 0=simple_1yr; 1=F(SPR); 2=F(MSY) 3=F(Btgt) or F0.1; 4=Ave F (uses first-last relF yrs); 5=input annual F scalar)
#' @param Fyears Years over which average F should be set
library(parallel)
Run_Forecasts <- function(model_dir, N_foreyrs, Scenario, Fsetting, Fyears, endyr, SavedCores=2, DeleteForecastFiles=T, seed=123){
  
  
  # COMMENT OUT THIS LINE
     root_dir      <- base.dir #root_dir <- here(..=2); set.seed(123)
     model_dir     <- current.dir #file.path(root_dir,"SS3 models","VALO","50_BOOT10")
     fore_dir <- file.path(model_dir,"forecast")
     Fsetting <- Fsetting
     Fyears <-Fyears
  #  FixedCatchSeq <- c(0.6,1.4,0.1)
  #  FixedCatchVec  <- seq(FixedCatchSeq[1],FixedCatchSeq[2],FixedCatchSeq[3])
   N_ForeCatch    <- length(Fsetting)
  # COMMENT OUT ABOVE  
    
  require(data.table);  require(tidyverse); require(r4ss)
    
  if(!file.exists(file.path(model_dir, "bootstrap"))){
    stop("No bootstrap runs were found. Please run bootstraps first and then re-run forecast.")
  }
  if(length(list.files(file.path(model_dir, "bootstrap"), pattern = "data_boot_")) < 1){
    stop("No bootstrap data files were found. Please run bootstraps first and then re-run forecast.")
  }
  
  fore_dir <- file.path(model_dir,"forecast")
  # 
  # FixedCatchVec  <- seq(FixedCatchSeq[1],FixedCatchSeq[2],FixedCatchSeq[3])
  # N_ForeCatch    <- length(FixedCatchVec)
  
  # Directory where forecasts will be run.
  if(!exists(fore_dir)){
    dir.create(fore_dir)
  }
  
  # Delete all files in that directory
  unlink(file.path(fore_dir,"*"),recursive=TRUE)
  
  # Run model one time to generate the data bootstrap files
 # file.copy(list.files(model_dir, pattern = "data|control|starter|forecast|.exe", full.names = T),
  file.copy(list.files(file.path(model_dir, "bootstrap"), pattern = "data|.ctl|starter|forecast|.exe", full.names = T),
            to = fore_dir)
  
  message(paste0("Creating forecast data files in ", fore_dir))
  
  starter <- SS_readstarter(file =  file.path(fore_dir, "starter.ss")) # read starter file
  file.copy(file.path(fore_dir, "starter.ss"), file.path(fore_dir, "starter_backup.ss")) # make backup
  #dat <- SS_readdat_3.30(file = file.path(fore_dir, "data.ss"))
  
  #create the forecast data file numbers (pad with leading 0s)
  #bootn <- stringr::str_pad(seq(1, N_boot, by = 1), 2, pad = "0")
  #foren <- stringr::str_pad(seq(1, N_ForeCatch, by = 1), 2, pad = "0")
  
  # Check how many bootstrapped data files exists
  N_boot <- length(list.files(file.path(model_dir, "bootstrap"), pattern = "data_boot", full.names = T))
  
  # loop over bootstrap files
  for (iboot in 1:N_boot) { 
    
    # change data file name in starter file and overwrite the original starter file
    starter[["datfile"]] <- paste("data_boot_", str_pad(iboot,3,pad="0"), ".ss", sep = "")
    starter[["N_bootstraps"]] <- 1
    starter$init_values_src <- 0
    SS_writestarter(starter, dir = fore_dir, overwrite = TRUE)
       # Create catch list to be sent into the lapply function
     #FixedCatchList <- vector("list",length(FixedCatchVec))
   ForecastSettingList<-vector("list",length(Fsetting))  
    for(i in 1:length(Fsetting)){
       #FixedCatchList[[i]] <- list(FixedCatch=FixedCatchVec[i],fore_dir=fore_dir,iboot=iboot,icatch=i,N_foreyrs=N_foreyrs,endyr=endyr)
      ForecastSettingList[[i]] <- list(Scenario=Scenario[i], Fsetting=Fsetting[i],Fyears=Fyears[[i]], fore_dir=fore_dir,iboot=iboot,N_foreyrs=N_foreyrs,endyr=endyr)
       
           }
  #  n_avail_cores <- parallel::detectCores()-SavedCores
  #  cl    <- parallel::makeCluster (n_avail_cores)
       
   # Cycle through all catch levels
   #parallel::parLapply(cl,ForecastSettingList,function(x){      
    lapply(ForecastSettingList,function(x){    
       require(pacman); pacman::p_load(data.table,tidyverse,r4ss)
         
        # aFixedCatch <- x$FixedCatch
         fore_dir    <- x$fore_dir
         iboot       <- x$iboot
      #   icatch      <- x$icatch
         N_foreyrs   <- x$N_foreyrs
         endyr       <- x$endyr
         Fsetting    <-x$Fsetting
         Fyears     <-x$Fyears
         Scenario <- x$Scenario
         
         
         cat("\n##### Running forecast number", Scenario, " #########\n","of ","bootstrap model number", iboot, " #########\n")
        
        # Create a temp directory to run a model from
        temp_dir <- file.path(fore_dir,paste0("B",str_pad(iboot,2,pad="0"),"C",str_pad(Scenario,2,pad="0")))
        if(!exists(temp_dir)){ dir.create(temp_dir) }
       
        # Copy necessary model files from fore_dir to temp_dir
        file.copy(list.files(fore_dir, pattern = ".ctl|starter|forecast|.exe", full.names = T),to = temp_dir)
        
        # Copy the relevant bootstrapped data files to the temp_dir
        file.copy(list.files(fore_dir,pattern=paste0("data_boot_",str_pad(iboot,3,pad="0"),".ss"),full.names=T),to=temp_dir)
        
        # # Obtain bootstrapped catch between 2019-2021 to use for projected catches in 2022 and 2023 (new ACLs starts in 2024)
        # aDat           <- SS_readdat_3.30(file = file.path(temp_dir, paste0("data_boot_", str_pad(iboot,3,pad="0"), ".ss")))
        # aCatch         <- aDat$catch
        # aCatch_Last3yr <- aCatch %>% filter(year>=max(year)-2) %>% summarize(Catch=mean(catch)) %>% as.numeric()
        # 
        # Read original forecast file
        forecast.file <- SS_readforecast(file =  file.path(temp_dir, "forecast.ss")) # read forecast file
         
        # Modify the forecast to include a new Fixed Catch to use in the projections
        forecast.file$Nforecastyrs <- N_foreyrs
      #  forecast.file$ForeCatch    <- data.frame(Year = seq(endyr+1, endyr + N_foreyrs, by = 1),
      #                                   Season = 1, 
      #                                   Fleet = 1,
      #                                   Catch = c(rep(aCatch_Last3yr,times=2),rep(aFixedCatch,times=N_foreyrs-2)))
     
        forecast.file$Forecast <- Fsetting
     forecast.file$Fcast_years<-Fyears
        # replace forecast file with modified version
        SS_writeforecast(forecast.file, dir = temp_dir, overwrite = TRUE)
        
        # delete any old output files
        file.remove(file.path(temp_dir, "Report.sso"))
        file.remove(file.path(temp_dir, "CompReport.sso"))
        file.remove(file.path(temp_dir, "covar.sso"))
        
        # run model
        r4ss::run(dir = temp_dir, exe = "ss.exe", skipfinished = F)
    
        # copy output files (might be good to use "file.exists" command first to check if they exist
        file.copy(file.path(temp_dir, "Report.sso"), paste0(fore_dir, "/Report_B",str_pad(iboot,2,pad="0"),"C",str_pad(Scenario,2,pad="0"),".sso"))
        file.copy(file.path(temp_dir, "CompReport.sso"), paste0(fore_dir, "/CompReport_B",str_pad(iboot,2,pad="0"),"C",str_pad(Scenario,2,pad="0"),".sso"))
         file.copy(file.path(temp_dir, "covar.sso"), paste0(fore_dir, "/covar_B",str_pad(iboot,2,pad="0"),"C",str_pad(Scenario,2,pad="0"),".sso"))
         file.copy(file.path(temp_dir, "data_echo.ss_new"), paste0(fore_dir, "/data_echo_B",str_pad(iboot,2,pad="0"),"C",str_pad(Scenario,2,pad="0"),".ss_new"))
        # other .sso files could be copied as well

       })  # End of Fixed Catch loop
  #   stopCluster (cl) 
  } # End of Bootstrap loop
 

  # Generate model names
  boot.names  <- paste0(  "B",str_pad(rep(1:N_boot, each=N_ForeCatch),2,pad="0")   )
  catch.names <- paste0(  "C",str_pad(rep(1:N_ForeCatch, times=N_boot),2,pad="0")    )
  model.info  <- data.table( model.names=paste0(boot.names,catch.names))

  
  # Read all model files and generate a list
  
  # This it the normal way of combining models into a list. It was giving me errors when trying to load a lot of models (>100)
  #  models <- SSgetoutput(keyvec = paste0("_",model.info[150:200]$model.names), 
  #                     dirvec = file.path(fore_dir), verbose = T)
  
  # models <- list()
  # for(i in 1:nrow(model.info)){
  #    models[[i]] <- SS_output(dir=file.path(fore_dir,model.info[i]),verbose=F,printstats=F,warn=F,readwt=F)  
  # }
  # 
  # 
  #   mvlns <- list()
  #   for(i in 1:length(models)){
  #     set.seed(seed)
  #   
  #     aTS                      <- data.table( models[[i]]$timeseries )
  #     model.info$FixedCatch[i] <- aTS[Era=="FORE"]$`dead(B):_1`[3] # Skip the first 2 years since they are not using the "fixed" catch (i.e. years between model end and start management)
  #   
  #     try(
  #      mvlns[[i]] <- ss3diags::SSdeltaMVLN(models[[i]], mc = 1000, 
  #                                       weight = 1, 
  #                                       run =model.info$model.names[i], 
  #                                       plot = F,
  #                                       #variance_method = "ww2019", #ww2019 or 2T
  #                                      #bias_correct_mean = T,
  #                                       addprj = T)$kb
  #     , silent=F)
  #    }
  # 
  # 
  #       
  # # Natural mortality for MSST reference point
  # # SS.results <- r4ss::SS_output(model_dir,verbose = FALSE, printstats = FALSE)
  # # PAR        <- data.table( SS.results$parameters )
  # # NatM       <- PAR[str_detect(PAR$Label,"NatM")]$Value
  # 
  # 
  # # Aggregate results and calculate new parameters
  # mv                  <- data.table::rbindlist(mvlns)
  # 
  #  mv_fore             <- mv[year>endyr]
  # # mv_fore$Fmsy        <- mv_fore$F/mv_fore$harvest
  # # mv_fore$SSBmsst     <- mv_fore$SSB/mv_fore$stock*max(0.5,1-NatM) 
  # # mv_fore$SSB_SSBmsst <- mv_fore$SSB/mv_fore$SSBmsst
  #  mv_fore             <- merge(mv_fore,model.info,by.x="run",by.y="model.names")
  # setnames(mv_fore,"harvest","F_Fmsy") 
  #  mv_fore             <- select(mv_fore,-c(stock,type,iter,Recr))
  # 
  # # Delete all files and save final result
  # if(DeleteForecastFiles==T)
  #  unlink(file.path(fore_dir,"*"),recursive=TRUE)
  # 
  # saveRDS(mv_fore, file = file.path(fore_dir, "mv_projections.rds"))
  
}
