#V3.30
#C file created using the SS_writectl function in the R package r4ss
#C file write time: 2023-10-05 10:03:14.829965
#
0 # 0 means do not read wtatage.ss; 1 means read and usewtatage.ss and also read and use growth parameters
1 #_N_Growth_Patterns
1 #_N_platoons_Within_GrowthPattern
4 # recr_dist_method for parameters
1 # not yet implemented; Future usage:Spawner-Recruitment; 1=global; 2=by area
1 # number of recruitment settlement assignments 
0 # unused option
# for each settlement assignment:
#_GPattern	month	area	age
1	7	1	0	#_recr_dist_pattern1
#
#_Cond 0 # N_movement_definitions goes here if N_areas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
3 #_Nblock_Patterns
1 1 2 #_blocks_per_pattern
#_begin and end years of blocks
1994 1996
1994 2003
1994 2000 2001 2007
#
# controls for all timevary parameters 
1 #_env/block/dev_adjust_method for all time-vary parms (1=warn relative to base parm bounds; 3=no bound check)
#
# AUTOGEN
1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen all time-varying parms; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
# setup for M, growth, maturity, fecundity, recruitment distibution, movement
#
3 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=Maunder_M;_6=Age-range_Lorenzen
#_ #_Age_natmort_by sex x growthpattern
#_Age_0	Age_1	Age_2	Age_3	Age_4	Age_5	Age_6	Age_7	Age_8	Age_9	Age_10	Age_11	Age_12	Age_13	Age_14	Age_15
0.42	0.37	0.32	0.27	0.22	0.22	0.22	0.22	0.22	0.22	0.22	0.22	0.22	0.22	0.22	0.22	#_natM1
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr;5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
0.5 #_Age(post-settlement)_for_L1;linear growth below this
15 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0 #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
1 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
#
#_growth_parms
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env_var&link	dev_link	dev_minyr	dev_maxyr	dev_PH	Block	Block_Fxn
   10	     160	   110.9	   40.2	 99	0	-4	0	0	0	0	0	0	0	#_L_at_Amin_Fem_GP_1       
  110	     260	   215.5	 146.46	 99	0	-3	0	0	0	0	0	0	0	#_L_at_Amax_Fem_GP_1       
 0.01	    0.56	  0.2645	  0.149	 99	0	-4	0	0	0	0	0	0	0	#_VonBert_K_Fem_GP_1       
 0.01	     0.3	    0.14	  0.135	 99	0	-3	0	0	0	0	0	0	0	#_CV_young_Fem_GP_1        
 0.01	     0.3	     0.1	   0.05	 99	0	-3	0	0	0	0	0	0	0	#_CV_old_Fem_GP_1          
   -2	       2	4.68e-06	8.7e-05	 99	0	-3	0	0	0	0	0	0	0	#_Wtlen_1_Fem_GP_1         
   -2	       4	    3.16	   3.16	 99	0	-3	0	0	0	0	0	0	0	#_Wtlen_2_Fem_GP_1         
    1	     200	   152.2	      5	 99	0	-3	0	0	0	0	0	0	0	#_Mat50%_Fem_GP_2          
   -5	       5	  -0.204	   -0.2	 99	0	-3	0	0	0	0	0	0	0	#_Mat_slope_Fem_GP_1       
    0	       3	       1	      1	 99	0	-3	0	0	0	0	0	0	0	#_Eggs/kg_inter_Fem_GP_1   
    0	       3	       0	      0	 99	0	-3	0	0	0	0	0	0	0	#_Eggs/kg_slope_wt_Fem_GP_1
   -1	       1	       1	      1	 99	0	-1	0	0	0	0	0	0	0	#_CohortGrowDev            
1e-06	0.999999	     0.5	    0.5	0.5	0	-9	0	0	0	0	0	0	0	#_FracFemale_GP_1          
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; 2=Ricker; 3=std_B-H; 4=SCAA;5=Hockey; 6=B-H_flattop; 7=survival_3Parm;8=Shepard_3Parm
1 # 0/1 to use steepness in initial equ recruitment calculation
1 # future feature: 0/1 to make realized sigmaR a function of SR curvature
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn # parm_name
  3	15	 6.8	   5	99	0	 1	0	0	0	0	0	0	0	#_SR_LN(R0)  
