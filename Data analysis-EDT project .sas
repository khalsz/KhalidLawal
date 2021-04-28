libname final "/folders/myshortcuts/MyFolders/final";
run;
data final.menag;
set "/folders/myshortcuts/MyFolders/final/menagep.sas7bdat";
run;

data final.ind;
set "/folders/myshortcuts/MyFolders/final/indip.sas7bdat";
run;

data final.ind_Menag;
merge final.ind final.menag;
by idmen;
run;

data final.ind_Menag;
set final.ind_Menag;
REG = input(RG, 4.);
ty = vtype(REG);
drop RG;
run;

DATA final.RegN;
LENGTH RegName $ 30;
INPUT REG RegName$;
DATALINES;
01  Guadeloupe
02  Martinique
03  Guyane
04  Réunion
21  Champagne-Ardennes
22  Picardie
23  Haute-Normandie
24  Centre
25  Basse-Normandie
26  Bourgogne
94  Corse
72  Aquitaine
83  Auvergne
43  Franche-Comté
31  Nord-Pas-De-Calais
74  Limousin
82  Rhône-Alpes
93  Provence-Alpes-Côted'Azur
91  Languedoc-Roussillon
41  Lorraine
52  PaysdelaLoire
11  IleDeFrance
54  Poitou-Charente
53  Bretagne
42  Alsace
73  Midi-Pyrénées
;
run;

proc sort  data=final.RegN;
by REG;
run;

proc sort data=final.ind_Menag;
by reg;
run;

data final.ind_MenagN;
merge final.ind_Menag final.RegN;
by REG;
run;

data final.ind_MenagNS;
set final.ind_MenagN;
run;

data final.ind_MenagNS;
set final.ind_MenagNS;
tys = vtype(age);
run;

DATA final.ind_MenagNS;
length CSP $ 20 AgeRange $20;
SET final.ind_MenagNS;
if csmen in ("11", "12", "12") then CSP = "Farmers";
else if csmen in ("21", "22", "23") then CSP = "Craftman-Trader";
else if csmen in ("31", "33", "34", "35", "37", "38") then csp = "Executive-Professional";
else if csmen in ("42", "43", "44", "45", "46", "47", "48") then csp = "Inter-Prof";
else if csmen in ("52", "53", "54", "55", "56") then csp = "Employee";
else if csmen in ("63", "64", "65", "66", "67", "68", "69") then csp = "worker";

if age < 25 then AgeRange = "Under_25";
else if 24 < age < 35 then AgeRange = "Betw_25-35_Yrs";
else if 34 < age < 45 then AgeRange = "Betw_35-45_Yrs";
else if 44 < age < 55 then AgeRange = "Betw_45-55_Yrs";
else if 54 < age < 65 then AgeRange = "Betw_55-65_Yrs";
else if age > 64 then AgeRange = "Above_65_Yrs";
run;

 
/*Frequency of individuals and occupated active/non-active people*/
PROC SORT DATA=final.ind_MenagNS;
BY RegName actoccup;
RUN;
Title "Frequency Table Showing Region Names";
PROC FREQ DATA=final.ind_MenagNS;
TABLE RegName;
RUN;
Title "Frequency Table Showing Active People in Selected Region";
PROC FREQ DATA=final.ind_MenagNs;
TABLE RegName*actoccup;
RUN;

PROC SORT DATA=final.ind_MenagNs;
BY RegName AgeRange;
RUN;

Title "Frequency Table Showing People's Age Range in Selected Region";
PROC FREQ DATA=final.ind_MenagNs;
TABLE RegName * AgeRange;
By RegName;
RUN;

PROC SORT DATA=final.ind_MenagNs;
BY RegName CESS10;
RUN;
Title "Frequency Table Showing People Currently Looking for Job in Selected Region";
PROC FREQ DATA=final.ind_MenagNs;
TABLE CESS10;
BY RegName;
RUN;
/*Frequency of CSP*/
PROC SORT DATA=final.ind_MenagNs;
BY RegName CSP;
RUN;
Title "Frequency Table Showing People's Occupation in Selected Region";
PROC FREQ DATA=final.ind_MenagNs;
TABLE CSP;
BY RegName;
RUN;


