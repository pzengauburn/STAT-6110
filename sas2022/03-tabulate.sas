/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University 
 * 4-18-2022 
 **********************************************************************/

filename myfile url "http://www.auburn.edu/~zengpen/teaching/datasets/bodymeasure.csv";

proc import out = body datafile = myfile 
   dbms = csv replace;
run;

proc contents data = body; run;

/**********************************************************************
 * proc tabulate 
 **********************************************************************/

proc tabulate data = body;   
   class race gender;
   table race all, gender all;
run;

proc tabulate data = body;   
   class race marital gender;
   table race * marital all, gender all;
run;

proc tabulate data = body;   
   var height;
   class race gender;
   table race, gender * (mean std) * height;
run;

proc tabulate data = body;   
   var height;
   class race gender;
   table race, (mean std) * height * gender;
run;

/**********************************************************************
 * proc tabulate with format 
 **********************************************************************/

proc tabulate data = body format = comma6.0;   
   class race gender;
   table race all, gender all / box = 'sample size';
run;

proc format;
   value $mygender 'F' = 'Female' 'M' = 'Male';
run;

proc tabulate data = body;   
   var height;
   class race gender;
   format gender $mygender.;
   table race = '', mean = 'mean height' * height = '' * gender = 'Gender';
run;

proc tabulate data = body;   
   var height weight;
   class race gender;
   format gender $mygender.;
   table race = '', 
         mean = '' * (height = 'Height (inches)' * format = 8.1 
                      weight = 'Weight (pounds)' * format = 8.2) * gender = '' / box = "Mean";
run;

/**********************************************************************
 * THE END
 **********************************************************************/