0.2	 1	0.87	0.75	99	0	-4	0	0	0	0	0	0	0	#_SR_BH_steep
  0	 2	 0.6	 0.6	99	0	-1	0	0	0	0	0	0	0	#_SR_sigmaR  
-10	10	   0	   0	99	0	-1	0	0	0	0	0	0	0	#_SR_regime  
  0	 0	   0	   0	99	0	-1	0	0	0	0	0	0	0	#_SR_autocorr
#_no timevary SR parameters
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1994 # first year of main recr_devs; early devs can preceed this era
2020 # last year of main recr_devs; forecast devs start in following year
3 #_recdev phase
1 # (0/1) to read 13 advanced options
1963 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
4 #_recdev_early_phase
0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
1 #_lambda for Fcast_recr_like occurring before endyr+1
1966.9 #_last_yr_nobias_adj_in_MPD; begin of ramp
1994.6 #_first_yr_fullbias_adj_in_MPD; begin of plateau
2019.4 #_last_yr_fullbias_adj_in_MPD
2020.6 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS sets bias_adj to 0.0 for fcast yrs)
0.9422 #_max_bias_adj_in_MPD (-1 to override ramp and set biasadj=1.0 for all estimated recdevs)
0 #_period of cycles in recruitment (N parms read below)
-5 #min rec_dev
5 #max rec_dev
0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
#Fishing Mortality info
2 # F ballpark
-1975 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
4 # max F or harvest rate, depends on F_Method
5 # N iterations for tuning F in hybrid method (recommend 3 to 7)
#
#_initial_F_parms
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE
0	7	1.8	0	99	0	1	#_1
#
#_Q_setup for fleets with cpue or survey data
#_fleet	link	link_info	extra_se	biasadj	float  #  fleetname
   26	1	0	0	0	1	#_1         
   27	1	0	0	0	1	#_2         
   28	1	0	0	0	1	#_3         
   29	1	0	0	0	1	#_4         
   30	1	0	0	0	1	#_5         
   31	1	0	0	0	1	#_6         
-9999	0	0	0	0	0	#_terminator
#_Q_parms(if_any);Qunits_are_ln(q)
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn  #  parm_name
-15	15	-6.14526	0	1	0	-1	0	0	0	0	0	0	0	#_LnQ_base_1
-15	15	 -6.3464	0	1	0	-1	0	0	0	0	0	0	0	#_LnQ_base_2
-15	15	-7.46111	0	1	0	-1	0	0	0	0	0	0	0	#_LnQ_base_3
-15	15	-5.87484	0	1	0	-1	0	0	0	0	0	0	0	#_LnQ_base_4
-15	15	-5.81877	0	1	0	-1	0	0	0	0	0	0	0	#_LnQ_base_5
-15	15	-6.01675	0	1	0	-1	0	0	0	0	0	0	0	#_LnQ_base_6
#_no timevary Q parameters
#
#_size_selex_patterns
#_Pattern	Discard	Male	Special
24	0	0	 0	#_1 1  
24	0	0	 0	#_2 2  
15	0	0	 2	#_3 3  
24	0	0	 0	#_4 4  
24	0	0	 0	#_5 5  
24	0	0	 0	#_6 6  
15	0	0	 2	#_7 7  
15	0	0	 4	#_8 8  
15	0	0	 5	#_9 9  
15	0	0	 6	#_10 10
15	0	0	 6	#_11 11
15	0	0	 4	#_12 12
 1	0	0	 0	#_13 13
 1	0	0	 0	#_14 14
15	0	0	 4	#_15 15
24	0	0	 0	#_16 16
15	0	0	16	#_17 17
 1	0	0	 0	#_18 18
