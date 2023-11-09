##This function writes the recruitment section of the Agepro input file


writeRecruitmentSection <- function(Recruitment) {
  cat("[RECRUIT]\n")
  cat(Recruitment$ScaleFactor[2:3], 500, "\n")  # Add a proper explanation for the '500'
  cat(Recruitment$Recr_Model, "\n")
  
  if (Recruitment$Recr_Model %in% c(1, 9)) {
    stop("Recruitment model not supported.")
  }
  
  if (Recruitment$Recr_Model %in% c(2, 3, 4, 15)) {
    cat(Recruitment$Nobs, "\n")
    cat(Recruitment$Recruits, "\n")
  }
  
  if (Recruitment$Recr_Model %in% c(5, 6, 10, 11)) {
    cat(Recruitment$alpha, Recruitment$beta, Recruitment$var, "\n")
    if (Recruitment$Recr_Model %in% c(10, 11)) {
      cat(Recruitment$Phi, Recruitment$LastResid, "\n")
    }
  }
  
  if (Recruitment$Recr_Model %in% c(7, 12)) {
    cat(Recruitment$alpha, Recruitment$beta, Recruitment$Kparm, Recruitment$var, "\n")
    if (Recruitment$Recr_Model == 12) {
      cat(Recruitment$Phi, Recruitment$LastResid, "\n")
    }
  }
  
  if (Recruitment$Recr_Model %in% c(8, 13)) {
    cat(Recruitment$mean, Recruitment$stdev, "\n")
    if (Recruitment$Recr_Model == 13) {
      cat(Recruitment$Phi, Recruitment$LastResid, "\n")
    }
  }
  
  if (Recruitment$Recr_Model == 14) {
    cat(Recruitment$Nobs, "\n")
    cat(Recruitment$Obs, "\n")
  }
  
  if (Recruitment$Recr_Model %in% c(16, 17, 18, 19)) {
    cat(Recruitment$Ncoeff, Recruitment$var, Recruitment$Intercept, "\n")
    cat(Recruitment$Coeff, "\n")
    cat(Recruitment$Observations, "\n")
  }
  
  if (Recruitment$Recr_Model == 20) {
    cat(Recruitment$Data, "\n")
  }
  
  if (Recruitment$Recr_Model == 21) {
    cat(Recruitment$Nobs, "\n")
    cat(Recruitment$Obs, "\n")
    cat(Recruitment$SSBHingeValue, "\n")
  }
}



