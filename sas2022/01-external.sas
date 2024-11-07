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

/**********************************************************************
 * import data from blood-pressure.xlsx
 **********************************************************************/

filename myfile2 "/home/zengpen/datasets/blood-pressure.xlsx";

proc import out = blood2 datafile = myfile2 
   dbms = xlsx replace;
run;

proc print data = blood2; run;

/**********************************************************************
 * THE END
 **********************************************************************/
