/*Application 1 - Data Analysis 
Khalid Lawal, Siarhei Bartalevich, Sakina Mustafayeva, Farshid Alizadminaabad, Naghmeh Mohammadpourlima- */

/*Question 2*/

libname appli1 "/folders/myshortcuts/MyFolders/study1";
run; 
/* Question 3 */
proc import datafile="/folders/myshortcuts/MyFolders/study1/Appl1_2012"
out= appli1.arm2012 
dbms=xls
replace
; 
sheet="ARM"; 
run;

proc import datafile="/folders/myshortcuts/MyFolders/study1/Appl1_2012"
out= appli1.com2012 
dbms=xls
replace
; 
sheet="COM"; 
run;  

proc import datafile="/folders/myshortcuts/MyFolders/study1/Appl1_2013"
out= appli1.arm2013
dbms=xls
replace
; 
sheet="ARM"; 
run; 
proc import datafile="/folders/myshortcuts/MyFolders/study1/Appl1_2013"
out= appli1.com2013
dbms=xls
replace
; 
sheet="COM"; 
run; 

proc import datafile="/folders/myshortcuts/MyFolders/study1/Appl1_2014"
out= appli1.arm2014
dbms=xls
replace
; 
sheet="ARM"; 
run; 
proc import datafile="/folders/myshortcuts/MyFolders/study1/Appl1_2014"
out= appli1.com2014
dbms=xls
replace
; 
sheet="COM"; 
run; 

proc import datafile="/folders/myshortcuts/MyFolders/study1/Appl1_2015"
out= appli1.arm2015
dbms=xls
replace
; 
sheet="ARM"; 
run; 

proc import datafile="/folders/myshortcuts/MyFolders/study1/Appl1_2015"
out= appli1.com2015
dbms=xls
replace
; 
sheet="COM"; 
run; 
proc import datafile="/folders/myshortcuts/MyFolders/study1/Appl1_2016"
out= appli1.arm2016
dbms=xlsx
replace
; 
sheet="ARM"; 
run; 
proc import datafile="/folders/myshortcuts/MyFolders/study1/Appl1_2016"
out= appli1.com2016
dbms=xlsx
replace
; 
sheet="COM"; 
run; 

proc import datafile="/folders/myshortcuts/MyFolders/study1/Appl1_2017"
out= appli1.arm2017
dbms=xlsx
replace
; 
sheet="ARM"; 
run; 

proc import datafile="/folders/myshortcuts/MyFolders/study1/Appl1_2017"
out= appli1.com2017
dbms=xlsx
replace
; 
sheet="COM"; 
run; 

/* Question 4 */
/*Application 1: Application 1: course construction and data analysis 
Year 2020/2021
Khalid Lawal  Siarhei Bartalevich Sakina Mustafayeva.*/

/* Question 5 */
/* Creation of data block for average salaries of the municipality or district. */
data appli1.Sum_2012;
set appli1.arm2012 appli1.com2012; 
run; 
data appli1.Sum_2012; 
set appli1.sum_2012; 
keep VAR1 B C; 
run; 

/* Question 6 */
/* Addition of Variable AN which contains the data set year respectively */
data appli1.Sum_2012;
set appli1.Sum_2012;
AN = 2012; 
run; 

/*  Question 7  */
/* Repetition of Question 5 and 6 for all years */
data appli1.Sum_2013;
set appli1.arm2013 appli1.com2013; 
run; 
data appli1.Sum_2013; 
set appli1.sum_2013; 
keep VAR1 B C; 
run; 
data appli1.Sum_2013;
set appli1.Sum_2013;
AN = 2013; 
run; 

data appli1.Sum_2014;
set appli1.arm2014 appli1.com2014; 
run; 
data appli1.Sum_2014; 
set appli1.sum_2014; 
keep VAR1 B C; 
run; 
data appli1.Sum_2014;
set appli1.Sum_2014;
AN = 2014; 
run; 

data appli1.Sum_2015;
set appli1.arm2015 appli1.com2015; 
run; 
data appli1.Sum_2015; 
set appli1.sum_2015; 
keep VAR1 B C; 
run; 
data appli1.Sum_2015;
set appli1.Sum_2015;
AN = 2015; 
run; 

data appli1.Sum_2016;
set appli1.arm2016 appli1.com2016; 
run; 
data appli1.Sum_2016; 
set appli1.sum_2016; 
keep VAR1 B C; 
run; 
data appli1.Sum_2016;
set appli1.Sum_2016;
AN = 2016; 
run; 

data appli1.Sum_2017;
set appli1.arm2017 appli1.com2017; 
run; 
data appli1.Sum_2017; 
set appli1.sum_2017; 
keep VAR1 B C; 
run; 
data appli1.Sum_2017;
set appli1.Sum_2017;
AN = 2017; 
run; 

/* Question 8 */
/* Combination of all the 12 files created for the 6 years */
data appli1.all_year; 
set appli1.sum_2012 appli1.sum_2013 appli1.sum_2014 appli1.sum_2015 appli1.sum_2016 appli1.sum_2017; 
run; 

/* Renaming of some variable and deletion of some rows since i did not do it in excel before starting */
data appli1.all_year (rename = ( C = Salaire_net_horaire_moyen ) );
set appli1.all_year; 
run; 
data appli1.all_year (rename = (B = Libell_Geographique) );
set appli1.all_year; 
run; 
data appli1.all_year (rename = (VAR1 = Code_Geographique ) );
set appli1.all_year; 
drop rename; 
run; 

data appli1.all_year;
set appli1.all_year;
ob = _n_;
run; 

data appli1.f; 
set appli1.all_year; 
run;
data appli1.all_year; 
set appli1.all_year;
where ob > 5;
run; 

data appli1.all_year; 
set appli1.all_year;
drop ob; 
run; 

data appli1.all_year;
set appli1.all_year;
if Libell_Geographique = "Libell� g�ographique" Then Delete;
if Libell_Geographique = "LIBGEO" Then delete; 
if Libell_Geographique = " " Then delete;
run; 

/* Question 9 */
/* Creation of data block for salaries of the men/managers and the
average salary. */
data appli1.men_manager2012;
set appli1.arm2012 appli1.com2012; 
run; 

data appli1.men_manager2012;
set appli1.men_manager2012;
keep VAR1 B  D N; 
run; 

/* Question 10 */
/*  Addition of variable AN, CSP and Gender to data set created in Question 9*/
DATA appli1.men_manager2012;
SET appli1.men_manager2012;
AN=2012;
CSP="Cadre";
GENDER="Male";
RUN;

/* Question 11 */
/* Renaming of the two variables created in question 9 */
data appli1.men_manager2012;
set appli1.men_manager2012; 
rename D = SalH; 
rename N = SalMoy;
run;

data appli1.men_manager2012;
set appli1.men_manager2012;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run; 

/* Question 12 */
/* Repetition of  question 9 - 11 for all year*/
/* Male Cadre Data for 2013 */
data appli1.men_manager2013;
set appli1.arm2013 appli1.com2013; 
run; 

data appli1.men_manager2013;
set appli1.men_manager2013;
keep VAR1 B  D N; 
run; 

DATA appli1.men_manager2013;
SET appli1.men_manager2013;
AN=2013;
CSP="Cadre";
GENDER="Male";
RUN;

data appli1.men_manager2013;
set appli1.men_manager2013; 
ob = _n_;
rename D = SalH; 
rename N = SalMoy;
run;

data appli1.men_manager2013;
set appli1.men_manager2013;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run; 

/* Male Cadre Data for 2014 */
data appli1.men_manager2014;
set appli1.arm2014 appli1.com2014; 
run; 

data appli1.men_manager2014;
set appli1.men_manager2014;
keep VAR1 B  D N; 
run; 

DATA appli1.men_manager2014;
SET appli1.men_manager2014;
AN=2014;
CSP="Cadre";
GENDER="Male";
RUN;

data appli1.men_manager2014;
set appli1.men_manager2014; 
ob = _n_;
rename D = SalH; 
rename N = SalMoy;
run;

data appli1.men_manager2014;
set appli1.men_manager2014;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run; 

/* Male Cadre Data for 2015 */
data appli1.men_manager2015;
set appli1.arm2015 appli1.com2015; 
run; 

data appli1.men_manager2015;
set appli1.men_manager2015;
keep VAR1 B  D N; 
run; 

DATA appli1.men_manager2015;
SET appli1.men_manager2015;
AN=2015;
CSP="Cadre";
GENDER="Male";
RUN;

data appli1.men_manager2015;
set appli1.men_manager2015; 
ob = _n_;
rename D = SalH; 
rename N = SalMoy;
run;

data appli1.men_manager2015;
set appli1.men_manager2015;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run; 

/* Male Cadre Data for 2016 */
data appli1.men_manager2016;
set appli1.arm2016 appli1.com2016; 
run; 

data appli1.men_manager2016;
set appli1.men_manager2016;
keep VAR1 B  D N; 
run; 

