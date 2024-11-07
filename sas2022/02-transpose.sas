/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-18-2022 
 **********************************************************************/

/**********************************************************************
 * proc transpose       
 **********************************************************************/

filename csvfile url "http://www.auburn.edu/~zengpen/teaching/datasets/grades.csv";
proc import out = grades datafile = csvfile 
   dbms = csv replace;
run;

proc print data = grades; run;

proc transpose data = grades  
   out = grades_temp;
run;

proc print data = grades_temp; run;

proc sort data = grades; 
   by name gender department; 
proc transpose data = grades name = exam
   out = grades_long (rename = (col1 = score));
   var exam1 exam2; 
   by name gender department; 
run;

proc print data = grades_long; run;

proc transpose data = grades_long out = grades_wide (drop = _name_);
   var score; 
   id exam; 
   by name gender department; 
run;

proc print data = grades_wide; run;

/**********************************************************************
 * THE END
 **********************************************************************/