/*Frequency of each Individula way of transports*/
PROC SORT DATA=final.ind_MenagNs;
BY RegName;
RUN;
Title "Frequency Table Showing People Who Walk to Work";
PROC FREQ DATA=final.ind_MenagNs (WHERE=(actoccup="1"));
TABLE trajmod_A;
BY RegName;
RUN;
Title "Frequency Table Showing People who Ride Bicycle to Work";
PROC FREQ DATA=final.ind_MenagNs(WHERE=(actoccup="1"));
TABLE trajmod_B;
BY RegName;
RUN;
Title "Frequency Table Showing People who Ride motorbike, moped or scooter to Work";
PROC FREQ DATA=final.ind_MenagNs(WHERE=(actoccup="1"));
TABLE trajmod_C;
BY RegName;
RUN;
Title "Frequency Table Showing People who Drive Car to Work";
PROC FREQ DATA=final.ind_MenagNs(WHERE=(actoccup="1"));
TABLE trajmod_D;
BY RegName;
RUN;
Title "Frequency Table Showing People who Board Train to Work";
PROC FREQ DATA=final.ind_MenagNs(WHERE=(actoccup="1"));
TABLE trajmod_E;
BY RegName;
RUN;
Title "Frequency Table Showing People who Use Another Collective Train to Work";
PROC FREQ DATA=final.ind_MenagNs(WHERE=(actoccup="1"));
TABLE trajmod_F;
BY RegName;
RUN;
Title "Frequency Table Showing People who Use Public Transport on Road Work";
PROC FREQ DATA=final.ind_MenagNs(WHERE=(actoccup="1"));
TABLE trajmod_G;
BY RegName;
RUN;
Title "Frequency Table Showing People who Use other Means to Work";
PROC FREQ DATA=final.ind_MenagNs(WHERE=(actoccup="1"));
TABLE trajmod_H;
BY RegName;
RUN;

/*Frequency of activities location*/

PROC SORT DATA=final.ind_MenagNs;
BY RegName lieuw;
RUN;
Title "Frequency Table Showing Activity Location";
PROC FREQ DATA=final.ind_MenagNs;
TABLE lieuw;
BY RegName;
RUN;
/*Frequency of sizes of urban unit*/
PROC SORT DATA=final.ind_MenagNs;
BY RegName TUU;
RUN;
Title "Frequency Table Showing Urban Unit Residence";
PROC FREQ DATA=final.ind_MenagNs;
TABLE TUU;
BY RegName;
RUN;

DATA final.Tab_Freq;
LENGTH RegName$ 20;
input RegName$ Number_ind b25y b35y b45y b55y b65y M65y Active_occ PerActive_occ Looking4Job MeanChildren Retired Farmer Merchant Executive Employee Worker InterProf
Foot Bicycle Motorbike Car Train CollTrain Public Othertrans Home SevLoc UsualLoc CustoHome NoUsualLoc OtherLoc Rural M5k M10k M20k M50k M100k M200k M2M Paris;
datalines;
Alsace 602 5.81 14.29 22.59 18.77 18.44 20.10 348 57.81 2.81 0.86 33.55 0.51 4.44 19.62 13.48 35.67 26.28 6.32 6.9 1.15 77.3 5.17 0 3.45 4.02 3.83 5.6 76.7 8.55 2.95 2.36 31.56 5.15 0 11.3 8.47 4.65 0 38.87 0
Auvergne 400 6.00 13.75 19.25 17.25 24.00 19.75 219 54.75 0 0.8 39.75 12.11 6.19 13.4 12.11 28.61 27.58 10.96 3.2 1.37 68.95 0 0 1.83 3.2 9.17 9.17 66.51 11.93 1.83 1.38 37.5 19.25 9.75 7.75 13.25 4.25 0 8.25 0
Bretagne 936 7.16 11.86 19.34 20.19 20.41 21.05 499 53.31 0.96 0.77 39.1 7.31 5.56 19.96 16.68 25.63 24.86 7.21 2 2 72.75 2 1.6 3.01 3.01 8.96 6.57 72.11 8.57 2.79 1 40.28 11.43 4.49 5.13 14.96 9.83 2.24 11.65 0
Franche-Comté 317 8.52 13.25 21.77 17.98 23.03 15.46 182 57.41 1.05 0.95 35.65 1.97 6.25 24.01 14.8 29.61 23.36 9.89 3.85 1.1 78.02 0.55 0 2.2 2.75 3.91 5.03 80.45 6.15 2.23 2.23 28.39 17.98 21.14 0 6.31 5.68 20.5 0 0
Ile-de-France 2860 6.47 19.23 21.40 18.50 17.38 17.03 1739 60.80 1.43 0.92 27.8 0.14 6.7 37.05 18.2 14.07 23.83 10.47 3.57 6.5 47.27 7.42 26.45 10.29 0.75 4.41 5.51 81.04 5.68 2.32 1.04 3.85 0.94 1.82 1.68 4.55 0.7 0 0 86.47
Rhône-Alpes 1600 7.25 14.38 19.81 19.50 17.81 21.25 915 57.19 1.68 0.83 33.88 2.12 9.27 25.82 14.68 22.34 25.76 5.68 4.37 2.73 75.19 1.97 2.62 3.61 2.73 4.48 7.03 74.4 10.22 2.64 0.88 22.25 1.69 3 3.69 7.5 11.69 15.75 34.44 0
PaysdelaLoire 1126 7.28 14.39 16.25 20.52 17.58 23.98 581 51.60 1.02 0.82 38.72 7.69 8.24 19.96 14.83 28.57 20.6 4.48 4.13 3.61 72.46 1.72 0.86 1.72 3.1 8.02 8.02 72.53 7.34 2.56 1.54 35.44 8.17 9.41 5.95 7.73 2.93 4.26 26.11 0
;
run;