DATA appli1.men_manager2016;
SET appli1.men_manager2016;
AN=2016;
CSP="Cadre";
GENDER="Male";
RUN;

data appli1.men_manager2016;
set appli1.men_manager2016; 
ob = _n_;
rename D = SalH; 
rename N = SalMoy;
run;

data appli1.men_manager2016;
set appli1.men_manager2016;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run; 
 
/* Male Cadre Data for 2017 */
data appli1.men_manager2017;
set appli1.arm2017 appli1.com2017; 
run; 

data appli1.men_manager2017;
set appli1.men_manager2017;
keep VAR1 B  D N; 
run; 

DATA appli1.men_manager2017;
SET appli1.men_manager2017;
AN=2017;
CSP="Cadre";
GENDER="Male";
RUN;

data appli1.men_manager2017;
set appli1.men_manager2017; 
ob = _n_;
rename D = SalH; 
rename N = SalMoy;
run;

data appli1.men_manager2017;
set appli1.men_manager2017;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run; 


/* combination of Cadre data for all year */
data appli1.all_in1; 
set appli1.men_manager2012 appli1.men_manager2013 appli1.men_manager2014 appli1.men_manager2015 appli1.men_manager2016 appli1.men_manager2017; 
run; 

data appli1.all_in1;
set appli1.all_in1;
LABEL SalMoy=Salaire moyen cadres;
LABEL SalH=Salaire moyen homme cadres;
run; 

data appli1.all_in1;
set appli1.all_in1;
if Libell_Geographique = "Libell� g�ographique" Then Delete;
if Libell_Geographique = "LIBGEO" Then delete; 
if Libell_Geographique = " " Then delete;
drop genre;
drop ob;
run; 

/* 2012 For Male Intermediary Professionals */
data appli1.intem_Prof_2012; 
set appli1.arm2012 appli1.com2012; 
run; 

data appli1.intem_Prof_2012;
set appli1.intem_Prof_2012;
keep VAR1 B O E; 
run; 

DATA appli1.intem_Prof_2012;
SET appli1.intem_Prof_2012;
AN=2012;
CSP="Profession intermdiaire";
GENDER="Male";
RUN;

data appli1.intem_Prof_2012;
set appli1.intem_Prof_2012; 
ob = _n_;
rename O = SalH; 
rename E = SalMoy;
run;

data appli1.intem_Prof_2012;
set appli1.intem_Prof_2012;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run; 

/* 2013 For Male Intermediary Professionals */
data appli1.intem_Prof_2013; 
set appli1.arm2013 appli1.com2013; 
run; 

data appli1.intem_Prof_2013;
set appli1.intem_Prof_2013;
keep VAR1 B O E; 
run; 

DATA appli1.intem_Prof_2013;
SET appli1.intem_Prof_2013;
AN=2013;
CSP="Profession intermdiaire";
GENDER="Male";
RUN;

data appli1.intem_Prof_2013;
set appli1.intem_Prof_2013; 
ob = _n_;
rename O = SalH; 
rename E = SalMoy;
run;

data appli1.intem_Prof_2013;
set appli1.intem_Prof_2013;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run; 

/* 2014 For Male Intermediary Professionals */
data appli1.intem_Prof_2014; 
set appli1.arm2014 appli1.com2014; 
run; 

data appli1.intem_Prof_2014;
set appli1.intem_Prof_2014;
keep VAR1 B O E; 
run; 

DATA appli1.intem_Prof_2014;
SET appli1.intem_Prof_2014;
AN=2014;
CSP="Profession intermdiaire";
GENDER="Male";
RUN;

data appli1.intem_Prof_2014;
set appli1.intem_Prof_2014; 
ob = _n_;
rename O = SalH; 
rename E = SalMoy;
run;

data appli1.intem_Prof_2014;
set appli1.intem_Prof_2014;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run; 

/* 2015 For Male Intermediary Professionals */
data appli1.intem_Prof_2015; 
set appli1.arm2015 appli1.com2015; 
run; 

data appli1.intem_Prof_2015;
set appli1.intem_Prof_2015;
keep VAR1 B O E; 
run; 

DATA appli1.intem_Prof_2015;
SET appli1.intem_Prof_2015;
AN=2015;
CSP="Profession intermdiaire";
GENDER="Male";
RUN;

data appli1.intem_Prof_2015;
set appli1.intem_Prof_2015; 
ob = _n_;
rename O = SalH; 
rename E = SalMoy;
run;

data appli1.intem_Prof_2015;
set appli1.intem_Prof_2015;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run; 


/* 2016 For Male Intermediary Professionals */
data appli1.intem_Prof_2016; 
set appli1.arm2016 appli1.com2016; 
run; 

data appli1.intem_Prof_2016;
set appli1.intem_Prof_2016;
keep VAR1 B O E; 
run; 

DATA appli1.intem_Prof_2016;
SET appli1.intem_Prof_2016;
AN=2016;
CSP="Profession intermdiaire";
GENDER="Male";
RUN;

data appli1.intem_Prof_2016;
set appli1.intem_Prof_2016; 
ob = _n_;
rename O = SalH; 
rename E = SalMoy;
run;

data appli1.intem_Prof_2016;
set appli1.intem_Prof_2016;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run; 

/* 2017 For Male Intermediary Professionals */
data appli1.intem_Prof_2017; 
set appli1.arm2017 appli1.com2017; 
run; 

data appli1.intem_Prof_2017;
set appli1.intem_Prof_2017;
keep VAR1 B O E; 
run; 

DATA appli1.intem_Prof_2017;
SET appli1.intem_Prof_2017;
AN=2017;
CSP="Profession intermdiaire";
GENDER="Male";
RUN;

data appli1.intem_Prof_2017;
set appli1.intem_Prof_2017; 
ob = _n_;
rename O = SalH; 
rename E = SalMoy;
run;

data appli1.intem_Prof_2017;
set appli1.intem_Prof_2017;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run; 

data appli1.combine_intem_prof; 
set appli1.intem_Prof_2012 appli1.intem_Prof_2013 appli1.intem_Prof_2014 appli1.intem_Prof_2015 appli1.intem_Prof_2016 appli1.intem_Prof_2017; 
run; 

/* 2012 For Male Employs */
data appli1.Emp_2012; 
set appli1.arm2012 appli1.com2012; 
run; 

data appli1.Emp_2012;
set appli1.Emp_2012;
keep VAR1 B F P; 
run; 

DATA appli1.Emp_2012;
SET appli1.Emp_2012;
AN=2012;
CSP="Employ";
GENDER="Male";
RUN;

data appli1.Emp_2012;
set appli1.Emp_2012; 
ob = _n_;
rename P = SalH; 
rename F = SalMoy;
run;

data appli1.Emp_2012;;
set appli1.Emp_2012;;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run; 

/* 2013 For Male Employs */
data appli1.Emp_2013; 
set appli1.arm2013 appli1.com2013; 
run; 

data appli1.Emp_2013;
set appli1.Emp_2013;
keep VAR1 B F P; 
run; 

DATA appli1.Emp_2013;
SET appli1.Emp_2013;
AN=2013;
CSP="Employ";
GENDER="Male";
RUN;

data appli1.Emp_2013;
set appli1.Emp_2013; 
ob = _n_;
rename P = SalH; 
rename F = SalMoy;
run;

data appli1.Emp_2013;;
set appli1.Emp_2013;;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* 2014 For Male Employs */
data appli1.Emp_2014; 
set appli1.arm2014 appli1.com2014; 
run; 

data appli1.Emp_2014;
set appli1.Emp_2014;
keep VAR1 B F P; 
run; 

DATA appli1.Emp_2014;
SET appli1.Emp_2014;
AN=2014;
CSP="Employ";
GENDER="Male";
RUN;

data appli1.Emp_2014;
set appli1.Emp_2014; 
ob = _n_;
rename P = SalH; 
rename F = SalMoy;
run;

data appli1.Emp_2014;
set appli1.Emp_2014;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* 2015 For Male Employs */
data appli1.Emp_2015; 
set appli1.arm2015 appli1.com2015; 
run; 

data appli1.Emp_2015;
set appli1.Emp_2015;
keep VAR1 B F P; 
run; 

DATA appli1.Emp_2015;
SET appli1.Emp_2015;
AN=2015;
CSP="Employ";
GENDER="Male";
RUN;

data appli1.Emp_2015;
set appli1.Emp_2015; 
ob = _n_;
rename P = SalH; 
rename F = SalMoy;
run;

data appli1.Emp_2015;
set appli1.Emp_2015;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* 2016 For Male Employs */
data appli1.Emp_2016; 
set appli1.arm2016 appli1.com2016; 
run; 

data appli1.Emp_2016;
set appli1.Emp_2016;
keep VAR1 B F P; 
run; 

DATA appli1.Emp_2016;
SET appli1.Emp_2016;
AN=2016;
CSP="Employ";
GENDER="Male";
RUN;

data appli1.Emp_2016;
set appli1.Emp_2016; 
ob = _n_;
rename P = SalH; 
rename F = SalMoy;
run;

