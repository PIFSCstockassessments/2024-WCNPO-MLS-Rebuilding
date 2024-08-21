/* Function Prototypes */

char *UpperCase(char *);
char *LowerCase(char *);
char *TrimString(char *);

void DateString(char *);
void TimeString(char *);

short ParseMultiToken(char *,double *);

void ZeroMatrix(double **, long, long);

void ZeroMat3(double ***,long,long,long);

void MultMatrix(long, long, long, double **, double **, double **);

void BubbleUpSort(long, double *);

double MeanValue(long, double *);

double StdDev(long, double, double *);

double StdDevP(long, double, double *);


double **AllocMatrix(long, long);

double ***AllocMat3(long,long,long);

int compdouble(const void *,const void *);


/* Date Time Strings */

char dstring[12];
char tstring[6];