ODS RTF FILE="/folders/myshortcuts/MyFolders/final/tab.doc";
PROC TABULATE  DATA=final.Tab_Freq;
TITLE "Individual transports usage according to regions";
CLASS RegName;
VAR Foot bicycle Motorbike Car Train Colltrain Public OtherTrans;
TABLE RegName, Foot bicycle Motorbike Car Train Colltrain Public OtherTrans;
LABEL RegName="Region Name"
      Foot="On foot"
 Bicycle="By Bicycle"
 Motorbike="By motorbike, scooter or moped"
 Car="By car"
 Train="By train"
 Colltrain="By collective transport on rail"
 Public="By Public transport on road"
 OtherTrans="By other means";
;RUN;
PROC TABULATE DATA=final.Tab_Freq;
TITLE "Social caracteristics of individuals/household in each regions";
CLASS RegName;
VAR Number_ind b25y b35y b45y b55y b65y M65y Active_occ PerActive_occ Looking4Job MeanChildren Retired;
TABLE RegName, Number_ind b25y b35y b45y b55y b65y M65y Active_occ PerActive_occ Looking4Job MeanChildren*(Mean) Retired;
LABEL RegName="Region Name"
 b25y="Below 25 years"
 b35y="Betw 25 and 35 years "
 b45y="Betw 35 and 45 years"
 b55y="Betw 45 and 55 years"
 b65y="Betw 55 and 65 years"
 M65y="More than 65 years"
      Number_ind="Number of individuals"
 Active_occ="Number of active Individuals"
 PerActive_occ="Proportion of active people"
 Looking4Job="Proportion of people looking for job"
 MeanChildren="Mean of number of children"
 Retired="Proportion of pre-retired/retired people";
;RUN;
PROC TABULATE DATA=final.Tab_Freq;
TITLE "Individual Occupation according to regions";
CLASS RegName;
VAR Farmer Merchant Executive Employee Worker InterProf;
TABLE RegName, Farmer Merchant Executive Employee Worker InterProf;
LABEL RegName="Region Name"
      Farmer="Farmers"
 Merchant="Artisans, merchants "
 Executive="Executives intelectual professionals"
 Employee="Employees"
 Worker="Workers"
 InterProf="Intermediate professionals";
;RUN;
PROC TABULATE DATA=final.Tab_Freq;
TITLE "Individual Working Location according to regions";
CLASS RegName;
VAR Home SevLoc UsualLoc CustoHome NoUsualLoc OtherLoc;
TABLE RegName, Home SevLoc UsualLoc CustoHome NoUsualLoc OtherLoc;
LABEL RegName="Region Name"
      Home="Work at home"
 SevLoc="Work at home or at several locations"
 UsualLoc="Work at a usual location"
 CustoHome="Work at customer's home"
 NoUsualLoc="Work as transporters or have not a usual location"
 Other="Work at an other type of location";
;RUN;
PROC TABULATE DATA=final.Tab_Freq;
TITLE "Distribution of People in unit urban in each region";
CLASS RegName;
VAR Rural M5k M10k M20k M50k M100k M200k M2M Paris;
TABLE RegName, Rural M5k M10k M20k M50k M100k M200k M2M Paris;
LABEL RegName="Region Name"
      Rural="Live in a rural town"
 M5k="City with less than 5,000 habitants"
 M10k="City with between 5,000 to 10,000 habitants"
 M20k="City with between 10,000 to 20,000 habitants"
 M50k="City with between 20,000 to 50,000 habitants"
 M100k="City with between 50,000 to 100,000 habitants"
 M200k="City with between 100,000 to 200,000 habitants"
 M2M="City with between 200,000 to 2,000,000 habitants"
 Paris="Paris";
;RUN;
ODS RTF CLOSE;

/*                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          /*Descriptive statistics and plots/charts */

PROC SORT DATA=final.ind_MenagNs;
BY RegName;
RUN;
PROC MEANS MEAN DATA=final.ind_MenagNs;
VAR trajh;
BY RegName;
OUTPUT OUT=final.transmn MEAN=TraMn;
RUN;

title "Transport times for each regions";
Footnote "Source: INSEE"; 
proc sgplot data=final.transmn;
scatter x=RegName y=TraMn / colorresponse=TraMn
   markerattrs=(symbol=CircleFilled size=14)
   filledoutlinedmarkers 
   colormodel=(CX3288BD CX99D594 CXE6F598 CXFEE08B CXFC8D59 CXD53E4F);
xaxis grid; yaxis grid;
LABEL RegName= "Region Name"
			TraMn= "Average time in transports";
	  