data appli1.Emp_2016;
set appli1.Emp_2016;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* 2017 For Male Employs */
data appli1.Emp_2017; 
set appli1.arm2017 appli1.com2017; 
run; 

data appli1.Emp_2017;
set appli1.Emp_2017;
keep VAR1 B F P; 
run; 

DATA appli1.Emp_2017;
SET appli1.Emp_2017;
AN=2017;
CSP="Employ";
GENDER="Male";
RUN;

data appli1.Emp_2017;
set appli1.Emp_2017; 
ob = _n_;
rename P = SalH; 
rename F = SalMoy;
run;

data appli1.Emp_2017;
set appli1.Emp_2017;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

data appli1.comb_emp; 
set appli1.Emp_2012 appli1.Emp_2013 appli1.Emp_2014 appli1.Emp_2015 appli1.Emp_2016 appli1.Emp_2017; 
run; 

/* 2012 For Male Worker */

data appli1.Work_2012; 
set appli1.arm2012 appli1.com2012; 
run; 

data appli1.Work_2012;
set appli1.Work_2012;
keep VAR1 B Q G; 
run; 

DATA appli1.Work_2012;
set appli1.Work_2012;
AN=2012;
CSP="Worker";
GENDER="Male";
RUN;

data appli1.Work_2012;
set appli1.Work_2012; 
ob = _n_;
rename Q = SalH; 
rename G = SalMoy;
run;

data appli1.Work_2012;
set appli1.Work_2012;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* 2013 For Male Worker */

data appli1.Work_2013; 
set appli1.arm2013 appli1.com2013; 
run; 

data appli1.Work_2013;
set appli1.Work_2013;
keep VAR1 B Q G; 
run; 

DATA appli1.Work_2013;
set appli1.Work_2013;
AN=2013;
CSP="Worker";
GENDER="Male";
RUN;

data appli1.Work_2013;
set appli1.Work_2013; 
ob = _n_;
rename Q = SalH; 
rename G = SalMoy;
run;

data appli1.Work_2013;
set appli1.Work_2013;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* 2014 For Male Worker */

data appli1.Work_2014; 
set appli1.arm2014 appli1.com2014; 
run; 

data appli1.Work_2014;
set appli1.Work_2014;
keep VAR1 B Q G; 
run; 

DATA appli1.Work_2014;
set appli1.Work_2014;
AN=2014;
CSP="Worker";
GENDER="Male";
RUN;

data appli1.Work_2014;
set appli1.Work_2014; 
ob = _n_;
rename Q = SalH; 
rename G = SalMoy;
run;

data appli1.Work_2014;
set appli1.Work_2014;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* 2015 For Male Worker */

data appli1.Work_2015; 
set appli1.arm2015 appli1.com2015; 
run; 

data appli1.Work_2015;
set appli1.Work_2015;
keep VAR1 B Q G; 
run; 

DATA appli1.Work_2015;
set appli1.Work_2015;
AN=2015;
CSP="Worker";
GENDER="Male";
RUN;

data appli1.Work_2015;
set appli1.Work_2015; 
ob = _n_;
rename Q = SalH; 
rename G = SalMoy;
run;

data appli1.Work_2015;
set appli1.Work_2015;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* 2016 For Male Worker */

data appli1.Work_2016; 
set appli1.arm2016 appli1.com2016; 
run; 

data appli1.Work_2016;
set appli1.Work_2016;
keep VAR1 B Q G; 
run; 

DATA appli1.Work_2016;
set appli1.Work_2016;
AN=2016;
CSP="Worker";
GENDER="Male";
RUN;

data appli1.Work_2016;
set appli1.Work_2016; 
ob = _n_;
rename Q = SalH; 
rename G = SalMoy;
run;

data appli1.Work_2016;
set appli1.Work_2016;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* 2017 For Male Worker */

data appli1.Work_2017; 
set appli1.arm2017 appli1.com2017; 
run; 

data appli1.Work_2017;
set appli1.Work_2017;
keep VAR1 B Q G; 
run; 

DATA appli1.Work_2017;
set appli1.Work_2017;
AN=2017;
CSP="Worker";
GENDER="Male";
RUN;

data appli1.Work_2017;
set appli1.Work_2017; 
ob = _n_;
rename Q = SalH; 
rename G = SalMoy;
run;

data appli1.Work_2017;
set appli1.Work_2017;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

data appli1.combine_work; 
set appli1.Work_2012 appli1.Work_2013 appli1.Work_2014 appli1.Work_2015 appli1.Work_2016 appli1.Work_2017; 
run; 

/* for female Cadre 2012 */
data appli1.FemCadre_2012; 
set appli1.arm2012 appli1.com2012; 
run; 

data appli1.FemCadre_2012; 
set appli1.FemCadre_2012; 
keep VAR1 B I D;
run; 
DATA appli1.FemCadre_2012;
set appli1.FemCadre_2012;
AN=2012;
CSP="Cadre";
GENDER="Female";
RUN;
data appli1.FemCadre_2012;
set appli1.FemCadre_2012; 
ob = _n_;
rename D = SalH; 
rename I = SalMoy;
run;

data appli1.FemCadre_2012;
set appli1.FemCadre_2012;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for female Cadre 2013 */
data appli1.FemCadre_2013; 
set appli1.arm2013 appli1.com2013; 
run; 

data appli1.FemCadre_2013; 
set appli1.FemCadre_2013; 
keep VAR1 B I D;
run; 
DATA appli1.FemCadre_2013;
set appli1.FemCadre_2013;
AN=2013;
CSP="Cadre";
GENDER="Female";
RUN;
data appli1.FemCadre_2013;
set appli1.FemCadre_2013; 
ob = _n_;
rename D = SalH; 
rename I = SalMoy;
run;

data appli1.FemCadre_2013;
set appli1.FemCadre_2013;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for female Cadre 2014 */
data appli1.FemCadre_2014; 
set appli1.arm2014 appli1.com2014; 
run; 

data appli1.FemCadre_2014; 
set appli1.FemCadre_2014; 
keep VAR1 B I D;
run; 
DATA appli1.FemCadre_2014;
set appli1.FemCadre_2014;
AN=2014;
CSP="Cadre";
GENDER="Female";
RUN;
data appli1.FemCadre_2014;
set appli1.FemCadre_2014; 
ob = _n_;
rename D = SalH; 
rename I = SalMoy;
run;

data appli1.FemCadre_2014;
set appli1.FemCadre_2014;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for female Cadre 2015 */
data appli1.FemCadre_2015; 
set appli1.arm2015 appli1.com2015; 
run; 

data appli1.FemCadre_2015; 
set appli1.FemCadre_2015; 
keep VAR1 B I D;
run; 
DATA appli1.FemCadre_2015;
set appli1.FemCadre_2015;
AN=2015;
CSP="Cadre";
GENDER="Female";
RUN;
data appli1.FemCadre_2015;
set appli1.FemCadre_2015; 
ob = _n_;
rename D = SalH; 
rename I = SalMoy;
run;

data appli1.FemCadre_2015;
set appli1.FemCadre_2015;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for female Cadre 2016 */
data appli1.FemCadre_2016; 
set appli1.arm2016 appli1.com2016; 
run; 

data appli1.FemCadre_2016; 
set appli1.FemCadre_2016; 
keep VAR1 B I D;
run; 
DATA appli1.FemCadre_2016;
set appli1.FemCadre_2016;
AN=2016;
CSP="Cadre";
GENDER="Female";
RUN;
data appli1.FemCadre_2016;
set appli1.FemCadre_2016; 
ob = _n_;
rename D = SalH; 
rename I = SalMoy;
run;

data appli1.FemCadre_2016;
set appli1.FemCadre_2016;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for female Cadre 2017 */
data appli1.FemCadre_2017; 
set appli1.arm2017 appli1.com2017; 
run; 

data appli1.FemCadre_2017; 
set appli1.FemCadre_2017; 
keep VAR1 B I D;
run; 
DATA appli1.FemCadre_2017;
set appli1.FemCadre_2017;
AN=2017;
CSP="Cadre";
GENDER="Female";
RUN;
data appli1.FemCadre_2017;
set appli1.FemCadre_2017; 
ob = _n_;
rename D = SalH; 
rename I = SalMoy;
run;

data appli1.FemCadre_2017;
set appli1.FemCadre_2017;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

Data appli1.FemCadreCombine; 
set appli1.FemCadre_2012 appli1.FemCadre_2013 appli1.FemCadre_2014 appli1.FemCadre_2015 appli1.FemCadre_2016 appli1.FemCadre_2017; 
run; 

/*For Female intermediary professional 2012*/

data appli1.FemIntPro_2012; 
set appli1.arm2012 appli1.com2012; 
run; 

data appli1.FemIntPro_2012;
set appli1.FemIntPro_2012; 
keep VAR1 B J E;
run;

DATA appli1.FemIntPro_2012;
set appli1.FemIntPro_2012;
AN=2012;
CSP="Intermediate Professional";
GENDER="Female";
RUN;

