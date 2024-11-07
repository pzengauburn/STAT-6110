/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-15-2022
 **********************************************************************/

/***** input data from csv file *****/

filename myfile url "http://www.auburn.edu/~zengpen/teaching/datasets/bodymeasure.csv";

proc import out = body
   datafile = myfile 
   dbms = csv replace;
run;

/***** show the summary information for SAS data ******/

proc contents data = body; run;

/********** find mean and standard deviation of height and weight **********/

proc means data = body;
   var height weight; 
run;

/********** find the frequency table for gender and marital **********/

proc freq data = body;
   table gender marital;
run;

/**********************************************************************
 * THE END
 **********************************************************************/
