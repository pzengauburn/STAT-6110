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

filename poke url "http://www.auburn.edu/~zengpen/teaching/datasets/pokemon.csv";

proc import out = pokemon datafile = poke
   dbms = csv replace; 
   guessingrows = 800; 
run;

proc print data = pokemon; run; 

libname mylib "/home/zengpen/datasets";

proc print data = mylib.employees; run; 

/**********************************************************************
 * examples for proc sql 
 **********************************************************************/

proc sql;
   /**** select all female students ****/
   select name, gender, department, exam1
   from grades
   where gender = 'F';
quit; 

proc sql;
   /**** select all female students, ordered by exam1 ****/
   select name, gender, department, exam1
   from grades
   where gender = 'F'
   order by exam1 desc;
quit; 

proc sql;
   /*** select all variables ***/ 
   select *
   from grades;
quit;

proc sql; 
   /*** define a new variable, average ***/ 
   select name, exam1, exam2, (exam1 + exam2) / 2 as average
   from grades;
quit;

proc sql; 
   /*** remove duplicate rows ***/
   select distinct gender, department
   from grades;
quit; 

proc sql;
   /*** use keyword calculated for newly defined variable ***/
   select name, (exam1 + exam2) / 2 as average, calculated average * 2 as sum 
   from grades
   where calculated average > 85;
quit;

proc sql; 
   /*** label and format can be defined for each variable ***/
   select name label = 'Student Name', department, exam1 format = 4.1
   from grades
   where gender = 'F'
   order by exam1 desc;
quit;

proc sql; 
   /*** insert string to improve readability ***/
   select name, 'got', exam1, 'points in Exam 1'
   from grades
   where gender = 'F'
   order by exam1 desc;
quit;

/**********************************************************************
 * coalesce() functions 
 **********************************************************************/

proc sql; 
   select name2, name, coalesce(name2, name) as name_updated
   from pokemon;
quit;

/**********************************************************************
 * summary functions 
 **********************************************************************/

proc sql; 
   /*** calculate means of observations ***/
   select name, exam1, mean(exam1) as ex1mean
   from grades;
quit;

proc sql; 
   /*** calculate means of variables ***/
   select name, exam1, exam2, mean(exam1, exam2) as mean
   from grades;
quit;

proc sql; 
   /* count unique values */ 
   select count (distinct department) as dept_count   
   from grades; 
quit;

/**********************************************************************
 * group by clause 
 **********************************************************************/

proc sql; 
   /*** mean combined with group by ***/
   select name, department, exam1, mean(exam1) as ex1mean
   from grades
   group by department;
quit;

proc sql; 
   select distinct department, gender, 
                   mean(exam1) as ex1mean format = 4.1, 
                   mean(exam2) as ex2mean format = 4.1
   from grades
   group by department, gender;
quit;

proc sql; 
   /*** count function ***/
   select distinct department, gender, count(*) as count
   from grades
   group by department, gender;
quit;

/**********************************************************************
 * having clause 
 **********************************************************************/

proc sql; 
   select distinct department, gender, mean(exam1) as ex1mean
   from grades
   group by department, gender
   having avg(exam1) > 85;
quit;

/**********************************************************************
 * like operator 
 **********************************************************************/

proc sql;
   select LastName, FirstName 
   from mylib.employees 
   where LastName like "H%";

   select LastName, FirstName 
   from mylib.employees 
   where LastName like "H____";
quit; 

/**********************************************************************
 * like operator with escape
 **********************************************************************/

data exone; 
   input name $ JobCode $;
datalines; 
aa1 FA1  
aa2 FB1  
bb1 FA_1 
bb2 FB_1
cc1 FAB1 
cc2 FAC1
;

proc sql; 
   select * from exone 
   where JobCode like "FA_1";

   select * from exone
   where JobCode like "FA/_1" escape "/";
quit; 

/**********************************************************************
 * sounds-like operator 
 **********************************************************************/

proc sql;
   select LastName, FirstName 
   from mylib.employees 
   where LastName =* "HALL";
quit; 

/**********************************************************************
 * THE END
 **********************************************************************/