data appli1.FemIntPro_2012;
set appli1.FemIntPro_2012; 
ob = _n_;
rename J = SalH; 
rename E = SalMoy;
run;

data appli1.FemIntPro_2012;
set appli1.FemIntPro_2012;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/*For Female intermediary professional 2013*/

data appli1.FemIntPro_2013; 
set appli1.arm2013 appli1.com2013; 
run; 

data appli1.FemIntPro_2013;
set appli1.FemIntPro_2013; 
keep VAR1 B J E;
run;

DATA appli1.FemIntPro_2013;
set appli1.FemIntPro_2013;
AN=2013;
CSP="Intermediate Professional";
GENDER="Female";
RUN;

data appli1.FemIntPro_2013;
set appli1.FemIntPro_2013; 
ob = _n_;
rename J = SalH; 
rename E = SalMoy;
run;

data appli1.FemIntPro_2013;
set appli1.FemIntPro_2013;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/*For Female intermediary professional 2014*/

data appli1.FemIntPro_2014; 
set appli1.arm2014 appli1.com2014; 
run; 

data appli1.FemIntPro_2014;
set appli1.FemIntPro_2014; 
keep VAR1 B J E;
run;

DATA appli1.FemIntPro_2014;
set appli1.FemIntPro_2014;
AN=2014;
CSP="Intermediate Professional";
GENDER="Female";
RUN;

data appli1.FemIntPro_2014;
set appli1.FemIntPro_2014; 
ob = _n_;
rename J = SalH; 
rename E = SalMoy;
run;

data appli1.FemIntPro_2014;
set appli1.FemIntPro_2014;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/*For Female intermediary professional 2015*/

data appli1.FemIntPro_2015; 
set appli1.arm2015 appli1.com2015; 
run; 

data appli1.FemIntPro_2015;
set appli1.FemIntPro_2015; 
keep VAR1 B J E;
run;

DATA appli1.FemIntPro_2015;
set appli1.FemIntPro_2015;
AN=2015;
CSP="Intermediate Professional";
GENDER="Female";
RUN;

data appli1.FemIntPro_2015;
set appli1.FemIntPro_2015; 
ob = _n_;
rename J = SalH; 
rename E = SalMoy;
run;

data appli1.FemIntPro_2015;
set appli1.FemIntPro_201;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/*For Female intermediary professional 2016*/

data appli1.FemIntPro_2016; 
set appli1.arm2016 appli1.com2016; 
run; 

data appli1.FemIntPro_2016;
set appli1.FemIntPro_2016; 
keep VAR1 B J E;
run;

DATA appli1.FemIntPro_2016;
set appli1.FemIntPro_2016;
AN=2016;
CSP="Intermediate Professional";
GENDER="Female";
RUN;

data appli1.FemIntPro_2016;
set appli1.FemIntPro_2016; 
ob = _n_;
rename J = SalH; 
rename E = SalMoy;
run;

data appli1.FemIntPro_2016;
set appli1.FemIntPro_2016;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/*For Female intermediary professional 2017*/

data appli1.FemIntPro_2017; 
set appli1.arm2017 appli1.com2017; 
run; 

data appli1.FemIntPro_2017;
set appli1.FemIntPro_2017; 
keep VAR1 B J E;
run;

DATA appli1.FemIntPro_2017;
set appli1.FemIntPro_2017;
AN=2017;
CSP="Intermediate Professional";
GENDER="Female";
RUN;

data appli1.FemIntPro_2017;
set appli1.FemIntPro_2017; 
ob = _n_;
rename J = SalH; 
rename E = SalMoy;
run;

data appli1.FemIntPro_2017;
set appli1.FemIntPro_2017;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

data appli1.combineFemIntPro; 
set appli1.FemIntPro_2012 appli1.FemIntPro_2013 appli1.FemIntPro_2014 appli1.FemIntPro_2015 appli1.FemIntPro_2016 appli1.FemIntPro_2017;
run; 

/* for Female Employ 2012*/
data Appli1.FeEmploy_2012; 
set appli1.arm2012 appli1.com2012; 
run; 

data Appli1.FeEmploy_2012;
set Appli1.FeEmploy_2012; 
keep VAR1 B K F;
run;

DATA Appli1.FeEmploy_2012;
set Appli1.FeEmploy_2012;
AN=2012;
CSP="Employ";
GENDER="Female";
RUN;

data Appli1.FeEmploy_2012;
set Appli1.FeEmploy_2012;
ob = _n_;
rename K = SalH; 
rename F = SalMoy;
run;

data Appli1.FeEmploy_2012;
set Appli1.FeEmploy_2012;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female Employ 2013*/
data Appli1.FeEmploy_2013; 
set appli1.arm2013 appli1.com2013; 
run; 

data Appli1.FeEmploy_2013;
set Appli1.FeEmploy_2013; 
keep VAR1 B K F;
run;

DATA Appli1.FeEmploy_2013;
set Appli1.FeEmploy_2013;
AN=2013;
CSP="Employ";
GENDER="Female";
RUN;

data Appli1.FeEmploy_2013;
set Appli1.FeEmploy_2013;
ob = _n_;
rename K = SalH; 
rename F = SalMoy;
run;

data Appli1.FeEmploy_2013;
set Appli1.FeEmploy_2013;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female Employ 2014*/
data Appli1.FeEmploy_2014; 
set appli1.arm2014 appli1.com2014; 
run; 

data Appli1.FeEmploy_2014;
set Appli1.FeEmploy_2014; 
keep VAR1 B K F;
run;

DATA Appli1.FeEmploy_2014;
set Appli1.FeEmploy_2014;
AN=2014;
CSP="Employ";
GENDER="Female";
RUN;

data Appli1.FeEmploy_2014;
set Appli1.FeEmploy_2014;
ob = _n_;
rename K = SalH; 
rename F = SalMoy;
run;

data Appli1.FeEmploy_2014;
set Appli1.FeEmploy_2014;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female Employ 2015*/
data Appli1.FeEmploy_2015; 
set appli1.arm2015 appli1.com2015; 
run; 

data Appli1.FeEmploy_2015;
set Appli1.FeEmploy_2015; 
keep VAR1 B K F;
run;

DATA Appli1.FeEmploy_2015;
set Appli1.FeEmploy_2015;
AN=2015;
CSP="Employ";
GENDER="Female";
RUN;

data Appli1.FeEmploy_2015;
set Appli1.FeEmploy_2015;
ob = _n_;
rename K = SalH; 
rename F = SalMoy;
run;

data Appli1.FeEmploy_2015;
set Appli1.FeEmploy_2015;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female Employ 2016*/
data Appli1.FeEmploy_2016; 
set appli1.arm2016 appli1.com2016; 
run; 

data Appli1.FeEmploy_2016;
set Appli1.FeEmploy_2016; 
keep VAR1 B K F;
run;

DATA Appli1.FeEmploy_2016;
set Appli1.FeEmploy_2016;
AN=2016;
CSP="Employ";
GENDER="Female";
RUN;

data Appli1.FeEmploy_2016;
set Appli1.FeEmploy_2016;
ob = _n_;
rename K = SalH; 
rename F = SalMoy;
run;

data Appli1.FeEmploy_2016;
set Appli1.FeEmploy_2016;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female Employ 2017*/
data Appli1.FeEmploy_2017; 
set appli1.arm2017 appli1.com2017; 
run; 

data Appli1.FeEmploy_2017;
set Appli1.FeEmploy_2017; 
keep VAR1 B K F;
run;

DATA Appli1.FeEmploy_2017;
set Appli1.FeEmploy_2017;
AN=2017;
CSP="Employ";
GENDER="Female";
RUN;

data Appli1.FeEmploy_2017;
set Appli1.FeEmploy_2017;
ob = _n_;
rename K = SalH; 
rename F = SalMoy;
run;

data Appli1.FeEmploy_2017;
set Appli1.FeEmploy_2017;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

Data Appli1.CombineFeEmploy; 
set Appli1.FeEmploy_2012 Appli1.FeEmploy_2013 Appli1.FeEmploy_2014 Appli1.FeEmploy_2015 Appli1.FeEmploy_2016 ; 
run; 

/* for workers 2012 */
data Appli1.FeWork_2012; 
set appli1.arm2012 appli1.com2012; 
run; 

data Appli1.FeWork_2012; 
set Appli1.FeWork_2012;  
keep VAR1 B L G;
run;
DATA Appli1.FeWork_2012;
set Appli1.FeWork_2012;
AN=2012;
CSP="Worker";
GENDER="Female";
RUN;

data Appli1.FeWork_2012;
set Appli1.FeWork_2012;
ob = _n_;
rename L = SalH; 
rename G = SalMoy;
run;

data Appli1.FeWork_2012;
set Appli1.FeWork_2012;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for workers 2013 */
data Appli1.FeWork_2013; 
set appli1.arm2013 appli1.com2013; 
run; 

data Appli1.FeWork_2013; 
set Appli1.FeWork_2013;  
keep VAR1 B L G;
run;
DATA Appli1.FeWork_2013;
set Appli1.FeWork_2013;
AN=2013;
CSP="Worker";
GENDER="Female";
RUN;

