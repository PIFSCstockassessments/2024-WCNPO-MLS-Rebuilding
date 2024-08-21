#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <time.h>
#include <math.h>


char *UpperCase(char *s)
{
	char *t;

	t = s;

	while (*s != '\0')
		*s++ = toupper(*s);

	return(t);
}
char *LowerCase(char *s)
{
	char *t;

	t = s;

	while (*s != '\0')
		*s++ = tolower(*s);

	return(t);
}
char *TrimString(char *s)
{
	char *c, *t;
	short j, k;


	t = s;
	while (isspace(*t))
		t++;


	k = strlen(t);
	j = k;
	c = t + k - 1;
	while (isspace(*c) && j > 0)
	{
		c--;
		j--;
	}

	*++c = '\0';

	return(t);
}
void DateString(char *ds)
{

	time_t tt;
	struct tm *Today;


	time(&tt);

	Today = localtime(&tt);

	strftime(ds,12,"%d %b %Y",Today);
}
void TimeString(char *ts)
{

	time_t tt;
	struct tm *Today;


	time(&tt);

	Today = localtime(&tt);

	strftime(ts,6,"%H:%M",Today);
}
short ParseMultiToken(char *s,double *x)
{
	char *t;
	short k;
	double a;

	k = 0;
	a = 0.0;

	if ((t = strchr(s,'*')) != NULL)
	{
		k = atoi(t+1);
		*t = '\0';
		a = atof(s);
	}

	*x = a;
	return(k);
}
double **AllocMatrix(long nrow,long ncol)
{
	double *vec;
	double **mat;
	long i;

	vec = (double *) malloc(nrow * ncol * sizeof(double));
	mat = (double **) malloc(nrow * sizeof(double *));

	for (i = 0; i < nrow; i++)
		mat[i] = &vec[i * ncol];

	return (mat);
}
void ZeroMatrix(double **x, long nr, long nc)
{
	long i, j;

	for (i = 0; i < nr; i++)
		for (j = 0; j < nc; j++)
			x[i][j] = 0.0;
}
void MultMatrix(long m, long p, long n, double **a, double **b, double **c)
{
	long i, j, k;
	double x;

	for (i = 0; i < m; i++)
		for (j = 0; j < n; j++)
		{
			x = 0.0;
			for (k = 0; k < p; k++)
				x += a[i][k] * b[k][j];

			c[i][j] = x;
		}
}
void BubbleUpSort(long n, double *x)
{
	long i,j;
	double t;

	for (i = 0; i < n; i++)
		for (j= i+1; j < n; j++)
		{
			if (x[j] < x[i])
			{
				t = x[i];
				x[i] = x[j];
				x[j] = t;
			}
		}
}
double MeanValue(long n, double *x)
{
	long i;
	double t, z;

	t = 0.0;
	for (i = 0; i < n; i++)
		t += x[i];

	z = t / (double) n;
	return z;
}
double StdDev(long n, double xm, double *x)
{
	long i;
	double t, v, z, d;

	t = 0.0;
	for (i = 0; i < n; i++)
	{
		d = x[i] - xm;
		t += d*d;
	}

	v = t / (double) (n - 1);
	z = sqrt(v);
	return z;
}
double StdDevP(long n, double xm, double *x)
{
	long i;
	double t, v, z, d;

	t = 0.0;
	for (i = 0; i < n; i++)
	{
		d = x[i] - xm;
		t += d*d;
	}

	v = t / (double) (n);
	z = sqrt(v);
	return z;
}
double ***AllocMat3(long nrow,long ncol,long nlevel)
{
	double *vec;
	double **m2;
	double ***mat;
	long i,j;

	vec = (double *) malloc(nrow * ncol * nlevel * sizeof(double));
	m2  = (double **) malloc(nrow * ncol * sizeof(double *));
	mat = (double ***) malloc(nrow * sizeof(double **));

	for (i = 0; i < nrow; i++)
		for (j = 0; j < ncol; j++)
			m2[j + i * ncol] = &vec[j * nlevel + i * ncol * nlevel];

	for (i = 0; i < nrow; i++)
		mat[i] = &m2[i*ncol];

	return (mat);
}
void ZeroMat3(double ***x,long nrow,long ncol,long nlevel)
{
	long i, j, k;

	for (k = 0; k < nlevel; k++)
	{
		for (j = 0; j < ncol; j++)
		{
			for (i = 0; i < nrow; i++)
			{
				x[i][j][k] = 0.0;
			}
		}
	}
}
int compdouble(const void *a,const void *b)
{
	double x1, x2;

	x1 = * (double *)a;
	x2 = * (double *)b;

	if (x1 < x2)
		return -1;
	else if (x2 < x1)
		return 1;
	else
		return 0;

}