15	0	0	18	#_19 19
15	0	0	14	#_20 20
15	0	0	12	#_21 21
15	0	0	 1	#_22 22
15	0	0	 5	#_23 23
15	0	0	 1	#_24 24
15	0	0	 5	#_25 25
15	0	0	 1	#_26 26
15	0	0	 5	#_27 27
15	0	0	16	#_28 28
15	0	0	18	#_29 29
15	0	0	 1	#_30 30
15	0	0	 5	#_31 31
#
#_age_selex_patterns
#_Pattern	Discard	Male	Special
0	0	0	0	#_1 1  
0	0	0	0	#_2 2  
0	0	0	0	#_3 3  
0	0	0	0	#_4 4  
0	0	0	0	#_5 5  
0	0	0	0	#_6 6  
0	0	0	0	#_7 7  
0	0	0	0	#_8 8  
0	0	0	0	#_9 9  
0	0	0	0	#_10 10
0	0	0	0	#_11 11
0	0	0	0	#_12 12
0	0	0	0	#_13 13
0	0	0	0	#_14 14
0	0	0	0	#_15 15
0	0	0	0	#_16 16
0	0	0	0	#_17 17
0	0	0	0	#_18 18
0	0	0	0	#_19 19
0	0	0	0	#_20 20
0	0	0	0	#_21 21
0	0	0	0	#_22 22
0	0	0	0	#_23 23
0	0	0	0	#_24 24
0	0	0	0	#_25 25
0	0	0	0	#_26 26
0	0	0	0	#_27 27
0	0	0	0	#_28 28
0	0	0	0	#_29 29
0	0	0	0	#_30 30
0	0	0	0	#_31 31
#
#_SizeSelex
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn  #  parm_name
53.025	227.5	  167.498	 200	99	0	 2	0	0	0	0	0	1	2	#_1 
   -10	    6	 -9.62625	  -8	99	0	-3	0	0	0	0	0	1	2	#_2 
    -1	   15	   5.8107	   6	99	0	 3	0	0	0	0	0	1	2	#_3 
    -1	   15	  6.18698	   6	99	0	 3	0	0	0	0	0	1	2	#_4 
  -999	 -999	     -999	-999	99	0	-2	0	0	0	0	0	0	0	#_5 
  -999	 -999	     -999	-999	99	0	-2	0	0	0	0	0	0	0	#_6 
53.025	227.5	  156.902	 150	99	0	 2	0	0	0	0	0	0	0	#_7 
   -10	    4	 -9.71696	 -10	99	0	-3	0	0	0	0	0	0	0	#_8 
    -1	    9	  6.04797	   6	99	0	 3	0	0	0	0	0	0	0	#_9 
    -1	    9	   6.4352	 5.5	99	0	 3	0	0	0	0	0	0	0	#_10
  -999	 -999	     -999	-999	99	0	-2	0	0	0	0	0	0	0	#_11
  -999	 -999	     -999	-999	99	0	-2	0	0	0	0	0	0	0	#_12
53.025	227.5	  170.119	 150	99	0	 2	0	0	0	0	0	0	0	#_13
   -10	    4	 -9.51824	 -10	99	0	-3	0	0	0	0	0	0	0	#_14
    -1	    9	   6.8104	   6	99	0	 3	0	0	0	0	0	0	0	#_15
    -1	   18	  6.62346	 5.5	99	0	 3	0	0	0	0	0	0	0	#_16
  -999	 -999	     -999	-999	99	0	-2	0	0	0	0	0	0	0	#_17
  -999	 -999	     -999	-999	99	0	-2	0	0	0	0	0	0	0	#_18
53.025	227.5	  145.868	 200	99	0	 2	0	0	0	0	0	0	0	#_19
   -10	    6	 -9.13068	  -8	99	0	-3	0	0	0	0	0	0	0	#_20
    -1	    9	  6.03993	   6	99	0	 3	0	0	0	0	0	0	0	#_21
    -1	    9	      5.8	   6	99	0	 3	0	0	0	0	0	0	0	#_22
  -999	 -999	     -999	-999	99	0	-2	0	0	0	0	0	0	0	#_23
  -999	 -999	     -999	-999	99	0	-2	0	0	0	0	0	0	0	#_24
