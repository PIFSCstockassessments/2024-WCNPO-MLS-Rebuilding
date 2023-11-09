#' @param model_dir directory where the key model files are located
#' @param N_boot number of bootstrap models to run (>= 3)
#' @param endyr end year of model
#' @param seed seed for reproducing random number generators


Run_Bootstraps <- function(model_dir, N_boot, endyr, seed){
  
  boot_dir <- file.path(model_dir,"bootstrap")
  
 #  # Directory where bootstrap will be run.
 #  if(!exists(boot_dir)){
 #    dir.create(boot_dir)
 #  }
 #  
 #  message(paste0("Creating bootstrap data files in ", boot_dir))
 #  
 #  # Run model one time to generate the data bootrap files
 #  file.copy(list.files(model_dir, pattern = ".dat|.ctl|starter|forecast|.exe|.par", full.names = T),
 #            to = boot_dir)
 #  start <- r4ss::SS_readstarter(file = file.path(boot_dir, "starter.ss"))
 #  start$N_bootstraps <- N_boot + 2
 #  r4ss::SS_writestarter(start, dir = boot_dir, overwrite = T)
 #  r4ss::run(dir = boot_dir, 
 #            exe = "ss", extras = "-nohess",  skipfinished = FALSE, show_in_console = TRUE)
 #  
 #  starter <- SS_readstarter(file =  file.path(boot_dir, "starter.ss")) # read starter file
 #  file.copy(file.path(boot_dir, "starter.ss"), file.path(boot_dir, "starter_backup.ss")) # make backup
 # # dat <- SS_readdat_3.30(file = file.path(boot_dir, "data.ss"))
 #  
 #  #create the bootstrap data file numbers (pad with leading 0s)
 #  bootn <- stringr::str_pad(seq(1, N_boot, by = 1), 3, pad = "0")
 #  # loop over bootstrap files
 #  for (iboot in 1:N_boot) {
 #    # note what's happening
 #    cat("\n##### Running bootstrap model number", iboot, " #########\n")
 #    
 #    # replace only original catch data with bootstrapped catch
 #    # dat_boot <- SS_readdat_3.30(file = file.path(boot_dir, paste0("data_boot_", bootn[iboot], ".ss")))
 #    # dat$catch <- dat_boot$catch
 #    # SS_writedat_3.30(dat, outfile = file.path(boot_dir, paste0("data_boot_", bootn[iboot], ".ss")), 
 #    #                  overwrite = T)
 #    # change data file name in starter file
 #    starter[["datfile"]] <- paste("data_boot_", bootn[iboot], ".ss", sep = "")
 #    starter[["N_bootstraps"]] <- 1
 #    # replace starter file with modified version
 #    SS_writestarter(starter, dir = boot_dir, overwrite = TRUE)
 #    
 #    # delete any old output files
 #    file.remove(file.path(boot_dir, "Report.sso"))
 #    file.remove(file.path(boot_dir, "CompReport.sso"))
 #    file.remove(file.path(boot_dir, "covar.sso"))
 #    
 #    # run model
 #    r4ss::run(dir = boot_dir, exe = "ss.exe",
 #                  skipfinished = F)
 # 
 #    # copy output files (might be good to use "file.exists" command first to check if they exist
 #    file.copy(file.path(boot_dir, "Report.sso"), paste(boot_dir, "/Report_", iboot, ".sso", sep = ""))
 #    file.copy(file.path(boot_dir, "CompReport.sso"), paste(boot_dir, "/CompReport_", iboot, ".sso", sep = ""))
 #    file.copy(file.path(boot_dir, "covar.sso"), paste(boot_dir, "/covar_", iboot, ".sso", sep = ""))
 #    # other .sso files could be copied as well
 #  }
 #  
  mods <- SSgetoutput(keyvec = paste0("_", seq(1, N_boot)), 
                      dirvec = file.path(boot_dir), verbose = F)
  mvlns <- list()
  
  for(i in 1:length(mods)){
    set.seed(seed)
    try(
    mvlns[[i]] <- ss3diags::SSdeltaMVLN(mods[[i]], mc = 1500, 
                              weight = 1, 
                              run = paste0("boot", i),
                             # bias_correct_mean = T,
                              plot = F,
                              addprj = F)$kb
    , silent=F)
  }
  
  mv <- data.table::rbindlist(mvlns)
  saveRDS(mv, file = file.path(boot_dir, "mvln_draws.rds"))
  

}