PROC MEANS MEAN DATA=final.ind_MenagNs (WHERE=(trajmod_A=1));
VAR trajh;
RUN;
PROC MEANS MEAN DATA=final.ind_MenagNs (WHERE=(trajmod_B=1));
VAR trajh;
RUN;
PROC MEANS MEAN DATA=final.ind_MenagNs (WHERE=(trajmod_C=1));
VAR trajh;
RUN;
PROC MEANS MEAN DATA=final.ind_MenagNs (WHERE=(trajmod_D=1));
VAR trajh;
RUN;
PROC MEANS MEAN DATA=final.ind_MenagNs (WHERE=(trajmod_E=1));
VAR trajh;
RUN;
PROC MEANS MEAN DATA=final.ind_MenagNs (WHERE=(trajmod_F=1));
VAR trajh;
RUN;
PROC MEANS MEAN DATA=final.ind_MenagNs (WHERE=(trajmod_G=1));
VAR trajh;
RUN;
PROC MEANS MEAN DATA=final.ind_MenagNs (WHERE=(trajmod_H=1));
VAR trajh;
RUN;

DATA final.TransMode;
LENGTH TransMode$ 10;
INPUT TransMode$ TraMean;
DATALINES;
Foot  55.0
Cycle  60.9
Motorbike  78.4
Car  71.0
Train  158.3
Metro  111.9
Public_Bus  97.4
Other  159.4
;
RUN;

	  
title "Transport time of each Mode of transport";
Footnote "Source: INSEE"; 
proc sgplot data=final.TransMode;
scatter x=TransMode y=TraMean / colorresponse=TraMean
   markerattrs=(symbol=CircleFilled size=14)
   filledoutlinedmarkers 
   colormodel=(CX3288BD CX99D594 CXE6F598 CXFEE08B CXFC8D59 CXD53E4F);
xaxis grid; yaxis grid;
LABEL TransMode= "Way of transport"
			TraMean= "Average time of use (in minutes)";
			

PROC SORT DATA=final.ind_MenagNs;
BY lieuw;
RUN;
PROC MEANS MEAN DATA=final.ind_MenagNs;
VAR trajh;
BY lieuw;
RUN;

DATA final.WorkLocMean;
LENGTH WorkLoctn$ 20;
INPUT WorkLoctn$ WorkLocMean;
DATALINES;
Home                0
Several_locations   78.02
Usual_location      58.41
Customer's_home     170.01
No_usual_location   123.19
Others              170.27
;
RUN;

title "Transport time for work locations";
Footnote "Source: INSEE"; 
proc sgplot data=final.WorkLocMean;
scatter x=WorkLoctn y=WorkLocMean / colorresponse=WorkLocMean
   markerattrs=(symbol=CircleFilled size=14)
   filledoutlinedmarkers 
   colormodel=(CX3288BD CX99D594 CXE6F598 CXFEE08B CXFC8D59 CXD53E4F);
xaxis grid; yaxis grid;
LABEL WorkLoctn= "Work location"
			WorkLocMean= "Average time to go Work (in minutes)";
			
			

PROC SORT DATA=final.ind_MenagNs;
BY TUU;
RUN;
PROC MEANS MEAN DATA=final.ind_MenagNs;
VAR trajh;
BY TUU;
RUN;
DATA Final.citypopsize; 
LENGTH popsize$ 20; 
INPUT CityPop $ PopN; 
DATALINES;
Rural 6.63
Less_5K 7.16
Less_10k 3.89
Less_20k 4.77
Less_50k 2.98
Less_100k 4.38
Less_200k 2.07
Less_2M 5.35
Paris 2.47
;
RUN;
title "Transport time for each urban unit based on Size";
Footnote "Source: INSEE"; 
proc sgplot data=Final.citypopsize;
scatter x=CityPop y=PopN / colorresponse=PopN
   markerattrs=(symbol=CircleFilled size=14)
   filledoutlinedmarkers 
   colormodel=(CX3288BD CX99D594 CXE6F598 CXFEE08B CXFC8D59 CXD53E4F);
xaxis grid; yaxis grid;
LABEL CityPop= "Urban unit size"
			PopN= "Average time spent";
			

DATA final.ind_MenagNs;
SET final.ind_MenagNs;
IF travh="." THEN travh=0;
IF indh="." THEN indh=0;
IF FOR8="." THEN FOR8=0;
IF FOR11="." THEN FOR11=0;
WorkSum=travh+indh+FOR8+FOR11;   
RUN;
DATA final.ind_MenagNs;
SET final.ind_MenagNs;
IF WorkSum>125 THEN WorkSum=".";
RUN;
PROC SORT DATA=final.ind_MenagNs;
BY RegName;
RUN;
PROC MEANS MEAN DATA=final.ind_MenagNs;
VAR WorkSum;
BY RegName; 
RUN;
DATA final.ind_MenagNs;
SET final.ind_MenagNs;
IF WorkSum=0 THEN WorkSum=".";
RUN;

PROC SORT DATA=final.ind_MenagNs;
BY CSP RegName; 
RUN;
PROC MEANS MEAN DATA=final.ind_MenagNs;
VAR WorkSum; 
BY CSP;
OUTPUT OUT=final.TravCSP MEAN=TravCSPM; 
RUN;