53.025	227.5	  153.364	 138	99	0	 2	0	0	0	0	0	0	0	#_25
   -12	    4	  -11.145	  -8	99	0	-3	0	0	0	0	0	0	0	#_26
    -1	    9	  5.95168	 5.5	99	0	 3	0	0	0	0	0	0	0	#_27
    -1	    9	   6.2118	 5.5	99	0	 3	0	0	0	0	0	0	0	#_28
  -999	 -999	     -999	-999	99	0	-2	0	0	0	0	0	0	0	#_29
  -999	 -999	     -999	-999	99	0	-2	0	0	0	0	0	0	0	#_30
53.025	227.5	  157.044	 170	99	0	 2	0	0	0	0	0	0	0	#_31
   0.1	   30	  12.2447	  10	99	0	 3	0	0	0	0	0	0	0	#_32
53.025	227.5	  144.642	 170	99	0	 2	0	0	0	0	0	0	0	#_33
   0.1	   50	  26.9187	  30	99	0	 3	0	0	0	0	0	0	0	#_34
53.025	227.5	  120.737	 143	99	0	 2	0	0	0	0	0	3	2	#_35
    -8	    4	-0.319125	  -7	99	0	-3	0	0	0	0	0	3	2	#_36
    -1	    9	  5.64836	   7	99	0	 3	0	0	0	0	0	3	2	#_37
   -15	    9	  5.90677	 6.5	99	0	 3	0	0	0	0	0	3	2	#_38
  -999	 -999	     -999	-999	99	0	-2	0	0	0	0	0	0	0	#_39
  -999	 -999	     -999	-999	99	0	-2	0	0	0	0	0	0	0	#_40
53.025	227.5	  157.044	 170	99	0	 2	0	0	0	0	0	0	0	#_41
   0.1	  100	  12.2447	  10	99	0	 3	0	0	0	0	0	0	0	#_42
#_AgeSelex
#_No age_selex_parm
# timevary selex parameters 
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE
53.025	227.5	  167.498	200	99	0	 2	#_1 
   -10	    6	 -9.62625	 -8	99	0	-3	#_2 
    -1	    9	   5.8107	  6	99	0	 3	#_3 
    -1	   15	  6.18698	  6	99	0	 3	#_4 
53.025	227.5	  120.737	143	99	0	 2	#_5 
53.025	227.5	  120.737	143	99	0	 2	#_6 
    -8	    4	-0.319125	 -7	99	0	-3	#_7 
    -8	    4	-0.319125	 -7	99	0	-3	#_8 
    -1	    9	  5.64836	  7	99	0	 3	#_9 
    -1	    9	  5.64836	  7	99	0	 3	#_10
   -15	    9	  5.90677	6.5	99	0	 3	#_11
   -15	    9	  5.90677	6.5	99	0	 3	#_12
# info on dev vectors created for selex parms are reported with other devs after tag parameter section
#
0 #  use 2D_AR1 selectivity(0/1):  experimental feature
#_no 2D_AR1 selex offset used
# Tag loss and Tag reporting parameters go next
0 # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# Input variance adjustments factors: 
#_factor	fleet	Value
1    	26	 0.0116574	#_2         
1    	27	         0	#_3         
1    	28	0.00937983	#_4         
1    	29	 0.0982327	#_5         
1    	30	         0	#_6         
1    	31	         0	#_7         
-9999	0 	         0	#_terminator
#
6 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 17 changes to default Lambdas (default value is 1.0)
#_likecomp	fleet	phase	value	sizefreq
    1	26	1	1	1	#_1         
    1	27	1	1	1	#_2         
    1	28	1	0	1	#_3         
    1	29	1	1	1	#_4         
    1	30	1	1	1	#_5         
    1	31	1	0	1	#_6         
    4	 1	1	1	1	#_7         
    4	 2	1	1	1	#_8         
    4	 4	1	1	1	#_9         
    4	 5	1	1	1	#_10        
    4	 6	1	1	1	#_11        
    4	13	1	1	1	#_12        
    4	14	1	1	1	#_13        
    4	16	1	1	1	#_14        
    4	18	1	1	1	#_15        
    9	 4	1	0	0	#_16        
   10	 1	1	1	1	#_17        
-9999	 0	0	0	0	#_terminator
#
0 # 0/1 read specs for more stddev reporting
#
999
