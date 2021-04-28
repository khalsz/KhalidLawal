/*Application 2 - Data Analysis 
Khalid Lawal, Siarhei Bartalevich, Sakina Mustafayeva, Farshid Alizadminaabad, Naghmeh Mohammadpourlima- */



libname applic2 "/folders/myshortcuts/MyFolders/study1";
run; 

/* Question 1  */
DATA Applic2.byCode;
SET Appli1.byCode;
Code_Depart=SUBSTR(Code_Geographique,1,2);
RUN;

proc import datafile="/folders/myshortcuts/MyFolders/study1/region_departement.xlsx"
out= applic2.region_dept
dbms=xlsx
replace;
run; 



data applic2.region_dept; 
set applic2.region_dept; 
if Nom_Region = "Corse" then delete; 
run; 

data applic2.reg_depart; 
merge Applic2.byCode applic2.region_dept; 
by Code_Depart; 
run; 

/* To remove all variables that don't have regional code*/
data applic2.reg_depart; 
set applic2.reg_depart; 
datew = anydigit(Code_Depart) & Code_Depart < 98;
run;

data applic2.reg_depart; 
set applic2.reg_depart; 
if datew NE 1 then delete; 
run; 

data applic2.reg_depart; 
set applic2.reg_depart; 
datew = anydigit(Code_Depart) & Code_Depart < 98;
drop datew;
run;

/* Question 2 */
DATA applic2.reg_depart; 
SET applic2.reg_depart; 
LABEL Code_Depart="Departement"
	  Nom_Depart="Departement"
	  Code_Region="Code Region"
	  Nom_Region="Region";
	  
RUN;

/* Converting variable Salaire_net_horaire_moyen from character to numeric */
data applic2.reg_depart; 
set applic2.reg_depart; 
Salaire_net_horaire_moyen1 = input(Salaire_net_horaire_moyen, 16.13); 
drop Salaire_net_horaire_moyen; 
run; 

/* Question 3 */
data applic2.reg_depart_2015; 
set applic2.reg_depart; 
where AN = 2015; 
run;
PROC TABULATE DATA=applic2.reg_depart_2015;
TITLE "Descriptive Statistics of Average Workers Salaries for the year 2015 based on Department";
CLASS Code_Depart;
VAR Salaire_net_horaire_moyen1;
WHERE(Nom_Region)="Île-de-France";
TABLE Code_Depart, Salaire_net_horaire_moyen1*(MEDIAN Q1 Q3 MAX MIN);
LABEL Salaire_net_horaire_moyen1="Salaires";
footnote "Ile-de-France  region  Descriptive data ";
RUN;

/* Question 4 */
ODS RTF FILE="/folders/myshortcuts/MyFolders/study1/word_out.doc";
PROC TABULATE DATA=applic2.reg_depart_2015;
TITLE "Descriptive Statistics of Average Workers Salaries for the year 2015 based on Department";
CLASS Code_Depart;
VAR Salaire_net_horaire_moyen1;
WHERE(Nom_Region)="Ile-de-France";
TABLE Code_Depart, Salaire_net_horaire_moyen1*(MEDIAN Q1 Q3 MAX MIN);
LABEL Salaire_net_horaire_moyen1="Salaires";
footnote "Ile-de-France  region  Descriptive data "
RUN;
ODS RTF CLOSE;

/* Question 5 */
data applic2.reg_depart;
length GENDER $ 10;
set applic2.reg_depart;
if GENDER = "Fema " then GENDER = "Female"; 
run; 

proc sort data = applic2.reg_depart;
by Code_Depart GENDER;
run;

proc means data = applic2.reg_depart;
by Code_Depart GENDER; 
VAR Salaire_net_horaire_moyen1;
OUTPUT OUT= applic2.GenDep MEAN=average;
run; 

data applic2.GenDep;
set applic2.GenDep;
run; 
data applic2.GenDep1;
merge applic2.GenDep applic2.region_dept;
by Code_Depart; 
run;

data applic2.GenDep1;
set applic2.GenDep1;
if GENDER = "Male" then GENDER = 1; 
if GENDER = "Female" then GENDER = 2; 
run; 

data applic2.GenDep1;
set applic2.GenDep1;
SEX = input(GENDER,10.); 
run; 


proc corr data = applic2.GenDep1;
var average SEX; 
run; 
/* According to the statistics, the two variables are positively correlated, with correlation value of [0.02]. 
and the P-Value is < 0.01*/

/* Question 6 */
PROC MEANS MEAN DATA=applic2.reg_depart(WHERE=(GENDER="Male")) ;
VAR Salaire_net_horaire_moyen1;
BY Code_Depart;
OUTPUT OUT=applic2.MeanM MEAN=MMean;
RUN;

PROC MEANS MEAN DATA=applic2.reg_depart(WHERE=(GENDER="Female"));
VAR Salaire_net_horaire_moyen1;
BY Code_Depart;
OUTPUT OUT=applic2.MeanF MEAN=FMean;
RUN;
data MFMean; 
merge applic2.region_dept applic2.MeanF applic2.MeanM;
by  Code_Depart;
drop _TYPE_ _FREQ_;
label MMean = "Male Average Wage"; 
label FMean = "Female Average Wage"
run; 

