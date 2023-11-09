##plot APSM results using r4ss
#set working directory
# wd=c("C:\\Users\\Michelle.Sculley\\Documents\\2022 MLS ASSESS\\send20220204\\MLS_2022SA_000\\US Time Block\\R0_Prof")
# setwd(paste0(base.dir,"\\ModelDev\\NoSex\\TWN block\\JPN F1 block\\DW Size comp\\R0_Prof"))
# ## devtools::install_github("r4ss/r4ss") # to update r4ss
# ## load r4ss
 library(r4ss)
# ## load the model
# base.model<-SS_output(getwd())
# ## plot the model
# SS_plots(base.model, pdf = TRUE, png = FALSE, html=FALSE)
# 
 setwd(paste0(current.dir,"\\R0_Prof"))



### Running R0 Profile:
## 1. Make a folder called R0_Prof
## 2. Inside put the complete model into a folder called orig.
## 3. in the control file set the phase for the R0 parameter to -1
## 4. in the starter file make sure the option to use the par file is 1
## 5. update the working directories in run_R0_parallel.R and plot_r0_profile.r
## 6. at the end of this file, ensure the location of plot_r0_profile.r is correct
## 7. in the R0_Prof folder, make a folder call 00_mle, put the files from orig into 00_mle



rm(list=ls())

library('foreach')
#library('doMC') # Comment out for windows
 library('doSNOW') # Uncomment for Windows

parm.min <- 6.2
parm.max <-7.8
parm.step <- 0.1
parmstr.parfile <- '# SR_parm\\[1]:' # Note that you need to add double backslash for escape character for grep
parfile <- 'ss.par'
ssdir.orig <- 'orig'

numcpus <- 8
#runss.str <- './SS324ab.bin -nohess -nox' # Comment out for windows
runss.str <- 'ss.exe -nohess -nox' # Uncomment for Windows

origwd <- getwd()

parm.vec <- seq(parm.min, parm.max, parm.step)
numdir <- length(parm.vec)

for (ii in 1:numdir) {
	dir.name <- paste(sprintf('%02d',ii),sprintf('%.2f',parm.vec[ii]),sep='_')
#	system(paste('cp -r', ssdir.orig, dir.name, sep=' ')) # Comment out for windows
	 system(paste('xcopy ', ssdir.orig, ' ', dir.name, '\\* ', '/E', sep='')) # Uncomment for Windows
	
	parfile.infile <- paste(dir.name,'/',parfile, sep='')
	conn <- file(parfile.infile, open='r')
	parfile.intxt <- readLines(conn)
	close(conn)
	parfile.outtxt <- parfile.intxt
	wantedline <- grep(parmstr.parfile,parfile.intxt)
	parfile.outtxt[wantedline+1] <-  parm.vec[ii]
	conn <- file(parfile.infile, open='w')
	writeLines(parfile.outtxt, conn)
	close(conn)	
}
#registerDoMC(numcpus) # Comment out for windows

 cl<-makeCluster(numcpus) # Uncomment for Windows
 registerDoSNOW(cl) # Uncomment for Windows

foreach(ii=1:numdir) %dopar% {
	dir.name <- paste(sprintf('%02d',ii),sprintf('%.2f',parm.vec[ii]),sep='_')
	setwd(paste(origwd,'/',dir.name,sep=''))
	print(paste(origwd,'/',dir.name,sep=''))
	system(runss.str)
	setwd(origwd)
}
	
 stopCluster(cl) # Uncomment for Windows
	
setwd(origwd) 

#setwd(paste(origwd,'/00_mle',sep=''))
#system(runss.str)
#setwd(origwd)

##make sure 
source('C:\\Users\\Michelle.Sculley\\Documents\\2022 MLS ASSESS\\send20220204\\MLS_2022SA_000\\US Time Block\\Adjust Recruit Devs\\US CPUE Time Block\\R0_Prof\\plot_r0_profile.r')