DATA final.TravCSP; 
SET final.TravCSP; 
IF CSP=" " THEN DELETE;
IF CSP="Farmer" Then CSP = "Farmer"; 
IF CSP="Craftman-Trader" THEN CSP="Artisan-Merchant";
IF CSP="Executive-Professional" THEN CSP="Executive";
IF CSP="Employee" THEN CSP="Employee";
IF CSP="Worker" THEN CSP="Worker"; 
IF CSP="Inter-Prof" THEN CSP="Intermediate Prof";
RUN;

title "Working time for each Occupation";
Footnote "Source: INSEE"; 
proc sgplot data=final.TravCSP;
scatter x=CSP y=TravCSPM / colorresponse=TravCSPM
   markerattrs=(symbol=CircleFilled size=14)
   filledoutlinedmarkers 
   colormodel=(CX3288BD CX99D594 CXE6F598 CXFEE08B CXFC8D59 CXD53E4F);
xaxis grid; yaxis grid;
LABEL CSP= "Individual Occupation"
			TravCSPM= "Average time of working per week in hours";
	  


PROC SORT DATA=final.ind_MenagNs;
BY RegName; 
RUN;
PROC MEANS MEAN DATA=final.ind_MenagNs;; 
VAR WorkSum;
BY RegName; 
OUTPUT OUT=final.TravRegion MEAN=TravRgM;
RUN;

title "Working times for each regions";
Footnote "Source: INSEE"; 
proc sgplot data=final.TravRegion;
scatter x=RegName y=TravRgM / colorresponse=TravRgM
   markerattrs=(symbol=CircleFilled size=14)
   filledoutlinedmarkers 
   colormodel=(CX3288BD CX99D594 CXE6F598 CXFEE08B CXFC8D59 CXD53E4F);
xaxis grid; yaxis grid;
LABEL RegName= "Region Name"
			TravRgM= "Average time of working per week (in hours)";
			
PROC SORT DATA=final.ind_MenagNs;
BY RegName;
RUN;
PROC MEANS MEAN DATA=final.ind_MenagNs;
VAR CULT11;
BY RegName;
RUN;

/*Base for an only type of household*/
DATA final.hous; 
SET final.ind_MenagNs;
RUN;
DATA final.hous; 
SET final.hous; 
IF TYPMEN15 NE "10" THEN DELETE;
RUN;
PROC SORT DATA=final.hous; 
BY RegName actoccup;
RUN;
PROC FREQ DATA=final.hous; 
TABLE actoccup;
BY RegName; 
RUN;
PROC SORT DATA=final.hous;
BY RegName  AgeRange; 
RUN;
PROC FREQ DATA=final.hous;
TABLE AgeRange;
BY RegName;
RUN;
PROC SORT DATA=final.hous;
BY RegName CESS10;
RUN;
PROC FREQ DATA=final.hous;
TABLE CESS10;
BY RegName;
RUN;
PROC SORT DATA=final.hous;
BY RegName;
RUN;
PROC FREQ DATA=final.hous;
TABLE trajmod_A;
BY RegName;
RUN;
PROC FREQ DATA=final.hous;
TABLE trajmod_B;
BY RegName;
RUN;
PROC FREQ DATA=final.hous;
TABLE trajmod_C;
BY RegName;
RUN;
PROC FREQ DATA=final.hous;
TABLE trajmod_D;
BY RegName;
RUN;
PROC FREQ DATA=final.hous;
TABLE trajmod_E;
BY RegName;
RUN;
PROC FREQ DATA=final.hous;
TABLE trajmod_F;
BY RegName;
RUN;
PROC FREQ DATA=final.hous;
TABLE trajmod_G;
BY RegName;
RUN;
PROC FREQ DATA=final.hous;
TABLE trajmod_H;
BY RegName;
RUN;
PROC SORT DATA=final.hous;
BY RegName TUU;
RUN;
PROC FREQ DATA=final.hous;
TABLE TUU;
BY RegName;
RUN;

/*Statistics on this group*/
PROC MEANS MEAN DATA=final.hous;
VAR trajh;
BY RegName;
RUN;
PROC MEANS MEAN DATA=final.hous;
VAR WorkSum;
BY RegName;
RUN;
PROC MEANS MEAN DATA=final.hous;
VAR CULT11;
BY RegName;
RUN;

