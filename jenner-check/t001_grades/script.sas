/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-15-2022 
 **********************************************************************/

/**********************************************************************
 * the first SAS code 
 **********************************************************************/

/* create a SAS dataset with name "grades" */ 

data grades;   
   input name $ sex $ exam1 exam2 exam3;  /* list names of variables */ 
datalines;  
aa  M  43  70  81
bb  F  67  93  95
cc  F  83  90  50
dd  M  57  76  92
ee  F  74  48  67
ff  M  52  82  92
;
/* contents of the dataset are listed after "datalines" */
/* one observation per line, and each column indicates one variable */

/* show contents of the dataset */

proc print data = grades;   
run;

/* compute some descriptive statistics */

proc means data = grades;  
   var exam1 exam2 exam3;
run;

/**********************************************************************
 * THE END
 **********************************************************************/
