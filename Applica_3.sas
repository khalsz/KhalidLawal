/*Application 3 - Data Analysis 
Khalid Lawal, Siarhei Bartalevich, Sakina Mustafayeva, Farshid Alizadminaabad, Naghmeh Mohammadpourlima- */

libname applic3 "/folders/myshortcuts/MyFolders/study1";
run;

/*Exercise 1*/
/*Modelling with variable years in application 2*/
data applic3.reg_depart;
	set applic2.reg_depart;
	keep Code_geographique Libell_geographique AN Gender Nom_Region Nom_Depart CSP 
		SalH Salaire_net_horaire_moyen1;
run;

proc import 
		datafile="/folders/myshortcuts/MyFolders/study1/region_departement.xlsx" 
		out=applic3.re_dept dbms=xlsx replace;
run;

proc sort data=applic3.re_dept;
	by Code_Depart;
run;

data applic3.reg_depart;
	merge Applic2.byCode applic3.re_dept;
	by Code_Depart;
run;

data applic3.reg_depart;
	length GENDER $ 10;
	set applic3.reg_depart;

	if GENDER="Fema " then
		GENDER="Female";
run;

proc freq data=applic3.re_dept;
run;

DATA applic3.reg_depart;
	SET applic3.reg_depart;
	logSal=log(SalH);

	IF Nom_Region="Auvergne-Rhône-Alpes" THEN
		N1=1;
	ELSE
		N1=0;

	IF Nom_Region="Centre-Val de Loire" THEN
		N4=1;
	ELSE
		N4=0;

	IF Nom_Region="Corse" THEN
		N5=1;
	ELSE
		N5=0;

	IF Nom_Region="Bourgogne-Franche-Comté" THEN
		N2=1;
	ELSE
		N2=0;

	IF Nom_Region="Bretagne" THEN
		N3=1;
	ELSE
		N3=0;

	IF Nom_Region="Grand-Est" THEN
		N6=1;
	ELSE
		N6=0;

	IF Nom_Region="Guadeloupe" THEN
		N7=1;
	ELSE
		N7=0;

	IF Nom_Region="Guyane" THEN
		N8=1;
	ELSE
		N8=0;

	IF Nom_Region="Hauts-de-France" THEN
		N9=1;
	ELSE
		N9=0;

	IF Nom_Region="Martinique" THEN
		N10=1;
	ELSE
		N10=0;

	IF Nom_Region="Normandie" THEN
		N11=1;
	ELSE
		N11=0;

	IF Nom_Region="Nouvelle-Aquitaine" THEN
		N12=1;
	ELSE
		N12=0;

	IF Nom_Region="Occitanie" THEN
		N13=1;
	ELSE
		N13=0;

	IF Nom_Region="Pays de la Loire" THEN
		N14=1;
	ELSE
		N14=0;

	IF Nom_Region="Provence-Alpes-Côte d'Azur" THEN
		N15=1;
	ELSE
		N15=0;

	IF Nom_Region="La Réunion" THEN
		N16=1;
	ELSE
		N16=0;

	IF Nom_Region="Île-de-France" THEN
		N17=1;
	ELSE
		N17=0;

	IF GENDER="Female" THEN
		F=1;
	ELSE
		F=0;

	IF CSP="Cadre" THEN
		Cadre=1;
	ELSE
		Cadre=0;

	IF AN="2012" THEN
		Y1=1;
	ELSE
		Y1=0;

	IF AN="2013" THEN
		Y2=1;
	ELSE
		Y2=0;

	IF AN="2014" THEN
		Y3=1;
	ELSE
		Y3=0;

	IF AN="2015" THEN
		Y4=1;
	ELSE
		Y4=0;

	IF AN="2016" THEN
		Y5=1;
	ELSE
		Y5=0;

	IF AN="2017" THEN
		Y6=1;
	ELSE
		Y6=0;
	FCadre=F*Cadre;
Run;

PROC REG DATA=applic3.reg_depart;
	LOG : MODEL logSal=N2 N3 N4 N5 N6 N7 N8 N9 N10 N11 N12 N13 N14 N15 N16 N17 N1 
		F Cadre FCadre Y1 Y2 Y3 Y4 Y5 Y6 / DWPROB SPEC;
	OUTPUT OUT=reg_out r=regress p=estimated;
	PLOT R. * NQQ.;
	PLOT R. * P.;

	/*for heteroscedasticity*/
	Plot Rstudent.* P.;
	plot Rstudent. * H.;

	/* H=> leverage*/
	/*Without intervals*/
	TEST N1=N2=N3=N4=N5=N6=N7=N8=N9=N10=N11=N12=N13=N14=N15=N16=N17;
	TEST N3=N5;
	TEST N2=N12;
	RUN;
