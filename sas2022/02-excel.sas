/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University 
 * 4-18-2022 
 **********************************************************************/

/**********************************************************************
 * read a range of cells in an Excel worksheet 
 **********************************************************************/

filename exer "/home/zengpen/datasets/exercise.xlsx"; 
proc import out = short datafile = exer 
   dbms = xlsx replace; 
   range = "activitylevels$B1:D10";
run;

proc print data = short; run; 

/**********************************************************************
 * read worksheets of an excel file  
 **********************************************************************/

libname myxlsx xlsx "/home/zengpen/datasets/exercise.xlsx"; 

proc contents data = myxlsx._all_;
run;

proc print data = myxlsx.activitylevels; run;
proc print data = myxlsx.tests; run;

/**********************************************************************
 * write worksheets to an excel file  
 **********************************************************************/

libname mylib "/home/zengpen/datasets/";

data myxlsx.newSheet;
    set mylib.employees; 
run; 

/**********************************************************************
 * THE END
 **********************************************************************/
