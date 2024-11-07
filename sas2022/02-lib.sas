/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University 
 * 4-18-2022 
 **********************************************************************/

/**********************************************************************
 * use library for permanent data sets 
 **********************************************************************/

libname mylib "/home/zengpen/"; 

/* look for a file named grades.sas7dbat */

data mylib.grades;   
   input name $ sex $ exam1 exam2 exam3;  
datalines;  
aa  M  43  70  81
bb  F  67  93  95
cc  F  83  90  50
dd  M  57  76  92
ee  F  74  48  67
ff  M  52  82  92
;
proc print data = mylib.grades;   
run;

proc contents data = mylib.grades;   
run;

/**********************************************************************
 * access a sas7dbat file 
 **********************************************************************/

libname mylib2 "/home/zengpen/datasets/";

proc print data = mylib2.employees; run; 

/**********************************************************************
 * THE END
 **********************************************************************/