QUIT;

/* After running the regression, the model presented numerous extreme values. The Plots also cinfirms this*/
/* Normality */
PROC UNIVARIATE DATA=reg_out all normal plot;
	VAR estimated;
RUN;

/* The two plots shows an abnormal distribution or estimation. Kolmogorov-Smirnov and  Cramer-von Mises also affirms this with low p-value (less than 0.05).*/
/* The same result with low (less than 0.05) P-value was also obtained from the  Anderson-Darling normality test.  */
/*H0 = there is no autocorrelation
H1 = there is autocorrelation */
/*DW - Order 1 and 2 autocorrelation*/
PROC AUTOREG DATA=applic3.reg_depart;
	MODEL logSal=N2 N3 N4 N5 N6 N7 N8 N9 N10 N11 N12 N13 N14 N15 N16 N17 N1 F 
		Cadre FCadre Y1 Y2 Y3 Y4 Y5 Y6/ dw=1 dwprob;
RUN;

/* DW statistic = 2.2570 at order 1, therefore we can't reject H0. */
PROC AUTOREG DATA=applic3.reg_depart;
	MODEL logSal=N2 N3 N4 N5 N6 N7 N8 N9 N10 N11 N12 N13 N14 N15 N16 N17 N1 F 
		Cadre FCadre Y1 Y2 Y3 Y4 Y5 Y6/ dw=4 dwprob;
RUN;

/*DW statistics = 2.35431 at order 2, therefore we can not also reject the null hypothesis */
/*Exercise 1, no. 3*/
/*Performing Linear regression with year and wage as explicative factor*/
DATA applic3.reg_depart;
	SET applic3.reg_depart;
	LofSallag=lag(logSal);

	IF AN=2012 THEN
		LofSallag=".";
RUN;

PROC REG DATA=applic3.reg_depart;
	MODEL logSal=N2 N3 N4 N5 N6 N7 N8 N9 N10 N11 N12 N13 N14 N15 N16 N17 N1 F 
		Cadre FCadre LofSallag;
	RUN;
QUIT;

/*Exercise 1, no. 4*/
/* Fisher test   */
/*H0=the variables are equal and they have equal impact.
H1=the variables are not equal and they don't have equal impact.
According to the first test, we reject null hypothesis, since the p value is low (less than 0.05), hence not all varaible have the same impact.
Due to the high p-value which is above 0.05 in the two other tests, we can accept null hypothesis.

/*Exercise 1, no.5*/
/*  Chow Test  */
/* H0 = the relationship is valid for all years */
/* H1 = at least one of the parameters is different from one year to the others  */
proc freq data=applic3.reg_depart;
	table AN;
run;

proc sort data=applic3.reg_depart;
	by AN;
run;

proc reg data=applic3.reg_depart outest=coefffi;
	by AN;
	MODEL logSal=N2 N3 N4 N5 N6 N7 N8 N9 N10 N11 N12 N13 N14 N15 N16 N17 N1 F 
		Cadre FCadre LofSallag;
	run;
quit;

proc autoreg data=applic3.reg_depart;
	MODEL logSal=N2 N3 N4 N5 N6 N7 N8 N9 N10 N11 N12 N13 N14 N15 N16 N17 N1 F 
		Cadre FCadre LofSallag;
run;

quit;

/* SInce the p-value is smaller than 0.0002 so we can reject H0 hypothesis.  */
/*Then we need to know which years carry the differences*/
proc reg data=applic3.reg_depart;
	MODEL logSal=N2 N3 N4 N5 N6 N7 N8 N9 N10 N11 N12 N13 N14 N15 N16 N17 N1 F 
		Cadre FCadre LofSallag;
	test Y2=Y3=Y4=Y5=Y6=0;
	run;
quit;

/*We decided to exclude the first year because it constant;
The result of the test shows that the p-value is smaller than 0.0001, hence we reject hypothesis that the coefficients are equal to 0.

/*Exercice 3*/
/*New estimation with hierarchic regression from cities and regions*/
PROC MIXED DATA=applic3.reg_depart;
	CLASS Code_geographique Nom_Region;
	MODEL logSal=N2 N3 N4 N5 N6 N7 N8 N9 N10 N11 N12 N13 N14 N15 N16 N17 N1 F 
		Cadre FCadre Y1 Y2 Y3 Y4 Y5 Y6 / solution DDFM=BW;
	RANDOM intercept / SUBJECT=Code_geographique*Nom_Region;
RUN;