data Appli1.FeWork_2013;
set Appli1.FeWork_2013;
ob = _n_;
rename L = SalH; 
rename G = SalMoy;
run;

data Appli1.FeWork_2013;
set Appli1.FeWork_2013;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for workers 2014 */
data Appli1.FeWork_2014; 
set appli1.arm2014 appli1.com2014; 
run; 

data Appli1.FeWork_2014; 
set Appli1.FeWork_2014;  
keep VAR1 B L G;
run;
DATA Appli1.FeWork_2014;
set Appli1.FeWork_2014;
AN=2014;
CSP="Worker";
GENDER="Female";
RUN;

data Appli1.FeWork_2014;
set Appli1.FeWork_2014;
ob = _n_;
rename L = SalH; 
rename G = SalMoy;
run;

data Appli1.FeWork_2014;
set Appli1.FeWork_2014;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for workers 2015 */
data Appli1.FeWork_2015; 
set appli1.arm2015 appli1.com2015; 
run; 

data Appli1.FeWork_2015; 
set Appli1.FeWork_2015;  
keep VAR1 B L G;
run;
DATA Appli1.FeWork_2015;
set Appli1.FeWork_2015;
AN=2015;
CSP="Worker";
GENDER="Female";
RUN;

data Appli1.FeWork_2015;
set Appli1.FeWork_2015;
ob = _n_;
rename L = SalH; 
rename G = SalMoy;
run;

data Appli1.FeWork_2015;
set Appli1.FeWork_2015;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for workers 2016 */
data Appli1.FeWork_2016; 
set appli1.arm2016 appli1.com2016; 
run; 

data Appli1.FeWork_2016; 
set Appli1.FeWork_2016;  
keep VAR1 B L G;
run;
DATA Appli1.FeWork_2016;
set Appli1.FeWork_2016;
AN=2016;
CSP="Worker";
GENDER="Female";
RUN;

data Appli1.FeWork_2016;
set Appli1.FeWork_2016;
ob = _n_;
rename L = SalH; 
rename G = SalMoy;
run;

data Appli1.FeWork_2016;
set Appli1.FeWork_2016;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for workers 2017 */
data Appli1.FeWork_2017; 
set appli1.arm2017 appli1.com2017; 
run; 

data Appli1.FeWork_2017; 
set Appli1.FeWork_2017;  
keep VAR1 B L G;
run;
DATA Appli1.FeWork_2017;
set Appli1.FeWork_2017;
AN=2017;
CSP="Worker";
GENDER="Female";
RUN;

data Appli1.FeWork_2017;
set Appli1.FeWork_2017;
ob = _n_;
rename L = SalH; 
rename G = SalMoy;
run;

data Appli1.FeWork_2017;
set Appli1.FeWork_2017;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

data appli1.combineFeWork; 
set Appli1.FeWork_2012 Appli1.FeWork_2013 Appli1.FeWork_2014 Appli1.FeWork_2015 Appli1.FeWork_2016 Appli1.FeWork_2017;
run; 

data appli1.AllCategory_Combine;
set appli1.combineFeWork Appli1.CombineFeEmploy appli1.combineFemIntPro appli1.FemCadreCombine appli1.combine_work  appli1.comb_emp  appli1.combine_intem_prof appli1.all_in1;  
run; 

data appli1.AllCategory_Combine;
set appli1.AllCategory_Combine;
drop GENRE ob; 
LABEL SalMoy=Salaire moyen selon la CSP;
LABEL SalH=Salaire moyen selon le sexe et la CSP;
run; 

/* Question 14 */
/* Age Classification 2012 */
data Appli1.Age18_25_2012; 
set appli1.arm2012 appli1.com2012; 
run; 

data Appli1.Age18_25_2012; 
set Appli1.Age18_25_2012; 
keep VAR1 B R X; 
run; 

DATA Appli1.Age18_25_2012;
set Appli1.Age18_25_2012;
AN=2012;
Age="18-25";
GENDER="Male";
RUN;

data Appli1.Age18_25_2012;
set Appli1.Age18_25_2012;
ob = _n_;
rename X = SalH; 
rename R = SalMoy;
run;

data Appli1.Age18_25_2012;
set Appli1.Age18_25_2012;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* Age Classification 2013 */
data Appli1.Age18_25_2013; 
set appli1.arm2013 appli1.com2013; 
run; 

data Appli1.Age18_25_2013; 
set Appli1.Age18_25_2013; 
keep VAR1 B R X; 
run; 

DATA Appli1.Age18_25_2013;
set Appli1.Age18_25_2013;
AN=2013;
Age="18-25";
GENDER="Male";
RUN;

data Appli1.Age18_25_2013;
set Appli1.Age18_25_2013;
ob = _n_;
rename X = SalH; 
rename R = SalMoy;
run;

data Appli1.Age18_25_2013;
set Appli1.Age18_25_2013;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* Age Classification 2014 */
data Appli1.Age18_25_2014; 
set appli1.arm2014 appli1.com2014; 
run; 

data Appli1.Age18_25_2014; 
set Appli1.Age18_25_2014; 
keep VAR1 B R X; 
run; 

DATA Appli1.Age18_25_2014;
set Appli1.Age18_25_2014;
AN=2014;
Age="18-25";
GENDER="Male";
RUN;

data Appli1.Age18_25_2014;
set Appli1.Age18_25_2014;
ob = _n_;
rename X = SalH; 
rename R = SalMoy;
run;

data Appli1.Age18_25_2014;
set Appli1.Age18_25_2014;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* Age Classification 2015 */
data Appli1.Age18_25_2015; 
set appli1.arm2012 appli1.com2015; 
run; 

data Appli1.Age18_25_2015; 
set Appli1.Age18_25_2015; 
keep VAR1 B R X; 
run; 

DATA Appli1.Age18_25_2015;
set Appli1.Age18_25_2015;
AN=2015;
Age="18-25";
GENDER="Male";
RUN;

data Appli1.Age18_25_2015;
set Appli1.Age18_25_2015;
ob = _n_;
rename X = SalH; 
rename R = SalMoy;
run;

data Appli1.Age18_25_2015;
set Appli1.Age18_25_2015;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* Age Classification 2016 */
data Appli1.Age18_25_2016; 
set appli1.arm2016 appli1.com2016; 
run; 

data Appli1.Age18_25_2016; 
set Appli1.Age18_25_2016; 
keep VAR1 B R X; 
run; 

DATA Appli1.Age18_25_2016;
set Appli1.Age18_25_2016;
AN=2016;
Age="18-25";
GENDER="Male";
RUN;

data Appli1.Age18_25_2016;
set Appli1.Age18_25_2016;
ob = _n_;
rename X = SalH; 
rename R = SalMoy;
run;

data Appli1.Age18_25_2016;
set Appli1.Age18_25_2016;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* Age Classification 2017 */
data Appli1.Age18_25_2017; 
set appli1.arm2017 appli1.com2017; 
run; 

data Appli1.Age18_25_2017; 
set Appli1.Age18_25_2017; 
keep VAR1 B R X; 
run; 

DATA Appli1.Age18_25_2017;
set Appli1.Age18_25_2017;
AN=2017;
Age="18-25";
GENDER="Male";
RUN;

data Appli1.Age18_25_2017;
set Appli1.Age18_25_2017;
ob = _n_;
rename X = SalH; 
rename R = SalMoy;
run;

data Appli1.Age18_25_2017;
set Appli1.Age18_25_2017;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

data Appli1.age18_25Combined; 
set Appli1.Age18_25_2012 Appli1.Age18_25_2013 Appli1.Age18_25_2014 Appli1.Age18_25_2015 Appli1.Age18_25_2016 Appli1.Age18_25_2017; 
run; 

/* @@@@@ */
DATA Appli1.age18_25Combined; 
SET Appli1.age18_25Combined; 
label SalMoy=Salaire_moyen_18_25_ans;
label SalH=Salaire_moyen_homme_18_25_ans;
run; 

/* for Male Above 26-50 2012*/
data Appli1.Age26_50_2012; 
set appli1.arm2012 appli1.com2012; 
run; 

data Appli1.Age26_50_2012; 
set Appli1.Age26_50_2012; 
keep VAR1 B Y S; 
run; 

DATA Appli1.Age26_50_2012;
set Appli1.Age26_50_2012;
AN=2012;
Age="26-50";
GENDER="Male";
RUN;

data Appli1.Age26_50_2012;
set Appli1.Age26_50_2012;
ob = _n_;
rename Y = SalH; 
rename S = SalMoy;
run;

data Appli1.Age26_50_2012;
set Appli1.Age26_50_2012;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Male Above 26-50 2013*/
data Appli1.Age26_50_2013; 
set appli1.arm2013 appli1.com2013; 
run; 

data Appli1.Age26_50_2013; 
set Appli1.Age26_50_2013; 
keep VAR1 B Y S; 
run; 