/*Difference of activities*/
DATA final.carnet; 
SET "/folders/myshortcuts/MyFolders/final/carnetp.sas7bdat";
KEEP actpr1 actpr2 actpr3 actpr4 actpr5 actpr6 actpr7 actse1 actse2 actse3 actse4 actse5 actse6 actse7 idmen idind nocar idcar;
RUN;
DATA final.carnet;
SET final.carnet;
IF SUBSTR(actpr1,1,1)=1 AND actpr1 NE 111 THEN ActP1="Domestique";
IF SUBSTR(actpr1,1,1)=2 THEN ActP1="WorkSum";
IF SUBSTR(actpr1,1,1)=3 THEN ActP1="Domestique";
IF SUBSTR(actpr1,1,1)=4 THEN ActP1="Semi-Loisir";
IF SUBSTR(actpr1,1,1)=5 THEN ActP1="Semi-Loisir";
IF SUBSTR(actpr1,1,1)=6 THEN ActP1="Loisir";
IF SUBSTR(actpr2,1,1)=1 AND actpr2 NE 111 THEN ActP2="Domestique";
IF SUBSTR(actpr2,1,1)=2 THEN ActP2="WorkSum";
IF SUBSTR(actpr2,1,1)=3 THEN ActP2="Domestique";
IF SUBSTR(actpr2,1,1)=4 THEN ActP2="Semi-Loisir";
IF SUBSTR(actpr2,1,1)=5 THEN ActP2="Semi-Loisir";
IF SUBSTR(actpr2,1,1)=6 THEN ActP2="Loisir";
IF SUBSTR(actpr3,1,1)=1 AND actpr3 NE 111 THEN ActP3="Domestique";
IF SUBSTR(actpr3,1,1)=2 THEN ActP3="WorkSum";
IF SUBSTR(actpr3,1,1)=3 THEN ActP3="Domestique";
IF SUBSTR(actpr3,1,1)=4 THEN ActP3="Semi-Loisir";
IF SUBSTR(actpr3,1,1)=5 THEN ActP3="Semi-Loisir";
IF SUBSTR(actpr3,1,1)=6 THEN ActP3="Loisir";
IF SUBSTR(actpr4,1,1)=1 AND actpr4 NE 111 THEN ActP4="Domestique";
IF SUBSTR(actpr4,1,1)=2 THEN ActP4="WorkSum";
IF SUBSTR(actpr4,1,1)=3 THEN ActP4="Domestique";
IF SUBSTR(actpr4,1,1)=4 THEN ActP4="Semi-Loisir";
IF SUBSTR(actpr4,1,1)=5 THEN ActP4="Semi-Loisir";
IF SUBSTR(actpr4,1,1)=6 THEN ActP4="Loisir";
IF SUBSTR(actpr5,1,1)=1 AND actpr5 NE 111 THEN ActP5="Domestique";
IF SUBSTR(actpr5,1,1)=2 THEN ActP5="WorkSum";
IF SUBSTR(actpr5,1,1)=3 THEN ActP5="Domestique";
IF SUBSTR(actpr5,1,1)=4 THEN ActP5="Semi-Loisir";
IF SUBSTR(actpr5,1,1)=5 THEN ActP5="Semi-Loisir";
IF SUBSTR(actpr5,1,1)=6 THEN ActP5="Loisir";
IF SUBSTR(actpr6,1,1)=1 AND actpr6 NE 111 THEN ActP6="Domestique";
IF SUBSTR(actpr6,1,1)=2 THEN ActP6="WorkSum";
IF SUBSTR(actpr6,1,1)=3 THEN ActP6="Domestique";
IF SUBSTR(actpr6,1,1)=4 THEN ActP6="Semi-Loisir";
IF SUBSTR(actpr6,1,1)=5 THEN ActP6="Semi-Loisir";
IF SUBSTR(actpr6,1,1)=6 THEN ActP6="Loisir";
IF SUBSTR(actpr7,1,1)=1 AND actpr7 NE 111 THEN ActP7="Domestique";
IF SUBSTR(actpr7,1,1)=2 THEN ActP7="WorkSum";
IF SUBSTR(actpr7,1,1)=3 THEN ActP7="Domestique";
IF SUBSTR(actpr7,1,1)=4 THEN ActP7="Semi-Loisir";
IF SUBSTR(actpr7,1,1)=5 THEN ActP7="Semi-Loisir";
IF SUBSTR(actpr7,1,1)=6 THEN ActP7="Loisir";
IF SUBSTR(actse1,1,1)=1 AND actse1 NE 111 THEN ActS1="Domestique";
IF SUBSTR(actse1,1,1)=2 THEN ActS1="WorkSum";
IF SUBSTR(actse1,1,1)=3 THEN ActS1="Domestique";
IF SUBSTR(actse1,1,1)=4 THEN ActS1="Semi-Loisir";
IF SUBSTR(actse1,1,1)=5 THEN ActS1="Semi-Loisir";
IF SUBSTR(actse1,1,1)=6 THEN ActS1="Loisir";
IF SUBSTR(actse2,1,1)=1 AND actse2 NE 111 THEN ActS2="Domestique";
IF SUBSTR(actse2,1,1)=2 THEN ActS2="WorkSum";
IF SUBSTR(actse2,1,1)=3 THEN ActS2="Domestique";
IF SUBSTR(actse2,1,1)=4 THEN ActS2="Semi-Loisir";
IF SUBSTR(actse2,1,1)=5 THEN ActS2="Semi-Loisir";
IF SUBSTR(actse2,1,1)=6 THEN ActS2="Loisir";
IF SUBSTR(actse3,1,1)=1 AND actse3 NE 111 THEN ActS3="Domestique";
IF SUBSTR(actse3,1,1)=2 THEN ActS3="WorkSum";
IF SUBSTR(actse3,1,1)=3 THEN ActS3="Domestique";
IF SUBSTR(actse3,1,1)=4 THEN ActS3="Semi-Loisir";
IF SUBSTR(actse3,1,1)=5 THEN ActS3="Semi-Loisir";
IF SUBSTR(actse3,1,1)=6 THEN ActS3="Loisir";
IF SUBSTR(actse4,1,1)=1 AND actse4 NE 111 THEN ActS4="Domestique";
IF SUBSTR(actse4,1,1)=2 THEN ActS4="WorkSum";
IF SUBSTR(actse4,1,1)=3 THEN ActS4="Domestique";
IF SUBSTR(actse4,1,1)=4 THEN ActS4="Semi-Loisir";
IF SUBSTR(actse4,1,1)=5 THEN ActS4="Semi-Loisir";
IF SUBSTR(actse4,1,1)=6 THEN ActS4="Loisir";
IF SUBSTR(actse5,1,1)=1 AND actse5 NE 111 THEN ActS5="Domestique";
IF SUBSTR(actse5,1,1)=2 THEN ActS5="WorkSum";
IF SUBSTR(actse5,1,1)=3 THEN ActS5="Domestique";
IF SUBSTR(actse5,1,1)=4 THEN ActS5="Semi-Loisir";
IF SUBSTR(actse5,1,1)=5 THEN ActS5="Semi-Loisir";
IF SUBSTR(actse5,1,1)=6 THEN ActS5="Loisir";
IF SUBSTR(actse6,1,1)=1 AND actse6 NE 111 THEN ActS6="Domestique";
IF SUBSTR(actse6,1,1)=2 THEN ActS6="WorkSum";
IF SUBSTR(actse6,1,1)=3 THEN ActS6="Domestique";
IF SUBSTR(actse6,1,1)=4 THEN ActS6="Semi-Loisir";
IF SUBSTR(actse6,1,1)=5 THEN ActS6="Semi-Loisir";
IF SUBSTR(actse6,1,1)=6 THEN ActS6="Loisir";
IF SUBSTR(actse7,1,1)=1 AND actse7 NE 111 THEN ActS7="Domestique";
IF SUBSTR(actse7,1,1)=2 THEN ActS7="WorkSum";
IF SUBSTR(actse7,1,1)=3 THEN ActS7="Domestique";
IF SUBSTR(actse7,1,1)=4 THEN ActS7="Semi-Loisir";
IF SUBSTR(actse7,1,1)=5 THEN ActS7="Semi-Loisir";
IF SUBSTR(actse7,1,1)=6 THEN ActS7="Loisir";
RUN;

