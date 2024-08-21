#define  MAXBUF      4096
#define  FILEBUF     1024
#define  MAXRECTYPE  21
#define  MXITER      100
#define  NXDATA      9
#define  MXRECPARM   6
#define  MXRECPRED   5
#define  XTOL        0.000001
#define  XXTOL       0.00001
#define  XUBOUND     5.0
#define  XLBOUND     0.001


/* Global Variables */

char Model[FILEBUF];
char BootFile[FILEBUF];

char fxname[FILEBUF];


FILE *fp1, *fp2, *fp3, *fp4, *fp5;
FILE *fp6, *fp7, *fp8, *fp9, *fp10;
FILE *fp11, *fp12;

FILE *fx1, *fx2, *fx3, *fx4, *fx5;
FILE *fx6, *fx7, *fx8, *fx9;


FILE *fp[NXDATA];



long NAges, NYears, NSims, NBoot;
long NFYear, NXYear, NFAge, NXAge;
long NRecModel, NFleet;

long ISeed;


long kfiles;
long hcount;

long DiscFlag;
long StockSummaryFlag;
long HarvestFlag;
long ThreshFlag;
long RetroFlag;
long RebuildFlag;

long ExportRFlag;
long DataFlag;

double BootFac;

double *TF, *TM;

double MaxWeight;
double MaxNatMort;


double **BootNumbers;

double **StockAge;
double **MeanStock;
double **SpawnStock;
double **CatchAge;
double **DiscAge;

double **StockWeights;
double **SpawnWeights;
double **MeanWeights;

double **NatMort;
double **Maturity;

double **RecDist;


double *StockBiomass;
double *SpawnBiomass;
double *MeanBiomass;
double *CatchBiomass;
double *Landings;
double *Discards;
double *Recruits;

double scalebio;
double scalerec;
double scalestk;

double *FMult;

double **FMort;
double **FMortFleet;
double **FFleet;
double **FleetLand;
double **FleetDisc;
double **FleetCatch;

double ***FleetSelec;
double ***CatchWeights;
double ***DiscWeights;
double ***DiscFrac;

double **WorkMat;
double **WorkMat2;

double *WorkVec;

double *RetroAdjust;

long *HarvestSpec;

double **HarvestValue;


long kpc[8];



/* Stochastic Data */

char *DataFiles[NXDATA];

double **AvgNatMort;
double **AvgMaturity;
double **AvgStockWeight;
double **AvgSpawnWeight;
double **AvgMeanStockWeight;

double ***AvgFSelec;
double ***AvgDiscFrac;
double ***AvgCatchWeight;
double ***AvgDiscWeight;


double *NatMortErr;
double *MaturityErr;

double **FSelecErr;
double **DiscFracErr;

double *StockWtErr;
double *SpawnWtErr;
double *MeanStockWtErr;

double **CatchWtErr;
double **DiscWtErr;

long NatMortFlag;
long MaturityFlag;
long FSelecFlag;
long DiscFracFlag;
long StockWtFlag;
long SpawnWtFlag;
long MeanStockWtFlag;
long CatchWtFlag;
long DiscWtFlag;

long NatMortTimeFlag;
long MaturityTimeFlag;
long FSelecTimeFlag;
long DiscFracTimeFlag;
long StockWtTimeFlag;
long SpawnWtTimeFlag;
long MeanStockWtTimeFlag;
long CatchWtTimeFlag;
long DiscWtTimeFlag;


long NatMortFileIndex;
long MaturityFileIndex;
long FSelecFileIndex;
long DiscFracFileIndex;
long StockWtFileIndex;
long SpawnWtFileIndex;
long MeanStockWtFileIndex;
long CatchWtFileIndex;
long DiscWtFileIndex;


/* Percentile Report */

long PercReportFlag;

double PercReportValue;

double **PercRepMat;

/* Rebuild */

long ktarget;
long TargetYear;
long TargetType;

double TargetValue;
double TargetPercent;

double **FProp;

/* PStar */

long KPStar;
long PStarFlag;
double *PStar;
double *PSCatch;
double *PQuota;
double PStarF;

/* Threhold */

double SSBThresh;
double StockBioThresh;
double MeanBioThresh;
double FMortThresh;

long CountSSBThresh;
long CountStockBioThresh;
long CountMeanBioThresh;
long CountFMortThresh;


long *SSBThreshCount;
long *StockBioThreshCount;
long *MeanBioThreshCount;
long *FMortThreshCount;


/* Recruitment Models */

double RecFac;
double SSBFac;

long MaxRecObs;

double **RecruitProb;

long *RecruitType;

double *RecSave;

long *KRecObs;
long *NRecObs;

double *SSBreak;

double **RecObs1;
double **RecObs2;
double **SSBObs1;
double **SSBObs2;

double *ObsData1;

double **AutoResidVar;

/* Parametric Models */

double **RecParms;



/* Model 1 - Markov Matrix */

long MarkovN;
long MarkovK;

double *MarkovRec;
double *MarkovSSB;
double **MarkovProb;


/* Predictor Models */

long *NRecPred;

double *RecPredVar;

double *RecPredBZero;

double **RecPredCoeff;

double ***RecPredObs;







/* Function Prototypes */


void ReadInputDataFile();
void ReadBootstrapData();
void AllocBasicData();
void InitSummaryTables();
void SaveProjectionResults();
void UpdateThresholdCount();
void ThresholdSummary();
void RebuildEstimate();
void PStarEstimate();
void PStarSummary();



void ApplyMortality(long);
void ApplyHarvestQuota(long);
void CalcHarvestF(long,long);
void ReadRecruitModelInput(long,long);
void AllocRecruit();
void ApplyRecruitment(long);
void ApplyInputDataError();
void SummaryReport(char *,char *,char *);
void ExportR(char *,char *,char *);
void ReportPercentLevel();


long CheckFeasibleSolution();

double CalcRebuild();
double CalcPStar();

double EmpiricalCDF(long,double *);
double LogNormalError(double,double,double,double);

double RecruitModel1(double);
double RecruitModel2(long,double);
double RecruitModel3(long);
double RecruitModel4(long,double);
double RecruitModel5(long,double);
double RecruitModel6(long,double);
double RecruitModel7(long,double);
double RecruitModel8(long);
double RecruitModel10(long,long,double);
double RecruitModel11(long,long,double);
double RecruitModel12(long,long,double);
double RecruitModel13(long,long);
double RecruitModel14(long);
double RecruitModel15(long,double);
double RecruitModel16(long,long,double);
double RecruitModel17(long,long,double);
double RecruitModel18(long,long);
double RecruitModel19(long,long);
double RecruitModel20(long,long);
double RecruitModel21(long,double);