DATA Appli1.Age26_50_2013;
set Appli1.Age26_50_2013;
AN=2013;
Age="26-50";
GENDER="Male";
RUN;

data Appli1.Age26_50_2013;
set Appli1.Age26_50_2013;
ob = _n_;
rename Y = SalH; 
rename S = SalMoy;
run;

data Appli1.Age26_50_2013;
set Appli1.Age26_50_2013;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Male Above 26-50 2014*/
data Appli1.Age26_50_2014; 
set appli1.arm2014 appli1.com2014; 
run; 

data Appli1.Age26_50_2014; 
set Appli1.Age26_50_2014; 
keep VAR1 B Y S; 
run; 

DATA Appli1.Age26_50_2014;
set Appli1.Age26_50_2014;
AN=2014;
Age="26-50";
GENDER="Male";
RUN;

data Appli1.Age26_50_2014;
set Appli1.Age26_50_2014;
ob = _n_;
rename Y = SalH; 
rename S = SalMoy;
run;

data Appli1.Age26_50_2014;
set Appli1.Age26_50_2014;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Male Above 26-50 2015*/
data Appli1.Age26_50_2015; 
set appli1.arm2015 appli1.com2015; 
run; 

data Appli1.Age26_50_2015; 
set Appli1.Age26_50_2015; 
keep VAR1 B Y S; 
run; 

DATA Appli1.Age26_50_2015;
set Appli1.Age26_50_2015;
AN=2015;
Age="26-50";
GENDER="Male";
RUN;

data Appli1.Age26_50_2015;
set Appli1.Age26_50_2015;
ob = _n_;
rename Y = SalH; 
rename S = SalMoy;
run;

data Appli1.Age26_50_2015;
set Appli1.Age26_50_2015;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Male Above 26-50 2016*/
data Appli1.Age26_50_2016; 
set appli1.arm2016 appli1.com2016; 
run; 

data Appli1.Age26_50_2016; 
set Appli1.Age26_50_2016; 
keep VAR1 B Y S; 
run; 

DATA Appli1.Age26_50_2016;
set Appli1.Age26_50_2016;
AN=2016;
Age="26-50";
GENDER="Male";
RUN;

data Appli1.Age26_50_2016;
set Appli1.Age26_50_2016;
ob = _n_;
rename Y = SalH; 
rename S = SalMoy;
run;

data Appli1.Age26_50_2016;
set Appli1.Age26_50_2016;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Male Above 26-50 2017*/
data Appli1.Age26_50_2017; 
set appli1.arm2017 appli1.com2017; 
run; 

data Appli1.Age26_50_2017; 
set Appli1.Age26_50_2017; 
keep VAR1 B Y S; 
run; 

DATA Appli1.Age26_50_2017;
set Appli1.Age26_50_2017;
AN=2017;
Age="26-50";
GENDER="Male";
RUN;

data Appli1.Age26_50_2017;
set Appli1.Age26_50_2017;
ob = _n_;
rename Y = SalH; 
rename S = SalMoy;
run;

data Appli1.Age26_50_2017;
set Appli1.Age26_50_2017;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

data Appli1.age26_50Combined; 
set Appli1.Age26_50_2012 Appli1.Age26_50_2013 Appli1.Age26_50_2014 Appli1.Age26_50_2015 Appli1.Age26_50_2016 Appli1.Age26_50_2017;
run;

DATA Appli1.age26_50Combined;  
SET Appli1.age26_50Combined; 
label SalMoy=Salaire_moyen_26_50_ans;
label SalH=Salaire_moyen_homme_26_50_ans;
run; 


/* for Male above 50 2012*/
data Appli1.AgeAbove50_2012; 
set appli1.arm2012 appli1.com2012; 
run; 

data Appli1.AgeAbove50_2012; 
set Appli1.AgeAbove50_2012;
keep VAR1 B Z T; 
run; 

DATA Appli1.AgeAbove50_2012;
set Appli1.AgeAbove50_2012;
AN=2012;
Age="Above 50";
GENDER="Male";
RUN;

data Appli1.AgeAbove50_2012;
set Appli1.AgeAbove50_2012;
ob = _n_;
rename Z = SalH; 
rename T = SalMoy;
run;

data Appli1.AgeAbove50_2012;
set Appli1.AgeAbove50_2012;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;


/* for Male above 50 2013*/
data Appli1.AgeAbove50_2013; 
set appli1.arm2013 appli1.com2013; 
run; 

data Appli1.AgeAbove50_2013; 
set Appli1.AgeAbove50_2013;
keep VAR1 B Z T; 
run; 

DATA Appli1.AgeAbove50_2013;
set Appli1.AgeAbove50_2013;
AN=2013;
Age="Above 50";
GENDER="Male";
RUN;

data Appli1.AgeAbove50_2013;
set Appli1.AgeAbove50_2013;
ob = _n_;
rename Z = SalH; 
rename T = SalMoy;
run;

data Appli1.AgeAbove50_2013;
set Appli1.AgeAbove50_2013;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Male above 50 2014*/
data Appli1.AgeAbove50_2014; 
set appli1.arm2014 appli1.com2014; 
run; 

data Appli1.AgeAbove50_2014; 
set Appli1.AgeAbove50_2014;
keep VAR1 B Z T; 
run; 

DATA Appli1.AgeAbove50_2014;
set Appli1.AgeAbove50_2014;
AN=2014;
Age="Above 50";
GENDER="Male";
RUN;

data Appli1.AgeAbove50_2014;
set Appli1.AgeAbove50_2014;
ob = _n_;
rename Z = SalH; 
rename T = SalMoy;
run;

data Appli1.AgeAbove50_2014;
set Appli1.AgeAbove50_2014;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Male above 50 2015*/
data Appli1.AgeAbove50_2015; 
set appli1.arm2015 appli1.com2015; 
run; 

data Appli1.AgeAbove50_2015; 
set Appli1.AgeAbove50_2015;
keep VAR1 B Z T; 
run; 

DATA Appli1.AgeAbove50_2015;
set Appli1.AgeAbove50_2015;
AN=2015;
Age="Above 50";
GENDER="Male";
RUN;

data Appli1.AgeAbove50_2015;
set Appli1.AgeAbove50_2015;
ob = _n_;
rename Z = SalH; 
rename T = SalMoy;
run;

data Appli1.AgeAbove50_2015;
set Appli1.AgeAbove50_2015;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Male above 50 2016*/
data Appli1.AgeAbove50_2016; 
set appli1.arm2015 appli1.com2016; 
run; 

data Appli1.AgeAbove50_2016; 
set Appli1.AgeAbove50_2016;
keep VAR1 B Z T; 
run; 

DATA Appli1.AgeAbove50_2016;
set Appli1.AgeAbove50_2016;
AN=2016;
Age="Above 50";
GENDER="Male";
RUN;

data Appli1.AgeAbove50_2016;
set Appli1.AgeAbove50_2016;
ob = _n_;
rename Z = SalH; 
rename T = SalMoy;
run;

data Appli1.AgeAbove50_2016;
set Appli1.AgeAbove50_2016;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Male above 50 2017*/
data Appli1.AgeAbove50_2017; 
set appli1.arm2017 appli1.com2017; 
run; 

data Appli1.AgeAbove50_2017; 
set Appli1.AgeAbove50_2017;
keep VAR1 B Z T; 
run; 

DATA Appli1.AgeAbove50_2017;
set Appli1.AgeAbove50_2017;
AN=2017;
Age="Above 50";
GENDER="Male";
RUN;

data Appli1.AgeAbove50_2017;
set Appli1.AgeAbove50_2017;
ob = _n_;
rename Z = SalH; 
rename T = SalMoy;
run;

data Appli1.AgeAbove50_2017;
set Appli1.AgeAbove50_2017;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

data Appli1.ageAbove50Combined; 
set Appli1.AgeAbove50_2012 Appli1.AgeAbove50_2013 Appli1.AgeAbove50_2014 Appli1.AgeAbove50_2015 Appli1.AgeAbove50_2015 Appli1.AgeAbove50_2016 Appli1.AgeAbove50_2017;
run;

DATA Appli1.ageAbove50Combined;  
SET Appli1.ageAbove50Combined; 
label SalMoy=Salaire_moyen_Above_50_ans;
label SalH=Salaire_moyen_homme_Above_50_ans;
run; 


/* for Female Below 18-25 2012*/
data Appli1.FeAge18_25_2012; 
set appli1.arm2012 appli1.com2012; 
run; 

data Appli1.FeAge18_25_2012; 
set Appli1.FeAge18_25_2012;
keep VAR1 B U R; 
run; 

DATA Appli1.FeAge18_25_2012;
set Appli1.FeAge18_25_2012;
AN=2012;
Age="18-25";
GENDER="Female";
RUN;

data Appli1.FeAge18_25_2012;
set Appli1.FeAge18_25_2012;
ob = _n_;
rename U = SalH; 
rename R = SalMoy;
run;

