/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022 
 **********************************************************************/

/**********************************************************************
 * first and last       
 **********************************************************************/

filename csvfile url "http://www.auburn.edu/~zengpen/teaching/datasets/grades.csv";

proc import out = grades datafile = csvfile
   dbms = csv replace; 
run;

proc print data = grades; run;

proc sort data = grades; 
   by department descending exam1;
run;

proc print data = grades; run;

data best; 
   set grades; 
   if first.department; 
   by department descending exam1; 
run; 

proc print data = best; run;

/**********************************************************************
 * first and last: check details 
 **********************************************************************/

data grades_updated; 
   set grades; 
   first_department = first.department; 
   last_department = last.department; 
   first_exam1 = first.exam1; 
   last_exam1 = last.exam1; 
   by department descending exam1; 
run;

proc print data = grades_updated; run;

data best; 
   set grades; 
   putlog "Show current values:";
   putlog department = exam1 = first.department = last.department = ;  
   if first.department; 
   by department descending exam1; 
run; 

/**********************************************************************
 * first and last: remove duplicate 
 **********************************************************************/

data dept;
   set grades; 
   keep gender department; 
run;

proc print data = dept; run; 

proc sort data = dept; 
   by gender department; 
run;

data dept_unique;
   set dept;
   by gender department; 
   if first.department;
run;

proc print data = dept_unique; run;

proc sort data = dept out = dept_unique2 noduprecs;
   by gender department; 
run;

proc print data = dept_unique2; run;

/**********************************************************************
 * THE END
 **********************************************************************/
