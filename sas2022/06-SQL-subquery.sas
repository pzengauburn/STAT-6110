/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022
 **********************************************************************/

filename myfile url "http://www.auburn.edu/~zengpen/teaching/datasets/grades.csv";

proc import out = grades datafile = myfile 
   dbms = csv replace;
run;

proc print data = grades; run;

/**********************************************************************
 * find dept-gender combination whose average is larger than 
 * the average of female students in math department
 **********************************************************************/

proc sql;
   select distinct department, gender, mean(exam1) as ex1mean
   from grades
   group by department, gender
   having avg(exam1) >= (select avg(exam1) as exam1ave from grades 
                         where department = 'MATH' and gender = 'F');
quit;

/* equivalent but length one */

proc sql;
   select avg(exam1) as exam1ave 
   from grades 
   where department = 'MATH' and gender = 'F';

   select distinct department, gender, mean(exam1) as ex1mean
   from grades
   group by department, gender
   having avg(exam1) >= 81.5;
quit;

/**********************************************************************
 * THE END
 **********************************************************************/