data Appli1.FeAge18_25_2012;
set Appli1.FeAge18_25_2012;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female Below 18-25 2013*/
data Appli1.FeAge18_25_2013; 
set appli1.arm2013 appli1.com2013; 
run; 

data Appli1.FeAge18_25_2013; 
set Appli1.FeAge18_25_2013;
keep VAR1 B U R; 
run; 

DATA Appli1.FeAge18_25_2013;
set Appli1.FeAge18_25_2013;
AN=2013;
Age="18-25";
GENDER="Female";
RUN;

data Appli1.FeAge18_25_2013;
set Appli1.FeAge18_25_2013;
ob = _n_;
rename U = SalH; 
rename R = SalMoy;
run;

data Appli1.FeAge18_25_2013;
set Appli1.FeAge18_25_2013;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female Below 18-25 2014*/
data Appli1.FeAge18_25_2014; 
set appli1.arm2014 appli1.com2014; 
run; 

data Appli1.FeAge18_25_2014; 
set Appli1.FeAge18_25_2014;
keep VAR1 B U R; 
run; 

DATA Appli1.FeAge18_25_2014;
set Appli1.FeAge18_25_2014;
AN=2014;
Age="18-25";
GENDER="Female";
RUN;

data Appli1.FeAge18_25_2014;
set Appli1.FeAge18_25_2014;
ob = _n_;
rename U = SalH; 
rename R = SalMoy;
run;

data Appli1.FeAge18_25_2014;
set Appli1.FeAge18_25_2014;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female Below 18-25 2015*/
data Appli1.FeAge18_25_2015; 
set appli1.arm2015 appli1.com2015; 
run; 

data Appli1.FeAge18_25_2015; 
set Appli1.FeAge18_25_2015;
keep VAR1 B U R; 
run; 

DATA Appli1.FeAge18_25_2015;
set Appli1.FeAge18_25_2015;
AN=2015;
Age="18-25";
GENDER="Female";
RUN;

data Appli1.FeAge18_25_2015;
set Appli1.FeAge18_25_2015;
ob = _n_;
rename U = SalH; 
rename R = SalMoy;
run;

data Appli1.FeAge18_25_2015;
set Appli1.FeAge18_25_2015;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female Below 18-25 2016*/
data Appli1.FeAge18_25_2016; 
set appli1.arm2016 appli1.com2016; 
run; 

data Appli1.FeAge18_25_2016; 
set Appli1.FeAge18_25_2016;
keep VAR1 B U R; 
run; 

DATA Appli1.FeAge18_25_2016;
set Appli1.FeAge18_25_2016;
AN=2016;
Age="18-25";
GENDER="Female";
RUN;

data Appli1.FeAge18_25_2016;
set Appli1.FeAge18_25_2016;
ob = _n_;
rename U = SalH; 
rename R = SalMoy;
run;

data Appli1.FeAge18_25_2016;
set Appli1.FeAge18_25_2016;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female Below 18-25 2017*/
data Appli1.FeAge18_25_2017; 
set appli1.arm2017 appli1.com2017; 
run; 

data Appli1.FeAge18_25_2017; 
set Appli1.FeAge18_25_2017;
keep VAR1 B U R; 
run; 

DATA Appli1.FeAge18_25_2017;
set Appli1.FeAge18_25_2017;
AN=2017;
Age="18-25";
GENDER="Female";
RUN;

data Appli1.FeAge18_25_2017;
set Appli1.FeAge18_25_2017;
ob = _n_;
rename U = SalH; 
rename R = SalMoy;
run;

data Appli1.FeAge18_25_2017;
set Appli1.FeAge18_25_2017;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

data Appli1.Femage18_25Combined; 
set Appli1.FeAge18_25_2012 Appli1.FeAge18_25_2013 Appli1.FeAge18_25_2014 Appli1.FeAge18_25_2015 Appli1.FeAge18_25_2016 Appli1.FeAge18_25_2017;
run;

DATA Appli1.Femage18_25Combined;   
SET Appli1.Femage18_25Combined; 
label SalMoy=Salaire_moyen_18_25_ans;
label SalH=Salaire_moyen_Femme_18_25_ans;
run; 


/* for Female 26-50 2012*/
data Appli1.FeAge26_50_2012; 
set appli1.arm2012 appli1.com2012; 
run; 

data Appli1.FeAge26_50_2012; 
set Appli1.FeAge26_50_2012;
keep VAR1 B V S; 
run; 

DATA Appli1.FeAge26_50_2012;
set Appli1.FeAge26_50_2012;
AN=2012;
Age="26-50";
GENDER="Female";
RUN;

data Appli1.FeAge26_50_2012;
set Appli1.FeAge26_50_2012;
ob = _n_;
rename V = SalH; 
rename S = SalMoy;
run;

data Appli1.FeAge26_50_2012;
set Appli1.FeAge26_50_2012;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female 26-50 2013*/
data Appli1.FeAge26_50_2013; 
set appli1.arm2013 appli1.com2013; 
run; 

data Appli1.FeAge26_50_2013; 
set Appli1.FeAge26_50_2013;
keep VAR1 B V S; 
run; 

DATA Appli1.FeAge26_50_2013;
set Appli1.FeAge26_50_2013;
AN=2013;
Age="26-50";
GENDER="Female";
RUN;

data Appli1.FeAge26_50_2013;
set Appli1.FeAge26_50_2013;
ob = _n_;
rename V = SalH; 
rename S = SalMoy;
run;

data Appli1.FeAge26_50_2013;
set Appli1.FeAge26_50_2013;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female 26-50 2014*/
data Appli1.FeAge26_50_2014; 
set appli1.arm2014 appli1.com2014; 
run; 

data Appli1.FeAge26_50_2014; 
set Appli1.FeAge26_50_2014;
keep VAR1 B V S; 
run; 

DATA Appli1.FeAge26_50_2014;
set Appli1.FeAge26_50_2014;
AN=2014;
Age="26-50";
GENDER="Female";
RUN;

data Appli1.FeAge26_50_2014;
set Appli1.FeAge26_50_2014;
ob = _n_;
rename V = SalH; 
rename S = SalMoy;
run;

data Appli1.FeAge26_50_2014;
set Appli1.FeAge26_50_2014;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female 26-50 2015*/
data Appli1.FeAge26_50_2015; 
set appli1.arm2015 appli1.com2015; 
run; 

data Appli1.FeAge26_50_2015; 
set Appli1.FeAge26_50_2015;
keep VAR1 B V S; 
run; 

DATA Appli1.FeAge26_50_2015;
set Appli1.FeAge26_50_2015;
AN=2015;
Age="26-50";
GENDER="Female";
RUN;

data Appli1.FeAge26_50_2015;
set Appli1.FeAge26_50_2015;
ob = _n_;
rename V = SalH; 
rename S = SalMoy;
run;

data Appli1.FeAge26_50_2015;
set Appli1.FeAge26_50_2015; 
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female 26-50 2016*/
data Appli1.FeAge26_50_2016; 
set appli1.arm2016 appli1.com2016; 
run; 

data Appli1.FeAge26_50_2016; 
set Appli1.FeAge26_50_2016;
keep VAR1 B V S; 
run; 

DATA Appli1.FeAge26_50_2016;
set Appli1.FeAge26_50_2016;
AN=2016;
Age="26-50";
GENDER="Female";
RUN;

data Appli1.FeAge26_50_2016;
set Appli1.FeAge26_50_2016;
ob = _n_;
rename V = SalH; 
rename S = SalMoy;
run;

data Appli1.FeAge26_50_2016;
set Appli1.FeAge26_50_2016;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female 26-50 2017*/
data Appli1.FeAge26_50_2017; 
set appli1.arm2017 appli1.com2017; 
run; 

data Appli1.FeAge26_50_2017; 
set Appli1.FeAge26_50_2017;
keep VAR1 B V S; 
run; 

DATA Appli1.FeAge26_50_2017;
set Appli1.FeAge26_50_2017;
AN=2017;
Age="26-50";
GENDER="Female";
RUN;

data Appli1.FeAge26_50_2017;
set Appli1.FeAge26_50_2017;
ob = _n_;
rename V = SalH; 
rename S = SalMoy;
run;

data Appli1.FeAge26_50_2017;
set Appli1.FeAge26_50_2017;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

data Appli1.Femage26_50Combined; 
set Appli1.FeAge26_50_2012 Appli1.FeAge26_50_2013 Appli1.FeAge26_50_2014 Appli1.FeAge26_50_2015 Appli1.FeAge26_50_2016 Appli1.FeAge26_50_2017; 
run;

DATA Appli1.Femage26_50Combined;    
SET Appli1.Femage26_50Combined;  
label SalMoy=Salaire_moyen_26_50_ans;
label SalH=Salaire_moyen_Femme_25_50_ans;
run; 

/* for Female Above50 2012*/
data Appli1.FeAgeAbove_50_2012; 
set appli1.arm2012 appli1.com2012; 
run; 

data Appli1.FeAgeAbove_50_2012;  
set Appli1.FeAgeAbove_50_2012; 
keep VAR1 B W T; 
run; 