PROC SORT DATA=final.carnet;
BY idmen;
RUN;

proc sort data=final.ind_MenagNS;
by idmen; 
run; 
DATA final.carnet;
MERGE final.carnet final.ind_MenagNS;
BY idmen;
KEEP actpr1 actpr2 actpr3 actpr4 actpr5 actpr6 actpr7 actse1 actse2 actse3 actse4 actse5 actse6 actse7
ActP1 ActP2 ActP3 ActP4 ActP5 ActP6 ActP7 ActS1 ActS2 ActS3 ActS4 ActS5 ActS6 ActS7 AgeRange actoccup RRET RegName CSP idmen idind nocar idcar;
RUN;

PROC SORT DATA=final.carnet;
BY RegName; 
RUN;
PROC FREQ DATA=final.carnet;
TABLE ActP1 ActP2 ActP3 ActP4 ActP5 ActP6 ActP7 ActS1 ActS2 ActS3 ActS4 ActS5 ActS6 ActS7;
BY RegName; 
RUN;
PROC SORT DATA=final.carnet;
BY AgeRange;
RUN;
PROC FREQ DATA=final.carnet;
TABLE ActP1 ActP2 ActP3 ActP4 ActP5 ActP6 ActP7 ActS1 ActS2 ActS3 ActS4 ActS5 ActS6 ActS7;
BY AgeRange;
RUN;
PROC SORT DATA=final.carnet;
BY actoccup;
RUN;
PROC FREQ DATA=final.carnet;
TABLE ActP1 ActP2 ActP3 ActP4 ActP5 ActP6 ActP7 ActS1 ActS2 ActS3 ActS4 ActS5 ActS6 ActS7;
BY actoccup;
RUN;
PROC SORT DATA=final.carnet;
BY RRET;
RUN;
PROC FREQ DATA=final.carnet;
TABLE ActP1 ActP2 ActP3 ActP4 ActP5 ActP6 ActP7 ActS1 ActS2 ActS3 ActS4 ActS5 ActS6 ActS7;
BY RRET;
RUN;

