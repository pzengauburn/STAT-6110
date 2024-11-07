/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022
 **********************************************************************/

/**********************************************************************
 * output statement 
 **********************************************************************/

data ex1;
   input id $ gender $ x1 x2;
datalines;
A  F  10  20
B  M  30  40
C  F  50  60
D  M  70  80
;
proc print data = ex1; run;

data ex1_new;
   set ex1;
   x = x1; output;
   x = x2; output;
run; 

proc print data = ex1_new; run;

/**********************************************************************
 * multiple data sets 
 **********************************************************************/

data ex1_M ex1_F;
   set ex1;
   if gender = 'F' then output ex1_F;
   if gender = 'M' then output ex1_M;
run;

proc print data = ex1_M; run;
proc print data = ex1_F; run;

data ex1_M2 (drop = gender) ex1_F2 (keep = id x2);
   set ex1;
   if gender = 'F' then output ex1_F2;
   if gender = 'M' then output ex1_M2;
run; 

proc print data = ex1_M2; run;
proc print data = ex1_F2; run;

data ex1_M3 ex1_F3;
   set ex1 (drop = x2);
   if gender = 'F' then output ex1_F3;
   if gender = 'M' then output ex1_M3;
run; 

proc print data = ex1_M3; run;
proc print data = ex1_F3; run;

/**********************************************************************
 * example of _n_ 
 **********************************************************************/

data ex2;
   set ex1;
   n = _n_;
run; 

proc print data = ex2; run;

data ex1_M4 ex1_F4;
   set ex1;
   n = _n_;
   if gender = 'F' then output ex1_F4;
   if gender = 'M' then output ex1_M4;
run; 

proc print data = ex1_M4; run;
proc print data = ex1_F4; run;

/**********************************************************************
 * THE END
 **********************************************************************/