DATA Appli1.FeAgeAbove_50_2012;
set Appli1.FeAgeAbove_50_2012;
AN=2012;
Age="Above 50";
GENDER="Female";
RUN;

data Appli1.FeAgeAbove_50_2012;
set Appli1.FeAgeAbove_50_2012;
ob = _n_;
rename W = SalH; 
rename T = SalMoy;
run;

data Appli1.FeAgeAbove_50_2012;
set Appli1.FeAgeAbove_50_2012;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female Above50 2013*/
data Appli1.FeAgeAbove_50_2013; 
set appli1.arm2013 appli1.com2013; 
run; 

data Appli1.FeAgeAbove_50_2013;  
set Appli1.FeAgeAbove_50_2013; 
keep VAR1 B W T; 
run; 

DATA Appli1.FeAgeAbove_50_2013;
set Appli1.FeAgeAbove_50_2013;
AN=2013;
Age="Above 50";
GENDER="Female";
RUN;

data Appli1.FeAgeAbove_50_2013;
set Appli1.FeAgeAbove_50_2013;
ob = _n_;
rename W = SalH; 
rename T = SalMoy;
run;

data Appli1.FeAgeAbove_50_2013;
set Appli1.FeAgeAbove_50_2013;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female Above50 2014*/
data Appli1.FeAgeAbove_50_2014; 
set appli1.arm2014 appli1.com2014; 
run; 

data Appli1.FeAgeAbove_50_2014;  
set Appli1.FeAgeAbove_50_2014; 
keep VAR1 B W T; 
run; 

DATA Appli1.FeAgeAbove_50_2014;
set Appli1.FeAgeAbove_50_2014;
AN=2014;
Age="Above 50";
GENDER="Female";
RUN;

data Appli1.FeAgeAbove_50_2014;
set Appli1.FeAgeAbove_50_2014;
ob = _n_;
rename W = SalH; 
rename T = SalMoy;
run;

data Appli1.FeAgeAbove_50_2014;
set Appli1.FeAgeAbove_50_2014;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female Above50 2015*/
data Appli1.FeAgeAbove_50_2015; 
set appli1.arm2015 appli1.com2015; 
run; 

data Appli1.FeAgeAbove_50_2015;  
set Appli1.FeAgeAbove_50_2015; 
keep VAR1 B W T; 
run; 

DATA Appli1.FeAgeAbove_50_2015;
set Appli1.FeAgeAbove_50_2015;
AN=2015;
Age="Above 50";
GENDER="Female";
RUN;

data Appli1.FeAgeAbove_50_2015;
set Appli1.FeAgeAbove_50_2015;
ob = _n_;
rename W = SalH; 
rename T = SalMoy;
run;

data Appli1.FeAgeAbove_50_2015;
set Appli1.FeAgeAbove_50_2015;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female Above50 2016*/
data Appli1.FeAgeAbove_50_2016; 
set appli1.arm2016 appli1.com2016; 
run; 

data Appli1.FeAgeAbove_50_2016;  
set Appli1.FeAgeAbove_50_2016; 
keep VAR1 B W T; 
run; 

DATA Appli1.FeAgeAbove_50_2016;
set Appli1.FeAgeAbove_50_2016;
AN=2016;
Age="Above 50";
GENDER="Female";
RUN;

data Appli1.FeAgeAbove_50_2016;
set Appli1.FeAgeAbove_50_2016;
ob = _n_;
rename W = SalH; 
rename T = SalMoy;
run;

data Appli1.FeAgeAbove_50_2016;
set Appli1.FeAgeAbove_50_2016;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

/* for Female Above50 2017*/
data Appli1.FeAgeAbove_50_2017; 
set appli1.arm2017 appli1.com2017; 
run; 

data Appli1.FeAgeAbove_50_2017;  
set Appli1.FeAgeAbove_50_2017; 
keep VAR1 B W T; 
run; 

DATA Appli1.FeAgeAbove_50_2017;
set Appli1.FeAgeAbove_50_2017;
AN=2017;
Age="Above 50";
GENDER="Female";
RUN;

data Appli1.FeAgeAbove_50_2017;
set Appli1.FeAgeAbove_50_2017;
ob = _n_;
rename W = SalH; 
rename T = SalMoy;
run;

data Appli1.FeAgeAbove_50_2017;
set Appli1.FeAgeAbove_50_2017;
where ob > 5; 
rename VAR1 = Code_Geographique; 
rename B = 	Libell_Geographique; 
drop ob;
run;

data Appli1.Femage_Above_50_Combined; 
set Appli1.FeAgeAbove_50_2012 Appli1.FeAgeAbove_50_2013 Appli1.FeAgeAbove_50_2014 Appli1.FeAgeAbove_50_2015 Appli1.FeAgeAbove_50_2016 Appli1.FeAgeAbove_50_2017;
run;

DATA Appli1.Femage_Above_50_Combined;   
SET Appli1.Femage_Above_50_Combined;  
label SalMoy=Salaire_moyen_Above_50_ans;
label SalH=Salaire_moyen_Femme_Above_50_ans;
run; 
/*  ******* */
/* data Appli1.age18_25Combined;  */
/* set Appli1.age18_25Combined;  */
/* rename Salaire_moyen_18_25_ans = SalMoy;  */
/* rename Salaire_moyen_homme_18_25_ans = SalH; */
/* run; */

DATA Appli1.Male_Fem_Age_Combined; 
set Appli1.age18_25Combined Appli1.age26_50Combined Appli1.ageAbove50Combined Appli1.Femage18_25Combined Appli1.Femage26_50Combined Appli1.Femage_Above_50_Combined; 
run; 

data Appli1.Male_Fem_Age_Combined;
set Appli1.Male_Fem_Age_Combined;
if Libell_Geographique = "Libell� g�ographique" Then Delete;
if Libell_Geographique = "LIBGEO" Then delete; 
if Libell_Geographique = " " Then delete;
run;




/* Question15 */
DATA appli1.AllCategory_Combine;
SET appli1.AllCategory_Combine;
run; 

data except3district; 
set appli1.AllCategory_Combine;
del=index(Libell_Geographique,"dissement"); 
if del > 0 then delete;
drop del;
run; 


/* data appli1.all_in1; */
/* set appli1.all_in1; */
/* run;  */
/*  */
/* data delete3district; */
/* set appli1.all_in1; */
/* dele=index(Libell_Geographique,"dissement"); */
/* if dele > 0 then delete;  */
/* drop dele;  */
/* run;  */

data Appli1.Male_Fem_Age_Combined;
set Appli1.Male_Fem_Age_Combined;
run; 

data dele3district; 
set Appli1.Male_Fem_Age_Combined;
delet = index(Libell_Geographique,"dissement");
if delet > 0 then delete; 
drop delet;
run; 

/* Question 16 */
DATA appli1.all_year;
SET appli1.all_year;
Libelecourt=SUBSTR(Libell_Geographique,1,3);
if SUBSTR(Libell_Geographique,1,5) = "Saint" then SUBSTR(Libell_Geographique,1,6)="St-"; 
RUN;

data appli1.AllCategory_Combine;
SET appli1.AllCategory_Combine;
Libelecourt=SUBSTR(Libell_Geographique,1,3);
if SUBSTR(Libell_Geographique,1,5) = "Saint" then SUBSTR(Libell_Geographique,1,6)="St-"; 
RUN;

data Appli1.Male_Fem_Age_Combined;
set Appli1.Male_Fem_Age_Combined;
Libelecourt=SUBSTR(Libell_Geographique,1,3);
if SUBSTR(Libell_Geographique,1,5) = "Saint" then SUBSTR(Libell_Geographique,1,6)="St-"; 
RUN;

/* Question 17 */

PROC SORT DATA=appli1.all_year;
BY Code_Geographique;
RUN;
PROC SORT DATA=appli1.AllCategory_Combine;
BY Code_Geographique;
RUN;
PROC SORT DATA=Appli1.Male_Fem_Age_Combined;
BY Code_Geographique;
RUN;
DATA Appli1.byCode;
MERGE appli1.all_year appli1.AllCategory_Combine Appli1.Male_Fem_Age_Combined;
BY Code_Geographique;
RUN;

/* Question 18 */
data appli1.all_year;
set appli1.all_year;
run; 
data appli1.all_in1;
set appli1.all_in1;
run; 
data Appli1.Male_Fem_Age_Combined;
set Appli1.Male_Fem_Age_Combined;
run; 

data appli1.diffsal;
set appli1.all_in1;
H_MoyDiff = SalH-SalMoy;
H_MoyDiff = round(H_MoyDiff,0.001);
Percent = (SalH/SalMoy)*100;
Percent = round(Percent,0.0001);
run;

data Appli1.Male_Fem_Combined_dif;
set Appli1.Male_Fem_Age_Combined;
H_MoyDiff = SalH-SalMoy;
H_MoyDiff = round(H_MoyDiff,0.001);
Percent = (SalH/SalMoy)*100;
Percent = round(Percent,0.0001);
run;