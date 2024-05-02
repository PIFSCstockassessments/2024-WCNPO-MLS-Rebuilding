/* AGEPRO Version 4.2.3
**
** 12-December-2023: Added auxiliary file output options to StockSummaryFlag
**
** 16-June-2022: Added USA Government disclaimer 
**
** File: agepro.c
**
** Authors: Jon Brodziak, Alan Seaver, Chris Legault, Paul Rago
**
** This File is part of the NOAA, National Marine Fisheries Service
** AGE-Structured PROjection (AGEPRO) software project.
**
** This software is a "United States Government Work" under the terms of the
** United States Copyright Act.  It was written as part of the author's official
** duties as a United States Government employee and thus cannot be copyrighted.
** This software is freely available to the public for use. The National Oceanic
** And Atmospheric Administration and the U.S. Government have not placed any
** restriction on its use or reproduction.  Although all reasonable efforts have
** been taken to ensure the accuracy and reliability of the software and data,
** the National Oceanic And Atmospheric Administration and the U.S. Government
** do not and cannot warrant the performance or results that may be obtained by
** using this  software or data. The National Oceanic And Atmospheric
** Administration and the U.S. Government disclaim all warranties, express or
** implied, including warranties of performance, merchantability or fitness
** for any particular purpose.
**
** Please cite the author(s) in any work or product based on this material.
**
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "util.h"
#include "agepro.h"
#include "ranx.h"


int main(int argc, char **argv)
{
	char fname[FILEBUF];
	char dstrng[15];
	char tstrng[15];
	char *fn;
	char *c;
	long i, j, k, n, m;

	if (argc < 2)
	{
		fprintf(stderr,"usage: agepro40  filename\n");
		exit(1);
	}

	fn = *++argv;

	strcpy(fname,fn);
	strcpy(fxname,fn);

	if ((fp1 = fopen(fname,"r")) == NULL)
	{
		fprintf(stderr,"Unable to Open Input File: %s\n",fname);
		exit(1);
	}

	DateString(dstrng);
	TimeString(tstrng);

	/* Auxiliary Files */

	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".xx1");

	if ((fp3 = fopen(fname,"w")) == NULL)
	{
		fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
		exit(1);
	}


	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".xx2");

	if ((fp4 = fopen(fname,"w")) == NULL)
	{
		fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
		exit(1);
	}

	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".xx3");

	if ((fp5 = fopen(fname,"w")) == NULL)
	{
		fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
		exit(1);
	}

	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".xx4");

	if ((fp6 = fopen(fname,"w")) == NULL)
	{
		fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
		exit(1);
	}


	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".xx5");

	if ((fp7 = fopen(fname,"w")) == NULL)
	{
		fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
		exit(1);
	}

	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".xx6");

	if ((fp8 = fopen(fname,"w")) == NULL)
	{
		fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
		exit(1);
	}


	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".xx7");

	if ((fp9 = fopen(fname,"w")) == NULL)
	{
		fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
		exit(1);
	}

	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".xx8");

	if ((fp10 = fopen(fname,"w")) == NULL)
	{
		fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
		exit(1);
	}


	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".xx9");

	if ((fp11 = fopen(fname,"w")) == NULL)
	{
		fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
		exit(1);
	}


	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".xx10");

	if ((fp12 = fopen(fname,"w")) == NULL)
	{
		fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
		exit(1);
	}
	
	/* Read Input Data File */

	ReadInputDataFile();


	/* Open Files for Stochastic Data */

	if (DataFlag)
	{
		c = strrchr(fname,'.');
		*c = '\0';
		strcat(fname,".xxx1");

		if ((fx1 = fopen(fname,"w")) == NULL)
		{
			fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
			exit(1);
		}

		c = strrchr(fname,'.');
		*c = '\0';
		strcat(fname,".xxx2");

		if ((fx2 = fopen(fname,"w")) == NULL)
		{
			fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
			exit(1);
		}

		c = strrchr(fname,'.');
		*c = '\0';
		strcat(fname,".xxx3");

		if ((fx3 = fopen(fname,"w")) == NULL)
		{
			fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
			exit(1);
		}

		c = strrchr(fname,'.');
		*c = '\0';
		strcat(fname,".xxx4");

		if ((fx4 = fopen(fname,"w")) == NULL)
		{
			fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
			exit(1);
		}

		c = strrchr(fname,'.');
		*c = '\0';
		strcat(fname,".xxx5");

		if ((fx5 = fopen(fname,"w")) == NULL)
		{
			fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
			exit(1);
		}


		c = strrchr(fname,'.');
		*c = '\0';
		strcat(fname,".xxx6");

		if ((fx6 = fopen(fname,"w")) == NULL)
		{
			fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
			exit(1);
		}

		c = strrchr(fname,'.');
		*c = '\0';
		strcat(fname,".xxx7");

		if ((fx7 = fopen(fname,"w")) == NULL)
		{
			fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
			exit(1);
		}

		c = strrchr(fname,'.');
		*c = '\0';
		strcat(fname,".xxx8");

		if ((fx8 = fopen(fname,"w")) == NULL)
		{
			fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
			exit(1);
		}


		c = strrchr(fname,'.');
		*c = '\0';
		strcat(fname,".xxx9");

		if ((fx9 = fopen(fname,"w")) == NULL)
		{
			fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
			exit(1);
		}

	}



	/* Read Bootstrap Data */

	ReadBootstrapData();


	/* Initiate Random Number Sequence */

	init_ranx(ISeed);


	/* Rebuilder Estimate */

	if (RebuildFlag)
		RebuildEstimate();

	/* PStar Calc */

	if (PStarFlag)
		PStarEstimate();



	hcount = 0;

	ZeroMatrix(RecDist,NYears,NRecModel);

	for (n = 0; n < NBoot; n++)
	{
		printf("Bootstrap Iteration: %ld\n",n+1);

		for (m = 0; m < NSims; m++)
		{
			/* Clear Intermediate Storage */

			ZeroMatrix(StockAge,NAges,NYears+1);
			ZeroMatrix(MeanStock,NAges,NYears);
			ZeroMatrix(SpawnStock,NAges,NYears);
			ZeroMatrix(CatchAge,NAges,NYears);
			ZeroMatrix(DiscAge,NAges,NYears);

			for (j = 0; j < NYears; j++)
			{
				StockBiomass[j] = 0.0;
				SpawnBiomass[j] = 0.0;
				MeanBiomass[j]  = 0.0;
				CatchBiomass[j] = 0.0;
				Discards[j]     = 0.0;
				Landings[j]     = 0.0;
				Recruits[j]     = 0.0;
			}

			/* Initialize Stock Numbers in 1st Year of Projection 
			** Using Bootstrap Numbers at Age 
			*/

			for (i = 0; i < NAges; i++)
				StockAge[i][0] = BootNumbers[i][n];

			/* Retrospective Adjustment */

			if (RetroFlag)
			{
				for (i = 0; i < NAges; i++)
					StockAge[i][0] = StockAge[i][0] * RetroAdjust[i];
			}

			/* Input Data With Error */

			ApplyInputDataError();


			/* Annual Projection Loop */

			for (j = 0; j < NYears; j++)
			{
				/*  Apply Mortality */

				if (HarvestSpec[j])
					ApplyHarvestQuota(j);
				else
				{

					if (!RebuildFlag)
					{
						for (k = 0; k < NFleet; k++)
							FFleet[j][k] = HarvestValue[j][k];
					}
					else if (j == 0 || j > ktarget - 1)
					{
						for (k = 0; k < NFleet; k++)
							FFleet[j][k] = HarvestValue[j][k];
					}

					ApplyMortality(j);
				}

				
				/* Apply Recruitment */

				ApplyRecruitment(j);
			}

				/* Save Time Series Results to Auxiliary Files */

				SaveProjectionResults();


			/* Threshold Probabilities */

			if (ThreshFlag)
				UpdateThresholdCount();

			if (HarvestFlag)
				hcount += CheckFeasibleSolution();


		}
	}

	for (k = 0; k < kfiles; k++)
		fclose(fp[k]);

   
	fclose(fp3);
	fclose(fp4);
	fclose(fp5);
	fclose(fp6);
	fclose(fp7);
	fclose(fp8);
	fclose(fp9);
	fclose(fp10);
	fclose(fp11);
	fclose(fp12);
	
 
	if (DataFlag)
	{
		fclose(fx1);
		fclose(fx2);
		fclose(fx3);
		fclose(fx4);
		fclose(fx5);
		fclose(fx6);
		fclose(fx7);
		fclose(fx8);
		fclose(fx9);
	}


	/* Write Summary Report */

	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".out");

	if ((fp2 = fopen(fname,"w")) == NULL)
	{
		fprintf(stderr,"Unable to Open Output File: %s\n",fname);
		exit(1);
	}


	InitSummaryTables();

	SummaryReport(fname,dstrng,tstrng); 

	if (ThreshFlag)
		ThresholdSummary();


	if (PercReportFlag)
		ReportPercentLevel();

	if (PStarFlag)
		PStarSummary();


	fclose(fp2);

	if (ExportRFlag)
		ExportR(fname,dstrng,tstrng);
	
	/* Clean up auxiliary files using StockSummaryFlag */
	
	j = StockSummaryFlag;
	if (j == 0) j = 1;

	
	switch(j)
	{
		case 3:
			printf("Case 3: Keeping all auxiliary output files\n");
			break;
		case 2:
			printf("Case 2: Deleting stock numbers at age file and keeping all other auxiliary output files\n");
			fclose(fp3);
			strcpy(fname,fn);
			c = strrchr(fname,'.');
			*c = '\0';
			strcat(fname,".xx1");
			remove(fname);
			break;
		case 1:
			printf("Case 1: Deleting all auxiliary output files\n");
			fclose(fp3);
			strcpy(fname,fn);
			c = strrchr(fname,'.');
			*c = '\0';
			strcat(fname,".xx1");
			remove(fname);
			
			fclose(fp4);
			strcpy(fname,fn);
			c = strrchr(fname,'.');
			*c = '\0';
			strcat(fname,".xx2");
			remove(fname);
						
			fclose(fp5);
			strcpy(fname,fn);
			c = strrchr(fname,'.');
			*c = '\0';
			strcat(fname,".xx3");
			remove(fname);
									
			fclose(fp6);
			strcpy(fname,fn);
			c = strrchr(fname,'.');
			*c = '\0';
			strcat(fname,".xx4");
			remove(fname);
												
			fclose(fp7);
			strcpy(fname,fn);
			c = strrchr(fname,'.');
			*c = '\0';
			strcat(fname,".xx5");
			remove(fname);
															
			fclose(fp8);
			strcpy(fname,fn);
			c = strrchr(fname,'.');
			*c = '\0';
			strcat(fname,".xx6");
			remove(fname);
																		
			fclose(fp9);
			strcpy(fname,fn);
			c = strrchr(fname,'.');
			*c = '\0';
			strcat(fname,".xx7");
			remove(fname);
																					
			fclose(fp10);
			strcpy(fname,fn);
			c = strrchr(fname,'.');
			*c = '\0';
			strcat(fname,".xx8");
			remove(fname);
																								
			fclose(fp11);
			strcpy(fname,fn);
			c = strrchr(fname,'.');
			*c = '\0';
			strcat(fname,".xx9");
			remove(fname);
																											
			fclose(fp12);
			strcpy(fname,fn);
			c = strrchr(fname,'.');
			*c = '\0';
			strcat(fname,".xx10");
			remove(fname);
	}
	
		


	return(0);


}
void ReadInputDataFile()
{
	char buffer[MAXBUF];
	char fname[FILEBUF];
	char *tok;
	char *c;
	long i, j, k;


	RetroFlag = 0;
	StockSummaryFlag = 0;
	ThreshFlag = 0;
	HarvestFlag = 0;
	RebuildFlag = 0;
	PStarFlag = 0;
	DataFlag = 0;
	ExportRFlag = 0;
	PercReportFlag = 0;

	kfiles = 0;

	MaxWeight = 10.0;
	MaxNatMort = 1.0;

	scalebio = 1000.0;
	scalerec = 1000.0;
	scalestk = 1000.0;


	fgets(buffer,MAXBUF-1,fp1);
	if (!strstr(buffer,"AGEPRO VERSION 4.0"))
	{
		fprintf(stderr,"Not Current AgePro Input Data File\n");
	}


	while (!feof(fp1))
	{
		fgets(buffer,MAXBUF-1,fp1);

		if (strstr(buffer,"GENERAL"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			NFYear = atol(tok);
			tok = strtok(NULL," \t\r\n");
			NXYear = atol(tok);
			tok = strtok(NULL," \t\r\n");
			NFAge = atol(tok);
			tok = strtok(NULL," \t\r\n");
			NXAge = atol(tok);
			tok = strtok(NULL," \t\r\n");
			NSims = atol(tok);
			tok = strtok(NULL," \t\r\n");
			NFleet = atol(tok);
			tok = strtok(NULL," \t\r\n");
			NRecModel = atol(tok);
			tok = strtok(NULL," \t\r\n");
			DiscFlag = atol(tok);
			tok = strtok(NULL," \t\r\n");
			ISeed = atol(tok);
			AllocBasicData();
		}
		else if (strstr(buffer,"CASEID"))
		{
			fgets(buffer,FILEBUF-1,fp1);
			strcpy(Model,buffer);

			if ((c = strrchr(Model,'\n')) !=NULL)
				*c = '\0';
		}
		else if (strstr(buffer,"BOOTSTRAP"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			NBoot = atol(tok);
			tok = strtok(NULL," \t\r\n");
			BootFac = atof(tok);
			fgets(buffer,FILEBUF-1,fp1);
			strcpy(BootFile,buffer);

			scalestk = BootFac;
		}
		else if (strstr(buffer,"HARVEST"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < NYears; i++)
			{
				HarvestSpec[i] = atol(tok);
				
				if (HarvestSpec[i] > 0)
					HarvestFlag = 1;

				tok = strtok(NULL," \t\r\n");
			}

			for (j = 0;j < NFleet; j++)
			{
				fgets(buffer,MAXBUF-1,fp1);
				tok = strtok(buffer," \t\r\n");
				for (i = 0; i < NYears; i++)
				{
					HarvestValue[i][j] = atof(tok);
					tok = strtok(NULL," \t\r\n");
				}
			}
		}
		else if (strstr(buffer,"RETROADJUST"))
		{
			RetroFlag = 1;
		
			RetroAdjust = (double *) calloc(NAges,sizeof(double));
				
			fgets(buffer,MAXBUF-1,fp1);				
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < NAges; i++)
			{
				RetroAdjust[i] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}
		}
		else if (strstr(buffer,"NATMORT"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			NatMortFlag = atol(tok);
			tok = strtok(NULL," \t\r\n");
			NatMortTimeFlag = atol(tok);


			if (NatMortFlag)
			{
				fgets(fname,FILEBUF-1,fp1);
				if ((c = strrchr(fname,'\n')) != NULL)
					*c = '\0';

				DataFiles[kfiles] = strdup(fname);

				if ((fp[kfiles] = fopen(fname,"r")) == NULL)
				{
					fprintf(stderr,"Unable to Open Data File: %s\n",fname);
					exit(1);
				}

				NatMortFileIndex = kfiles;
				kfiles++;
			}
			else
			{
				if (NatMortTimeFlag)
				{
					for (j = 0; j < NYears; j++)
					{
						fgets(buffer,MAXBUF-1,fp1);
						tok = strtok(buffer," \t\r\n");
						for (i = 0; i < NAges; i++)
						{
							AvgNatMort[i][j] = atof(tok);
							tok = strtok(NULL," \t\r\n");
						}
					}
				}
				else
				{
					ZeroMatrix(AvgNatMort,NAges,NYears);

					fgets(buffer,MAXBUF-1,fp1);
					tok = strtok(buffer," \t\r\n");
					for (i = 0; i < NAges; i++)
					{
						AvgNatMort[i][0] = atof(tok);
						tok = strtok(NULL," \t\r\n");
					}
				}

				fgets(buffer,MAXBUF-1,fp1);
				tok = strtok(buffer," \t\r\n");
				for (i = 0; i < NAges; i++)
				{
					NatMortErr[i] = atof(tok);
					tok = strtok(NULL," \t\r\n");
				}
			}
		}
		else if (strstr(buffer,"BIOLOGICAL"))
		{
			/* Fraction Fishery & Natural Mortality Prior to Spawning */

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			k = atol(tok);

			if (k)
			{
				fgets(buffer,MAXBUF-1,fp1);
				tok = strtok(buffer," \t\r\n");
				for (i = 0; i < NYears; i++)
				{
					TF[i] = atof(tok);
					tok = strtok(NULL," \t\r\n");
				}

				fgets(buffer,MAXBUF-1,fp1);
				tok = strtok(buffer," \t\r\n");
				for (i = 0; i < NYears; i++)
				{
					TM[i] = atof(tok);
					tok = strtok(NULL," \t\r\n");
				}
			}
			else
			{
				fgets(buffer,MAXBUF-1,fp1);
				tok = strtok(buffer," \t\r\n");
				TF[0] = atof(tok);
				for (i = 1; i < NYears; i++)
				{
					TF[i] = TF[0];
					tok = strtok(NULL," \t\r\n");
				}

				fgets(buffer,MAXBUF-1,fp1);
				tok = strtok(buffer," \t\r\n");
				TM[0] = atof(tok);
				for (i = 1; i < NYears; i++)
				{
					TM[i] = TM[0];
					tok = strtok(NULL," \t\r\n");
				}
			}


		}
		else if (strstr(buffer,"MATURITY"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			MaturityFlag = atol(tok);
			tok = strtok(NULL," \t\r\n");
			MaturityTimeFlag = atol(tok);

			if (MaturityFlag)
			{
				fgets(fname,FILEBUF-1,fp1);
				if ((c = strrchr(fname,'\n')) != NULL)
					*c = '\0';

				DataFiles[kfiles] = strdup(fname);

				if ((fp[kfiles] = fopen(fname,"r")) == NULL)
				{
					fprintf(stderr,"Unable to Open Data File: %s\n",fname);
					exit(1);
				}

				MaturityFileIndex = kfiles;
				kfiles++;
			}
			else
			{
				if (MaturityTimeFlag)
				{
					for (j = 0; j < NYears; j++)
					{
						fgets(buffer,MAXBUF-1,fp1);
						tok = strtok(buffer," \t\r\n");
						for (i = 0; i < NAges; i++)
						{
							AvgMaturity[i][j] = atof(tok);
							tok = strtok(NULL," \t\r\n");
						}
					}
				}
				else
				{
					ZeroMatrix(AvgMaturity,NAges,NYears);

					fgets(buffer,MAXBUF-1,fp1);
					tok = strtok(buffer," \t\r\n");
					for (i = 0; i < NAges; i++)
					{
						AvgMaturity[i][0] = atof(tok);
						tok = strtok(NULL," \t\r\n");
					}
				}

				fgets(buffer,MAXBUF-1,fp1);
				tok = strtok(buffer," \t\r\n");
				for (i = 0; i < NAges; i++)
				{
					MaturityErr[i] = atof(tok);
					tok = strtok(NULL," \t\r\n");
				}
			}
		}
		else if (strstr(buffer,"STOCK_WEIGHT"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			StockWtFlag = atol(tok);
			tok = strtok(NULL," \t\r\n");
			StockWtTimeFlag = atol(tok);

			if (StockWtFlag)
			{
				fgets(fname,FILEBUF-1,fp1);
				if ((c = strrchr(fname,'\n')) != NULL)
					*c = '\0';

				DataFiles[kfiles] = strdup(fname);

				if ((fp[kfiles] = fopen(fname,"r")) == NULL)
				{
					fprintf(stderr,"Unable to Open Data File: %s\n",fname);
					exit(1);
				}

				StockWtFileIndex = kfiles;
				kfiles++;
			}
			else
			{
				if (StockWtTimeFlag)
				{
					for (j = 0; j < NYears; j++)
					{
						fgets(buffer,MAXBUF-1,fp1);
						tok = strtok(buffer," \t\r\n");
						for (i = 0; i < NAges; i++)
						{
							AvgStockWeight[i][j] = atof(tok);
							tok = strtok(NULL," \t\r\n");
						}
					}
				}
				else
				{
					ZeroMatrix(AvgStockWeight,NAges,NYears);

					fgets(buffer,MAXBUF-1,fp1);
					tok = strtok(buffer," \t\r\n");
					for (i = 0; i < NAges; i++)
					{
						AvgStockWeight[i][0] = atof(tok);
						tok = strtok(NULL," \t\r\n");
					}
				}

				fgets(buffer,MAXBUF-1,fp1);
				tok = strtok(buffer," \t\r\n");
				for (i = 0; i < NAges; i++)
				{
					StockWtErr[i] = atof(tok);
					tok = strtok(NULL," \t\r\n");
				}
			}
		}
		else if (strstr(buffer,"SSB_WEIGHT"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			SpawnWtFlag = atol(tok);
			tok = strtok(NULL," \t\r\n");
			SpawnWtTimeFlag = atol(tok);

			if (SpawnWtFlag > 0)
			{
				fgets(fname,FILEBUF-1,fp1);
				if ((c = strrchr(fname,'\n')) != NULL)
					*c = '\0';

				DataFiles[kfiles] = strdup(fname);

				if ((fp[kfiles] = fopen(fname,"r")) == NULL)
				{
					fprintf(stderr,"Unable to Open Data File: %s\n",fname);
					exit(1);
				}
				SpawnWtFileIndex = kfiles;
				kfiles++;
			}
			else if (SpawnWtFlag == 0)
			{
				if (SpawnWtTimeFlag)
				{
					for (j = 0; j < NYears; j++)
					{
						fgets(buffer,MAXBUF-1,fp1);
						tok = strtok(buffer," \t\r\n");
						for (i = 0; i < NAges; i++)
						{
							AvgSpawnWeight[i][j] = atof(tok);
							tok = strtok(NULL," \t\r\n");
						}
					}
				}
				else
				{
					ZeroMatrix(AvgSpawnWeight,NAges,NYears);

					fgets(buffer,MAXBUF-1,fp1);
					tok = strtok(buffer," \t\r\n");
					for (i = 0; i < NAges; i++)
					{
						AvgSpawnWeight[i][0] = atof(tok);
						tok = strtok(NULL," \t\r\n");
					}
				}


				fgets(buffer,MAXBUF-1,fp1);
				tok = strtok(buffer," \t\r\n");
				for (i = 0; i < NAges; i++)
				{
					SpawnWtErr[i] = atof(tok);
					tok = strtok(NULL," \t\r\n");
				}
			}
		}	
		else if (strstr(buffer,"MEAN_WEIGHT"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			MeanStockWtFlag = atol(tok);
			tok = strtok(NULL," \t\r\n");
			MeanStockWtTimeFlag = atol(tok);

			if (MeanStockWtFlag > 0)
			{
				fgets(fname,FILEBUF-1,fp1);
				if ((c = strrchr(fname,'\n')) != NULL)
					*c = '\0';

				DataFiles[kfiles] = strdup(fname);

				if ((fp[kfiles] = fopen(fname,"r")) == NULL)
				{
					fprintf(stderr,"Unable to Open Data File: %s\n",fname);
					exit(1);
				}
				MeanStockWtFileIndex = kfiles;
				kfiles++;
			}
			else if (MeanStockWtFlag == 0)
			{
				if (MeanStockWtTimeFlag)
				{
					for (j = 0; j < NYears; j++)
					{
						fgets(buffer,MAXBUF-1,fp1);
						tok = strtok(buffer," \t\r\n");
						for (i = 0; i < NAges; i++)
						{
							AvgMeanStockWeight[i][j] = atof(tok);
							tok = strtok(NULL," \t\r\n");
						}
					}
				}
				else
				{
					ZeroMatrix(AvgMeanStockWeight,NAges,NYears);

					fgets(buffer,MAXBUF-1,fp1);
					tok = strtok(buffer," \t\r\n");
					for (i = 0; i < NAges; i++)
					{
						AvgMeanStockWeight[i][0] = atof(tok);
						tok = strtok(NULL," \t\r\n");
					}
				}

				fgets(buffer,MAXBUF-1,fp1);
				tok = strtok(buffer," \t\r\n");
				for (i = 0; i < NAges; i++)
				{
					MeanStockWtErr[i] = atof(tok);
					tok = strtok(NULL," \t\r\n");
				}
			}
		}
		else if (strstr(buffer,"FISHERY"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			FSelecFlag = atol(tok);
			tok = strtok(NULL," \t\r\n");
			FSelecTimeFlag = atol(tok);

			if (FSelecFlag)
			{
				fgets(fname,FILEBUF-1,fp1);
				if ((c = strrchr(fname,'\n')) != NULL)
					*c = '\0';

				DataFiles[kfiles] = strdup(fname);

				if ((fp[kfiles] = fopen(fname,"r")) == NULL)
				{
					fprintf(stderr,"Unable to Open Data File: %s\n",fname);
					exit(1);
				}
				FSelecFileIndex = kfiles;
				kfiles++;
			}
			else
			{
				for (k = 0; k < NFleet; k++)
				{	
					if (FSelecTimeFlag)
					{
						for (j = 0; j < NYears; j++)
						{
							fgets(buffer,MAXBUF-1,fp1);
							tok = strtok(buffer," \t\r\n");
							for (i = 0; i < NAges; i++)
							{
								AvgFSelec[i][j][k] = atof(tok);
								tok = strtok(NULL," \t\r\n");
							}
						}
					}
					else
					{
						fgets(buffer,MAXBUF-1,fp1);
						tok = strtok(buffer," \t\r\n");
						for (i = 0; i < NAges; i++)
						{
							AvgFSelec[i][0][k] = atof(tok);
							tok = strtok(NULL," \t\r\n");
						}
						for (j = 1; j < NYears; j++)
							for (i = 0; i < NAges; i++)
								AvgFSelec[i][j][k] = 0.0;
					}
				}
				for (k = 0; k < NFleet; k++)
				{
					fgets(buffer,MAXBUF-1,fp1);
					tok = strtok(buffer," \t\r\n");
					for (i = 0; i < NAges; i++)
					{
						FSelecErr[i][k] = atof(tok);
						tok = strtok(NULL," \t\r\n");
					}
				}
			}
		}
		else if (strstr(buffer,"DISCARD"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			DiscFracFlag = atol(tok);
			tok = strtok(NULL," \t\r\n");
			DiscFracTimeFlag = atol(tok);

			if (DiscFracFlag)
			{
				fgets(fname,FILEBUF-1,fp1);
				if ((c = strrchr(fname,'\n')) != NULL)
					*c = '\0';

				DataFiles[kfiles] = strdup(fname);

				if ((fp[kfiles] = fopen(fname,"r")) == NULL)
				{
					fprintf(stderr,"Unable to Open Data File: %s\n",fname);
					exit(1);
				}
				DiscFracFileIndex = kfiles;
				kfiles++;
			}
			else
			{
				for (k = 0; k < NFleet; k++)
				{
					if (DiscFracTimeFlag)
					{
						for (j = 0; j < NYears; j++)
						{
							fgets(buffer,MAXBUF-1,fp1);
							tok = strtok(buffer," \t\r\n");
							for (i = 0; i < NAges; i++)
							{
								AvgDiscFrac[i][j][k] = atof(tok);
								tok = strtok(NULL," \t\r\n");
							}
						}
					}
					else
					{
						fgets(buffer,MAXBUF-1,fp1);
						tok = strtok(buffer," \t\r\n");
						for (i = 0; i < NAges; i++)
						{
							AvgDiscFrac[i][0][k] = atof(tok);
							tok = strtok(NULL," \t\r\n");
						}
						for (j = 1; j < NYears; j++)
							for (i = 0; i < NAges; i++)
								AvgDiscFrac[i][j][k] = 0.0;
					}
				}
				for (k = 0; k < NFleet; k++)
				{
					fgets(buffer,MAXBUF-1,fp1);
					tok = strtok(buffer," \t\r\n");
					for (i = 0; i < NAges; i++)
					{
						DiscFracErr[i][k] = atof(tok);
						tok = strtok(NULL," \t\r\n");
					}
				}
			}
		}
		else if (strstr(buffer,"CATCH_WEIGHT"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			CatchWtFlag = atol(tok);
			tok = strtok(NULL," \t\r\n");
			CatchWtTimeFlag = atol(tok);

			if (CatchWtFlag > 0)
			{
				fgets(fname,FILEBUF-1,fp1);
				if ((c = strrchr(fname,'\n')) != NULL)
					*c = '\0';

				DataFiles[kfiles] = strdup(fname);

				if ((fp[kfiles] = fopen(fname,"r")) == NULL)
				{
					fprintf(stderr,"Unable to Open Data File: %s\n",fname);
					exit(1);
				}
				CatchWtFileIndex = kfiles;
				kfiles++;
			}
			else if (CatchWtFlag == 0)
			{
				for (k = 0; k < NFleet; k++)
				{	
					if (CatchWtTimeFlag)
					{
						for (j = 0; j < NYears; j++)
						{
							fgets(buffer,MAXBUF-1,fp1);
							tok = strtok(buffer," \t\r\n");
							for (i = 0; i < NAges; i++)
							{
								AvgCatchWeight[i][j][k] = atof(tok);
								tok = strtok(NULL," \t\r\n");
							}
						}
					}
					else
					{
						fgets(buffer,MAXBUF-1,fp1);
						tok = strtok(buffer," \t\r\n");
						for (i = 0; i < NAges; i++)
						{
							AvgCatchWeight[i][0][k] = atof(tok);
							tok = strtok(NULL," \t\r\n");
						}
						for (j = 1; j < NYears; j++)
							for (i = 0; i < NAges; i++)
								AvgCatchWeight[i][j][k] = 0.0;
					}
				}
				for (k = 0; k < NFleet; k++)
				{
					fgets(buffer,MAXBUF-1,fp1);
					tok = strtok(buffer," \t\r\n");
					for (i = 0; i < NAges; i++)
					{
						CatchWtErr[i][k] = atof(tok);
						tok = strtok(NULL," \t\r\n");
					}
				}
			}
		}
		else if (strstr(buffer,"DISC_WEIGHT"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			DiscWtFlag = atol(tok);
			tok = strtok(NULL," \t\r\n");
			DiscWtTimeFlag = atol(tok);

			if (DiscWtFlag > 0)
			{
				fgets(fname,FILEBUF-1,fp1);
				if ((c = strrchr(fname,'\n')) != NULL)
					*c = '\0';

				DataFiles[kfiles] = strdup(fname);

				if ((fp[kfiles] = fopen(fname,"r")) == NULL)
				{
					fprintf(stderr,"Unable to Open Data File: %s\n",fname);
					exit(1);
				}
				DiscWtFileIndex = kfiles;
				kfiles++;
			}
			else if (DiscWtFlag == 0)
			{
				for (k = 0; k < NFleet; k++)
				{
					if (DiscWtTimeFlag)
					{
						for (j = 0; j < NYears; j++)
						{
							fgets(buffer,MAXBUF-1,fp1);
							tok = strtok(buffer," \t\r\n");
							for (i = 0; i < NAges; i++)
							{
								AvgDiscWeight[i][j][k] = atof(tok);
								tok = strtok(NULL," \t\r\n");
							}
						}
					}
					else
					{
						fgets(buffer,MAXBUF-1,fp1);
						tok = strtok(buffer," \t\r\n");
						for (i = 0; i < NAges; i++)
						{
							AvgDiscWeight[i][0][k] = atof(tok);
							tok = strtok(NULL," \t\r\n");
						}

						for (j = 1; j < NYears; j++)
							for (i = 0; i < NAges; i++)
								AvgDiscWeight[i][j][k] = 0.0;
					}
				}
				for (k = 0; k < NFleet; k++)
				{
					fgets(buffer,MAXBUF-1,fp1);
					tok = strtok(buffer," \t\r\n");
					for (i = 0; i < NAges; i++)
					{
						DiscWtErr[i][k] = atof(tok);
						tok = strtok(NULL," \t\r\n");
					}
				}
			}
		}
		else if (strstr(buffer,"RECRUIT"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			RecFac = atof(tok);
			tok = strtok(NULL," \t\r\n");
			SSBFac = atof(tok);
			tok = strtok(NULL," \t\r\n");
			MaxRecObs = atol(tok);

			scalerec = RecFac;

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < NRecModel; i++)
			{
				RecruitType[i] = atol(tok);
				tok = strtok(NULL," \t\r\n");
			}

			for (i = 0; i < NYears; i++)
			{
				fgets(buffer,MAXBUF-1,fp1);
				tok = strtok(buffer," \t\r\n");
				for (j = 0; j < NRecModel; j++)
				{
					RecruitProb[i][j] = atof(tok);
					tok = strtok(NULL," \t\r\n");
				}
			}

			AllocRecruit();

			for (i = 0; i < NRecModel; i++)
			{
				k = RecruitType[i];
				ReadRecruitModelInput(i,k);
			}
		}
		else if (strstr(buffer,"BOUNDS"))
		{
			fgets(buffer,MAXBUF-1,fp1);				
			tok = strtok(buffer," \t\r\n");
			MaxWeight = atof(tok);
			tok = strtok(NULL," \t\r\n");
			MaxNatMort = atof(tok);
		}
		else if (strstr(buffer,"OPTIONS"))
		{
			fgets(buffer,MAXBUF-1,fp1);				
			tok = strtok(buffer," \t\r\n");
			StockSummaryFlag = atol(tok);
			tok = strtok(NULL," \t\r\n");
			DataFlag = atol(tok);
			tok = strtok(NULL," \t\r\n");
			ExportRFlag = atol(tok);
		}
		else if (strstr(buffer,"SCALE"))
		{
			fgets(buffer,MAXBUF-1,fp1);				
			tok = strtok(buffer," \t\r\n");
			scalebio = atof(tok);
			tok = strtok(NULL," \t\r\n");
			scalerec = atof(tok);
			tok = strtok(NULL," \t\r\n");
			scalestk = atof(tok);
		}
		else if (strstr(buffer,"PERC"))
		{
			PercReportFlag = 1;
			fgets(buffer,MAXBUF-1,fp1);				
			tok = strtok(buffer," \t\r\n");
			PercReportValue = atof(tok);
		}
		else if (strstr(buffer,"REFPOINT"))
		{
			ThreshFlag = 1;

			SSBThreshCount = (long *) calloc(NYears,sizeof(long));
			StockBioThreshCount = (long *) calloc(NYears,sizeof(long));
			MeanBioThreshCount = (long *) calloc(NYears,sizeof(long));
			FMortThreshCount = (long *) calloc(NYears,sizeof(long));

			CountSSBThresh = 0;
			CountStockBioThresh = 0;
			CountMeanBioThresh = 0;
			CountFMortThresh = 0;

			fgets(buffer,MAXBUF-1,fp1);				
			tok = strtok(buffer," \t\r\n");
			SSBThresh = atof(tok);
			tok = strtok(NULL," \t\r\n");
			StockBioThresh = atof(tok);
			tok = strtok(NULL," \t\r\n");
			MeanBioThresh = atof(tok);
			tok = strtok(NULL," \t\r\n");
			FMortThresh = atof(tok);

		}
		else if (strstr(buffer,"REBUILD"))
		{
			RebuildFlag = 1;

			fgets(buffer,MAXBUF-1,fp1);				
			tok = strtok(buffer," \t\r\n");
			TargetYear = atol(tok);
			tok = strtok(NULL," \t\r\n");
			TargetValue = atof(tok);
			tok = strtok(NULL," \t\r\n");
			TargetType = atol(tok);
			tok = strtok(NULL," \t\r\n");
			TargetPercent = atof(tok);
		}
		else if (strstr(buffer,"PSTAR"))
		{
			PStarFlag = 1;
			fgets(buffer,MAXBUF-1,fp1);				
			tok = strtok(buffer," \t\r\n");
			KPStar = atol(tok);

			PStar   = (double *) calloc(KPStar,sizeof(double));
			PSCatch = (double *) calloc(KPStar,sizeof(double));
			PQuota  = (double *) calloc(NFleet,sizeof(double));

			fgets(buffer,MAXBUF-1,fp1);				
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < KPStar; i++)
			{
				PStar[i] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}

			fgets(buffer,MAXBUF-1,fp1);				
			tok = strtok(buffer," \t\r\n");
			PStarF = atof(tok);

			fgets(buffer,MAXBUF-1,fp1);				
			tok = strtok(buffer," \t\r\n");
			TargetYear = atol(tok);

		}
	}


	fclose(fp1);

}
void AllocBasicData()
{

	NAges = NXAge - NFAge + 1;
	NYears = NXYear - NFYear + 1;

	StockAge   = AllocMatrix(NAges,NYears+1);
	MeanStock  = AllocMatrix(NAges,NYears);
	SpawnStock = AllocMatrix(NAges,NYears);
	CatchAge   = AllocMatrix(NAges,NYears);
	DiscAge    = AllocMatrix(NAges,NYears);
	FMort      = AllocMatrix(NAges,NYears);

	FMortFleet = AllocMatrix(NAges,NFleet);

	FFleet     = AllocMatrix(NYears,NFleet);
	FleetLand  = AllocMatrix(NYears,NFleet);
	FleetDisc  = AllocMatrix(NYears,NFleet);
	FleetCatch = AllocMatrix(NYears,NFleet);

	StockWeights = AllocMatrix(NAges,NYears);
	SpawnWeights = AllocMatrix(NAges,NYears);
	MeanWeights  = AllocMatrix(NAges,NYears);
	NatMort      = AllocMatrix(NAges,NYears);
	Maturity     = AllocMatrix(NAges,NYears);

	RecDist		 = AllocMatrix(NYears,NRecModel);



	FMult        = (double *) calloc(NYears,sizeof(double));
	StockBiomass = (double *) calloc(NYears+1,sizeof(double));
	MeanBiomass  = (double *) calloc(NYears,sizeof(double));
	CatchBiomass = (double *) calloc(NYears,sizeof(double));
	Landings     = (double *) calloc(NYears,sizeof(double));
	Discards     = (double *) calloc(NYears,sizeof(double));
	SpawnBiomass = (double *) calloc(NYears,sizeof(double));
	Recruits     = (double *) calloc(NYears,sizeof(double));

	RecSave      = (double *) calloc(NYears,sizeof(double));

	TF           = (double *) calloc(NYears,sizeof(double));
	TM           = (double *) calloc(NYears,sizeof(double));

	FleetSelec   = AllocMat3(NAges,NYears,NFleet);
	CatchWeights = AllocMat3(NAges,NYears,NFleet);
	DiscWeights  = AllocMat3(NAges,NYears,NFleet);
	DiscFrac     = AllocMat3(NAges,NYears,NFleet);

	HarvestSpec  = (long *) calloc(NYears,sizeof(long));

	HarvestValue = AllocMatrix(NYears,NFleet);

	RecruitType  = (long *) calloc(NRecModel,sizeof(long));

	RecruitProb  = AllocMatrix(NYears,NRecModel);

	AvgNatMort         = AllocMatrix(NAges,NYears);
	AvgMaturity        = AllocMatrix(NAges,NYears);
	AvgStockWeight     = AllocMatrix(NAges,NYears);
	AvgSpawnWeight     = AllocMatrix(NAges,NYears);
	AvgMeanStockWeight = AllocMatrix(NAges,NYears);

	AvgFSelec      = AllocMat3(NAges,NYears,NFleet);
	AvgDiscFrac    = AllocMat3(NAges,NYears,NFleet);
	AvgCatchWeight = AllocMat3(NAges,NYears,NFleet);
	AvgDiscWeight  = AllocMat3(NAges,NYears,NFleet);


	NatMortErr     = (double *) calloc(NAges,sizeof(double));
	MaturityErr    = (double *) calloc(NAges,sizeof(double));
	StockWtErr     = (double *) calloc(NAges,sizeof(double));
	SpawnWtErr     = (double *) calloc(NAges,sizeof(double));
	MeanStockWtErr = (double *) calloc(NAges,sizeof(double));

	FSelecErr    = AllocMatrix(NAges,NFleet);
	DiscFracErr  = AllocMatrix(NAges,NFleet);
	CatchWtErr   = AllocMatrix(NAges,NFleet);
	DiscWtErr    = AllocMatrix(NAges,NFleet);

}
void ReadBootstrapData()
{
	long i, j;
	char buffer[MAXBUF];
	char *tok;
	char *c;

	if ((c = strrchr(BootFile,'\n')) != NULL)
		*c = '\0';


	if ((fp1 = fopen(BootFile,"r")) == NULL)
	{
		fprintf(stderr,"Unable to Open Bootstrap File: %s\n",BootFile);
		exit(1);
	}


	if ((BootNumbers = AllocMatrix(NAges,NBoot)) == NULL)
	{
		fprintf(stderr,"Bootstrap Allocation Error (N's)\n");
		exit(1);
	}

	/* Read Bootstrap Stock Numbers at Age & Apply Scale Factor */

	for (j = 0; j < NBoot; j++)
	{
		fgets(buffer,MAXBUF-1,fp1);
		tok = strtok(buffer," \t\r\n");
		for (i = 0; i < NAges; i++)
		{
			BootNumbers[i][j] = atof(tok);
			BootNumbers[i][j] =  BootNumbers[i][j] * BootFac;
			tok = strtok(NULL," \t\r\n");
		}
	}


	fclose(fp1);


}
void ApplyInputDataError()
{
	char buffer[MAXBUF];
	char *tok;
	char *c;
	long i, j, k, n;
	double x, xm, cv;
	double xlo, xhi;

	if (NatMortFlag)
	{

		n = NatMortFileIndex;

		if (NatMortTimeFlag)
		{
			for (j = 0; j < NYears; j++)
			{
				if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
				{
					printf("Rewinding\n");
					rewind(fp[n]);
					fgets(buffer,MAXBUF-1,fp[n]);
				}
				tok = strtok(buffer," \t\r\n");

				for (i = 0; i < NAges; i++)
				{
					NatMort[i][j] = atof(tok);
					tok = strtok(NULL," \t\r\n");

					if (NatMort[i][j] < 0.0)
						NatMort[i][j] = 0.0;
					if (NatMort[i][j] > MaxNatMort)
						NatMort[i][j] = MaxNatMort;
				}
			}
		}
		else
		{
			if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
			{
				printf("Rewinding\n");
				rewind(fp[n]);
				fgets(buffer,MAXBUF-1,fp[n]);
			}
			tok = strtok(buffer," \t\r\n");

			for (i = 0; i < NAges; i++)
			{
				NatMort[i][0] = atof(tok);
				tok = strtok(NULL," \t\r\n");

				if (NatMort[i][0] < 0.0)
					NatMort[i][0] = 0.0;
				if (NatMort[i][0] > MaxNatMort)
					NatMort[i][0] = MaxNatMort;
			}

			for (j = 1; j < NYears; j++)
				for (i = 0; i < NAges; i++)
					NatMort[i][j] = NatMort[i][0];
		}
	}
	else
	{
		xlo = 0.0;
		xhi = MaxNatMort;
		
		if (NatMortTimeFlag)
		{
			for (j = 0; j < NYears; j++)
			{
				for (i = 0; i < NAges; i++)
				{
					x = AvgNatMort[i][j];
					cv = NatMortErr[i];
					NatMort[i][j] = LogNormalError(x,cv,xlo,xhi);
				}
			}
		}
		else
		{
			for (i = 0; i < NAges; i++)
			{
				x = AvgNatMort[i][0];
				cv = NatMortErr[i];
				NatMort[i][0] = LogNormalError(x,cv,xlo,xhi);
			}
			for (j = 1; j < NYears; j++)
				for (i = 0; i < NAges; i++)
					NatMort[i][j] = NatMort[i][0];
		}
	}

	if (MaturityFlag)
	{

		n = MaturityFileIndex;

		if (MaturityTimeFlag)
		{
			for (j = 0; j < NYears; j++)
			{
				if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
				{
					printf("Rewinding\n");
					rewind(fp[n]);
					fgets(buffer,MAXBUF-1,fp[n]);
				}
				tok = strtok(buffer," \t\r\n");

				for (i = 0; i < NAges; i++)
				{
					Maturity[i][j] = atof(tok);
					tok = strtok(NULL," \t\r\n");

					if (Maturity[i][j] < 0.0)
						Maturity[i][j] = 0.0;
					if (Maturity[i][j] > 1.0)
						Maturity[i][j] = 1.0;
				}
			}
		}
		else
		{
			if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
			{
				printf("Rewinding\n");
				rewind(fp[n]);
				fgets(buffer,MAXBUF-1,fp[n]);
			}
			tok = strtok(buffer," \t\r\n");

			for (i = 0; i < NAges; i++)
			{
				Maturity[i][0] = atof(tok);
				tok = strtok(NULL," \t\r\n");

				if (Maturity[i][0] < 0.0)
					Maturity[i][0] = 0.0;
				if (Maturity[i][0] > 1.0)
					Maturity[i][0] = 1.0;
			}

			for (j = 1; j < NYears; j++)
				for (i = 0; i < NAges; i++)
					Maturity[i][j] = Maturity[i][0];
		}
	}
	else
	{
		xlo = 0.0;
		xhi = 1.0;
		
		if (MaturityTimeFlag)
		{
			for (j = 0; j < NYears; j++)
			{
				for (i = 0; i < NAges; i++)
				{
					x = AvgMaturity[i][j];
					cv = MaturityErr[i];
					Maturity[i][j] = LogNormalError(x,cv,xlo,xhi);
				}
			}
		}
		else
		{
			for (i = 0; i < NAges; i++)
			{
				x = AvgMaturity[i][0];
				cv = MaturityErr[i];
				Maturity[i][0] = LogNormalError(x,cv,xlo,xhi);
			}
			for (j = 1; j < NYears; j++)
				for (i = 0; i < NAges; i++)
					Maturity[i][j] = Maturity[i][0];
		}

	}

	if (StockWtFlag)
	{

		n = StockWtFileIndex;

		if (StockWtTimeFlag)
		{
			for (j = 0; j < NYears; j++)
			{
				if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
				{
					printf("Rewinding\n");
					rewind(fp[n]);
					fgets(buffer,MAXBUF-1,fp[n]);
				}
				tok = strtok(buffer," \t\r\n");

				for (i = 0; i < NAges; i++)
				{
					StockWeights[i][j] = atof(tok);
					tok = strtok(NULL," \t\r\n");

					if (StockWeights[i][j] < 0.0)
						StockWeights[i][j] = 0.0;
					if (StockWeights[i][j] > MaxWeight)
						StockWeights[i][j] = MaxWeight;
				}
			}
		}
		else
		{
			if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
			{
				printf("Rewinding\n");
				rewind(fp[n]);
				fgets(buffer,MAXBUF-1,fp[n]);
			}
			tok = strtok(buffer," \t\r\n");

			for (i = 0; i < NAges; i++)
			{
				StockWeights[i][0] = atof(tok);
				tok = strtok(NULL," \t\r\n");

				if (StockWeights[i][0] < 0.0)
					StockWeights[i][0] = 0.0;
				if (StockWeights[i][0] > MaxWeight)
					StockWeights[i][0] = MaxWeight;
			}

			for (j = 1; j < NYears; j++)
				for (i = 0; i < NAges; i++)
					StockWeights[i][j] = StockWeights[i][0];

		}
	}
	else
	{
		xlo = 0.0;
		xhi = MaxWeight;
		
		if (StockWtTimeFlag)
		{
			for (j = 0; j < NYears; j++)
			{
				for (i = 0; i < NAges; i++)
				{
					x = AvgStockWeight[i][j];
					cv = StockWtErr[i];
					StockWeights[i][j] = LogNormalError(x,cv,xlo,xhi);
				}
			}
		}
		else
		{
			for (i = 0; i < NAges; i++)
			{
				x = AvgStockWeight[i][0];
				cv = StockWtErr[i];
				StockWeights[i][0] = LogNormalError(x,cv,xlo,xhi);
			}
			for (j = 1; j < NYears; j++)
				for (i = 0; i < NAges; i++)
					StockWeights[i][j] = StockWeights[i][0];
		}
	}

	if (SpawnWtFlag > 0)
	{

		n = SpawnWtFileIndex;

		if (SpawnWtTimeFlag)
		{
			for (j = 0; j < NYears; j++)
			{
				if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
				{
					printf("Rewinding\n");
					rewind(fp[n]);
					fgets(buffer,MAXBUF-1,fp[n]);
				}
				tok = strtok(buffer," \t\r\n");

				for (i = 0; i < NAges; i++)
				{
					SpawnWeights[i][j] = atof(tok);
					tok = strtok(NULL," \t\r\n");

					if (SpawnWeights[i][j] < 0.0)
						SpawnWeights[i][j] = 0.0;
					if (SpawnWeights[i][j] > MaxWeight)
						SpawnWeights[i][j] = MaxWeight;
				}
			}
		}
		else
		{
			if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
			{
				printf("Rewinding\n");
				rewind(fp[n]);
				fgets(buffer,MAXBUF-1,fp[n]);
			}
			tok = strtok(buffer," \t\r\n");

			for (i = 0; i < NAges; i++)
			{
				SpawnWeights[i][0] = atof(tok);
				tok = strtok(NULL," \t\r\n");

				if (SpawnWeights[i][0] < 0.0)
					SpawnWeights[i][0] = 0.0;
				if (SpawnWeights[i][0] > MaxWeight)
					SpawnWeights[i][0] = MaxWeight;
			}

			for (j = 1; j < NYears; j++)
				for (i = 0; i < NAges; i++)
					SpawnWeights[i][j] = SpawnWeights[i][0];

		}
	}
	else if (SpawnWtFlag == -1)
	{
		for (j = 0; j < NYears; j++)
			for (i = 0; i < NAges; i++)
				SpawnWeights[i][j] = StockWeights[i][j];
	}
	else 
	{
		xlo = 0.0;
		xhi = MaxWeight;
		
		if (SpawnWtTimeFlag)
		{
			for (j = 0; j < NYears; j++)
			{
				for (i = 0; i < NAges; i++)
				{
					x = AvgSpawnWeight[i][j];
					cv = SpawnWtErr[i];
					SpawnWeights[i][j] = LogNormalError(x,cv,xlo,xhi);
				}
			}
		}
		else
		{
			for (i = 0; i < NAges; i++)
			{
				x = AvgSpawnWeight[i][0];
				cv = SpawnWtErr[i];
				SpawnWeights[i][0] = LogNormalError(x,cv,xlo,xhi);
			}
			for (j = 1; j < NYears; j++)
				for (i = 0; i < NAges; i++)
					SpawnWeights[i][j] = SpawnWeights[i][0];
		}
	}

	if (MeanStockWtFlag > 0)
	{

		n = MeanStockWtFileIndex;

		if (MeanStockWtTimeFlag)
		{
			for (j = 0; j < NYears; j++)
			{
				if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
				{
					printf("Rewinding\n");
					rewind(fp[n]);
					fgets(buffer,MAXBUF-1,fp[n]);
				}
				tok = strtok(buffer," \t\r\n");

				for (i = 0; i < NAges; i++)
				{
					MeanWeights[i][j] = atof(tok);
					tok = strtok(NULL," \t\r\n");

					if (MeanWeights[i][j] < 0.0)
						MeanWeights[i][j] = 0.0;
					if (MeanWeights[i][j] > MaxWeight)
						MeanWeights[i][j] = MaxWeight;
				}
			}
		}
		else
		{
			if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
			{
				printf("Rewinding\n");
				rewind(fp[n]);
				fgets(buffer,MAXBUF-1,fp[n]);
			}
			tok = strtok(buffer," \t\r\n");

			for (i = 0; i < NAges; i++)
			{
				MeanWeights[i][0] = atof(tok);
				tok = strtok(NULL," \t\r\n");

				if (MeanWeights[i][0] < 0.0)
					MeanWeights[i][0] = 0.0;
				if (MeanWeights[i][0] > MaxWeight)
					MeanWeights[i][0] = MaxWeight;
			}

			for (j = 1; j < NYears; j++)
				for (i = 0; i < NAges; i++)
					MeanWeights[i][j] = MeanWeights[i][0];

		}
	}
	else if (MeanStockWtFlag == -1)
	{
		for (j = 0; j < NYears; j++)
			for (i = 0; i < NAges; i++)
				MeanWeights[i][j] = StockWeights[i][j];
	}
	else if (MeanStockWtFlag == -2)
	{
		for (j = 0; j < NYears; j++)
			for (i = 0; i < NAges; i++)
				MeanWeights[i][j] = SpawnWeights[i][j];
	}
	else 
	{
		xlo = 0.0;
		xhi = MaxWeight;
	
		if (MeanStockWtTimeFlag)
		{
			for (j = 0; j < NYears; j++)
			{
				for (i = 0; i < NAges; i++)
				{
					x = AvgMeanStockWeight[i][j];
					cv = MeanStockWtErr[i];
					MeanWeights[i][j] = LogNormalError(x,cv,xlo,xhi);
				}
			}
		}
		else
		{
			for (i = 0; i < NAges; i++)
			{
				x = AvgMeanStockWeight[i][0];
				cv = MeanStockWtErr[i];
				MeanWeights[i][0] = LogNormalError(x,cv,xlo,xhi);
			}
			for (j = 1; j < NYears; j++)
				for (i = 0; i < NAges; i++)
					MeanWeights[i][j] = MeanWeights[i][0];
		}
	}


	if (FSelecFlag)
	{

		n = FSelecFileIndex;

		if (FSelecTimeFlag)
		{
			for (j = 0; j < NYears; j++)
			{

				if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
				{
					printf("Rewinding\n");
					rewind(fp[n]);
					fgets(buffer,MAXBUF-1,fp[n]);
				}
				tok = strtok(buffer," \t\r\n");
				for (k = 0; k < NFleet; k++)
				{
					xm = 0.0;
					for (i = 0; i < NAges; i++)
					{
						FleetSelec[i][j][k] = atof(tok);
						tok = strtok(NULL," \t\r\n");

						if (FleetSelec[i][j][k] < 0.0)
							FleetSelec[i][j][k] = 0.0;
						if (FleetSelec[i][j][k] > xm)
							xm = FleetSelec[i][j][k];
					}

					for (i = 0; i <NAges; i++)
						FleetSelec[i][j][k] = FleetSelec[i][j][k] / xm;
				}
			}
		}
		else
		{

			if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
			{
				printf("Rewinding\n");
				rewind(fp[n]);
				fgets(buffer,MAXBUF-1,fp[n]);
			}
			tok = strtok(buffer," \t\r\n");
			for (k = 0; k < NFleet; k++)
			{
				xm = 0.0;

				for (i = 0; i < NAges; i++)
				{
					FleetSelec[i][0][k] = atof(tok);
					tok = strtok(NULL," \t\r\n");

					if (FleetSelec[i][0][k] < 0.0)
						FleetSelec[i][0][k] = 0.0;
					if (FleetSelec[i][0][k] > xm)
						xm = FleetSelec[i][0][k];
				}

				for (i = 0; i <NAges; i++)
					FleetSelec[i][0][k] = FleetSelec[i][0][k] / xm;

				for (j = 1; j < NYears; j++)
					for (i = 0; i < NAges; i++)
						FleetSelec[i][j][k] = FleetSelec[i][0][k];
			}

		}
	}
	else
	{
		xlo = 0.0;
		xhi = 1.0;
		
		for (k = 0; k < NFleet; k++)
		{
			if (FSelecTimeFlag)
			{
				for (j = 0; j < NYears; j++)
				{
					xm = 0.0;
					for (i = 0; i < NAges; i++)
					{
						x = AvgFSelec[i][j][k];
						cv = FSelecErr[i][k];
						FleetSelec[i][j][k] = LogNormalError(x,cv,xlo,xhi);

						if (FleetSelec[i][j][k] > xm)
							xm = FleetSelec[i][j][k];
					}

					for (i = 0; i <NAges; i++)
						FleetSelec[i][j][k] = FleetSelec[i][j][k] / xm;
				}
			}
			else
			{
				xm = 0.0;
				for (i = 0; i < NAges; i++)
				{
					x = AvgFSelec[i][0][k];
					cv = FSelecErr[i][k];
					FleetSelec[i][0][k] = LogNormalError(x,cv,xlo,xhi);

					if (FleetSelec[i][0][k] > xm)
						xm = FleetSelec[i][0][k];
				}

				for (i = 0; i <NAges; i++)
					FleetSelec[i][0][k] = FleetSelec[i][0][k] / xm;

				for (j = 1; j < NYears; j++)
					for (i = 0; i < NAges; i++)
						FleetSelec[i][j][k] = FleetSelec[i][0][k];
										
			}

		}
	}

	if (DiscFlag && DiscFracFlag)
	{

		n = DiscFracFileIndex;

		if (DiscFracTimeFlag)
		{
			for (j = 0; j < NYears; j++)
			{
				if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
				{
					printf("Rewinding\n");
					rewind(fp[n]);
					fgets(buffer,MAXBUF-1,fp[n]);
				}
				tok = strtok(buffer," \t\r\n");
				for (k = 0; k < NFleet; k++)
				{
					for (i = 0; i < NAges; i++)
					{
						DiscFrac[i][j][k] = atof(tok);
						tok = strtok(NULL," \t\r\n");

						if (DiscFrac[i][j][k] < 0.0)
							DiscFrac[i][j][k] = 0.0;
						if (DiscFrac[i][j][k] > 1.0)
							DiscFrac[i][j][k] = 1.0;
					}
				}
			}
		}
		else
		{
			if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
			{
				printf("Rewinding\n");
				rewind(fp[n]);
				fgets(buffer,MAXBUF-1,fp[n]);
			}
			tok = strtok(buffer," \t\r\n");
			for (k = 0; k < NFleet; k++)
			{

				for (i = 0; i < NAges; i++)
				{
					DiscFrac[i][0][k] = atof(tok);
					tok = strtok(NULL," \t\r\n");

					if (DiscFrac[i][0][k] < 0.0)
						DiscFrac[i][0][k] = 0.0;
					if (DiscFrac[i][0][k] > 1.0)
						DiscFrac[i][0][k] = 1.0;
				}


				for (j = 1; j < NYears; j++)
					for (i = 0; i < NAges; i++)
						DiscFrac[i][j][k] = DiscFrac[i][0][k];
			}

		}
	}
	else if (DiscFlag)
	{
		xlo = 0.0;
		xhi = 1.0;
		
		for (k = 0; k < NFleet; k++)
		{
			if (DiscFracTimeFlag)
			{
				for (j = 0; j < NYears; j++)
				{
					for (i = 0; i < NAges; i++)
					{
						x = AvgDiscFrac[i][j][k];
						cv = DiscFracErr[i][k];
						DiscFrac[i][j][k] = LogNormalError(x,cv,xlo,xhi);
					}
				}
			}
			else
			{
				for (i = 0; i < NAges; i++)
				{
					x = AvgDiscFrac[i][0][k];
					cv = DiscFracErr[i][k];
					DiscFrac[i][0][k] = LogNormalError(x,cv,xlo,xhi);
				}


				for (j = 1; j < NYears; j++)
					for (i = 0; i < NAges; i++)
						DiscFrac[i][j][k] = DiscFrac[i][0][k];
										
			}
		}
	}
	if (CatchWtFlag > 0)
	{

		n = CatchWtFileIndex;

		if (CatchWtTimeFlag)
		{
			for (j = 0; j < NYears; j++)
			{
				if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
				{
					printf("Rewinding\n");
					rewind(fp[n]);
					fgets(buffer,MAXBUF-1,fp[n]);
				}
				tok = strtok(buffer," \t\r\n");
				for (k = 0; k < NFleet; k++)
				{
					for (i = 0; i < NAges; i++)
					{
						CatchWeights[i][j][k] = atof(tok);
						tok = strtok(NULL," \t\r\n");

						if (CatchWeights[i][j][k] < 0.0)
							CatchWeights[i][j][k] = 0.0;
						if (CatchWeights[i][j][k] > MaxWeight)
							CatchWeights[i][j][k] = MaxWeight;
					}
				}
			}
		}
		else
		{
			if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
			{
				printf("Rewinding\n");
				rewind(fp[n]);
				fgets(buffer,MAXBUF-1,fp[n]);
			}
			tok = strtok(buffer," \t\r\n");
			for (k = 0; k < NFleet; k++)
			{
				for (i = 0; i < NAges; i++)
				{
					CatchWeights[i][0][k] = atof(tok);
					tok = strtok(NULL," \t\r\n");

					if (CatchWeights[i][0][k] < 0.0)
						CatchWeights[i][0][k] = 0.0;
					if (CatchWeights[i][0][k] > MaxWeight)
						CatchWeights[i][0][k] = MaxWeight;
				}


				for (j = 1; j < NYears; j++)
					for (i = 0; i < NAges; i++)
						CatchWeights[i][j][k] = CatchWeights[i][0][k];
			}

		}
	}
	else if (CatchWtFlag == -1)
	{
		for (k = 0; k < NFleet; k++)
			for (j = 0; j < NYears; j++)
				for (i = 0; i < NAges; i++)
					CatchWeights[i][j][k] = StockWeights[i][j];
	}
	else if (CatchWtFlag == -2)
	{
		for (k = 0; k < NFleet; k++)
			for (j = 0; j < NYears; j++)
				for (i = 0; i < NAges; i++)
					CatchWeights[i][j][k] = SpawnWeights[i][j];
	}
	else if (CatchWtFlag == -3)
	{
		for (k = 0; k < NFleet; k++)
			for (j = 0; j < NYears; j++)
				for (i = 0; i < NAges; i++)
					CatchWeights[i][j][k] = MeanWeights[i][j];
	}
	else 
	{
		xlo = 0.0;
		xhi = MaxWeight;
		
		for (k = 0; k < NFleet; k++)
		{
			if (CatchWtTimeFlag)
			{
				for (j = 0; j < NYears; j++)
				{
					for (i = 0; i < NAges; i++)
					{
						x = AvgCatchWeight[i][j][k];
						cv = CatchWtErr[i][k];
						CatchWeights[i][j][k] = LogNormalError(x,cv,xlo,xhi);
					}
				}
			}
			else
			{
				for (i = 0; i < NAges; i++)
				{
					x = AvgCatchWeight[i][0][k];
					cv = CatchWtErr[i][k];
					CatchWeights[i][0][k] = LogNormalError(x,cv,xlo,xhi);
				}


				for (j = 1; j < NYears; j++)
					for (i = 0; i < NAges; i++)
						CatchWeights[i][j][k] = CatchWeights[i][0][k];
										
			}
		}
	}

	if (DiscFlag && DiscWtFlag > 0)
	{

		n = DiscWtFileIndex;

		if (DiscWtTimeFlag)
		{
			for (j = 0; j < NYears; j++)
			{
				if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
				{
					printf("Rewinding\n");
					rewind(fp[n]);
					fgets(buffer,MAXBUF-1,fp[n]);
				}
				tok = strtok(buffer," \t\r\n");
				for (k = 0; k < NFleet; k++)
				{
					for (i = 0; i < NAges; i++)
					{
						DiscWeights[i][j][k] = atof(tok);
						tok = strtok(NULL," \t\r\n");

						if (DiscWeights[i][j][k] < 0.0)
							DiscWeights[i][j][k] = 0.0;
						if (DiscWeights[i][j][k] > MaxWeight)
							DiscWeights[i][j][k] = MaxWeight;
					}
				}
			}
		}
		else
		{
			if ((c = fgets(buffer,MAXBUF-1,fp[n])) == NULL)
			{
				printf("Rewinding\n");
				rewind(fp[n]);
				fgets(buffer,MAXBUF-1,fp[n]);
			}
			tok = strtok(buffer," \t\r\n");
			for (k = 0; k < NFleet; k++)
			{
				for (i = 0; i < NAges; i++)
				{
					DiscWeights[i][0][k] = atof(tok);
					tok = strtok(NULL," \t\r\n");

					if (DiscWeights[i][0][k] < 0.0)
						DiscWeights[i][0][k] = 0.0;
					if (DiscWeights[i][0][k] > MaxWeight)
						DiscWeights[i][0][k] = MaxWeight;
				}


				for (j = 1; j < NYears; j++)
					for (i = 0; i < NAges; i++)
						DiscWeights[i][j][k] = DiscWeights[i][0][k];
			}
		}
	}
	else if (DiscFlag && DiscWtFlag == -1)
	{
		for (k = 0; k < NFleet; k++)
			for (j = 0; j < NYears; j++)
				for (i = 0; i < NAges; i++)
					DiscWeights[i][j][k] = StockWeights[i][j];
	}
	else if (DiscFlag && DiscWtFlag == -2)
	{
		for (k = 0; k < NFleet; k++)
			for (j = 0; j < NYears; j++)
				for (i = 0; i < NAges; i++)
					DiscWeights[i][j][k] = SpawnWeights[i][j];
	}
	else if (DiscFlag && DiscWtFlag == -3)
	{
		for (k = 0; k < NFleet; k++)
			for (j = 0; j < NYears; j++)
				for (i = 0; i < NAges; i++)
					DiscWeights[i][j][k] = MeanWeights[i][j];
	}
	else if (DiscFlag && DiscWtFlag == -4)
	{
		for (k = 0; k < NFleet; k++)
			for (j = 0; j < NYears; j++)
				for (i = 0; i < NAges; i++)
					DiscWeights[i][j][k] = CatchWeights[i][j][k];
	}
	else if (DiscFlag)
	{
		xlo = 0.0;
		xhi = MaxWeight;
		
		for (k = 0; k < NFleet; k++)
		{
			if (DiscWtTimeFlag)
			{
				for (j = 0; j < NYears; j++)
				{
					xm = 0.0;
					for (i = 0; i < NAges; i++)
					{
						x = AvgDiscWeight[i][j][k];
						cv = DiscWtErr[i][k];
						DiscWeights[i][j][k] = LogNormalError(x,cv,xlo,xhi);
					}
				}
			}
			else
			{
				for (i = 0; i < NAges; i++)
				{
					x = AvgDiscWeight[i][0][k];
					cv = DiscWtErr[i][k];
					DiscWeights[i][0][k] = LogNormalError(x,cv,xlo,xhi);
				}


				for (j = 1; j < NYears; j++)
					for (i = 0; i < NAges; i++)
						DiscWeights[i][j][k] = DiscWeights[i][0][k];
										
			}
		}
	}
}
void ApplyMortality(long j)
{
	long i, k;
	double m, z, f, zx;
	double xc, xd, fd;




	for (i = 0; i < NAges; i++)
	{
		FMort[i][j] = 0.0;

		FMult[j] = 0.0;

		for (k = 0; k < NFleet; k++)
		{
			FMortFleet[i][k] = FFleet[j][k] * FleetSelec[i][j][k];
			FMort[i][j] += FMortFleet[i][k];
			FMult[j] += FFleet[j][k];
		}
	}


	StockAge[0][j+1] = 0.0;


	for (i = 0; i < NAges-1; i++)
	{
		f = FMort[i][j];
		m = NatMort[i][j];
		z = f + m;
		StockAge[i+1][j+1] = StockAge[i][j] * exp(-z);
	}

	/* Plus Group */

	f = FMort[NAges-1][j];
	m = NatMort[NAges-1][j];
	z = f + m;

	StockAge[NAges-1][j+1] += StockAge[NAges-1][j] * exp(-z);



	for (i = 0; i < NAges; i++)
	{
		f = FMort[i][j];
		m = NatMort[i][j];
		z = f + m;

		zx = f * TF[j] + m * TM[j];

		MeanStock[i][j]  = StockAge[i][j] * (1.0 - exp(-z)) / z;

		SpawnStock[i][j] = StockAge[i][j] * Maturity[i][j] * exp(-zx);

		fd = 0.0;
		if (DiscFlag)
		{
			for (k = 0; k < NFleet; k ++)
			{
				fd += DiscFrac[i][j][k] * FMortFleet[i][k] / FMort[i][j];
			}
		}

		xd = 1.0 - fd;

		xc = f * (1.0 - exp(-z)) / z;

		CatchAge[i][j] = StockAge[i][j] * xc * xd;
		DiscAge[i][j]  = StockAge[i][j] * xc * fd;
	}

	
	StockBiomass[j] = 0.0;
	CatchBiomass[j] = 0.0;
	Landings[j]		= 0.0;
	Discards[j]		= 0.0;

	SpawnBiomass[j] = 0.0;
	MeanBiomass[j] = 0.0;

	for (i = 0; i < NAges; i++)
	{
		StockBiomass[j] += StockAge[i][j] * StockWeights[i][j] / 1000.0;
		SpawnBiomass[j] += SpawnStock[i][j] * SpawnWeights[i][j] / 1000.0;
		MeanBiomass[j]  += MeanStock[i][j] * MeanWeights[i][j] / 1000.0;
	}

	
	for (k = 0; k < NFleet; k++)
	{
		FleetDisc[j][k]  = 0.0;
		FleetLand[j][k]	 = 0.0;
		FleetCatch[j][k] = 0.0;
	}

	for (k = 0; k < NFleet; k++)
	{
		for (i = 0; i < NAges; i++)
		{
			if (FMort[i][j] > 0.0)
				FleetLand[j][k] += CatchAge[i][j] * CatchWeights[i][j][k] * FMortFleet[i][k] / FMort[i][j] / 1000.0;


			if (DiscFlag)
			{
				if (FMort[i][j] > 0.0)
					FleetDisc[j][k] += DiscAge[i][j] * DiscWeights[i][j][k] * FMortFleet[i][k] / FMort[i][j] / 1000.0;

			}
			
		}

		FleetCatch[j][k] = FleetLand[j][k] + FleetDisc[j][k];
		Landings[j]     += FleetLand[j][k];
		Discards[j]     += FleetDisc[j][k];
	}
		
	CatchBiomass[j] = Landings[j] + Discards[j];

}
void ApplyHarvestQuota(long j)
{
	long k;
	long iter;
	double err, FTot;

	/* Initial Guess */
	
	FTot = 0.5;

	for (k = 0; k < NFleet; k++)
		FFleet[j][k] = FTot / (double) NFleet;

	iter = 0;

	/* Calculate F by Fleet to Match Quota */

	while (iter < MXITER)
	{
		for (k = 0; k < NFleet; k++)
			CalcHarvestF(j, k);

		err = (FTot - FMult[j]) / FTot;

		if (fabs(err) < XTOL)
			return;

		FTot = FMult[j];

		iter++;
	}


}
void CalcHarvestF(long j, long k)
{
	long i;
	long iter;
	double err1, err2, slope;
	double xx, x2;
	double hcalc, htarget;

	htarget = HarvestValue[j][k];

	xx = FFleet[j][k];

	iter = 0;

	while (iter < MXITER)
	{
		FFleet[j][k] = xx;

		ApplyMortality(j);

		if (HarvestSpec[j] == 1)
		{
			hcalc = 0.0;
			for (i = 0; i < NAges; i++)
			{
				if (FMort[i][j] > 0.0)
					hcalc += CatchAge[i][j] * CatchWeights[i][j][k] * FMortFleet[i][k] / FMort[i][j] / 1000.0;
			}

		}
		else
		{
			hcalc = 0.0;
			for (i = 0; i < NAges; i++)
			{
				if (FMort[i][j] > 0.0)
				{
					hcalc += CatchAge[i][j] * CatchWeights[i][j][k] * FMortFleet[i][k] / FMort[i][j] / 1000.0;
					hcalc += DiscAge[i][j] * DiscWeights[i][j][k] * FMortFleet[i][k] / FMort[i][j] / 1000.0;
				}
			}
		}

		err1 = (hcalc - htarget) / htarget;

		if (fabs(err1) < XTOL)
			return;

		if (iter == 0)
		{
			x2 = xx;
			err2 = err1;

			if (hcalc < htarget)
				xx = 1.0;
			else
				xx = 0.1;

		}
		else
		{
			slope = (err2 - err1) / (x2 - xx);
			x2 = xx;
			err2 = err1;

			xx = (slope * xx - err2) / slope;
		}

		if (xx > XUBOUND)
			xx = XUBOUND;

		if (xx < XLBOUND)
			xx = XLBOUND;

		iter++;
	}

}
void AllocRecruit()
{
	long i;
	long ParmFlag;
	long EmpFlag;
	long PredFlag;


	ParmFlag = EmpFlag = PredFlag = 0;

	for (i = 0; i < NRecModel; i++)
	{
		if (RecruitType[i] > 4 && RecruitType[i] < 14)
			ParmFlag = 1;
		else if (RecruitType[i] == 14 || RecruitType[i] == 15 || RecruitType[i] == 3 || RecruitType[i] >= 20)
			EmpFlag = 1;
		else if (RecruitType[i] == 2 || RecruitType[i] == 4)
			EmpFlag = 2;
		else if (RecruitType[i] > 15)
			PredFlag = 1;
	}

	if (ParmFlag)
	{
		RecParms = AllocMatrix(MXRECPARM,NRecModel);
		ZeroMatrix(RecParms,MXRECPARM,NRecModel);
	}

	if (EmpFlag == 1)
	{
		KRecObs = (long *) calloc(NRecModel,sizeof(long));
		NRecObs = (long *) calloc(NRecModel,sizeof(long));

		SSBreak = (double *) calloc(NRecModel,sizeof(double));

		for (i = 0; i < NRecModel; i++)
		{
			KRecObs[i] = 0;
			NRecObs[i] = 0;
			SSBreak[i] = 0.0;
		}

		RecObs1 = AllocMatrix(MaxRecObs,NRecModel);
		RecObs2 = AllocMatrix(MaxRecObs,NRecModel);

		ZeroMatrix(RecObs1,MaxRecObs,NRecModel);
		ZeroMatrix(RecObs2,MaxRecObs,NRecModel);
	}
	else if (EmpFlag == 2)
	{
		KRecObs = (long *) calloc(NRecModel,sizeof(long));
		NRecObs = (long *) calloc(NRecModel,sizeof(long));

		SSBreak = (double *) calloc(NRecModel,sizeof(double));

		for (i = 0; i < NRecModel; i++)
		{
			KRecObs[i] = 0;
			NRecObs[i] = 0;
			SSBreak[i] = 0.0;
		}


		RecObs1 = AllocMatrix(MaxRecObs,NRecModel);
		RecObs2 = AllocMatrix(MaxRecObs,NRecModel);
		SSBObs1 = AllocMatrix(MaxRecObs,NRecModel);
		SSBObs2 = AllocMatrix(MaxRecObs,NRecModel);

		ZeroMatrix(RecObs1,MaxRecObs,NRecModel);
		ZeroMatrix(RecObs2,MaxRecObs,NRecModel);
		ZeroMatrix(SSBObs1,MaxRecObs,NRecModel);
		ZeroMatrix(SSBObs2,MaxRecObs,NRecModel);

	}

	if (PredFlag)
	{
		NRecPred     = (long *) calloc(NRecModel,sizeof(long));
		RecPredBZero = (double *) calloc(NRecModel,sizeof(double));
		RecPredVar   = (double *) calloc(NRecModel,sizeof(double));

		RecPredCoeff = AllocMatrix(MXRECPRED,NRecModel);
		ZeroMatrix(RecPredCoeff,MXRECPRED,NRecModel);

		RecPredObs = AllocMat3(MXRECPRED,NYears,NRecModel);
		ZeroMat3(RecPredObs,MXRECPRED,NYears,NRecModel);
	}

	ObsData1     = (double *) calloc(MaxRecObs,sizeof(double));
	AutoResidVar = AllocMatrix(NYears+1,NRecModel);
}
void ReadRecruitModelInput(long k,long n)
{
	
	char buffer[MAXBUF];
	char *tok;
	long i, j;
	long kk, nn;

	switch(n)
	{
		case 1:

			/* Markov Matrix */


			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			MarkovN = atol(tok);
			tok = strtok(NULL," \t\r\n");
			MarkovK = atol(tok);

			MarkovRec = (double *) calloc(MarkovN,sizeof(double));
			MarkovSSB = (double *) calloc(MarkovK,sizeof(double));

			MarkovProb = AllocMatrix(MarkovK,MarkovN);

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < MarkovN; i++)
			{
				MarkovRec[i] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < MarkovK; i++)
			{
				MarkovSSB[i] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}

			for (i = 0; i < MarkovK; i++)
			{
				fgets(buffer,MAXBUF-1,fp1);
				tok = strtok(buffer," \t\r\n");
				for (j = 0; j < MarkovN; j++)
				{
					MarkovProb[i][j] = atof(tok);
					tok = strtok(NULL," \t\r\n");
				}
			}

			break;

		case 2:

			/* Empirical CDF of R/S */


			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			kk = atol(tok);

			NRecObs[k] = kk;

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < kk; i++)
			{
				RecObs1[i][k] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < kk; i++)
			{
				SSBObs1[i][k] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}

			break;

		case 3:

			/* Empirical Recruitment */


			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			kk = atol(tok);

			NRecObs[k] = kk;

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < kk; i++)
			{
				RecObs1[i][k] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}

			break;

		case 4:

			/* 2- Stage Empirical CDF of R/S */

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			kk = atol(tok);

			KRecObs[k] = kk;

			tok = strtok(NULL," \t\r\n");
			nn = atol(tok);

			NRecObs[k] = nn;

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < kk; i++)
			{
				RecObs1[i][k] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < kk; i++)
			{
				SSBObs1[i][k] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}


			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < nn; i++)
			{
				RecObs2[i][k] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < nn; i++)
			{
				SSBObs2[i][k] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			SSBreak[k] = atof(tok);

			break;

		case 5:
		case 6:

			/* Beverton Holt or Ricker */


			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			RecParms[0][k] = atof(tok);

			tok = strtok(NULL," \t\r\n");
			RecParms[1][k] = atof(tok);

			tok = strtok(NULL," \t\r\n");
			RecParms[2][k] = atof(tok);


			break;

		case 7:

			/* Shepherd */

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			RecParms[0][k] = atof(tok);

			tok = strtok(NULL," \t\r\n");
			RecParms[1][k] = atof(tok);

			tok = strtok(NULL," \t\r\n");
			RecParms[2][k] = atof(tok);

			tok = strtok(NULL," \t\r\n");
			RecParms[3][k] = atof(tok);

			break;

		case 8:

			/* Lognormal Distribution */

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			RecParms[0][k] = atof(tok);

			tok = strtok(NULL," \t\r\n");
			RecParms[1][k] = atof(tok);

			break;

		case 10:
		case 11:

			/* Beverton Holt or Ricker  w/ Autocorrelation */


			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			RecParms[0][k] = atof(tok);

			tok = strtok(NULL," \t\r\n");
			RecParms[1][k] = atof(tok);

			tok = strtok(NULL," \t\r\n");
			RecParms[2][k] = atof(tok);

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			RecParms[3][k] = atof(tok);

			tok = strtok(NULL," \t\r\n");
			RecParms[4][k] = atof(tok);

			AutoResidVar[0][k] = RecParms[4][k];


			break;

		case 12:

			/* Shepherd w/Autocorrelation */

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			RecParms[0][k] = atof(tok);

			tok = strtok(NULL," \t\r\n");
			RecParms[1][k] = atof(tok);

			tok = strtok(NULL," \t\r\n");
			RecParms[2][k] = atof(tok);

			tok = strtok(NULL," \t\r\n");
			RecParms[3][k] = atof(tok);

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			RecParms[4][k] = atof(tok);

			tok = strtok(NULL," \t\r\n");
			RecParms[5][k] = atof(tok);

			AutoResidVar[0][k] = RecParms[5][k];

			break;

		case 13:

			/* Lognormal Distribution w/Autocorrelation */

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			RecParms[0][k] = atof(tok);

			tok = strtok(NULL," \t\r\n");
			RecParms[1][k] = atof(tok);

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			RecParms[2][k] = atof(tok);

			tok = strtok(NULL," \t\r\n");
			RecParms[3][k] = atof(tok);

			AutoResidVar[0][k] = RecParms[3][k];

			break;

		case 14:

			/* Empirical CDF Recruitment */

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			kk = atol(tok);

			NRecObs[k] = kk;

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < kk; i++)
			{
				RecObs1[i][k] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}

			break;

		case 15:

			/* 2-Stage Empirical CDF of Recruitment */

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			kk = atol(tok);

			KRecObs[k] = kk;

			tok = strtok(NULL," \t\r\n");
			nn = atol(tok);

			NRecObs[k] = nn;

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < kk; i++)
			{
				RecObs1[i][k] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < nn; i++)
			{
				RecObs2[i][k] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			SSBreak[k] = atof(tok);

			break;

		case 16:  case 17: case 18: case 19:

			/*  Predictors */

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			NRecPred[k] = atol(tok);

			tok = strtok(NULL," \t\r\n");
			RecPredVar[k] = atof(tok);
			tok = strtok(NULL," \t\r\n");
			RecPredBZero[k] = atof(tok);

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < NRecPred[k]; i++)
			{
				RecPredCoeff[i][k] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}

			for (i = 0; i < NRecPred[k]; i++)
			{
				fgets(buffer,MAXBUF-1,fp1);
				tok = strtok(buffer," \t\r\n");
				for (j = 0; j < NYears; j++)
				{
					RecPredObs[i][j][k] = atof(tok);
					tok = strtok(NULL," \t\r\n");
				}
			}

			break;

		case 20:

			/* Fixed Recruitment */

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			kk = atol(tok);

			NRecObs[k] = kk;

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < kk; i++)
			{
				RecObs1[i][k] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}

			break;

		case 21:

			/* Empirical CDF with Linear Decline to Zero */
			
			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			kk = atol(tok);

			NRecObs[k] = kk;

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (i = 0; i < kk; i++)
			{
				RecObs1[i][k] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}

			/* Read SSB Hinge Point */

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			SSBreak[k] = atof(tok);


			break;

		default:

			fprintf(stderr,"Recruitment Method Not Supported\n");
			exit(1);
	}

}
void ApplyRecruitment(long j)
{
	long i, k, n;
	double rnum, prob;
	double ssb;


	ssb = SpawnBiomass[j];

	n = 0;

	if (NRecModel > 1)
	{
		/* Select Recruitment Method Based Recruitment Probability */

		rnum = ranx();

		prob = 0.0;
		for (i = 0; i < NRecModel; i++)
		{
			prob += RecruitProb[j][i];

			if (rnum < prob + XTOL)
			{
				n = i;
				break;

			}
		}

	}

	RecDist[j][n] += 1.0;

	k = RecruitType[n];

	switch(k)
	{
		case 1:
			Recruits[j] = RecruitModel1(ssb);
			break;
		case 2:
			Recruits[j] = RecruitModel2(n,ssb);
			break;
		case 3:
			Recruits[j] = RecruitModel3(n);
			break;
		case 4:
			Recruits[j] = RecruitModel4(n,ssb);
			break;
		case 5:
			Recruits[j] = RecruitModel5(n,ssb);
			break;
		case 6:
			Recruits[j] = RecruitModel6(n,ssb);
			break;
		case 7:
			Recruits[j] = RecruitModel7(n,ssb);
			break;
		case 8:
			Recruits[j] = RecruitModel8(n);
			break;
		case 10:
			Recruits[j] = RecruitModel10(n,j,ssb);
			break;
		case 11:
			Recruits[j] = RecruitModel11(n,j,ssb);
			break;
		case 12:
			Recruits[j] = RecruitModel12(n,j,ssb);
			break;
		case 13:
			Recruits[j] = RecruitModel13(n,j);
			break;
		case 14:
			Recruits[j] = RecruitModel14(n);
			break;
		case 15:
			Recruits[j] = RecruitModel15(n,ssb);
			break;
		case 16:
			Recruits[j] = RecruitModel16(n,j,ssb);
			break;
		case 17:
			Recruits[j] = RecruitModel17(n,j,ssb);
			break;
		case 18:
			Recruits[j] = RecruitModel18(n,j);
			break;
		case 19:
			Recruits[j] = RecruitModel19(n,j);
			break;
		case 20:
			Recruits[j] = RecruitModel20(n,j);
			break;
		case 21:
			Recruits[j] = RecruitModel21(n,ssb);
			break;
		default:
			fprintf(stderr,"Invalid Recruitment Method: %ld\n",k);
			exit(1);
	}



	if (NFAge == 0)
	{
		if (j == 0)
			Recruits[0] = StockAge[0][0];
		else
			StockAge[0][j] = Recruits[j];
	}
	else
		StockAge[0][j+1] = Recruits[j];

}
double RecruitModel1(double ssb)
{
	
	/* Markov Matrix */


	long i, k, n;
	long kx, nx;
	double rnum, prob;
	double xr;

	ssb = ssb / SSBFac;

	xr = 0.0;


	k = MarkovK;
	n = MarkovN;

	kx = k-1;

	for (i = 0; i < k; k++)
	{
		if (ssb < MarkovSSB[i])
		{
			kx = i;
			break;
		}
	}

	rnum = ranx();

	prob = 0;

	for (i = 0; i < n; i++)
	{
		prob += MarkovProb[kx][i];

		if (rnum < prob + XTOL)
		{
			nx = i;
			break;
		}
	}

	xr = MarkovRec[nx];

	xr = xr * RecFac;

	return(xr);

}
double RecruitModel2(long n,double ssb)
{
	/* Empirical CDF of R/S */

	long i, k;
	double xx, xr;

	ssb = ssb / SSBFac;

	xr = 0.0;

	k = NRecObs[n];

	for (i = 0; i < k; i++)
		ObsData1[i] = RecObs1[i][n] / SSBObs1[i][n];

	xx = EmpiricalCDF(k,ObsData1);

	xr = xx * ssb;

	xr = xr * RecFac;


	return(xr);

}
double RecruitModel3(long n)
{
	/* Empirical Recruitment */

	long i, k, k1;
	double rnum;
	double x1, xr;

	xr = 0.0;

	k = NRecObs[n];

	for (i = 0; i < k; i++)
		ObsData1[i] = RecObs1[i][n];

	BubbleUpSort(k,ObsData1);

	rnum = ranx();

	x1 = floor(rnum * (double) (k));
	k1 = (long) x1;

	xr = ObsData1[k1];

	xr = xr * RecFac;

	return(xr);


}
double RecruitModel4(long n,double ssb)
{
	/* 2-Stage Empirical CDF of R/S */

	long i, k;
	double xx, xr;

	ssb = ssb / SSBFac;

	xr = 0.0;


	if (ssb > SSBreak[n])
	{

		k = NRecObs[n];

		for (i = 0; i < k; i++)
			ObsData1[i] = RecObs2[i][n] / SSBObs2[i][n];
	}
	else
	{
		k = KRecObs[n];

		for (i = 0; i < k; i++)
			ObsData1[i] = RecObs1[i][n] / SSBObs1[i][n];
	}



	xx = EmpiricalCDF(k,ObsData1);

	xr = xx * ssb;

	xr = xr * RecFac;


	return(xr);

}
double RecruitModel5(long n,double ssb)
{

	/* Beverton - Holt */

	double alpha, beta;
	double x, xx, xr;
	double sd;
	double var;
	double zscore;

	ssb = ssb / SSBFac;

	alpha = RecParms[0][n];
	beta  = RecParms[1][n];
	var   = RecParms[2][n];

	x = alpha * ssb / (beta + ssb);

	sd = sqrt(var);

	do
	{

		/* Get Zscore from Box-muller Transformation*/

		zscore = gsl_box_muller();


		xx = x * exp(zscore * sd);

	} while (xx < 0.001);

	xr = xx * RecFac;

	return(xr);


}
double RecruitModel6(long n,double ssb)
{
	/* Ricker Equation */

	double alpha, beta;
	double x, xx, xr;
	double sd;
	double var;
	double zscore;

	ssb = ssb / SSBFac;

	alpha = RecParms[0][n];
	beta  = RecParms[1][n];
	var   = RecParms[2][n];
	
	x = alpha * ssb * exp(-beta*ssb);

	sd = sqrt(var);

	do
	{

		/* Get Zscore from Box muller Transformation */

		zscore = gsl_box_muller();


		xx = x * exp(zscore * sd);

	} while (xx < 0.001);

	xr = xx * RecFac;

	return(xr);


}
double RecruitModel7(long n,double ssb)
{
	/* Shepherd Equation */

	double alpha, beta, kparm;
	double x, xx, xr;
	double sd;
	double var;
	double zscore;

	ssb = ssb / SSBFac;

	alpha = RecParms[0][n];
	beta  = RecParms[1][n];
	kparm = RecParms[2][n];
	var   = RecParms[3][n];

	xx = ssb / kparm;

	x = alpha * ssb / (1.0 + pow(xx,beta));

	sd = sqrt(var);

	do
	{

		/* Get Zscore from Box-muller Transformation */

		zscore = gsl_box_muller();

		xx = x * exp(zscore * sd);

	} while (xx < 0.001);

	xr = xx * RecFac;

	return(xr);


}
double RecruitModel8(long n)
{

	/* Lognormal Distribution */

	double sd;
	double zscore;
	double x,xx,xr;


	x  = RecParms[0][n];
	sd = RecParms[1][n];

	do
	{


		/* Get Zscore from Box-muller Transformation */

		zscore = gsl_box_muller();

		xx = exp(x + zscore * sd);

	} while (xx < 0.001);


	xr = xx * RecFac;

	return(xr);

}
double RecruitModel10(long n,long j,double ssb)
{

	/* Beverton - Holt w/ Autocorrelation */

	double alpha, beta;
	double x, xx, xr;
	double sd;
	double var;
	double phi;
	double zscore;

	ssb = ssb / SSBFac;

	alpha = RecParms[0][n];
	beta  = RecParms[1][n];
	var   = RecParms[2][n];
	phi   = RecParms[3][n];

	x = alpha * ssb / (beta + ssb);

	var = (1.0 - phi * phi) * var;

	sd = sqrt(var);

	do
	{

		/* Get Zscore from Box-muller Transformation */

		zscore = gsl_box_muller();

		zscore = zscore * sd;

		zscore = zscore + phi * AutoResidVar[j][n];

		xx = x * exp(zscore);

	} while (xx < 0.001);

	AutoResidVar[j+1][n] = log(xx) - log(x);

	xr = xx * RecFac;

	return(xr);


}
double RecruitModel11(long n,long j,double ssb)
{
	/* Ricker Equation w/Autocorrelation */

	double alpha, beta;
	double x, xx, xr;
	double sd;
	double var;
	double phi;
	double zscore;

	ssb = ssb / SSBFac;

	alpha = RecParms[0][n];
	beta  = RecParms[1][n];
	var   = RecParms[2][n];
	phi   = RecParms[3][n];

	x = alpha * ssb * exp(-beta*ssb);

	var = (1.0 - phi * phi) * var;

	sd = sqrt(var);

	do
	{

		/* Get Zscore from Box-muller Transformation */

		zscore = gsl_box_muller();

		zscore = zscore * sd;

		zscore = zscore + phi * AutoResidVar[j][n];

		xx = x * exp(zscore);

	} while (xx < 0.001);


	AutoResidVar[j+1][n] = log(xx) - log(x);

	xr = xx * RecFac;

	return(xr);


}
double RecruitModel12(long n,long j,double ssb)
{
	/* Shepherd Equation w/Autocorrelation */

	double alpha, beta, kparm;
	double x, xx, xr;
	double sd;
	double var;
	double phi;
	double zscore;

	ssb = ssb / SSBFac;

	alpha = RecParms[0][n];
	beta  = RecParms[1][n];
	kparm = RecParms[2][n];
	var   = RecParms[3][n];
	phi   = RecParms[4][n];

	xx = ssb / kparm;

	x = alpha * ssb / (1.0 + pow(xx,beta));

	var = (1.0 - phi * phi) * var;

	sd = sqrt(var);

	do
	{


		/* Get Zscore from Box-muller Transformation */

		zscore = gsl_box_muller();

		zscore = zscore * sd;

		zscore = zscore + phi * AutoResidVar[j][n];

		xx = x * exp(zscore);

	} while (xx < 0.001);

	xr = xx * RecFac;

	AutoResidVar[j+1][n] = log(xx) - log(x);

	return(xr);

}
double RecruitModel13(long n,long j)
{

	/* Lognormal Distribution w/Autocorrelation  */

	double sd;
	double zscore;
	double var, phi;
	double x,xx,xr;


	x    = RecParms[0][n];
	var  = RecParms[1][n];
	phi  = RecParms[2][n];

	var = (1.0 - phi * phi) * var;

	sd = sqrt(var);


	do
	{

		/* Get Zscore from Box-muller Transformation */

		zscore = gsl_box_muller();

		zscore = zscore * sd;

		zscore = zscore + phi * AutoResidVar[j][n];

		xx = exp(x + zscore);

	} while (xx < 0.001);


	xr = xx * RecFac;

	AutoResidVar[j+1][n] = log(xx) - x;

	return(xr);

}
double RecruitModel14(long n)
{

	/* Empirical CDF of Recruitment */

	long i, k;
	double xr;


	xr = 0.0;

	k = NRecObs[n];

	for (i = 0; i < k; i++)
		ObsData1[i] = RecObs1[i][n];

	xr = EmpiricalCDF(k,ObsData1);


	xr = xr * RecFac;


	return(xr);

}
double RecruitModel15(long n,double ssb)
{

	/* 2-Stage Empirical CDF of Recruitment */

	long i, k;
	double xr;


	ssb = ssb / SSBFac;


	if (ssb > SSBreak[n])
	{

		k = NRecObs[n];

		for (i = 0; i < k; i++)
			ObsData1[i] = RecObs2[i][n];
	}
	else
	{
		k = KRecObs[n];

		for (i = 0; i < k; i++)
			ObsData1[i] = RecObs1[i][n];
	}


	xr = 0.0;


	xr = EmpiricalCDF(k,ObsData1);

	xr = xr * RecFac;


	return(xr);

}
double RecruitModel16(long n,long j,double ssb)
{
	/* Linear R/SSB Predictor with Normal Error */

	long i, k;
	double var, sd, zscore;
	double bzero;
	double xx, xr;

	ssb = ssb / SSBFac;

	k = NRecPred[n];

	var = RecPredVar[n];
	bzero = RecPredBZero[n];

	sd = sqrt(var);


	do
	{
		/* Get Zscore from Box-muller Transformation */

		zscore = gsl_box_muller();

		xx = bzero + zscore * sd;

		for (i = 0; i < k; i++)
			xx += RecPredCoeff[i][n] * RecPredObs[i][j][n];

		xr = xx * ssb;

	} while (xr < 0.001);

	xr = xr * RecFac;


	return(xr);
}
double RecruitModel17(long n,long j,double ssb)
{
	/* Linear R/SSB Predictor with Lognormal Error */

	long i, k;
	double var, sd, zscore;
	double bzero;
	double xx, xr;

	ssb = ssb / SSBFac;

	k = NRecPred[n];

	var = RecPredVar[n];
	bzero = RecPredBZero[n];

	sd = sqrt(var);


	do
	{
		/* Get Zscore from Box-muller Transformation */

		zscore = gsl_box_muller();

		zscore = zscore * sd - 0.5 *var;

		xx = bzero + zscore;

		for (i = 0; i < k; i++)
			xx += RecPredCoeff[i][n] * RecPredObs[i][j][n];

		xx = exp(xx);

		xr = xx * ssb;

	} while (xr < 0.001);

	xr = xr * RecFac;


	return(xr);
}
double RecruitModel18(long n,long j)
{
	/* Linear Recruitment Predictor with Normal Error */

	long i, k;
	double var, sd, zscore;
	double bzero;
	double xr;

	k = NRecPred[n];

	var = RecPredVar[n];
	bzero = RecPredBZero[n];

	sd = sqrt(var);


	do
	{
		/* Get Zscore from Box-muller Transformation */

		zscore = gsl_box_muller();

		xr = bzero + zscore * sd;

		for (i = 0; i < k; i++)
			xr += RecPredCoeff[i][n] * RecPredObs[i][j][n];


	} while (xr < 0.001);

	xr = xr * RecFac;


	return(xr);
}
double RecruitModel19(long n,long j)
{
	/* Linear Recruit Predictor with Lognormal Error */

	long i, k;
	double var, sd, zscore;
	double bzero;
	double xx, xr;

	k = NRecPred[n];

	var = RecPredVar[n];
	bzero = RecPredBZero[n];

	sd = sqrt(var);


	do
	{

		/* Get Zscore from Box-muller Transformation */

		zscore = gsl_box_muller();

		zscore = zscore * sd - 0.5 *var;

		xx = bzero + zscore;

		for (i = 0; i < k; i++)
			xx += RecPredCoeff[i][n] * RecPredObs[i][j][n];

		xr = exp(xx);


	} while (xr < 0.001);

	xr = xr * RecFac;


	return(xr);
}
double RecruitModel20(long n, long j)
{
	/* Fixed Recruitment */

	double xr;

		xr = RecObs1[j][n];

		xr = xr * RecFac;


	return(xr);

}
double RecruitModel21(long n,double ssb)
{

	/* 1-Stage Empirical CDF with Linear Decline to Zero */

	long i, k;
	double xr;


	ssb = ssb / SSBFac;


	xr = 0.0;

	k = NRecObs[n];

	for (i = 0; i < k; i++)
		ObsData1[i] = RecObs1[i][n];

	xr = EmpiricalCDF(k,ObsData1);

	if (ssb < SSBreak[n])
		xr = xr * ssb / SSBreak[n];

	xr = xr * RecFac;


	return(xr);

}
void InitSummaryTables()
{
	long k;

	/* Allocate Workspace for Summary Tables */

	k = NBoot * NSims;

	WorkMat = AllocMatrix(k,NYears);
	
	if (StockSummaryFlag > 0)
		WorkMat2 = AllocMatrix(k,NAges);

	if ((WorkVec = (double *) calloc(k,sizeof(double))) == NULL)
	{
		fprintf(stderr,"Allocation Error\n");
		exit(1);
	}
}
double EmpiricalCDF(long n,double *x)
{
	long k;
	double xn, xk;
	double xr, xx, rnum;

	/* Vector Must be sorted in ascending order */

	BubbleUpSort(n,x);

	xn = (double) (n - 1);

	/* Get Uniform Pseudorandom Number */

	rnum = ranx();

	xk = floor(rnum * xn);

	k = (long) xk;

	xx = xk / xn;


	xr = x[k] + (x[k+1] - x[k]) * (rnum - xx) * xn;

	return xr;


}
double LogNormalError(double x,double cv,double xlo,double xhi)
{
	double sd, xx, zscore;

	sd = sqrt(log(cv * cv + 1.0));


	do
	{

		/* Get Zscore from Box-muller Transformation */

		zscore = gsl_box_muller();

		xx = x * exp(zscore * sd - sd * sd * 0.5);

	} while (xx < xlo || xx > xhi);


	return(xx);
}
void SaveProjectionResults()
{
	long i, j, k;


	if (StockSummaryFlag > 0)
	{

		for (j = 0; j < NYears; j++)
		{
			for (i = 0; i < NAges; i++)
				fprintf(fp3,"%12.6E  ",StockAge[i][j]);
			fprintf(fp3,"\n");
		}
	}

	k = RecruitType[0];

	if (k == 20)
	{
		/*  Fixed Recruitment Vector */

		for (j = 0; j < NYears-1; j++)
			RecSave[j+1] = Recruits[j];

		RecSave[0] = StockAge[0][0];

		for (j = 0; j < NYears; j++)
			Recruits[j] = RecSave[j];

	}

	for (j = 0; j < NYears; j++)
		fprintf(fp4,"%12.6E  ",Recruits[j]);
	fprintf(fp4,"\n");

	for (j = 0; j < NYears; j++)
		fprintf(fp5,"%12.6E  ",SpawnBiomass[j]);
	fprintf(fp5,"\n");

	for (j = 0; j < NYears; j++)
		fprintf(fp6,"%12.6E  ",StockBiomass[j]);
	fprintf(fp6,"\n");

	for (j = 0; j < NYears; j++)
		fprintf(fp7,"%12.6E  ",MeanBiomass[j]);
	fprintf(fp7,"\n");

	for (j = 0; j < NYears; j++)
		fprintf(fp8,"%12.6E  ",CatchBiomass[j]);
	fprintf(fp8,"\n");

	for (j = 0; j < NYears; j++)
		fprintf(fp9,"%12.6E  ",Landings[j]);
	fprintf(fp9,"\n");
	
	if (DiscFrac)
	{
		for (j = 0; j < NYears; j++)
			fprintf(fp10,"%12.6E  ",Discards[j]);
		fprintf(fp10,"\n");
	}


	for (j = 0; j < NYears; j++)
		fprintf(fp11,"%12.6E  ",FMult[j]);
	fprintf(fp11,"\n");

	if (NFleet > 1)
	  {
		for (i = 0; i < NFleet; i++)
		{
			for (j = 0; j < NYears; j++)
				fprintf(fp12,"%12.6E  ",FFleet[j][i]);
			fprintf(fp12,"\n");

			for (j = 0; j < NYears; j++)
				fprintf(fp12,"%12.6E  ",FleetCatch[j][i]);
			fprintf(fp12,"\n");

			for (j = 0; j < NYears; j++)
				fprintf(fp12,"%12.6E  ",FleetLand[j][i]);
			fprintf(fp12,"\n");

			for (j = 0; j < NYears; j++)
				fprintf(fp12,"%12.6E  ",FleetDisc[j][i]);
			fprintf(fp12,"\n");

		}
	  }	

	if (DataFlag)
	{
		if (!StockWtFlag)
		{

			if (StockWtTimeFlag)
			{
				for (j = 0; j < NYears; j++)
				{
					for (i = 0; i < NAges; i++)
						fprintf(fx1,"%12.6E  ",StockWeights[i][j]);
					fprintf(fx1,"\n");
				}
			}
			else
			{
				for (i = 0; i < NAges; i++)
					fprintf(fx1,"%12.6E  ",StockWeights[i][0]);
				fprintf(fx1,"\n");
			}
		}

		if (!MeanStockWtFlag)
		{
			if (MeanStockWtTimeFlag)
			{
				for (j = 0; j < NYears; j++)
				{
					for (i = 0; i < NAges; i++)
						fprintf(fx2,"%12.6E  ",MeanWeights[i][j]);
					fprintf(fx2,"\n");
				}
			}
			else
			{
				for (i = 0; i < NAges; i++)
					fprintf(fx2,"%12.6E  ",MeanWeights[i][0]);
				fprintf(fx2,"\n");
			}
		}

		if (!SpawnWtFlag)
		{
			if (SpawnWtTimeFlag)
			{
				for (j = 0; j < NYears; j++)
				{
					for (i = 0; i < NAges; i++)
						fprintf(fx3,"%12.6E  ",SpawnWeights[i][j]);
					fprintf(fx3,"\n");
				}
			}
			else
			{
				for (i = 0; i < NAges; i++)
					fprintf(fx3,"%12.6E  ",SpawnWeights[i][0]);
				fprintf(fx3,"\n");
			}
		}

		if (!CatchWtFlag)
		{
			if (CatchWtTimeFlag)
			{
				for (j = 0; j < NYears; j++)
				{
					for (k = 0; k < NFleet; k++)
					{
						for (i = 0; i < NAges; i++)
							fprintf(fx4,"%12.6E  ",CatchWeights[i][j][k]);
					}
					fprintf(fx4,"\n");
				}
			}
			else
			{
				for (k = 0; k < NFleet; k++)
				{
					for (i = 0; i < NAges; i++)
						fprintf(fx4,"%12.6E  ",CatchWeights[i][0][k]);
				}
				fprintf(fx4,"\n");
			}
		}

		if (!DiscWtFlag && DiscFlag)
		{
			if (DiscWtTimeFlag)
			{
				for (j = 0; j < NYears; j++)
				{
					for (k = 0; k < NFleet; k++)
					{
						for (i = 0; i < NAges; i++)
							fprintf(fx5,"%12.6E  ",DiscWeights[i][j][k]);
					}
					fprintf(fx5,"\n");
				}
			}
			else
			{
				for (k = 0; k < NFleet; k++)
				{
					for (i = 0; i < NAges; i++)
						fprintf(fx5,"%12.6E  ",DiscWeights[i][0][k]);
				}
				fprintf(fx5,"\n");
			}
		}

		if (!NatMortFlag)
		{
			if (NatMortTimeFlag)
			{
				for (j = 0; j < NYears; j++)
				{
					for (i = 0; i < NAges; i++)
						fprintf(fx6,"%12.6E  ",NatMort[i][j]);
					fprintf(fx6,"\n");
				}
			}
			else
			{
				for (i = 0; i < NAges; i++)
					fprintf(fx6,"%12.6E  ",NatMort[i][0]);
				fprintf(fx6,"\n");
			}
		}

		if (!MaturityFlag)
		{
			if (MaturityTimeFlag)
			{
				for (j = 0; j < NYears; j++)
				{
					for (i = 0; i < NAges; i++)
						fprintf(fx7,"%12.6E  ",Maturity[i][j]);
					fprintf(fx7,"\n");
				}
			}
			else
			{
				for (i = 0; i < NAges; i++)
					fprintf(fx7,"%12.6E  ",Maturity[i][0]);
				fprintf(fx7,"\n");
			}
		}

		if (!FSelecFlag)
		{
			if (FSelecTimeFlag)
			{
				for (j = 0; j < NYears; j++)
				{
					for (k = 0; k < NFleet; k++)
					{
						for (i = 0; i < NAges; i++)
							fprintf(fx8,"%12.6E  ",FleetSelec[i][j][k]);
					}
					fprintf(fx8,"\n");
				}
			}
			else
			{
				for (k = 0; k < NFleet; k++)
				{
					for (i = 0; i < NAges; i++)
						fprintf(fx8,"%12.6E  ",FleetSelec[i][0][k]);
				}
				fprintf(fx8,"\n");
			}
		}

		if (!DiscFracFlag && DiscFlag)
		{
			if (DiscFracTimeFlag)
			{
				for (j = 0; j < NYears; j++)
				{
					for (k = 0; k < NFleet; k++)
					{
						for (i = 0; i < NAges; i++)
							fprintf(fx9,"%12.6E  ",DiscFrac[i][j][k]);
					}
					fprintf(fx9,"\n");
				}
			}
			else
			{
				for (k = 0; k < NFleet; k++)
				{
					for (i = 0; i < NAges; i++)
						fprintf(fx9,"%12.6E  ",DiscFrac[i][0][k]);
				}
				fprintf(fx9,"\n");
			}
		}

	}



}
void UpdateThresholdCount()
{
	long j;
	long flag1;
	long flag2;
	long flag3;
	long flag4;

	flag1 = flag2 = flag3 = flag4 = 0;

	for (j = 0; j < NYears; j++)
	{

		if (SSBThresh > 0.0 && SpawnBiomass[j] > SSBThresh)
		{
			flag1 = 1;
			SSBThreshCount[j]++;
		}

		if (StockBioThresh > 0.0 && StockBiomass[j] > StockBioThresh)
		{
			flag2 = 1;
			StockBioThreshCount[j]++;
		}

		if (MeanBioThresh > 0.0 && MeanBiomass[j] > MeanBioThresh)
		{
			flag3 = 1;
			MeanBioThreshCount[j]++;
		}

		if (FMortThresh > 0.0 && FMult[j] > FMortThresh)
		{
			flag4 = 1;
			FMortThreshCount[j]++;
		}
	}

	if (flag1)
		CountSSBThresh++;

	if (flag2)
		CountStockBioThresh++;

	if (flag3)
		CountMeanBioThresh++;

	if (flag4)
		CountFMortThresh++;

}
void ThresholdSummary()
{
	long i;
	double xn;

	printf("Threshold Summary ...\n");

	fprintf(fp2,"\n");

	if (SSBThresh > 0.0)
	{
		fprintf(fp2,"Probability Spawning Stock Biomass Exceeds Threshold %10.3f (1000 MT)\n\n",SSBThresh/1000.);
		fprintf(fp2,"Year    Probability\n\n");
		for (i = 0; i < NYears; i++)
		{
			xn = (double) SSBThreshCount[i] / (double) (NSims * NBoot);
			fprintf(fp2,"%ld  %10.6f\n",NFYear+i,xn);

		}

		xn = (double) CountSSBThresh / (double) (NSims * NBoot);

		fprintf(fp2,"\n");
		fprintf(fp2,"Probability Threshold Exceeded at Least Once = %10.4f\n",xn);
	}


	if (StockBioThresh > 0.0)
	{
		fprintf(fp2,"\n");
		fprintf(fp2,"Probability Jan-1 Stock Biomass Exceeds Threshold %10.3f (1000 MT)\n\n",StockBioThresh/1000.);
		fprintf(fp2,"Year    Probability\n\n");
		for (i = 0; i < NYears; i++)
		{
			xn = (double) StockBioThreshCount[i] / (double) (NSims * NBoot);
			fprintf(fp2,"%ld  %10.6f\n",NFYear+i,xn);

		}
		xn = (double) CountStockBioThresh / (double) (NSims * NBoot);

		fprintf(fp2,"\n");
		fprintf(fp2,"Probability Threshold Exceeded at Least Once = %10.4f\n",xn);

	}

	if (MeanBioThresh > 0.0)
	{
		fprintf(fp2,"\n");
		fprintf(fp2,"Probability Mean Biomass Exceeds Threshold %10.3f (1000 MT)\n\n",MeanBioThresh/1000.);
		fprintf(fp2,"Year    Probability\n\n");
		for (i = 0; i < NYears; i++)
		{
			xn = (double) MeanBioThreshCount[i] / (double) (NSims * NBoot);
			fprintf(fp2,"%ld  %10.6f\n",NFYear+i,xn);

		}

		xn = (double) CountMeanBioThresh / (double) (NSims * NBoot);

		fprintf(fp2,"\n");
		fprintf(fp2,"Probability Threshold Exceeded at Least Once = %10.4f\n",xn);
	}

	if (FMortThresh > 0.0)
	{
		fprintf(fp2,"\n");
		fprintf(fp2,"Probability Total Fishing Mortality Exceeds Threshold %10.4f \n\n",FMortThresh);
		fprintf(fp2,"Year    Probability\n\n");
		for (i = 0; i < NYears; i++)
		{
			xn = (double) FMortThreshCount[i] / (double) (NSims * NBoot);
			fprintf(fp2,"%ld  %10.6f\n",NFYear+i,xn);

		}

		xn = (double) CountFMortThresh / (double) (NSims * NBoot);

		fprintf(fp2,"\n");
		fprintf(fp2,"Probability Threshold Exceeded at Least Once = %10.4f\n",xn);
	}

}
long CheckFeasibleSolution()
{
	long ix;
	long j, k;
	double x, xx;

	ix = 0;
	for (j = 0; j < NYears; j++)
	{

		xx = 0.0;
		for (k = 0; k < NFleet; k++)
			xx += HarvestValue[j][k];

		if (HarvestSpec[j] == 1)
		{
			x = xx - Landings[j];
			if (x > 1.0)
				ix++;
		}
		else if (HarvestSpec[j] == 2)
		{
			x = xx - Landings[j] - Discards[j];
			if (x > 1.0)
				ix++;
		}

	}

	if (ix > 0)
		return 0;
	else
		return 1;


}
void SummaryReport(char *fname,char *ds,char *ts)
{
	long i, j, k, n;
	long niter;
	long kx;
	long kpr;
	long kpflag = 0;
	char buffer[MAXBUF];
	char *c;
	char *tok;
	double xn;
	double xm;
	double xx;
	double sd;

	printf("Summary Reports ...\n");

	fprintf(fp2,"AGEPRO VERSION 4.2\n\n");

	fprintf(fp2,"%s\n\n",Model);

	fprintf(fp2,"Date & Time of Run: %s  %s\n\n",ds,ts);

	fprintf(fp2,"Input File Name:    %s\n\n",fxname);

	fprintf(fp2,"First Age Class:                %10ld\n",NFAge);
	fprintf(fp2,"Number of Age Classes:          %10ld\n",NAges);
	fprintf(fp2,"Number of Years in Projection:  %10ld\n",NYears);
	fprintf(fp2,"Number of Fleets:               %10ld\n",NFleet);
	fprintf(fp2,"Number of Recruitment Models:   %10ld\n",NRecModel);
	fprintf(fp2,"Number of Bootstraps:           %10ld\n",NBoot);
	fprintf(fp2,"Number of Simulations:          %10ld\n\n",NSims);
	fprintf(fp2,"Bootstrap File Name:            %s\n\n",BootFile);

	niter = NBoot * NSims;


	if (HarvestFlag)
		fprintf(fp2,"Number of Feasible Solutions: %10ld  of %10ld Realizations\n\n",hcount,niter);


	fprintf(fp2,"Input Harvest Scenario\n\n");

	if (NFleet > 1)
	{
		fprintf(fp2,"Year  Type        ");

		for (i = 0; i < NFleet; i++)
			fprintf(fp2,"Fleet-%ld    ",i+1);
		fprintf(fp2,"\n\n");
	}
	else
		fprintf(fp2,"Year  Type         Value\n\n");

	for (i = 0; i < NYears; i++)
	{
		fprintf(fp2,"%ld  ",NFYear+i);

		if (HarvestSpec[i] == 0)
			fprintf(fp2,"F-Mult   ");
		else if (HarvestSpec[i] == 1)
			fprintf(fp2,"Landings ");
		else
			fprintf(fp2,"Removals ");
		for (j = 0; j < NFleet; j++)
		{
			if (HarvestSpec[i] == 0)
				fprintf(fp2,"%10.4f ",HarvestValue[i][j]);
			else
				fprintf(fp2,"%10.0f ",HarvestValue[i][j]);
		}
		fprintf(fp2,"\n");
	}
	fprintf(fp2,"\n");


	if (NRecModel > 1)
	{
		fprintf(fp2,"Recruitment Selection Distribution\n\n");
		fprintf(fp2,"Year  ");
		for (j = 0; j < NRecModel; j++)
			fprintf(fp2,"Selection-%ld ",j+1);
		fprintf(fp2,"\n\n");

		for (i = 0; i < NYears; i++)
		{
			xx = 0.0;

			fprintf(fp2,"%ld  ",NFYear+i);

			for (j = 0; j < NRecModel; j++)
				xx += RecDist[i][j];

			for (j = 0; j < NRecModel; j++)
			{
				xm = RecDist[i][j] / xx;
				fprintf(fp2,"%10.4f ",xm);
			}
			fprintf(fp2,"\n");
		}
		fprintf(fp2,"\n");
	}


	xx = (double) niter * 0.01;
	kx = (long) xx;

	if (kx < 1)
		kx = 1;

	kpc[0] = kx - 1;

	xx = (double) niter * 0.05;
	kx = (long) xx;

	if (kx < 1)
		kx = 1;

	kpc[1] = kx - 1;

	xx = (double) niter * 0.10;
	kx = (long) xx;
	kpc[2] = kx - 1;

	xx = (double) niter * 0.25;
	kx = (long) xx;
	kpc[3] = kx - 1;

	xx = (double) niter * 0.75;
	kx = (long) xx;
	kpc[4] = kx - 1;

	xx = (double) niter * 0.90;
	kx = (long) xx;
	kpc[5] = kx - 1;

	xx = (double) niter * 0.95;
	kx = (long) xx;
	kpc[6] = kx - 1;

	xx = (double) niter * 0.99;
	kx = (long) xx;
	kpc[7] = kx - 1;


	if (PercReportFlag)
	{
		kx = NAges + 8;
		PercRepMat = AllocMatrix(NYears,kx);
		ZeroMatrix(PercRepMat,NYears,kx);

		if (fabs(PercReportValue - 50.0) < 0.001)
			kpflag = 1;

		xx = (double) niter * PercReportValue / 100.0;
		kpr = (long) xx;
		kpr = kpr - 1;
	}



	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".xx2");

	if ((fp1 = fopen(fname,"r")) == NULL)
	{
		fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
		exit(1);
	}


	printf("Recruits ... \n");

	fprintf(fp2,"Recruits  %10.0f  Fish\n\n",scalerec);

	fprintf(fp2,"Year Class   Average        StdDev\n");

	/* Read Recruits */


	ZeroMatrix(WorkMat,niter,NYears);

	for (i = 0; i < niter; i++)
	{

		/* Read NYears Data */

		fgets(buffer,MAXBUF-1,fp1);
		tok = strtok(buffer," \t\r\n");
		for (j = 0; j < NYears; j++)
		{
			WorkMat[i][j] = atof(tok);
			tok = strtok(NULL," \t\r\n");
		}

	}



	for (j = 0; j < NYears; j++)
	{
		for (i = 0; i < niter; i++)
			WorkVec[i] = WorkMat[i][j] / scalerec;



		xn = MeanValue(niter,WorkVec);
		sd = StdDev(niter,xn,WorkVec);

		fprintf(fp2,"%ld    %12.4f  %12.4f\n",NFYear+j,xn,sd);
	}

	fprintf(fp2,"\n");
	fprintf(fp2,"Recruits Distribution\n\n");
	fprintf(fp2,"Year Class ");
	fprintf(fp2,"1%%         ");
	fprintf(fp2,"5%%         ");
	fprintf(fp2,"10%%        ");
	fprintf(fp2,"25%%        ");
	fprintf(fp2,"50%%        ");
	fprintf(fp2,"75%%        ");
	fprintf(fp2,"90%%        ");
	fprintf(fp2,"95%%        ");
	fprintf(fp2,"99%%    \n");

	for (j = 0; j < NYears; j++)
	{
		for (i = 0; i < niter; i++)
			WorkVec[i] = WorkMat[i][j] / scalerec;

		qsort(WorkVec,niter,sizeof(double),compdouble);

		printf("%ld \n",NFYear+j);
		fprintf(fp2,"%ld ",NFYear+j);

		if (niter % 2)
		{
			kx = niter / 2;
			xm = WorkVec[kx];
		}
		else
		{
			kx = niter / 2;
			xm = (WorkVec[kx-1] + WorkVec[kx]) / 2.0;
		}

		k = kpc[0];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[1];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[2];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[3];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		fprintf(fp2,"%10.4f ",xm);

		k = kpc[4];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[5];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[6];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[7];
		fprintf(fp2,"%10.4f\n",WorkVec[k]);

		if (PercReportFlag)
		{
			if (kpflag)
				PercRepMat[j][NAges] = xm;
			else
				PercRepMat[j][NAges] = WorkVec[kpr];
		}
	}

	fclose(fp1);

	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".xx3");

	if ((fp1 = fopen(fname,"r")) == NULL)
	{
		fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
		exit(1);
	}


	printf("SSB ... \n");

	fprintf(fp2,"\n");
	fprintf(fp2,"Spawning Stock Biomass  x %10.0f MT\n\n",scalebio);
	fprintf(fp2,"Year       Average        StdDev\n");

	/* Read SSB */


	ZeroMatrix(WorkMat,niter,NYears);

	for (i = 0; i < niter; i++)
	{

		/* Read NYears Data */

		fgets(buffer,MAXBUF-1,fp1);
		tok = strtok(buffer," \t\r\n");
		for (j = 0; j < NYears; j++)
		{
			WorkMat[i][j] = atof(tok);
			tok = strtok(NULL," \t\r\n");
		}

	}


	for (j = 0; j < NYears; j++)
	{
		for (i = 0; i < niter; i++)
			WorkVec[i] = WorkMat[i][j] / scalebio;


		xn = MeanValue(niter,WorkVec);
		sd = StdDev(niter,xn,WorkVec);

		fprintf(fp2,"%ld  %12.4f  %12.4f\n",NFYear+j,xn,sd);

	}


	fprintf(fp2,"\n");
	fprintf(fp2,"Spawning Stock Biomass Distribution\n\n");
	fprintf(fp2,"Year        ");
	fprintf(fp2,"1%%         ");
	fprintf(fp2,"5%%         ");
	fprintf(fp2,"10%%        ");
	fprintf(fp2,"25%%        ");
	fprintf(fp2,"50%%        ");
	fprintf(fp2,"75%%        ");
	fprintf(fp2,"90%%        ");
	fprintf(fp2,"95%%        ");
	fprintf(fp2,"99%%   \n");



	for (j = 0; j < NYears; j++)
	{
		for (i = 0; i < niter; i++)
			WorkVec[i] = WorkMat[i][j] / scalebio;

		qsort(WorkVec,niter,sizeof(double),compdouble);

		printf("%ld \n",NFYear+j);
		fprintf(fp2,"%ld ",NFYear+j);

		if (niter % 2)
		{
			kx = niter / 2;
			xm = WorkVec[kx];
		}
		else
		{
			kx = niter / 2;
			xm = (WorkVec[kx-1] + WorkVec[kx]) / 2.0;
		}

		k = kpc[0];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[1];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[2];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[3];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		fprintf(fp2,"%10.4f ",xm);

		k = kpc[4];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[5];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[6];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[7];
		fprintf(fp2,"%10.4f \n",WorkVec[k]);

		if (PercReportFlag)
		{
			if (kpflag)
				PercRepMat[j][NAges+1] = xm;
			else
				PercRepMat[j][NAges+1] = WorkVec[kpr];
		}
	}

	fclose(fp1);

	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".xx4");

	if ((fp1 = fopen(fname,"r")) == NULL)
	{
		fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
		exit(1);
	}

	printf("Jan-1 Stock Biomass ... \n");

	fprintf(fp2,"\n");
	fprintf(fp2,"JAN-1 Stock Biomass  x %10.0f MT\n\n",scalebio);
	fprintf(fp2,"Year       Average        StdDev\n");

	/* Read Stock Biomass */


	ZeroMatrix(WorkMat,niter,NYears);

	for (i = 0; i < niter; i++)
	{

		/* Read NYears Data */

		fgets(buffer,MAXBUF-1,fp1);
		tok = strtok(buffer," \t\r\n");
		for (j = 0; j < NYears; j++)
		{
			WorkMat[i][j] = atof(tok);
			tok = strtok(NULL," \t\r\n");
		}
	}


	for (j = 0; j < NYears; j++)
	{
		for (i = 0; i < niter; i++)
			WorkVec[i] = WorkMat[i][j] / scalebio;


		xn = MeanValue(niter,WorkVec);
		sd = StdDev(niter,xn,WorkVec);

		fprintf(fp2,"%ld  %12.4f  %12.4f\n",NFYear+j,xn,sd);

	}


	fprintf(fp2,"\n");
	fprintf(fp2,"JAN-1 Stock Biomass Distribution\n\n");
	fprintf(fp2,"Year       ");
	fprintf(fp2,"1%%         ");
	fprintf(fp2,"5%%         ");
	fprintf(fp2,"10%%        ");
	fprintf(fp2,"25%%        ");
	fprintf(fp2,"50%%        ");
	fprintf(fp2,"75%%        ");
	fprintf(fp2,"90%%        ");
	fprintf(fp2,"95%%        ");
	fprintf(fp2,"99%%    \n");



	for (j = 0; j < NYears; j++)
	{
		for (i = 0; i < niter; i++)
			WorkVec[i] = WorkMat[i][j] / scalebio;

		qsort(WorkVec,niter,sizeof(double),compdouble);

		printf("%ld \n",NFYear+j);
		fprintf(fp2,"%ld ",NFYear+j);

		if (niter % 2)
		{
			kx = niter / 2;
			xm = WorkVec[kx];
		}
		else
		{
			kx = niter / 2;
			xm = (WorkVec[kx-1] + WorkVec[kx]) / 2.0;
		}

		k = kpc[0];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[1];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[2];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[3];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		fprintf(fp2,"%10.4f ",xm);

		k = kpc[4];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[5];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[6];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[7];
		fprintf(fp2,"%10.4f \n",WorkVec[k]);

		if (PercReportFlag)
		{
			if (kpflag)
				PercRepMat[j][NAges+2] = xm;
			else
				PercRepMat[j][NAges+2] = WorkVec[kpr];
		}

	}

	fclose(fp1);

	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".xx5");

	if ((fp1 = fopen(fname,"r")) == NULL)
	{
		fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
		exit(1);
	}


	printf("Mean Biomass ... \n");

	fprintf(fp2,"\n");
	fprintf(fp2,"Mean Biomass  x %10.0f MT\n\n",scalebio);
	fprintf(fp2,"Year       Average        StdDev\n");

	/* Read Mean Biomass */


	ZeroMatrix(WorkMat,niter,NYears);

	for (i = 0; i < niter; i++)
	{

		/* Read NYears Data */

		fgets(buffer,MAXBUF-1,fp1);
		tok = strtok(buffer," \t\r\n");
		for (j = 0; j < NYears; j++)
		{
			WorkMat[i][j] = atof(tok);
			tok = strtok(NULL," \t\r\n");
		}

	}


	for (j = 0; j < NYears; j++)
	{
		for (i = 0; i < niter; i++)
			WorkVec[i] = WorkMat[i][j] / scalebio;


		xn = MeanValue(niter,WorkVec);
		sd = StdDev(niter,xn,WorkVec);

		fprintf(fp2,"%ld  %12.4f  %12.4f\n",NFYear+j,xn,sd);

	}


	fprintf(fp2,"\n");
	fprintf(fp2,"Mean Biomass Distribution\n\n");
	fprintf(fp2,"Year       ");
	fprintf(fp2,"1%%         ");
	fprintf(fp2,"5%%         ");
	fprintf(fp2,"10%%        ");
	fprintf(fp2,"25%%        ");
	fprintf(fp2,"50%%        ");
	fprintf(fp2,"75%%        ");
	fprintf(fp2,"90%%        ");
	fprintf(fp2,"95%%        ");
	fprintf(fp2,"99%%    \n");



	for (j = 0; j < NYears; j++)
	{
		for (i = 0; i < niter; i++)
			WorkVec[i] = WorkMat[i][j] / scalebio;

		qsort(WorkVec,niter,sizeof(double),compdouble);

		printf("%ld \n",NFYear+j);
		fprintf(fp2,"%ld ",NFYear+j);

		if (niter % 2)
		{
			kx = niter / 2;
			xm = WorkVec[kx];
		}
		else
		{
			kx = niter / 2;
			xm = (WorkVec[kx-1] + WorkVec[kx]) / 2.0;
		}

		k = kpc[0];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[1];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[2];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[3];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		fprintf(fp2,"%10.4f ",xm);

		k = kpc[4];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[5];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[6];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[7];
		fprintf(fp2,"%10.4f \n",WorkVec[k]);


		if (PercReportFlag)
		{
			if (kpflag)
				PercRepMat[j][NAges+3] = xm;
			else
				PercRepMat[j][NAges+3] = WorkVec[kpr];
		}

	}

	fclose(fp1);

	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".xx6");

	if ((fp1 = fopen(fname,"r")) == NULL)
	{
		fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
		exit(1);
	}


	printf("Combined Catch Biomass ... \n");

	fprintf(fp2,"\n");
	fprintf(fp2,"Combined Catch Biomass  x %10.0f MT\n\n",scalebio);
	fprintf(fp2,"Year       Average        StdDev\n");

	/* Read Catch Biomass */


	ZeroMatrix(WorkMat,niter,NYears);

	for (i = 0; i < niter; i++)
	{

		/* Read NYears Data */

		fgets(buffer,MAXBUF-1,fp1);
		tok = strtok(buffer," \t\r\n");
		for (j = 0; j < NYears; j++)
		{
			WorkMat[i][j] = atof(tok);
			tok = strtok(NULL," \t\r\n");
		}

	}


	for (j = 0; j < NYears; j++)
	{
		for (i = 0; i < niter; i++)
			WorkVec[i] = WorkMat[i][j] / scalebio;


		xn = MeanValue(niter,WorkVec);
		sd = StdDev(niter,xn,WorkVec);

		fprintf(fp2,"%ld  %12.4f  %12.4f\n",NFYear+j,xn,sd);

	}


	fprintf(fp2,"\n");
	fprintf(fp2,"Combined Catch Distribution\n\n");
	fprintf(fp2,"Year       ");
	fprintf(fp2,"1%%         ");
	fprintf(fp2,"5%%         ");
	fprintf(fp2,"10%%        ");
	fprintf(fp2,"25%%        ");
	fprintf(fp2,"50%%        ");
	fprintf(fp2,"75%%        ");
	fprintf(fp2,"90%%        ");
	fprintf(fp2,"95%%        ");
	fprintf(fp2,"99%%    \n");



	for (j = 0; j < NYears; j++)
	{
		for (i = 0; i < niter; i++)
			WorkVec[i] = WorkMat[i][j] / scalebio;

		qsort(WorkVec,niter,sizeof(double),compdouble);

		printf("%ld \n",NFYear+j);
		fprintf(fp2,"%ld ",NFYear+j);

		if (niter % 2)
		{
			kx = niter / 2;
			xm = WorkVec[kx];
		}
		else
		{
			kx = niter / 2;
			xm = (WorkVec[kx-1] + WorkVec[kx]) / 2.0;
		}

		k = kpc[0];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[1];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[2];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[3];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		fprintf(fp2,"%10.4f ",xm);

		k = kpc[4];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[5];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[6];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[7];
		fprintf(fp2,"%10.4f \n",WorkVec[k]);

		if (PercReportFlag)
		{
			if (kpflag)
				PercRepMat[j][NAges+4] = xm;
			else
				PercRepMat[j][NAges+4] = WorkVec[kpr];
		}

	}

	fclose(fp1);



	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".xx7");

	if ((fp1 = fopen(fname,"r")) == NULL)
	{
		fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
		exit(1);
	}


	printf("Landings ... \n");

	fprintf(fp2,"\n");
	fprintf(fp2,"Landings  x %10.0f MT\n\n",scalebio);
	fprintf(fp2,"Year       Average        StdDev\n");

	/* Read Landings */


	ZeroMatrix(WorkMat,niter,NYears);

	for (i = 0; i < niter; i++)
	{

		/* Read NYears Data */

		fgets(buffer,MAXBUF-1,fp1);
		tok = strtok(buffer," \t\r\n");
		for (j = 0; j < NYears; j++)
		{
			WorkMat[i][j] = atof(tok);
			tok = strtok(NULL," \t\r\n");
		}

	}


	for (j = 0; j < NYears; j++)
	{
		for (i = 0; i < niter; i++)
			WorkVec[i] = WorkMat[i][j] / scalebio;


		xn = MeanValue(niter,WorkVec);
		sd = StdDev(niter,xn,WorkVec);

		fprintf(fp2,"%ld  %12.4f  %12.4f\n",NFYear+j,xn,sd);

	}


	fprintf(fp2,"\n");
	fprintf(fp2,"Landings Distribution\n\n");
	fprintf(fp2,"Year       ");
	fprintf(fp2,"1%%         ");
	fprintf(fp2,"5%%         ");
	fprintf(fp2,"10%%        ");
	fprintf(fp2,"25%%        ");
	fprintf(fp2,"50%%        ");
	fprintf(fp2,"75%%        ");
	fprintf(fp2,"90%%        ");
	fprintf(fp2,"95%%        ");
	fprintf(fp2,"99%%    \n");



	for (j = 0; j < NYears; j++)
	{
		for (i = 0; i < niter; i++)
			WorkVec[i] = WorkMat[i][j] / scalebio;

		qsort(WorkVec,niter,sizeof(double),compdouble);

		printf("%ld \n",NFYear+j);
		fprintf(fp2,"%ld ",NFYear+j);

		if (niter % 2)
		{
			kx = niter / 2;
			xm = WorkVec[kx];
		}
		else
		{
			kx = niter / 2;
			xm = (WorkVec[kx-1] + WorkVec[kx]) / 2.0;
		}

		k = kpc[0];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[1];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[2];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[3];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		fprintf(fp2,"%10.4f ",xm);

		k = kpc[4];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[5];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[6];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[7];
		fprintf(fp2,"%10.4f \n",WorkVec[k]);

		if (PercReportFlag)
		{
			if (kpflag)
				PercRepMat[j][NAges+5] = xm;
			else
				PercRepMat[j][NAges+5] = WorkVec[kpr];
		}

	}

	fclose(fp1);

	if (DiscFlag)
	{

		c = strrchr(fname,'.');
		*c = '\0';
		strcat(fname,".xx8");

		if ((fp1 = fopen(fname,"r")) == NULL)
		{
			fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
			exit(1);
		}

		printf("Discards ... \n");

			fprintf(fp2,"\n");
		fprintf(fp2,"Discards  x %10.0f MT\n\n",scalebio);
		fprintf(fp2,"Year       Average        StdDev\n");

		/* Read Discard Biomass */


		ZeroMatrix(WorkMat,niter,NYears);

		for (i = 0; i < niter; i++)
		{

			/* Read NYears Data */

			fgets(buffer,MAXBUF-1,fp1);
			tok = strtok(buffer," \t\r\n");
			for (j = 0; j < NYears; j++)
			{
				WorkMat[i][j] = atof(tok);
				tok = strtok(NULL," \t\r\n");
			}

		}


		for (j = 0; j < NYears; j++)
		{
			for (i = 0; i < niter; i++)
				WorkVec[i] = WorkMat[i][j] / scalebio;


			xn = MeanValue(niter,WorkVec);
			sd = StdDev(niter,xn,WorkVec);

			fprintf(fp2,"%ld  %12.4f  %12.4f\n",NFYear+j,xn,sd);

		}


		fprintf(fp2,"\n");
		fprintf(fp2,"Discards Distribution\n\n");
		fprintf(fp2,"Year       ");
		fprintf(fp2,"1%%         ");
		fprintf(fp2,"5%%         ");
		fprintf(fp2,"10%%        ");
		fprintf(fp2,"25%%        ");
		fprintf(fp2,"50%%        ");
		fprintf(fp2,"75%%        ");
		fprintf(fp2,"90%%        ");
		fprintf(fp2,"95%%        ");
		fprintf(fp2,"99%%    \n");



		for (j = 0; j < NYears; j++)
		{
			for (i = 0; i < niter; i++)
				WorkVec[i] = WorkMat[i][j] / scalebio;

			qsort(WorkVec,niter,sizeof(double),compdouble);

			printf("%ld \n",NFYear+j);
			fprintf(fp2,"%ld ",NFYear+j);

			if (niter % 2)
			{
				kx = niter / 2;
				xm = WorkVec[kx];
			}
			else
			{
				kx = niter / 2;
				xm = (WorkVec[kx-1] + WorkVec[kx]) / 2.0;
			}

			k = kpc[0];
			fprintf(fp2,"%10.4f ",WorkVec[k]);

			k = kpc[1];
			fprintf(fp2,"%10.4f ",WorkVec[k]);

			k = kpc[2];
			fprintf(fp2,"%10.4f ",WorkVec[k]);

			k = kpc[3];
			fprintf(fp2,"%10.4f ",WorkVec[k]);

			fprintf(fp2,"%10.4f ",xm);

			k = kpc[4];
			fprintf(fp2,"%10.4f ",WorkVec[k]);

			k = kpc[5];
			fprintf(fp2,"%10.4f ",WorkVec[k]);

			k = kpc[6];
			fprintf(fp2,"%10.4f ",WorkVec[k]);

			k = kpc[7];
			fprintf(fp2,"%10.4f \n",WorkVec[k]);

			if (PercReportFlag)
			{
				if (kpflag)
					PercRepMat[j][NAges+6] = xm;
				else
					PercRepMat[j][NAges+6] = WorkVec[kpr];
			}


		}

		fclose(fp1);
	}

	c = strrchr(fname,'.');
	*c = '\0';
	strcat(fname,".xx9");

	if ((fp1 = fopen(fname,"r")) == NULL)
	{
		fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
		exit(1);
	}

	printf("Fishing Mortality ... \n");

	fprintf(fp2,"\n");
	fprintf(fp2,"Total Fishing Mortality\n\n");
	fprintf(fp2,"Year       Average        StdDev\n");

	/* Read Fishing Mortality */


	ZeroMatrix(WorkMat,niter,NYears);

	for (i = 0; i < niter; i++)
	{

		/* Read NYears Data */

		fgets(buffer,MAXBUF-1,fp1);
		tok = strtok(buffer," \t\r\n");
		for (j = 0; j < NYears; j++)
		{
			WorkMat[i][j] = atof(tok);
			tok = strtok(NULL," \t\r\n");
		}

	}


	for (j = 0; j < NYears; j++)
	{
		for (i = 0; i < niter; i++)
			WorkVec[i] = WorkMat[i][j];


		xn = MeanValue(niter,WorkVec);
		sd = StdDev(niter,xn,WorkVec);

		fprintf(fp2,"%ld  %12.4f  %12.4f\n",NFYear+j,xn,sd);

	}


	fprintf(fp2,"\n");
	fprintf(fp2,"Total Fishing Mortality Distribution\n\n");
	fprintf(fp2,"Year       ");
	fprintf(fp2,"1%%         ");
	fprintf(fp2,"5%%         ");
	fprintf(fp2,"10%%        ");
	fprintf(fp2,"25%%        ");
	fprintf(fp2,"50%%        ");
	fprintf(fp2,"75%%        ");
	fprintf(fp2,"90%%        ");
	fprintf(fp2,"95%%        ");
	fprintf(fp2,"99%%    \n");



	for (j = 0; j < NYears; j++)
	{
		for (i = 0; i < niter; i++)
			WorkVec[i] = WorkMat[i][j];

		qsort(WorkVec,niter,sizeof(double),compdouble);

		printf("%ld \n",NFYear+j);
		fprintf(fp2,"%ld ",NFYear+j);

		if (niter % 2)
		{
			kx = niter / 2;
			xm = WorkVec[kx];
		}
		else
		{
			kx = niter / 2;
			xm = (WorkVec[kx-1] + WorkVec[kx]) / 2.0;
		}

		k = kpc[0];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[1];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[2];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[3];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		fprintf(fp2,"%10.4f ",xm);

		k = kpc[4];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[5];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[6];
		fprintf(fp2,"%10.4f ",WorkVec[k]);

		k = kpc[7];
		fprintf(fp2,"%10.4f \n",WorkVec[k]);

		if (PercReportFlag)
		{
			if (kpflag)
				PercRepMat[j][NAges+7] = xm;
			else
				PercRepMat[j][NAges+7] = WorkVec[kpr];
		}

	}

	fclose(fp1);

	if (StockSummaryFlag > 0)
	{

		printf("JAN-1 Stock Numbers at Age... \n");

		c = strrchr(fname,'.');
		*c = '\0';
		strcat(fname,".xx1");

		if ((fp1 = fopen(fname,"r")) == NULL)
		{
			fprintf(stderr,"Unable to Open Auxiliary Output File: %s\n",fname);
			exit(1);
		}

		fprintf(fp2,"\n");
		fprintf(fp2,"JAN-1 Stock Numbers at Age  - %10.0f  Fish\n",scalestk);

		for (n = 0; n < NYears; n++)
		{

			printf("%ld \n",NFYear+n);

			for (j = 0; j < n; j++)
				fgets(buffer,MAXBUF-1,fp1);


			ZeroMatrix(WorkMat2,niter,NAges);

			for (i = 0; i < niter; i++)
			{

				/* Read NAges Data */

				fgets(buffer,MAXBUF-1,fp1);
				tok = strtok(buffer," \t\r\n");
				for (j = 0; j < NAges; j++)
				{
					WorkMat2[i][j] = atof(tok);
					tok = strtok(NULL," \t\r\n");
				}

				for (j = 0; j < NYears-1; j++)
					fgets(buffer,MAXBUF-1,fp1);

			}


			fprintf(fp2,"\n");
			fprintf(fp2,"%ld\n\n",NFYear+n);
			fprintf(fp2,"Age        ");
			fprintf(fp2,"1%%         ");
			fprintf(fp2,"5%%         ");
			fprintf(fp2,"10%%        ");
			fprintf(fp2,"25%%        ");
			fprintf(fp2,"50%%        ");
			fprintf(fp2,"75%%        ");
			fprintf(fp2,"90%%        ");
			fprintf(fp2,"95%%        ");
			fprintf(fp2,"99%%    \n");

			for (j = 0; j < NAges; j++)
			{
				for (i = 0; i < niter; i++)
					WorkVec[i] = WorkMat2[i][j] / scalestk;

				qsort(WorkVec,niter,sizeof(double),compdouble);

				if (j < NAges-1)
					fprintf(fp2,"%ld    ",NFAge+j);
				else
					fprintf(fp2,"%ld+   ",NFAge+j);

				if (niter % 2)
				{
					kx = niter / 2;
					xm = WorkVec[kx];
				}
				else
				{
					kx = niter / 2;
					xm = (WorkVec[kx-1] + WorkVec[kx]) / 2.0;
				}

				k = kpc[0];
				fprintf(fp2,"%10.4f ",WorkVec[k]);

				k = kpc[1];
				fprintf(fp2,"%10.4f ",WorkVec[k]);

				k = kpc[2];
				fprintf(fp2,"%10.4f ",WorkVec[k]);

				k = kpc[3];
				fprintf(fp2,"%10.4f ",WorkVec[k]);

				fprintf(fp2,"%10.4f ",xm);

				k = kpc[4];
				fprintf(fp2,"%10.4f ",WorkVec[k]);

				k = kpc[5];
				fprintf(fp2,"%10.4f ",WorkVec[k]);

				k = kpc[6];
				fprintf(fp2,"%10.4f ",WorkVec[k]);

				k = kpc[7];
				fprintf(fp2,"%10.4f\n",WorkVec[k]);


				if (PercReportFlag)
				{
					if (kpflag)
						PercRepMat[n][j] = xm;
					else
						PercRepMat[n][j] = WorkVec[kpr];
				}


			}


			rewind(fp1);

		}

		fclose(fp1);
	}


}
void RebuildEstimate()
{
	long i,j,k;
	long iter;
	long ixseed;
	double x, xx;
	double xtarget;
	double err1, err2, slope;
	double x2;

	ixseed = ISeed;

	ktarget = TargetYear - NFYear + 1;

	/* F Proportion by Fleet */

	FProp = AllocMatrix(NYears,NFleet);
	ZeroMatrix(FProp,NYears,NFleet);

	for (i = 1; i < ktarget; i++)
	{
		x = 0.0;
		for (j = 0; j < NFleet; j++)
			x += HarvestValue[i][j];

		for (j = 0; j < NFleet; j++)
			FProp[i][j] = HarvestValue[i][j] / x;
	}

	/* Check for Feasibility */

	for (i = 1; i < ktarget; i++)
		for (j = 0; j < NFleet; j++)
			FFleet[i][j] = 0.0;


	/* Clear Intermediate Storage */

	ZeroMatrix(StockAge,NAges,NYears);
	ZeroMatrix(CatchAge,NAges,NYears);
	ZeroMatrix(DiscAge,NAges,NYears);
	ZeroMatrix(SpawnStock,NAges,NYears);
	ZeroMatrix(MeanStock,NAges,NYears);
	ZeroMatrix(FMort,NAges,NYears);


	for (j = 0; j < NYears; j++)
	{
		StockBiomass[j]      = 0.0;
		CatchBiomass[j]      = 0.0;
		Landings[j]          = 0.0;
		Discards[j]          = 0.0;
		MeanBiomass[j]    = 0.0;
		SpawnBiomass[j] = 0.0;
		Recruits[j]          = 0.0;
	}


	for (i = 0; i < NAges; i++)
		StockAge[i][0] = BootNumbers[i][0];


	if (RetroFlag)
	{
		for (i = 0; i < NAges; i++)
			StockAge[i][0] = StockAge[i][0] * RetroAdjust[i];
	}

	/* Input Data With Error */

	ApplyInputDataError();

	for (j = 0; j < ktarget; j++)
	{

		/*  Apply Mortality */

		if (HarvestSpec[j])
			ApplyHarvestQuota(j);
		else
			ApplyMortality(j);


		/* Apply Recruitment */

		ApplyRecruitment(j);

	}

	/* Rewind Stochastic Data Files */

	for (k = 0; k < kfiles; k++)
		rewind(fp[k]);


	if (TargetType == 0)
		xtarget = SpawnBiomass[ktarget-1];
	else if (TargetType == 1)
		xtarget = StockBiomass[ktarget-1];
	else
		xtarget = MeanBiomass[ktarget-1];

	if (xtarget < TargetValue)
	{
		fprintf(stderr,"Unable to Meet Rebuilder Target with F = 0.0\n");

		return;
	}

	xx = 0.5;

	iter = 0;

	while (iter < MXITER)
	{
		printf("FRebuild = %8.4f\n",xx);

		for (j = 1; j < ktarget; j++)
		{
			for (k = 0; k < NFleet; k++)
				FFleet[j][k] = xx * FProp[j][k];
		}

		/* Reset Random Number Seed on Each Rebuilder Iteration */

		ISeed = ixseed;

		init_ranx(ISeed);

		x = CalcRebuild();

		err1 = (x - TargetPercent);

		if (fabs(err1) < 0.01)
			break;

		if (iter == 0)
		{
			x2 = xx;
			err2 = err1;

			if (x > TargetPercent)
				xx = 1.0;
			else
				xx = 0.1;
		}
		else
		{
			slope = (err2 - err1) / (x2 - xx);
			x2 = xx;
			err2 = err1;

			xx = (slope * xx - err2) / slope;
		}

		if (xx > XUBOUND)
			xx = XUBOUND;

		if (xx < XLBOUND)
			xx = XLBOUND;

		iter++;

	}

	/* Reset Random Number Seed */

	ISeed = ixseed;

	init_ranx(ISeed);

	/* Rewind Stochastic Data Files */

	for (k = 0; k < kfiles; k++)
		rewind(fp[k]);

}
double CalcRebuild()
{
	long i, j, k, ks, n;
	long kcount;
	double xx;
	double xtarget;


	kcount = 0;
	for (n = 0; n < NBoot; n++)
	{
		for (ks = 0; ks < NSims; ks++)
		{


			/* Clear Intermediate Storage */

			ZeroMatrix(StockAge,NAges,NYears);
			ZeroMatrix(CatchAge,NAges,NYears);
			ZeroMatrix(DiscAge,NAges,NYears);
			ZeroMatrix(SpawnStock,NAges,NYears);
			ZeroMatrix(MeanStock,NAges,NYears);
			ZeroMatrix(FMort,NAges,NYears);


			/* Input Data With Error */

			ApplyInputDataError();

			for (j = 0; j < NYears; j++)
			{
				StockBiomass[j]      = 0.0;
				CatchBiomass[j]      = 0.0;
				Landings[j]          = 0.0;
				Discards[j]          = 0.0;
				MeanBiomass[j]    = 0.0;
				SpawnBiomass[j] = 0.0;
				Recruits[j]          = 0.0;
			}

			/* Initialize Stock Numbers in 1st Year of Projection 
			** Using Bootstrap Numbers at Age 
			*/

			for (i = 0; i < NAges; i++)
				StockAge[i][0] = BootNumbers[i][n];

			/* Retrospective Adjustment */

			if (RetroFlag)
			{
				for (i = 0; i < NAges; i++)
					StockAge[i][0] = StockAge[i][0] * RetroAdjust[i];
			}


			/* Annual Projection Loop */

			for (j = 0; j < NYears; j++)
			{
				/*  Apply Mortality */

				if (HarvestSpec[j])
					ApplyHarvestQuota(j);
				else
					ApplyMortality(j);


				/* Apply Recruitment */

				ApplyRecruitment(j);

			}

			if (TargetType == 0)
				xtarget = SpawnBiomass[ktarget-1];
			else if (TargetType == 1)
				xtarget = StockBiomass[ktarget-1];
			else
				xtarget = MeanBiomass[ktarget-1];

			if (xtarget >= TargetValue)
				kcount++;

		}
	}

	/* Rewind Stochastic Data Files */

	for (k = 0; k < kfiles; k++)
		rewind(fp[k]);


	xx = (double) kcount / (double) (NBoot * NSims);

	return(xx * 100.0);

}
void PStarEstimate()
{
	long j,k,n;
	long iter;
	long ixseed;
	double x, xx;
	double xtarget;
	double xhi, xlo;
	double err;

	ixseed = ISeed;

	for (n = 0; n < KPStar; n++)
	{
		xtarget = PStar[n];

		ktarget = TargetYear - NFYear + 1;

		xx = 0.0;

		for (j = 0; j < NFleet; j++)
			xx += HarvestValue[ktarget-1][j];

		for (j = 0; j < NFleet; j++)
			PQuota[j] = HarvestValue[ktarget-1][j] / xx;

		for (j = 0; j < NYears; j++)
		{
			if (!HarvestSpec[j])
			{
				for (k = 0; k < NFleet; k++)
					FFleet[j][k] = HarvestValue[j][k];
			}

		}

		iter = 0;

		xlo = 0.0;

		xhi = 0.0;

		while (iter < MXITER)
		{
			printf("PStar = %8.4f  TAC = %8.0f  Iter = %ld\n",xtarget,xx,iter+1);

			/* Reset Random Number Seed on Each Iteration */

			ISeed = ixseed;

			init_ranx(ISeed);

			/* Rewind Stochastic Data Files */

			for (k = 0; k < kfiles; k++)
				rewind(fp[k]);


			x = CalcPStar();

			err = (x - xtarget);

			if (fabs(err) < 0.0001)
			{
				PSCatch[n] = xx;
				break;
			}

			if (iter == 0)
			{
				if (x > xtarget)
				{
					xhi = xx;
					xx = xx * 0.5;
				}
				else
				{
					xlo = xx;
					xx = xx * 2.0;
				}
			}
			else 
			{
				if (x > xtarget)
					xhi = xx;
				else
					xlo = xx;

				if (xlo > 0.0 && xhi > 0.0)
					xx = (xhi + xlo) * 0.5;
				else if (x > xtarget)
					xx = xx * 0.90;
				else
					xx = xx * 1.10;

			}

			if (xx > 1.0E+09)
				xx = 1.0E+09;
			
			if (xx < 0.0)
				xx = 0.0;

			for (j = 0; j < NFleet; j++)
				HarvestValue[ktarget-1][j] = xx * PQuota[j];

			iter++;

		}

		/* Reset Random Number Seed */

		ISeed = ixseed;

		init_ranx(ISeed);

		/* Rewind Stochastic Data Files */

		for (k = 0; k < kfiles; k++)
			rewind(fp[k]);

	}

}
double CalcPStar()
{
	long i, j, k, ks, n;
	long kcount;
	double xx;


	kcount = 0;
	for (n = 0; n < NBoot; n++)
	{
		for (ks = 0; ks < NSims; ks++)
		{
			/* Clear Intermediate Storage */

			ZeroMatrix(StockAge,NAges,NYears);
			ZeroMatrix(CatchAge,NAges,NYears);
			ZeroMatrix(DiscAge,NAges,NYears);
			ZeroMatrix(SpawnStock,NAges,NYears);
			ZeroMatrix(MeanStock,NAges,NYears);
			ZeroMatrix(FMort,NAges,NYears);


			/* Input Data With Error */

			ApplyInputDataError();

			for (j = 0; j < NYears; j++)
			{
				StockBiomass[j] = 0.0;
				CatchBiomass[j] = 0.0;
				Landings[j]     = 0.0;
				Discards[j]     = 0.0;
				MeanBiomass[j]  = 0.0;
				SpawnBiomass[j] = 0.0;
				Recruits[j]     = 0.0;
			}

			/* Initialize Stock Numbers in 1st Year of Projection 
			** Using Bootstrap Numbers at Age 
			*/

			for (i = 0; i < NAges; i++)
				StockAge[i][0] = BootNumbers[i][n];

			/* Retrospective Adjustment */

			if (RetroFlag)
			{
				for (i = 0; i < NAges; i++)
					StockAge[i][0] = StockAge[i][0] * RetroAdjust[i];
			}


			/* Annual Projection Loop */

			for (j = 0; j < NYears; j++)
			{
				/*  Apply Mortality */

				if (HarvestSpec[j])
					ApplyHarvestQuota(j);
				else
					ApplyMortality(j);


				/* Apply Recruitment */

				ApplyRecruitment(j);

			}


			if (FMult[ktarget-1] > PStarF)
				kcount++;

		}
	}

	/* Rewind Stochastic Data Files */

	for (k = 0; k < kfiles; k++)
		rewind(fp[k]);


	xx = (double) kcount / (double) (NBoot * NSims);

	return(xx);
}
void PStarSummary()
{
	long i;

	printf("PStar Summary..\n");

	fprintf(fp2,"\n");
	fprintf(fp2,"PStar Summary Report\n\n");
	fprintf(fp2,"Overfishing F = %10.4f   Target Year = %ld\n\n",PStarF,TargetYear);
	fprintf(fp2,"  PStar          TAC\n\n");

	for (i = 0; i < KPStar; i++)
		fprintf(fp2,"%8.4f   %10.0f\n",PStar[i],PSCatch[i]);


}
void ExportR(char *fname,char *ds,char *ts)
{
	long i, j, k, n;
	long kx = 9;
	long nx[9];
	char *c, *t;
	char xname[FILEBUF];
	char buffer[MAXBUF];
	double *xvec;
	double *sdvec;
	double **xmat;
	double **ymat;

	printf("Export to R ...\n");

	strcpy(xname,fname);
	c = strrchr(xname,'.');
	*c = '\0';
	strcat(xname,".rdat");

	if ((fp2 = fopen(xname,"w")) == NULL)
	{
		fprintf(stderr,"Unable to Open Output File: %s\n",xname);
		exit(1);
	}

	fprintf(fp2,"structure(list(\n\n");

	fprintf(fp2,"metadata = structure(list(\n");
	fprintf(fp2,"     model='AGEPRO Version 4.2',\n");
	fprintf(fp2,"     descr='%s',\n",Model);
	fprintf(fp2,"     rundate='%s  %s',\n",ds,ts);

	strcpy(xname,fxname);

	c = xname;

	while (*c != '\0')
	{
		if (*c == '\\')
			*c = '/';
		c++;
	}

	fprintf(fp2,"     inputfile='%s',\n",xname);

	strcpy(xname,BootFile);

	c = xname;

	while (*c != '\0')
	{
		if (*c == '\\')
			*c = '/';
		c++;
	}


	fprintf(fp2,"     bootfile='%s'),\n",xname);
	fprintf(fp2,".Names= c('model','descr','rundate','inputfile','bootfile')),\n\n");

	fprintf(fp2,"genparms = structure(list(\n");
	fprintf(fp2,"     startyear=%ld,\n",NFYear);
	fprintf(fp2,"     endyear=%ld,\n",NXYear);
	fprintf(fp2,"     nyears=%ld,\n",NYears);
	fprintf(fp2,"     minage=%ld,\n",NFAge);
	fprintf(fp2,"     maxage=%ld,\n",NXAge);
	fprintf(fp2,"     nages=%ld,\n",NAges);
	fprintf(fp2,"     nrecmodel=%ld,\n",NRecModel);
	fprintf(fp2,"     nfleet=%ld,\n",NFleet);
	fprintf(fp2,"     nsims=%ld,\n",NSims);
	fprintf(fp2,"     nboot=%ld,\n",NBoot);
	fprintf(fp2,"     nrealcomp=%ld,\n",hcount);
	fprintf(fp2,"     nrealreq=%ld,\n",NSims*NBoot);
	fprintf(fp2,"     randseed=%ld),\n",ISeed);

	fprintf(fp2,".Names= c('startyear','endyear','nyears','minage','maxage','nages','nrecmodel','nfleet','nsims',");
	fprintf(fp2,"'nboot','nrealcomp','nrealreq','randseed')),\n\n");


	fprintf(fp2,"runopt = structure(list(\n");
	if (DiscFlag)
		fprintf(fp2,"     discards='Yes',\n");
	else
		fprintf(fp2,"     discards='No',\n");

	if (ThreshFlag)
		fprintf(fp2,"     refpoint='Yes',\n");
	else
		fprintf(fp2,"     refpoint='No',\n");

	if (RebuildFlag)
		fprintf(fp2,"     rebuild='Yes',\n");
	else
		fprintf(fp2,"     rebuild='No',\n");

	if (PStarFlag)
		fprintf(fp2,"     pstar='Yes'),\n");
	else
		fprintf(fp2,"     pstar='No'),\n");

	fprintf(fp2,".Names= c('discards','refpoint','rebuild','pstar')),\n\n");




	fprintf(fp2,"harvestscenario = structure(list(\n");
	fprintf(fp2,"     Type=c(");

	for (i = 0; i < NYears-1; i++)
	{
		if (HarvestSpec[i] == 0)
			fprintf(fp2,"'FMult',");
		else if (HarvestSpec[i] == 1)
			fprintf(fp2,"'Landings',");
		else
			fprintf(fp2,"'TotalCatch',");
	}

	if (HarvestSpec[NYears-1] == 0)
		fprintf(fp2,"'FMult'),\n");
	else if (HarvestSpec[NYears-1] == 1)
		fprintf(fp2,"'Landings'),\n");
	else
		fprintf(fp2,"'TotalCatch'),\n");

	for (k = 0; k < NFleet; k++)
	{
		fprintf(fp2,"     Fleet%d=c(",k+1);

		for (i = 0; i < NYears; i++)
		{
			if (HarvestSpec[i] == 0 && i < NYears-1)
				fprintf(fp2,"%10.6f,",HarvestValue[i][k]);
			else if (HarvestSpec[i] == 0)
				fprintf(fp2,"%10.6f),\n",HarvestValue[i][k]);
			else if (i < NYears - 1)
				fprintf(fp2,"%10.0f,",HarvestValue[i][k]);
			else
				fprintf(fp2,"%10.0f),\n",HarvestValue[i][k]);
		}
	}
	fprintf(fp2,".Names = c('Type',");
	for (k = 0; k < NFleet; k++)
	{
		if (i < NFleet-1)
			fprintf(fp2,"'Fleet%d',",k+1);
		else
			fprintf(fp2,"'Fleet%d'),\n",k+1);
	}
	fprintf(fp2,"row.names=c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"'%d',",NFYear+i);
		else
			fprintf(fp2,"'%d'),\n",NFYear+i);
	}
	fprintf(fp2,"class='data.frame')),\n\n");


	xvec  = (double *) calloc(NYears,sizeof(double));
	sdvec = (double *) calloc(NYears,sizeof(double));
	xmat = AllocMatrix(NYears,kx);

	nx[0] = 1;
	nx[1] = 5;
	nx[2] = 10;
	nx[3] = 25;
	nx[4] = 50;
	nx[5] = 75;
	nx[6] = 90;
	nx[7] = 95;
	nx[8] = 99;

	strcpy(xname,fname);
	c = strrchr(xname,'.');
	*c = '\0';
	strcat(xname,".out");

	if ((fp1 = fopen(xname,"r")) == NULL)
	{
		fprintf(stderr,"Unable to Open Output File: %s\n",xname);
		exit(1);
	}

	/* Recruits */

	while (!feof(fp1))
	{
		fgets(buffer,MAXBUF-1,fp1);

		if (strstr(buffer,"Recruits"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			fgets(buffer,MAXBUF-1,fp1);
			break;
		}
	}

	for (i = 0; i < NYears; i++)
	{
		fgets(buffer,MAXBUF-1,fp1);
		t = strtok(buffer," \t\r\n");
		t = strtok(NULL," \t\r\n");
		xvec[i] = atof(t) * scalerec;
		t = strtok(NULL," \t\r\n");
		sdvec[i] = atof(t) * scalerec;
	}

	for (i = 0; i < 4; i++)
		fgets(buffer,MAXBUF-1,fp1);

	for (i = 0; i < NYears; i++)
	{
		fgets(buffer,MAXBUF-1,fp1);
		t = strtok(buffer," \t\r\n");
		for (j = 0; j < kx; j++)
		{
			t = strtok(NULL," \t\r\n");
			xmat[i][j] = atof(t) * scalerec;
		}
	}

	fprintf(fp2,"recruits = structure(list(\n");
	fprintf(fp2,"    average = c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"%15.6E,",xvec[i]);
		else
			fprintf(fp2,"%15.6E),\n",xvec[i]);
	}
	fprintf(fp2,"    sdev = c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"%15.6E,",sdvec[i]);
		else
			fprintf(fp2,"%15.6E),\n",sdvec[i]);
	}

	for (j = 0; j < kx; j++)
	{

		fprintf(fp2,"    pct%ld = c(",nx[j]);
		for (i = 0; i < NYears; i++)
		{
			if (i < NYears-1)
				fprintf(fp2,"%15.6E,",xmat[i][j]);
			else
				fprintf(fp2,"%15.6E),\n",xmat[i][j]);
		}
	}



	fprintf(fp2,".Names = c('average','sdev','pct1','pct5','pct10','pct25','pct50','pct75','pct90','pct05','pct99'),\n");
	fprintf(fp2,"row.names=c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"'%d',",NFYear+i);
		else
			fprintf(fp2,"'%d'),\n",NFYear+i);
	}
	fprintf(fp2,"class='data.frame')),\n\n");



	/* SSB */

	while (!feof(fp1))
	{
		fgets(buffer,MAXBUF-1,fp1);

		if (strstr(buffer,"Spawning Stock Biomass"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			fgets(buffer,MAXBUF-1,fp1);
			break;
		}
	}

	for (i = 0; i < NYears; i++)
	{
		fgets(buffer,MAXBUF-1,fp1);
		t = strtok(buffer," \t\r\n");
		t = strtok(NULL," \t\r\n");
		xvec[i] = atof(t) * scalebio;
		t = strtok(NULL," \t\r\n");
		sdvec[i] = atof(t) * scalebio;
	}

	for (i = 0; i < 4; i++)
		fgets(buffer,MAXBUF-1,fp1);

	for (i = 0; i < NYears; i++)
	{
		fgets(buffer,MAXBUF-1,fp1);
		t = strtok(buffer," \t\r\n");
		for (j = 0; j < kx; j++)
		{
			t = strtok(NULL," \t\r\n");
			xmat[i][j] = atof(t) * scalebio;
		}
	}

	fprintf(fp2,"ssb = structure(list(\n");
	fprintf(fp2,"    average = c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"%15.6E,",xvec[i]);
		else
			fprintf(fp2,"%15.6E),\n",xvec[i]);
	}
	fprintf(fp2,"    sdev = c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"%15.6E,",sdvec[i]);
		else
			fprintf(fp2,"%15.6E),\n",sdvec[i]);
	}

	for (j = 0; j < kx; j++)
	{

		fprintf(fp2,"    pct%ld = c(",nx[j]);
		for (i = 0; i < NYears; i++)
		{
			if (i < NYears-1)
				fprintf(fp2,"%15.6E,",xmat[i][j]);
			else
				fprintf(fp2,"%15.6E),\n",xmat[i][j]);
		}
	}



	fprintf(fp2,".Names = c('average','sdev','pct1','pct5','pct10','pct25','pct50','pct75','pct90','pct05','pct99'),\n");
	fprintf(fp2,"row.names=c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"'%d',",NFYear+i);
		else
			fprintf(fp2,"'%d'),\n",NFYear+i);
	}
	fprintf(fp2,"class='data.frame')),\n\n");


	/* Jan-1 Biomass */

	while (!feof(fp1))
	{
		fgets(buffer,MAXBUF-1,fp1);

		if (strstr(buffer,"JAN-1 Stock Biomass"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			fgets(buffer,MAXBUF-1,fp1);
			break;
		}
	}

	for (i = 0; i < NYears; i++)
	{
		fgets(buffer,MAXBUF-1,fp1);
		t = strtok(buffer," \t\r\n");
		t = strtok(NULL," \t\r\n");
		xvec[i] = atof(t) * scalebio;
		t = strtok(NULL," \t\r\n");
		sdvec[i] = atof(t) * scalebio;
	}

	for (i = 0; i < 4; i++)
		fgets(buffer,MAXBUF-1,fp1);

	for (i = 0; i < NYears; i++)
	{
		fgets(buffer,MAXBUF-1,fp1);
		t = strtok(buffer," \t\r\n");
		for (j = 0; j < kx; j++)
		{
			t = strtok(NULL," \t\r\n");
			xmat[i][j] = atof(t) * scalebio;
		}
	}

	fprintf(fp2,"jan1bio = structure(list(\n");
	fprintf(fp2,"    average = c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"%15.6E,",xvec[i]);
		else
			fprintf(fp2,"%15.6E),\n",xvec[i]);
	}
	fprintf(fp2,"    sdev = c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"%15.6E,",sdvec[i]);
		else
			fprintf(fp2,"%15.6E),\n",sdvec[i]);
	}

	for (j = 0; j < kx; j++)
	{

		fprintf(fp2,"    pct%ld = c(",nx[j]);
		for (i = 0; i < NYears; i++)
		{
			if (i < NYears-1)
				fprintf(fp2,"%15.6E,",xmat[i][j]);
			else
				fprintf(fp2,"%15.6E),\n",xmat[i][j]);
		}
	}



	fprintf(fp2,".Names = c('average','sdev','pct1','pct5','pct10','pct25','pct50','pct75','pct90','pct05','pct99'),\n");
	fprintf(fp2,"row.names=c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"'%d',",NFYear+i);
		else
			fprintf(fp2,"'%d'),\n",NFYear+i);
	}
	fprintf(fp2,"class='data.frame')),\n\n");


	/* Mean Biomass */

	while (!feof(fp1))
	{
		fgets(buffer,MAXBUF-1,fp1);

		if (strstr(buffer,"Mean Biomass"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			fgets(buffer,MAXBUF-1,fp1);
			break;
		}
	}

	for (i = 0; i < NYears; i++)
	{
		fgets(buffer,MAXBUF-1,fp1);
		t = strtok(buffer," \t\r\n");
		t = strtok(NULL," \t\r\n");
		xvec[i] = atof(t) * scalebio;
		t = strtok(NULL," \t\r\n");
		sdvec[i] = atof(t) * scalebio;
	}

	for (i = 0; i < 4; i++)
		fgets(buffer,MAXBUF-1,fp1);

	for (i = 0; i < NYears; i++)
	{
		fgets(buffer,MAXBUF-1,fp1);
		t = strtok(buffer," \t\r\n");
		for (j = 0; j < kx; j++)
		{
			t = strtok(NULL," \t\r\n");
			xmat[i][j] = atof(t) * scalebio;
		}
	}

	fprintf(fp2,"meanbio = structure(list(\n");
	fprintf(fp2,"    average = c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"%15.6E,",xvec[i]);
		else
			fprintf(fp2,"%15.6E),\n",xvec[i]);
	}
	fprintf(fp2,"    sdev = c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"%15.6E,",sdvec[i]);
		else
			fprintf(fp2,"%15.6E),\n",sdvec[i]);
	}

	for (j = 0; j < kx; j++)
	{

		fprintf(fp2,"    pct%ld = c(",nx[j]);
		for (i = 0; i < NYears; i++)
		{
			if (i < NYears-1)
				fprintf(fp2,"%15.6E,",xmat[i][j]);
			else
				fprintf(fp2,"%15.6E),\n",xmat[i][j]);
		}
	}


	fprintf(fp2,".Names = c('average','sdev','pct1','pct5','pct10','pct25','pct50','pct75','pct90','pct05','pct99'),\n");
	fprintf(fp2,"row.names=c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"'%d',",NFYear+i);
		else
			fprintf(fp2,"'%d'),\n",NFYear+i);
	}
	fprintf(fp2,"class='data.frame')),\n\n");


	/* Total Catch Biomass */

	while (!feof(fp1))
	{
		fgets(buffer,MAXBUF-1,fp1);

		if (strstr(buffer,"Combined Catch Biomass"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			fgets(buffer,MAXBUF-1,fp1);
			break;
		}
	}

	for (i = 0; i < NYears; i++)
	{
		fgets(buffer,MAXBUF-1,fp1);
		t = strtok(buffer," \t\r\n");
		t = strtok(NULL," \t\r\n");
		xvec[i] = atof(t) * scalebio;
		t = strtok(NULL," \t\r\n");
		sdvec[i] = atof(t) * scalebio;
	}

	for (i = 0; i < 4; i++)
		fgets(buffer,MAXBUF-1,fp1);

	for (i = 0; i < NYears; i++)
	{
		fgets(buffer,MAXBUF-1,fp1);
		t = strtok(buffer," \t\r\n");
		for (j = 0; j < kx; j++)
		{
			t = strtok(NULL," \t\r\n");
			xmat[i][j] = atof(t) * scalebio;
		}
	}

	fprintf(fp2,"totalcatch = structure(list(\n");
	fprintf(fp2,"    average = c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"%15.6E,",xvec[i]);
		else
			fprintf(fp2,"%15.6E),\n",xvec[i]);
	}
	fprintf(fp2,"    sdev = c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"%15.6E,",sdvec[i]);
		else
			fprintf(fp2,"%15.6E),\n",sdvec[i]);
	}

	for (j = 0; j < kx; j++)
	{

		fprintf(fp2,"    pct%ld = c(",nx[j]);
		for (i = 0; i < NYears; i++)
		{
			if (i < NYears-1)
				fprintf(fp2,"%15.6E,",xmat[i][j]);
			else
				fprintf(fp2,"%15.6E),\n",xmat[i][j]);
		}
	}


	fprintf(fp2,".Names = c('average','sdev','pct1','pct5','pct10','pct25','pct50','pct75','pct90','pct05','pct99'),\n");
	fprintf(fp2,"row.names=c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"'%d',",NFYear+i);
		else
			fprintf(fp2,"'%d'),\n",NFYear+i);
	}
	fprintf(fp2,"class='data.frame')),\n\n");

	/* Landings */

	while (!feof(fp1))
	{
		fgets(buffer,MAXBUF-1,fp1);

		if (strstr(buffer,"Landings"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			fgets(buffer,MAXBUF-1,fp1);
			break;
		}
	}

	for (i = 0; i < NYears; i++)
	{
		fgets(buffer,MAXBUF-1,fp1);
		t = strtok(buffer," \t\r\n");
		t = strtok(NULL," \t\r\n");
		xvec[i] = atof(t) * scalebio;
		t = strtok(NULL," \t\r\n");
		sdvec[i] = atof(t) * scalebio;
	}

	for (i = 0; i < 4; i++)
		fgets(buffer,MAXBUF-1,fp1);

	for (i = 0; i < NYears; i++)
	{
		fgets(buffer,MAXBUF-1,fp1);
		t = strtok(buffer," \t\r\n");
		for (j = 0; j < kx; j++)
		{
			t = strtok(NULL," \t\r\n");
			xmat[i][j] = atof(t) * scalebio;
		}
	}

	fprintf(fp2,"landings = structure(list(\n");
	fprintf(fp2,"    average = c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"%15.6E,",xvec[i]);
		else
			fprintf(fp2,"%15.6E),\n",xvec[i]);
	}
	fprintf(fp2,"    sdev = c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"%15.6E,",sdvec[i]);
		else
			fprintf(fp2,"%15.6E),\n",sdvec[i]);
	}

	for (j = 0; j < kx; j++)
	{

		fprintf(fp2,"    pct%ld = c(",nx[j]);
		for (i = 0; i < NYears; i++)
		{
			if (i < NYears-1)
				fprintf(fp2,"%15.6E,",xmat[i][j]);
			else
				fprintf(fp2,"%15.6E),\n",xmat[i][j]);
		}
	}


	fprintf(fp2,".Names = c('average','sdev','pct1','pct5','pct10','pct25','pct50','pct75','pct90','pct05','pct99'),\n");
	fprintf(fp2,"row.names=c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"'%d',",NFYear+i);
		else
			fprintf(fp2,"'%d'),\n",NFYear+i);
	}
	fprintf(fp2,"class='data.frame')),\n\n");

	/* Discards */

	if (DiscFlag)
	{
		while (!feof(fp1))
		{
			fgets(buffer,MAXBUF-1,fp1);

			if (strstr(buffer,"Discards"))
			{
				fgets(buffer,MAXBUF-1,fp1);
				fgets(buffer,MAXBUF-1,fp1);
				break;
			}
		}

		for (i = 0; i < NYears; i++)
		{
			fgets(buffer,MAXBUF-1,fp1);
			t = strtok(buffer," \t\r\n");
			t = strtok(NULL," \t\r\n");
			xvec[i] = atof(t) * scalebio;
			t = strtok(NULL," \t\r\n");
			sdvec[i] = atof(t) * scalebio;
		}

		for (i = 0; i < 4; i++)
			fgets(buffer,MAXBUF-1,fp1);

		for (i = 0; i < NYears; i++)
		{
			fgets(buffer,MAXBUF-1,fp1);
			t = strtok(buffer," \t\r\n");
			for (j = 0; j < kx; j++)
			{
				t = strtok(NULL," \t\r\n");
				xmat[i][j] = atof(t) * scalebio;
			}
		}

		fprintf(fp2,"discards = structure(list(\n");
		fprintf(fp2,"    average = c(");

		for (i = 0; i < NYears; i++)
		{
			if (i < NYears-1)
				fprintf(fp2,"%15.6E,",xvec[i]);
			else
				fprintf(fp2,"%15.6E),\n",xvec[i]);
		}
		fprintf(fp2,"    sdev = c(");

		for (i = 0; i < NYears; i++)
		{
			if (i < NYears-1)
				fprintf(fp2,"%15.6E,",sdvec[i]);
			else
				fprintf(fp2,"%15.6E),\n",sdvec[i]);
		}

		for (j = 0; j < kx; j++)
		{

			fprintf(fp2,"    pct%ld = c(",nx[j]);
			for (i = 0; i < NYears; i++)
			{
				if (i < NYears-1)
					fprintf(fp2,"%15.6E,",xmat[i][j]);
				else
					fprintf(fp2,"%15.6E),\n",xmat[i][j]);
			}
		}


		fprintf(fp2,".Names = c('average','sdev','pct1','pct5','pct10','pct25','pct50','pct75','pct90','pct05','pct99'),\n");
		fprintf(fp2,"row.names=c(");

		for (i = 0; i < NYears; i++)
		{
			if (i < NYears-1)
				fprintf(fp2,"'%d',",NFYear+i);
			else
				fprintf(fp2,"'%d'),\n",NFYear+i);
		}
		fprintf(fp2,"class='data.frame')),\n\n");
	}

	/* F-Mult */

	while (!feof(fp1))
	{
		fgets(buffer,MAXBUF-1,fp1);

		if (strstr(buffer,"Total Fishing Mortality"))
		{
			fgets(buffer,MAXBUF-1,fp1);
			fgets(buffer,MAXBUF-1,fp1);
			break;
		}
	}

	for (i = 0; i < NYears; i++)
	{
		fgets(buffer,MAXBUF-1,fp1);
		t = strtok(buffer," \t\r\n");
		t = strtok(NULL," \t\r\n");
		xvec[i] = atof(t);
		t = strtok(NULL," \t\r\n");
		sdvec[i] = atof(t);
	}

	for (i = 0; i < 4; i++)
		fgets(buffer,MAXBUF-1,fp1);

	for (i = 0; i < NYears; i++)
	{
		fgets(buffer,MAXBUF-1,fp1);
		t = strtok(buffer," \t\r\n");
		for (j = 0; j < kx; j++)
		{
			t = strtok(NULL," \t\r\n");
			xmat[i][j] = atof(t);
		}
	}

	fprintf(fp2,"fmult = structure(list(\n");
	fprintf(fp2,"    average = c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"%15.6E,",xvec[i]);
		else
			fprintf(fp2,"%15.6E),\n",xvec[i]);
	}
	fprintf(fp2,"    sdev = c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"%15.6E,",sdvec[i]);
		else
			fprintf(fp2,"%15.6E),\n",sdvec[i]);
	}

	for (j = 0; j < kx; j++)
	{

		fprintf(fp2,"    pct%ld = c(",nx[j]);
		for (i = 0; i < NYears; i++)
		{
			if (i < NYears-1)
				fprintf(fp2,"%15.6E,",xmat[i][j]);
			else
				fprintf(fp2,"%15.6E),\n",xmat[i][j]);
		}
	}


	fprintf(fp2,".Names = c('average','sdev','pct1','pct5','pct10','pct25','pct50','pct75','pct90','pct05','pct99'),\n");
	fprintf(fp2,"row.names=c(");

	for (i = 0; i < NYears; i++)
	{
		if (i < NYears-1)
			fprintf(fp2,"'%d',",NFYear+i);
		else
			fprintf(fp2,"'%d'),\n",NFYear+i);
	}

	if ((StockSummaryFlag > 0) || ThreshFlag || RebuildFlag || PStarFlag)
		fprintf(fp2,"class='data.frame')),\n\n");
	else
		fprintf(fp2,"class='data.frame'))\n\n");



	/* Stock Numbers at Age */

	if (StockSummaryFlag > 0)
	{
		ymat = AllocMatrix(NAges,kx);

		while (!feof(fp1))
		{
			fgets(buffer,MAXBUF-1,fp1);

			if (strstr(buffer,"JAN-1 Stock Numbers at Age"))
				break;
		}
		for (n = 0; n < NYears; n++)
		{
			for (i = 0; i < 4; i++)
				fgets(buffer,MAXBUF-1,fp1);

			for (i = 0; i < NAges; i++)
			{
				fgets(buffer,MAXBUF-1,fp1);
				t = strtok(buffer," \t\r\n");
				for (j = 0; j < kx; j++)
				{
					t = strtok(NULL," \t\r\n");
					ymat[i][j] = atof(t) * scalestk;
				}
			}

			fprintf(fp2,"stock%ld = structure(list(\n",NFYear+n);


			for (j = 0; j < kx; j++)
			{

				fprintf(fp2,"    pct%ld = c(",nx[j]);
				for (i = 0; i < NAges; i++)
				{
					if (i < NAges-1)
						fprintf(fp2,"%15.6E,",ymat[i][j]);
					else
						fprintf(fp2,"%15.6E),\n",ymat[i][j]);
				}
			}


			fprintf(fp2,".Names = c('pct1','pct5','pct10','pct25','pct50','pct75','pct90','pct05','pct99'),\n");
			fprintf(fp2,"row.names=c(");

			for (i = 0; i < NAges; i++)
			{
				if (i < NAges-1)
					fprintf(fp2,"'age%d',",NFAge+i);
				else
					fprintf(fp2,"'age%d'),\n",NFAge+i);
			}

			if (ThreshFlag || RebuildFlag || PStarFlag)
				fprintf(fp2,"class='data.frame')),\n\n");
			else
				fprintf(fp2,"class='data.frame'))\n\n");
		}
	}

	if (ThreshFlag)
	{
		fprintf(fp2,"threshold = structure(list(\n");
		fprintf(fp2,"     ssb=%15.6E,\n",SSBThresh);
		fprintf(fp2,"     jan1bio=%15.6E,\n",StockBioThresh);
		fprintf(fp2,"     meanbio=%15.6E,\n",MeanBioThresh);
		fprintf(fp2,"     fmort=%15.6E),\n",FMortThresh);
		fprintf(fp2,".Names= c('ssb','jan1bio','meanbio','fmort')),\n\n");

		fprintf(fp2,"threshprob = structure(list(\n");

		for (i = 0; i < NYears; i++)
			xvec[i] = 0.0;

		if (SSBThresh > 0.0)
		{
			while (!feof(fp1))
			{
				fgets(buffer,MAXBUF-1,fp1);

				if (strstr(buffer,"Probability Spawning Stock Biomass Exceeds Threshold"))
				{
					fgets(buffer,MAXBUF-1,fp1);
					fgets(buffer,MAXBUF-1,fp1);
					fgets(buffer,MAXBUF-1,fp1);
					break;
				}
			}

			for (i = 0; i < NYears; i++)
			{
				fgets(buffer,MAXBUF-1,fp1);
				t = strtok(buffer," \t\r\n");
				t = strtok(NULL," \t\r\n");
				xvec[i] = atof(t);
			}

		}

		fprintf(fp2,"    ssb = c(");

		for (i = 0; i < NYears; i++)
		{
			if (i < NYears-1)
				fprintf(fp2,"%15.6E,",xvec[i]);
			else
				fprintf(fp2,"%15.6E),\n",xvec[i]);
		}

		for (i = 0; i < NYears; i++)
			xvec[i] = 0.0;

		if (StockBioThresh > 0.0)
		{
			while (!feof(fp1))
			{
				fgets(buffer,MAXBUF-1,fp1);

				if (strstr(buffer,"Probability Jan-1 Stock Biomass Exceeds Threshold"))
				{
					fgets(buffer,MAXBUF-1,fp1);
					fgets(buffer,MAXBUF-1,fp1);
					fgets(buffer,MAXBUF-1,fp1);
					break;
				}
			}

			for (i = 0; i < NYears; i++)
			{
				fgets(buffer,MAXBUF-1,fp1);
				t = strtok(buffer," \t\r\n");
				t = strtok(NULL," \t\r\n");
				xvec[i] = atof(t);
			}

		}

		fprintf(fp2,"    jan1bio = c(");

		for (i = 0; i < NYears; i++)
		{
			if (i < NYears-1)
				fprintf(fp2,"%15.6E,",xvec[i]);
			else
				fprintf(fp2,"%15.6E),\n",xvec[i]);
		}


		for (i = 0; i < NYears; i++)
			xvec[i] = 0.0;

		if (MeanBioThresh > 0.0)
		{
			while (!feof(fp1))
			{
				fgets(buffer,MAXBUF-1,fp1);

				if (strstr(buffer,"Probability Mean Biomass Exceeds Threshold"))
				{
					fgets(buffer,MAXBUF-1,fp1);
					fgets(buffer,MAXBUF-1,fp1);
					fgets(buffer,MAXBUF-1,fp1);
					break;
				}
			}

			for (i = 0; i < NYears; i++)
			{
				fgets(buffer,MAXBUF-1,fp1);
				t = strtok(buffer," \t\r\n");
				t = strtok(NULL," \t\r\n");
				xvec[i] = atof(t);
			}

		}

		fprintf(fp2,"    meanbio = c(");

		for (i = 0; i < NYears; i++)
		{
			if (i < NYears-1)
				fprintf(fp2,"%15.6E,",xvec[i]);
			else
				fprintf(fp2,"%15.6E),\n",xvec[i]);
		}


		for (i = 0; i < NYears; i++)
			xvec[i] = 0.0;

		if (FMortThresh > 0.0)
		{
			while (!feof(fp1))
			{
				fgets(buffer,MAXBUF-1,fp1);

				if (strstr(buffer,"Probability Total Fishing Mortality Exceeds Threshold"))
				{
					fgets(buffer,MAXBUF-1,fp1);
					fgets(buffer,MAXBUF-1,fp1);
					fgets(buffer,MAXBUF-1,fp1);
					break;
				}
			}

			for (i = 0; i < NYears; i++)
			{
				fgets(buffer,MAXBUF-1,fp1);
				t = strtok(buffer," \t\r\n");
				t = strtok(NULL," \t\r\n");
				xvec[i] = atof(t);
			}

		}

		fprintf(fp2,"    fmort = c(");

		for (i = 0; i < NYears; i++)
		{
			if (i < NYears-1)
				fprintf(fp2,"%15.6E,",xvec[i]);
			else
				fprintf(fp2,"%15.6E),\n",xvec[i]);
		}

		fprintf(fp2,".Names = c('ssb','jan1bio','meanbio','fmort'),\n");
		fprintf(fp2,"row.names=c(");

		for (i = 0; i < NYears; i++)
		{
			if (i < NYears-1)
				fprintf(fp2,"'%d',",NFYear+i);
			else
				fprintf(fp2,"'%d'),\n",NFYear+i);
		}

		if (RebuildFlag || PStarFlag)
			fprintf(fp2,"class='data.frame')),\n\n");
		else
			fprintf(fp2,"class='data.frame'))\n\n");
	}

	if (RebuildFlag)
	{
		fprintf(fp2,"rebuild = structure(list(\n");
		fprintf(fp2,"     year=%ld,\n",TargetYear);

		if (TargetType == 0)
			fprintf(fp2,"     type='spawning stock biomass',\n");
		else if (TargetType == 1)
			fprintf(fp2,"     type='jan1 biomass',\n");
		else
			fprintf(fp2,"     type='mean biomass',\n");

		fprintf(fp2,"     target=%15.6E,\n",TargetValue);
		fprintf(fp2,"     percent=%15.6E,\n",TargetPercent);
		fprintf(fp2,"     frebuild=%15.6E),\n",FMult[ktarget-1]);
		fprintf(fp2,".Names= c('year','type','value','percent','frebuild'))\n\n");
	}

	if (PStarFlag)
	{
		fprintf(fp2,"pstarget = structure(list(\n");
		fprintf(fp2,"     year=%ld,\n",TargetYear);
		fprintf(fp2,"     overfish=%15.6E,\n",PStarF);
		fprintf(fp2,"     nlevel=%ld),\n",KPStar);
		fprintf(fp2,".Names= c('year','overfish','nlevel')),\n\n");

		fprintf(fp2,"pstar = structure(list(\n");
		fprintf(fp2,"   pslevel = c(");

		for (i = 0; i < KPStar; i++)
		{
			if (i < KPStar-1)
				fprintf(fp2,"%15.6E,",PStar[i]);
			else
				fprintf(fp2,"%15.6E),\n",PStar[i]);
		}

		fprintf(fp2,"   tac = c(");

		for (i = 0; i < KPStar; i++)
		{
			if (i < KPStar-1)
				fprintf(fp2,"%15.6E,",PSCatch[i]);
			else
				fprintf(fp2,"%15.6E),\n",PSCatch[i]);
		}
		fprintf(fp2,".Names= c('pslevel','tac'),\n");
		fprintf(fp2,"class='data.frame'))\n\n");
	}

	fprintf(fp2,"), .Names= c('metadata','genparms','runopt','harvestscenario','recruits','ssb','jan1bio','meanbio','totalcatch','landings',");

	if (DiscFlag)
		fprintf(fp2,"'discards',");

	fprintf(fp2,"'fmult'");


	if (StockSummaryFlag > 0)
	{
		for (i = 0; i < NYears; i++)
			fprintf(fp2,",'stock%ld'",NFYear+i);
	}

	if (ThreshFlag)
		fprintf(fp2,",'threshold','threshprob'");

	if (RebuildFlag)
		fprintf(fp2,",'rebuild'");
	else if (PStarFlag)
		fprintf(fp2,",'pstarget','pstar'");

	fprintf(fp2,"))\n");

	fclose(fp1);
	fclose(fp2);

}
void ReportPercentLevel()
{
	long i, j;


	printf("Requested Percentile Report\n");
	fprintf(fp2,"\n\nRequested Percentile Report\n\n");
	fprintf(fp2,"Percentile = %8.2f %%\n\n",PercReportValue);

	fprintf(fp2,"                           ");
	for (i = 0; i < NYears; i++)
		fprintf(fp2,"%10ld ",NFYear+i);
	fprintf(fp2,"\n\n");

	fprintf(fp2,"Recruits                   ");
	for (j = 0; j < NYears; j++)
		fprintf(fp2,"%10.4f ",PercRepMat[j][NAges]);
	fprintf(fp2,"\n");

	fprintf(fp2,"Spawning Stock Biomass     ");
	for (j = 0; j < NYears; j++)
		fprintf(fp2,"%10.4f ",PercRepMat[j][NAges+1]);
	fprintf(fp2,"\n");


	fprintf(fp2,"Jan-1 Stock Biomass        ");
	for (j = 0; j < NYears; j++)
		fprintf(fp2,"%10.4f ",PercRepMat[j][NAges+2]);
	fprintf(fp2,"\n");

	fprintf(fp2,"Mean Biomass               ");
	for (j = 0; j < NYears; j++)
		fprintf(fp2,"%10.4f ",PercRepMat[j][NAges+3]);
	fprintf(fp2,"\n");

	fprintf(fp2,"Combined Catch Biomass     ");
	for (j = 0; j < NYears; j++)
		fprintf(fp2,"%10.4f ",PercRepMat[j][NAges+4]);
	fprintf(fp2,"\n");

	fprintf(fp2,"Landings                   ");
	for (j = 0; j < NYears; j++)
		fprintf(fp2,"%10.4f ",PercRepMat[j][NAges+5]);
	fprintf(fp2,"\n");

	if (DiscFlag)
	{
		fprintf(fp2,"Discards                   ");
		for (j = 0; j < NYears; j++)
			fprintf(fp2,"%10.4f ",PercRepMat[j][NAges+6]);
		fprintf(fp2,"\n");
	}

	fprintf(fp2,"FMort                      ");
	for (j = 0; j < NYears; j++)
		fprintf(fp2,"%10.4f ",PercRepMat[j][NAges+7]);
	fprintf(fp2,"\n");

	if (StockSummaryFlag > 0)
	{
		fprintf(fp2,"\nStock Numbers at Age\n");
		for (i = 0; i < NAges; i++)
		{
			fprintf(fp2,"Age %ld                      ",i+1);
			for (j = 0; j < NYears; j++)
				fprintf(fp2,"%10.4f ",PercRepMat[j][i]);
			fprintf(fp2,"\n");
		}

	}


}


