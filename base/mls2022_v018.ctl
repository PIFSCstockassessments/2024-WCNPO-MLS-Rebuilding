#V3.30.18.00;_safe;_compile_date:_Sep 30 2021;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis

#_data_and_control_files: MLS2022_v001.dat // MLS2022_v006.ctl
0 # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1 #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_within/between_stdev_ratio (no read if N_platoons=1)
#_Cond 1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters: 2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
1 # number of recruitment settlement assignments 
0 # unused option
#GPattern month area age (for each settlement assignment)
 1 7 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
3 #_Nblock_Patterns
 1 1 2 #_blocks_per_pattern 
# begin and end years of blocks
 1994 1996 # 1997 2003
 1994 2003
1994 2000 2001 2007
#
# controls for all timevary parameters 
1 #_time-vary parm bound check (1=warn relative to base parm bounds; 3=no bound check); Also see env (3) and dev (5) options to constrain with base bounds
#
# AUTOGEN
 1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen time-varying parms of this category; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks: 1: P(y)=P_base*exp(TVP*env(y)); 2: P(y)=P_base+TVP*env(y); 3: P(y)=f(TVP,env_Zscore) w/ logit to stay in min-max; 4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks: 1: P(y)*=exp(dev(y)*dev_se; 2: P(y)+=dev(y)*dev_se; 3: random walk; 4: zero-reverting random walk with rho; 5: like 4 with logit transform to stay in base min-max
#_DevLinks(more): 21-25 keep last dev for rest of years
#
#_Prior_codes: 0=none; 6=normal; 1=symmetric beta; 2=CASAL's beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
#
# setup for M, growth, wt-len, maturity, fecundity, (hermaphro), recr_distr, cohort_grow, (movement), (age error), (catch_mult), sex ratio 
#_NATMORT
3 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=BETA:_Maunder_link_to_maturity
 #_Age_natmort_by sex x growthpattern (nest GP in sex)
 0.54 0.47 0.43 0.4 0.38 0.38 0.38 0.38 0.38 0.38 0.38 0.38 0.38 0.38 0.38 0.38
#
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
0.5 #_Age(post-settlement)_for_L1;linear growth below this
15 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0 #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern: 0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option: 1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
1 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option: 0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach for M, G, CV_G: 1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1 BioPattern: 1 NatMort
# Sex: 1 BioPattern: 1 Growth
10 160 110.9 40.2 99 0 -4 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 110 260 215.5 146.46 99 0 -3 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0.01 0.56 0.2645 0.149 99 0 -4 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0.01 0.3 0.14 0.135 99 0 -3 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0.01 0.3 0.10 0.05 99 0 -3 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
# Sex: 1 BioPattern: 1 WtLen
 -2 2 4.68e-06 8.7e-05 99 0 -3 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 -2 4 3.16 3.16 99 0 -3 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1 BioPattern: 1 Maturity&Fecundity
 1 200 152.2 5 99 0 -3 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -5 5 -0.204 -0.2 99 0 -3 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 0 3 1 1 99 0 -3 0 0 0 0 0 0 0 # Eggs/kg_inter_Fem_GP_1
 0 3 0 0 99 0 -3 0 0 0 0 0 0 0 # Eggs/kg_slope_wt_Fem_GP_1
# Hermaphroditism
# Recruitment Distribution 
# Cohort growth dev base
 -1 1 1 1 99 0 -1 0 0 0 0 0 0 0 # CohortGrowDev
# Movement
# Age Error from parameters
# catch multiplier
# fraction female, by GP
 1e-06 0.999999 0.5 0.5 0.5 0 -9 0 0 0 0 0 0 0 # FracFemale_GP_1
# M2 parameter for each predator fleet
#
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 1=NA; 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
1 # 0/1 to use steepness in initial equ recruitment calculation
0 # future feature: 0/1 to make realized sigmaR a function of SR curvature
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env-var use_dev dev_mnyr dev_mxyr dev_PH Block Blk_Fxn # parm_name
 3 15 6.8 5 99 0 1 0 0 0 0 0 0 0 # SR_LN(R0)
 0.2 1 0.87 0.75 99 0 -4 0 0 0 0 0 0 0 # SR_BH_steep
 0 2 0.6 0.6 99 0 -1 0 0 0 0 0 0 0 # SR_sigmaR
 -10 10 0 0 99 0 -1 0 0 0 0 0 0 0 # SR_regime
 0 0 0 0 99 0 -1 0 0 0 0 0 0 0 # SR_autocorr
#_no timevary SR parameters
1 #do_recdev: 0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
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
 0.9422 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
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
# all recruitment deviations
# 1960E 1961E 1962E 1963E 1964E 1965E 1966E 1967E 1968E 1969E 1970E 1971E 1972E 1973E 1974E 1975R 1976R 1977R 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017R 2018R 2019R 2020R
# 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0#
#Fishing Mortality info 
2 # F ballpark value in units of annual_F
-1975 # F ballpark year (neg value to disable)
3 # F_Method: 1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
4 # max F (methods 2-4) or harvest fraction (method 1)
5 # N iterations for tuning in hybrid mode; recommend 3 (faster) to 5 (more precise if many fleets)
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 1
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
 0 7 1.8 0 99 0 1 # InitF_seas_2_flt_4F04_JPNLL_Q2A1
#
# F rates by fleet x season
#
#_Q_setup for fleets with cpue or survey data
#_1: fleet number
#_2: link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3: extra input for link, i.e. mirror fleet# or dev index number
#_4: 0/1 to select extra sd parameter
#_5: 0/1 for biasadj or not
#_6: 0/1 to float
#_ fleet link link_info extra_se biasadj float # fleetname
 26 1 0 0 0 1 # S01_JPNLL_Q1A1_Late
 27 1 0 0 0 1 # S02_JPNLL_Q3A1_Late
 28 1 0 0 0 1 # S03_US_LL
 29 1 0 0 0 1 # S04_TWN_DWLL
 30 1 0 0 0 1 # S05_JPNLL_Q1A1_Early
 31 1 0 0 0 1 # S06_JPNLL_Q3A1_Early
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env-var use_dev dev_mnyr dev_mxyr dev_PH Block Blk_Fxn # parm_name
 -15 15 -6.14526 0 1 0 -1 0 0 0 0 0 0 0 # LnQ_base_S01_JPNLL_Q1A1_Late(26)
 -15 15 -6.3464 0 1 0 -1 0 0 0 0 0 0 0 # LnQ_base_S02_JPNLL_Q3A1_Late(27)
 -15 15 -7.46111 0 1 0 -1 0 0 0 0 0 0 0 # LnQ_base_S03_US_LL(28)
 -15 15 -5.87484 0 1 0 -1 0 0 0 0 0 0 0 # LnQ_base_S04_TWN_DWLL(29)
 -15 15 -5.81877 0 1 0 -1 0 0 0 0 0 0 0 # LnQ_base_S05_JPNLL_Q1A1_Early(30)
 -15 15 -6.01675 0 1 0 -1 0 0 0 0 0 0 0 # LnQ_base_S06_JPNLL_Q3A1_Early(31)
#_no timevary Q parameters
#
#_size_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for all sizes
#Pattern:_1; parm=2; logistic; with 95% width specification
#Pattern:_2; parm=6; modification of pattern 24 with improved sex-specific offset
#Pattern:_5; parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_11; parm=2; selex=1.0 for specified min-max population length bin range
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6; parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2; like 6, with 2 additional param for scaling (average over bin range)
#Pattern:_8; parm=8; double_logistic with smooth transitions and constant above Linf option
#Pattern:_9; parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_25; parm=3; exponential-logistic in length
#Pattern:_27; parm=special+3; cubic spline in length; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=special+3+2; cubic spline; like 27, with 2 additional param for scaling (average over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 24 0 0 0 # 1 F01_JPNLL_Q1A1_Late
 24 0 0 0 # 2 F02_JPNLL_Q1A2
 15 0 0 2 # 3 F03_JPNLL_Q1A3
 24 0 0 0 # 4 F04_JPNLL_Q2A1
 24 0 0 0 # 5 F05_JPNLL_Q3A1_Late
 24 0 0 0 # 6 F06_JPNLL_Q4A1
 15 0 0 2 # 7 F07_JPNLL_Q1A4
 15 0 0 4 # 8 F08_JPNLL_Q2A2
 15 0 0 5 # 9 F09_JPNLL_Q3A2
 15 0 0 6 # 10 F10_JPNLL_Q4A2
 15 0 0 6 # 11 F11_JPNLL_Q4A3
 15 0 0 4 # 12 F12_JPNLL_Others
 1 0 0 0 # 13 F13_JPNDF_Q14_EarlyLate
 1 0 0 0 # 14 F14_JPNDF_Q23_EarlyLate
 15 0 0 4 # 15 F15_JPN_Others
 24 0 0 0 # 16 F16_US_LL
 15 0 0 16 # 17 F17_US_Others
 1 0 0 0 # 18 F18_TWN_DWLL
 15 0 0 18 # 19 F19_TWN_STLL
 15 0 0 14 # 20 F20_TWN_Others
 15 0 0 12 # 21 F21_WCPFC_Others
 15 0 0 1 # 22 F22_JPNLL_Q1A1_Early
 15 0 0 5 # 23 F23_JPNLL_Q3A1_Early
 15 0 0 1 # 24 F24_JPNDF_Q14_Mid
 15 0 0 5 # 25 F25_JPNDF_Q23_Mid
 15 0 0 1 # 26 S01_JPNLL_Q1A1_Late
 15 0 0 5 # 27 S02_JPNLL_Q3A1_Late
 15 0 0 16 # 28 S03_US_LL
 15 0 0 18 # 29 S04_TWN_DWLL
 15 0 0 1 # 30 S05_JPNLL_Q1A1_Early
 15 0 0 5 # 31 S06_JPNLL_Q3A1_Early
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0 for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (average over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (average over bin range)
#Age patterns entered with value >100 create Min_selage from first digit and pattern from remainder
#_Pattern Discard Male Special
 0 0 0 0 # 1 F01_JPNLL_Q1A1_Late
 0 0 0 0 # 2 F02_JPNLL_Q1A2
 0 0 0 0 # 3 F03_JPNLL_Q1A3
 0 0 0 0 # 4 F04_JPNLL_Q2A1
 0 0 0 0 # 5 F05_JPNLL_Q3A1_Late
 0 0 0 0 # 6 F06_JPNLL_Q4A1
 0 0 0 0 # 7 F07_JPNLL_Q1A4
 0 0 0 0 # 8 F08_JPNLL_Q2A2
 0 0 0 0 # 9 F09_JPNLL_Q3A2
 0 0 0 0 # 10 F10_JPNLL_Q4A2
 0 0 0 0 # 11 F11_JPNLL_Q4A3
 0 0 0 0 # 12 F12_JPNLL_Others
 0 0 0 0 # 13 F13_JPNDF_Q14_EarlyLate
 0 0 0 0 # 14 F14_JPNDF_Q23_EarlyLate
 0 0 0 0 # 15 F15_JPN_Others
 0 0 0 0 # 16 F16_US_LL
 0 0 0 0 # 17 F17_US_Others
 0 0 0 0 # 18 F18_TWN_DWLL
 0 0 0 0 # 19 F19_TWN_STLL
 0 0 0 0 # 20 F20_TWN_Others
 0 0 0 0 # 21 F21_WCPFC_Others
 0 0 0 0 # 22 F22_JPNLL_Q1A1_Early
 0 0 0 0 # 23 F23_JPNLL_Q3A1_Early
 0 0 0 0 # 24 F24_JPNDF_Q14_Mid
 0 0 0 0 # 25 F25_JPNDF_Q23_Mid
 0 0 0 0 # 26 S01_JPNLL_Q1A1_Late
 0 0 0 0 # 27 S02_JPNLL_Q3A1_Late
 0 0 0 0 # 28 S03_US_LL
 0 0 0 0 # 29 S04_TWN_DWLL
 0 0 0 0 # 30 S05_JPNLL_Q1A1_Early
 0 0 0 0 # 31 S06_JPNLL_Q3A1_Early
#
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env-var use_dev dev_mnyr dev_mxyr dev_PH Block Blk_Fxn # parm_name
# 1 F01_JPNLL_Q1A1_Late LenSelex
 53.025 227.5 167.498 200 99 0 2 0 0 0 0 0 1 2 # Size_DblN_peak_F01_JPNLL_Q1A1_Late(1)
 -10 6 -9.62625 -8 99 0 -3 0 0 0 0 0 1 2 # Size_DblN_top_logit_F01_JPNLL_Q1A1_Late(1)
 -1 15 5.8107 6 99 0 3 0 0 0 0 0 1 2 # Size_DblN_ascend_se_F01_JPNLL_Q1A1_Late(1)
 -1 15 6.18698 6 99 0 3 0 0 0 0 0 1 2 # Size_DblN_descend_se_F01_JPNLL_Q1A1_Late(1)
 -999 -999 -999 -999 99 0 -2 0 0 0 0 0 0 0 # Size_DblN_start_logit_F01_JPNLL_Q1A1_Late(1)
 -999 -999 -999 -999 99 0 -2 0 0 0 0 0 0 0 # Size_DblN_end_logit_F01_JPNLL_Q1A1_Late(1)
# 2 F02_JPNLL_Q1A2 LenSelex
 53.025 227.5 156.902 150 99 0 2 0 0 0 0 0 0 0 # Size_DblN_peak_F02_JPNLL_Q1A2(2)
 -10 4 -9.71696 -10 99 0 -3 0 0 0 0 0 0 0 # Size_DblN_top_logit_F02_JPNLL_Q1A2(2)
 -1 9 6.04797 6 99 0 3 0 0 0 0 0 0 0 # Size_DblN_ascend_se_F02_JPNLL_Q1A2(2)
 -1 9 6.4352 5.5 99 0 3 0 0 0 0 0 0 0 # Size_DblN_descend_se_F02_JPNLL_Q1A2(2)
 -999 -999 -999 -999 99 0 -2 0 0 0 0 0 0 0 # Size_DblN_start_logit_F02_JPNLL_Q1A2(2)
 -999 -999 -999 -999 99 0 -2 0 0 0 0 0 0 0 # Size_DblN_end_logit_F02_JPNLL_Q1A2(2)
# 3 F03_JPNLL_Q1A3 LenSelex
# 4 F04_JPNLL_Q2A1 LenSelex
 53.025 227.5 170.119 150 99 0 2 0 0 0 0 0 0 0 # Size_DblN_peak_F04_JPNLL_Q2A1(4)
 -10 4 -9.51824 -10 99 0 -3 0 0 0 0 0 0 0 # Size_DblN_top_logit_F04_JPNLL_Q2A1(4)
 -1 9 6.8104 6 99 0 3 0 0 0 0 0 0 0 # Size_DblN_ascend_se_F04_JPNLL_Q2A1(4)
 -1 18 6.62346 5.5 99 0 3 0 0 0 0 0 0 0 # Size_DblN_descend_se_F04_JPNLL_Q2A1(4)
 -999 -999 -999 -999 99 0 -2 0 0 0 0 0 0 0 # Size_DblN_start_logit_F04_JPNLL_Q2A1(4)
 -999 -999 -999 -999 99 0 -2 0 0 0 0 0 0 0 # Size_DblN_end_logit_F04_JPNLL_Q2A1(4)
# 5 F05_JPNLL_Q3A1_Late LenSelex
 53.025 227.5 145.868 200 99 0 2 0 0 0 0 0 0 0 # Size_DblN_peak_F05_JPNLL_Q3A1_Late(5)
 -10 6 -9.13068 -8 99 0 -3 0 0 0 0 0 0 0 # Size_DblN_top_logit_F05_JPNLL_Q3A1_Late(5)
 -1 9 6.03993 6 99 0 3 0 0 0 0 0 0 0 # Size_DblN_ascend_se_F05_JPNLL_Q3A1_Late(5)
 -1 9 5.8 6 99 0 3 0 0 0 0 0 0 0 # Size_DblN_descend_se_F05_JPNLL_Q3A1_Late(5)
 -999 -999 -999 -999 99 0 -2 0 0 0 0 0 0 0 # Size_DblN_start_logit_F05_JPNLL_Q3A1_Late(5)
 -999 -999 -999 -999 99 0 -2 0 0 0 0 0 0 0 # Size_DblN_end_logit_F05_JPNLL_Q3A1_Late(5)
# 6 F06_JPNLL_Q4A1 LenSelex
 53.025 227.5 153.364 138 99 0 2 0 0 0 0 0 0 0 # Size_DblN_peak_F06_JPNLL_Q4A1(6)
 -12 4 -11.145 -8 99 0 -3 0 0 0 0 0 0 0 # Size_DblN_top_logit_F06_JPNLL_Q4A1(6)
 -1 9 5.95168 5.5 99 0 3 0 0 0 0 0 0 0 # Size_DblN_ascend_se_F06_JPNLL_Q4A1(6)
 -1 9 6.2118 5.5 99 0 3 0 0 0 0 0 0 0 # Size_DblN_descend_se_F06_JPNLL_Q4A1(6)
 -999 -999 -999 -999 99 0 -2 0 0 0 0 0 0 0 # Size_DblN_start_logit_F06_JPNLL_Q4A1(6)
 -999 -999 -999 -999 99 0 -2 0 0 0 0 0 0 0 # Size_DblN_end_logit_F06_JPNLL_Q4A1(6)
# 7 F07_JPNLL_Q1A4 LenSelex
# 8 F08_JPNLL_Q2A2 LenSelex
# 9 F09_JPNLL_Q3A2 LenSelex
# 10 F10_JPNLL_Q4A2 LenSelex
# 11 F11_JPNLL_Q4A3 LenSelex
# 12 F12_JPNLL_Others LenSelex
# 13 F13_JPNDF_Q14_EarlyLate LenSelex
 53.025 227.5 157.044 170 99 0 2 0 0 0 0 0 0 0 # Size_inflection_F13_JPNDF_Q14_EarlyLate(13)
 0.1 30 12.2447 10 99 0 3 0 0 0 0 0 0 0 # Size_95%width_F13_JPNDF_Q14_EarlyLate(13)
# 14 F14_JPNDF_Q23_EarlyLate LenSelex
 53.025 227.5 144.642 170 99 0 2 0 0 0 0 0 0 0 # Size_inflection_F14_JPNDF_Q23_EarlyLate(14)
 0.1 50 26.9187 30 99 0 3 0 0 0 0 0 0 0 # Size_95%width_F14_JPNDF_Q23_EarlyLate(14)
# 15 F15_JPN_Others LenSelex
# 16 F16_US_LL LenSelex
 53.025 227.5 120.737 143 99 0 2 0 0 0 0 0 3 2 # Size_DblN_peak_F16_US_LL(16)
 -8 4 -0.319125 -7 99 0 -3 0 0 0 0 0 3 2 # Size_DblN_top_logit_F16_US_LL(16)
 -1 9 5.64836 7 99 0 3 0 0 0 0 0 3 2 # Size_DblN_ascend_se_F16_US_LL(16)
 -15 9 5.90677 6.5 99 0 3 0 0 0 0 0 3 2 # Size_DblN_descend_se_F16_US_LL(16)
 -999 -999 -999 -999 99 0 -2 0 0 0 0 0 0 0 # Size_DblN_start_logit_F16_US_LL(16)
 -999 -999 -999 -999 99 0 -2 0 0 0 0 0 0 0 # Size_DblN_end_logit_F16_US_LL(16)
# 17 F17_US_Others LenSelex
# 18 F18_TWN_DWLL LenSelex
 53.025 227.5 157.044 170 99 0 2 0 0 0 0 0 0 0 # Size_inflection_F18_TWN_DWLL(18)
 0.1 100 12.2447 10 99 0 3 0 0 0 0 0 0 0 # Size_95%width_F18_TWN_DWLL(18)
# 19 F19_TWN_STLL LenSelex
# 20 F20_TWN_Others LenSelex
# 21 F21_WCPFC_Others LenSelex
# 22 F22_JPNLL_Q1A1_Early LenSelex
# 23 F23_JPNLL_Q3A1_Early LenSelex
# 24 F24_JPNDF_Q14_Mid LenSelex
# 25 F25_JPNDF_Q23_Mid LenSelex
# 26 S01_JPNLL_Q1A1_Late LenSelex
# 27 S02_JPNLL_Q3A1_Late LenSelex
# 28 S03_US_LL LenSelex
# 29 S04_TWN_DWLL LenSelex
# 30 S05_JPNLL_Q1A1_Early LenSelex
# 31 S06_JPNLL_Q3A1_Early LenSelex
# 1 F01_JPNLL_Q1A1_Late AgeSelex
# 2 F02_JPNLL_Q1A2 AgeSelex
# 3 F03_JPNLL_Q1A3 AgeSelex
# 4 F04_JPNLL_Q2A1 AgeSelex
# 5 F05_JPNLL_Q3A1_Late AgeSelex
# 6 F06_JPNLL_Q4A1 AgeSelex
# 7 F07_JPNLL_Q1A4 AgeSelex
# 8 F08_JPNLL_Q2A2 AgeSelex
# 9 F09_JPNLL_Q3A2 AgeSelex
# 10 F10_JPNLL_Q4A2 AgeSelex
# 11 F11_JPNLL_Q4A3 AgeSelex
# 12 F12_JPNLL_Others AgeSelex
# 13 F13_JPNDF_Q14_EarlyLate AgeSelex
# 14 F14_JPNDF_Q23_EarlyLate AgeSelex
# 15 F15_JPN_Others AgeSelex
# 16 F16_US_LL AgeSelex
# 17 F17_US_Others AgeSelex
# 18 F18_TWN_DWLL AgeSelex
# 19 F19_TWN_STLL AgeSelex
# 20 F20_TWN_Others AgeSelex
# 21 F21_WCPFC_Others AgeSelex
# 22 F22_JPNLL_Q1A1_Early AgeSelex
# 23 F23_JPNLL_Q3A1_Early AgeSelex
# 24 F24_JPNDF_Q14_Mid AgeSelex
# 25 F25_JPNDF_Q23_Mid AgeSelex
# 26 S01_JPNLL_Q1A1_Late AgeSelex
# 27 S02_JPNLL_Q3A1_Late AgeSelex
# 28 S03_US_LL AgeSelex
# 29 S04_TWN_DWLL AgeSelex
# 30 S05_JPNLL_Q1A1_Early AgeSelex
# 31 S06_JPNLL_Q3A1_Early AgeSelex
#_No_Dirichlet parameters
# timevary selex parameters 
#_ LO HI INIT PRIOR PR_SD PR_type PHASE # parm_name
 53.025 227.5 167.498 200 99 0 2 # Size_DblN_peak_F01_JPNLL_Q1A1_Late(1)_BLK1repl_1994
# 53.025 227.5 167.498 200 99 0 2 # Size_DblN_peak_F01_JPNLL_Q1A1_Late(1)_BLK1repl_1997
 -10 6 -9.62625 -8 99 0 -3 # Size_DblN_top_logit_F01_JPNLL_Q1A1_Late(1)_BLK1repl_1994
# -10 6 -9.62625 -8 99 0 -3 # Size_DblN_top_logit_F01_JPNLL_Q1A1_Late(1)_BLK1repl_1997
 -1 9 5.8107 6 99 0 3 # Size_DblN_ascend_se_F01_JPNLL_Q1A1_Late(1)_BLK1repl_1994
# -1 9 5.8107 6 99 0 3 # Size_DblN_ascend_se_F01_JPNLL_Q1A1_Late(1)_BLK1repl_1997
 -1 15 6.18698 6 99 0 3 # Size_DblN_descend_se_F01_JPNLL_Q1A1_Late(1)_BLK1repl_1994
# -1 9 6.18698 6 99 0 3 # Size_DblN_descend_se_F01_JPNLL_Q1A1_Late(1)_BLK1repl_1997
# 53.025 227.5 145.868 200 99 0 2 # Size_DblN_peak_F05_JPNLL_Q3A1_Late(5)_BLK2repl_1994
# -10 6 -9.13068 -8 99 0 -3 # Size_DblN_top_logit_F05_JPNLL_Q3A1_Late(5)_BLK2repl_1994
# -1 9 6.03993 6 99 0 3 # Size_DblN_ascend_se_F05_JPNLL_Q3A1_Late(5)_BLK2repl_1994
# -1 9 5.8 6 99 0 3 # Size_DblN_descend_se_F05_JPNLL_Q3A1_Late(5)_BLK2repl_1994
 53.025 227.5 120.737 143 99 0 2 # Size_DblN_peak_F16_US_LL(16)_BLK3repl_1994
 53.025 227.5 120.737 143 99 0 2 # Size_DblN_peak_F16_US_LL(16)_BLK3repl_1994
 -8 4 -0.319125 -7 99 0 -3 # Size_DblN_top_logit_F16_US_LL(16)_BLK3repl_1994
 -8 4 -0.319125 -7 99 0 -3 # Size_DblN_top_logit_F16_US_LL(16)_BLK3repl_1994
 -1 9 5.64836 7 99 0 3 # Size_DblN_ascend_se_F16_US_LL(16)_BLK3repl_1994
 -1 9 5.64836 7 99 0 3 # Size_DblN_ascend_se_F16_US_LL(16)_BLK3repl_1994
 -15 9 5.90677 6.5 99 0 3 # Size_DblN_descend_se_F16_US_LL(16)_BLK3repl_1994
 -15 9 5.90677 6.5 99 0 3 # Size_DblN_descend_se_F16_US_LL(16)_BLK3repl_1994
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0 # use 2D_AR1 selectivity(0/1)
#_no 2D_AR1 selex offset used
#
# Tag loss and Tag reporting parameters go next
0 # TG_custom: 0=no read and autogen if tag data exist; 1=read
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0 #_placeholder if no parameters
#
# deviation vectors for timevary parameters
# base base first block block env env dev dev dev dev dev
# type index parm trend pattern link var vectr link _mnyr mxyr phase dev_vector
# 5 1 1 1 2 0 0 0 0 0 0 0
# 5 2 3 1 2 0 0 0 0 0 0 0
# 5 3 5 1 2 0 0 0 0 0 0 0
# 5 4 7 1 2 0 0 0 0 0 0 0
# 5 19 9 2 2 0 0 0 0 0 0 0
# 5 20 10 2 2 0 0 0 0 0 0 0
# 5 21 11 2 2 0 0 0 0 0 0 0
# 5 22 12 2 2 0 0 0 0 0 0 0
# 5 35 13 3 2 0 0 0 0 0 0 0
# 5 36 14 3 2 0 0 0 0 0 0 0
# 5 37 15 3 2 0 0 0 0 0 0 0
# 5 38 16 3 2 0 0 0 0 0 0 0
 #
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor Fleet Value
 4 1 1
 4 2 1
 4 4 1
 4 5 1
 4 6 1
 4 13 1
 4 14 1
 4 16 1
 4 18 1
 1 26 0.0116574
 1 27 0
 1 28 0.00937983
 1 29 0.0982327
 1 30 0
 1 31 0
 -9999 1 0 # terminator
#
6 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 17 changes to default Lambdas (default value is 1.0)
# Like_comp codes: 1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet phase value sizefreq_method
 1 26 1 1 1
 1 27 1 1 1
 1 28 1 0 1
 1 29 1 1 1
 1 30 1 1 1
 1 31 1 0 1
 4 1 1 1 1
 4 2 1 1 1
 4 4 1 1 1
 4 5 1 1 1
 4 6 1 1 1
 4 13 1 1 1
 4 14 1 1 1
 4 16 1 1 1
 4 18 1 1 1
 9 4 1 0 0
 10 1 1 1 1
-9999 1 1 1 1 # terminator
#
# lambdas (for info only; columns are phases)
# 0 0 0 0 0 0 #_CPUE/survey:_1
# 0 0 0 0 0 0 #_CPUE/survey:_2
# 0 0 0 0 0 0 #_CPUE/survey:_3
# 0 0 0 0 0 0 #_CPUE/survey:_4
# 0 0 0 0 0 0 #_CPUE/survey:_5
# 0 0 0 0 0 0 #_CPUE/survey:_6
# 0 0 0 0 0 0 #_CPUE/survey:_7
# 0 0 0 0 0 0 #_CPUE/survey:_8
# 0 0 0 0 0 0 #_CPUE/survey:_9
# 0 0 0 0 0 0 #_CPUE/survey:_10
# 0 0 0 0 0 0 #_CPUE/survey:_11
# 0 0 0 0 0 0 #_CPUE/survey:_12
# 0 0 0 0 0 0 #_CPUE/survey:_13
# 0 0 0 0 0 0 #_CPUE/survey:_14
# 0 0 0 0 0 0 #_CPUE/survey:_15
# 0 0 0 0 0 0 #_CPUE/survey:_16
# 0 0 0 0 0 0 #_CPUE/survey:_17
# 0 0 0 0 0 0 #_CPUE/survey:_18
# 0 0 0 0 0 0 #_CPUE/survey:_19
# 0 0 0 0 0 0 #_CPUE/survey:_20
# 0 0 0 0 0 0 #_CPUE/survey:_21
# 0 0 0 0 0 0 #_CPUE/survey:_22
# 0 0 0 0 0 0 #_CPUE/survey:_23
# 0 0 0 0 0 0 #_CPUE/survey:_24
# 0 0 0 0 0 0 #_CPUE/survey:_25
# 1 1 1 1 1 1 #_CPUE/survey:_26
# 1 1 1 1 1 1 #_CPUE/survey:_27
# 1 1 1 1 1 1 #_CPUE/survey:_28
# 1 1 1 1 1 1 #_CPUE/survey:_29
# 1 1 1 1 1 1 #_CPUE/survey:_30
# 1 1 1 1 1 1 #_CPUE/survey:_31
# 1 1 1 1 1 1 #_lencomp:_1
# 1 1 1 1 1 1 #_lencomp:_2
# 0 0 0 0 0 0 #_lencomp:_3
# 1 1 1 1 1 1 #_lencomp:_4
# 1 1 1 1 1 1 #_lencomp:_5
# 1 1 1 1 1 1 #_lencomp:_6
# 0 0 0 0 0 0 #_lencomp:_7
# 0 0 0 0 0 0 #_lencomp:_8
# 0 0 0 0 0 0 #_lencomp:_9
# 0 0 0 0 0 0 #_lencomp:_10
# 0 0 0 0 0 0 #_lencomp:_11
# 0 0 0 0 0 0 #_lencomp:_12
# 1 1 1 1 1 1 #_lencomp:_13
# 1 1 1 1 1 1 #_lencomp:_14
# 0 0 0 0 0 0 #_lencomp:_15
# 1 1 1 1 1 1 #_lencomp:_16
# 0 0 0 0 0 0 #_lencomp:_17
# 1 1 1 1 1 1 #_lencomp:_18
# 0 0 0 0 0 0 #_lencomp:_19
# 0 0 0 0 0 0 #_lencomp:_20
# 0 0 0 0 0 0 #_lencomp:_21
# 0 0 0 0 0 0 #_lencomp:_22
# 0 0 0 0 0 0 #_lencomp:_23
# 0 0 0 0 0 0 #_lencomp:_24
# 0 0 0 0 0 0 #_lencomp:_25
# 0 0 0 0 0 0 #_lencomp:_26
# 0 0 0 0 0 0 #_lencomp:_27
# 0 0 0 0 0 0 #_lencomp:_28
# 0 0 0 0 0 0 #_lencomp:_29
# 0 0 0 0 0 0 #_lencomp:_30
# 0 0 0 0 0 0 #_lencomp:_31
# 1 1 1 1 1 1 #_init_equ_catch1
# 1 1 1 1 1 1 #_init_equ_catch2
# 1 1 1 1 1 1 #_init_equ_catch3
# 0 0 0 0 0 0 #_init_equ_catch4
# 1 1 1 1 1 1 #_init_equ_catch5
# 1 1 1 1 1 1 #_init_equ_catch6
# 1 1 1 1 1 1 #_init_equ_catch7
# 1 1 1 1 1 1 #_init_equ_catch8
# 1 1 1 1 1 1 #_init_equ_catch9
# 1 1 1 1 1 1 #_init_equ_catch10
# 1 1 1 1 1 1 #_init_equ_catch11
# 1 1 1 1 1 1 #_init_equ_catch12
# 1 1 1 1 1 1 #_init_equ_catch13
# 1 1 1 1 1 1 #_init_equ_catch14
# 1 1 1 1 1 1 #_init_equ_catch15
# 1 1 1 1 1 1 #_init_equ_catch16
# 1 1 1 1 1 1 #_init_equ_catch17
# 1 1 1 1 1 1 #_init_equ_catch18
# 1 1 1 1 1 1 #_init_equ_catch19
# 1 1 1 1 1 1 #_init_equ_catch20
# 1 1 1 1 1 1 #_init_equ_catch21
# 1 1 1 1 1 1 #_init_equ_catch22
# 1 1 1 1 1 1 #_init_equ_catch23
# 1 1 1 1 1 1 #_init_equ_catch24
# 1 1 1 1 1 1 #_init_equ_catch25
# 1 1 1 1 1 1 #_init_equ_catch26
# 1 1 1 1 1 1 #_init_equ_catch27
# 1 1 1 1 1 1 #_init_equ_catch28
# 1 1 1 1 1 1 #_init_equ_catch29
# 1 1 1 1 1 1 #_init_equ_catch30
# 1 1 1 1 1 1 #_init_equ_catch31
# 1 1 1 1 1 1 #_recruitments
# 1 1 1 1 1 1 #_parameter-priors
# 1 1 1 1 1 1 #_parameter-dev-vectors
# 1 1 1 1 1 1 #_crashPenLambda
# 0 0 0 0 0 0 # F_ballpark_lambda
0 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 # 0 2 0 0 # Selectivity: (1) fleet, (2) 1=len/2=age/3=both, (3) year, (4) N selex bins
 # 0 0 # Growth: (1) growth pattern, (2) growth ages
 # 0 0 0 # Numbers-at-age: (1) area(-1 for all), (2) year, (3) N ages
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
999

