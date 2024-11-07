/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-15-2022 
 **********************************************************************/

/**********************************************************************
 * import data from blood-pressure.csv
 **********************************************************************/

filename myfile1 url "http://www.auburn.edu/~zengpen/teaching/datasets/blood-pressure.csv";

proc import out = blood datafile = myfile1 
   dbms = csv replace;
run;

proc print data = blood; run;

proc print data = blood;  
   var patient systolic;
run;

proc contents data = blood; run;

/***** calculate some descriptive statistics *****/

proc means data = blood;
   var systolic diastolic;
run;

/***** create frequency tables *****/

proc freq data = blood;
   table gender;
run;

/***** sort observations *****/

proc sort data = blood;
   by systolic diastolic;
proc print data = blood; run;

proc sort data = blood;
   by systolic descending diastolic;
proc print data = blood; run;

/**********************************************************************
 * THE END
 **********************************************************************/