/* PROC sgscatter  DATA=MFMean; */
/*    PLOT MMean * FMean */
/*    / datalabel = Nom_Depart group = Nom_Depart; */
/* RUN; */

/* Question 7 */
data applic2.reg_depart;
set applic2.reg_depart; 
run; 

PROC MEANS Q1 MEDIAN Q3 DATA=applic2.reg_depart(WHERE=(GENDER="Male"));
VAR Salaire_net_horaire_moyen1;
RUN;
PROC MEANS Q1 MEDIAN Q3 DATA=applic2.reg_depart(WHERE=(GENDER="Female"));
VAR Salaire_net_horaire_moyen1;
RUN;
PROC SORT DATA=applic2.reg_depart;
BY Libell_Geographique;
RUN;
PROC MEANS MEAN data = applic2.reg_depart(WHERE=(GENDER="Male")) noprint;
VAR Salaire_net_horaire_moyen1;
BY Libell_Geographique;
OUTPUT OUT=Applic2.SaalM MEAN=SalM;
RUN;
PROC MEANS MEAN DATA=applic2.reg_depart(WHERE=(GENDER="Female")) noprint;
VAR Salaire_net_horaire_moyen1;
BY Libell_Geographique;
OUTPUT OUT=Applic2.SaalF MEAN=SalF;
RUN;

DATA Applic2.SalFM;
MERGE Applic2.SaalF Applic2.SaalM;
BY Libell_Geographique;
LABEL SalF="Female Salaries"
	  SalM="Male Salaries";
drop _TYPE_ _FREQ_;
RUN; 

DATA Applic2.SalMM;
SET Applic2.SalFM;
IF SalM<12.2749947 THEN Q_hom=1;
IF 12.8793632 < SalM < 13.2357184 THEN Q_hom=2;
IF 14.0371288 < SalM < 14.7416432 THEN Q_hom=3;
IF SalM>14.7416432 THEN Q_hom=4;
IF SalF<12.2749947 THEN Q_fem=1;
IF 12.8793632 < SalF < 13.2357184THEN Q_fem=2;
IF 14.0371288 < SalF < 14.7416432  THEN Q_fem=3;
IF SalF>14.7416432 THEN Q_fem=4;
RUN;


/*Question 8*/
PROC FREQ DATA=Applic2.SalMM;
TABLE Q_hom*Q_fem / chisq;
RUN;
/* With H0:variables have no relationship, ChiSquare was done between variable Q_fem and Q_hom.
/* Since the P-Value is 0.01 we can reject null hypothesis. Hence there is correlation between the two variables */

/*Question 9*/
PROC CORR DATA=Applic2.SalMM spearman kendall hoeffding;
VAR Q_hom; 
with Q_fem;
RUN;
PROC FREQ DATA=Applic2.SalMM;
TABLE Q_hom*Q_fem / jt;
RUN;
/* The Statistical result shows correlation between the two variable, and P-Value is < 0.01, hence significant and we reject null hypothesis */

/* Question 10 */

proc freq data= applic2.reg_depart;
tables Nom_Region; 
run; 
proc sort data=applic2.reg_depart;
by Nom_Region AN; 
run; 

PROC MEANS MEAN DATA=applic2.reg_depart(WHERE=(Nom_Region="Île-de-France")) noprint;
VAR Salaire_net_horaire_moyen1;
BY Nom_Region AN;
OUTPUT OUT=Applic2.MeanIF MEAN=IFMean;
RUN;
PROC MEANS MEAN DATA=applic2.reg_depart(WHERE=(Nom_Region="Auvergne-Rhône-Alpes")) noprint;
VAR Salaire_net_horaire_moyen1;
BY Nom_Region AN;
OUTPUT OUT=Applic2.MeanARA MEAN=ARAMean;
RUN;
PROC MEANS MEAN DATA=applic2.reg_depart(WHERE=(Nom_Region="Provence-Alpes-Côte d'Azur")) noprint;
VAR Salaire_net_horaire_moyen1;
BY Nom_Region AN;
OUTPUT OUT=Applic2.MeanPAC MEAN=PACMean;
RUN;

DATA Applic2.for_Graph;
MERGE Applic2.MeanPAC Applic2.MeanARA Applic2.MeanIF;
BY Nom_Region AN;
drop _TYPE_ _FREQ_;
RUN;



/*Question 11*/
DATA Applic2.for_Graph;
SET Applic2.for_Graph;
IF AN="2012" THEN Inf=0.02;
IF AN="2013" THEN Inf=0.009;
IF AN="2014" THEN Inf=0.005;
IF AN="2015" THEN Inf=0.00;
IF AN="2016" THEN Inf=0.002;
IF AN="2017" THEN Inf=0.01;
RUN;
DATA Applic2.for_Graphe;
SET Applic2.for_Graph;
SalPAC=PACMean-(PACMean*Inf);
SalARA=ARAMean-(ARAMean*Inf);
SalIF=IFMean-(IFMean*Inf);
RUN;