/*Base for regression*/
DATA final.ind_Menagfg; 
SET final.ind_MenagNS;
KEEP idmen idind sexe handicap trajh trajmod_A trajmod_B trajmod_C trajmod_D trajmod_E trajmod_F trajmod_G trajmod_H lieuw TUU WorkSum NENFANTS NACTIFS CSP RRET AgeRange REG RegName; 
RUN;
DATA final.ind_Menagfg;
SET final.ind_Menagfg;
IF trajmod_A=1 THEN Transport="1";
IF trajmod_B=1 THEN Transport="2";
IF trajmod_C=1 THEN Transport="3";
IF trajmod_D=1 THEN Transport="4";
IF trajmod_E=1 THEN Transport="5";
IF trajmod_F=1 THEN Transport="6";
IF trajmod_G=1 THEN Transport="7";
IF Transport="." THEN Transport="0";
RUN;
DATA final.ind_Menagfg;
SET final.ind_Menagfg;
IF lieuw="1" THEN Home=1;
ELSE Home=0;
IF lieuw="2" THEN Several_places=1;
ELSE Several_places=0;
IF lieuw="3" THEN Habi_place=1;
ELSE Habi_place=0;
IF lieuw="4" THEN At_customer=1;
ELSE At_customer=0;
IF lieuw="5" THEN Deliveries=1;
ELSE Deliveries=0;
IF lieuw="6" THEN Other=1;
ELSE Others=0;
RUN;
DATA final.ind_Menagfg;
SET final.ind_Menagfg;
IF TUU="0" THEN Rural=1; 
ELSE Rural=0;
IF TUU="1" THEN Below_5k=1;
ELSE Below_5k=0;
IF TUU="2" THEN Below_10k=1;
ELSE Below_10k=0;
IF TUU="3" THEN Below_20k=1;
ELSE Below_20k=0;
IF TUU="4" THEN Below_50k=1;
ELSE Below_50k=0;
IF TUU="5" THEN Below_100k=1;
ELSE Below_100k=0;
IF TUU="6" THEN Below_200k=1;
ELSE Below_200k=0;
IF TUU="7" THEN Below_2m=1;
ELSE Below_2m=0;
IF TUU="8" THEN Paris=1;
ELSE Paris=0;
RUN;

/*ANOVA method and quantile regression for transport*/
proc freq data = final.ind_Menagfg;
tables Transport*lieuw / chisq; 
run; 
proc freq data = final.ind_Menagfg;
tables Transport*TUU / chisq; 
run; 
proc freq data = final.ind_Menagfg;
tables TUU*lieuw / chisq; 
run; 

PROC GLM DATA=final.ind_Menagfg;
CLASS Transport lieuw TUU;
MODEL trajh=Transport | lieuw | TUU;
RUN;QUIT;
PROC QUANTREG DATA=final.ind_Menagfg ALGORITHM=simplex
CI=sparsity / IID;
MODEL trajh=trajmod_A trajmod_B trajmod_C trajmod_D trajmod_E trajmod_F trajmod_G trajmod_H 
Several_places Habi_place At_customer Deliveries
Rural Below_5k Below_10k Below_20k Below_50k Below_100k Below_200k Below_2m/ noint quantile=0.30 0.50 0.70;
RUN;
/*ANOVA method and quantile regression for work*/
DATA final.ind_Menagfg;
SET final.ind_Menagfg;
IF CSP="Worker" THEN Worker=1;
ELSE Worker=0;
IF CSP="Farmer" THEN Farmer=1;
ELSE Farmer=0;
IF CSP="Employee" THEN Employee=1;
ELSE Employee=0;
IF CSP="Executive-Professional" THEN Executive=1;
ELSE Executive=0;
IF CSP="InterProf" THEN InterProf=1;
ELSE InterProf=0;
IF CSP="Merchant" THEN Artisan=1;
ELSE Artisan=0;
RUN;
DATA final.ind_Menagfg;
SET final.ind_Menagfg;
IF AgeRange="Under_25_Yrs" THEN below25=1;
ELSE below25=0;
IF AgeRange="Betw_25-35_Yrs" THEN b25to35=1;
ELSE b25to35=0;
IF AgeRange="Betw_35-45_Yrs" THEN b35to45=1;
ELSE b35to45=0;
IF AgeRange="Betw_45-55_Yrs" THEN b45to55=1;
ELSE b45to55=0;
IF AgeRange="Betw_55-65_Yrs" THEN b55to65=1;
ELSE b55to65=0;
IF AgeRange="Above_65_Yrs" THEN Above65=1;
ELSE Above65=0;


PROC GLM DATA=final.ind_Menagfg;
CLASS CSP AgeRange lieuw;
MODEL WorkSum= CSP | AgeRange | lieuw ;
RUN;QUIT;
PROC QUANTREG DATA=final.ind_Menagfg ALGORITHM=simplex
CI=sparsity / IID;
MODEL trajh=Worker Farmer Employee Executive InterProf Artisan
below25 b25to35 b35to45 b45to55 b55to65 Above65 
Several_places Habi_place At_customer Deliveries/ noint quantile=0.30 0.50 0.70;
RUN;