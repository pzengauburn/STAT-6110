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
 * create data based on query  
 **********************************************************************/

proc sql;
   create table FemaleStudent as 
   select name, gender, department, exam1
   from grades
   where gender = 'F'
   order by exam1 desc;
quit;

proc print data = FemaleStudent; run;

/**********************************************************************
 * describe table   
 **********************************************************************/

proc sql;
   describe table grades; 
quit; 

/**********************************************************************
 * insert rows with set clause 
 **********************************************************************/

proc print data = grades; run; 

proc sql; 
   insert into grades
   set name = "Zack", gender = "M", department = "MATH", exam1 = 89, exam2 = 91 
   set name = "Lilly", gender = "F", exam1 = 77;
quit; 

proc print data = grades; run; 

/**********************************************************************
 * insert rows with value clause 
 **********************************************************************/

proc print data = grades; run; 

proc sql; 
   insert into grades
   values ("Zack", "M", "MATH", 89, 91)
   values ("Lilly", "F", "", 77, .);
quit; 

proc print data = grades; run; 

proc sql; 
   insert into grades (name, gender, exam1)
   values ("Zack", "M", 89)
   values ("Lilly", ".", 77);
quit; 

proc print data = grades; run; 

/**********************************************************************
 * insert rows with select-frome   
 **********************************************************************/

proc print data = grades; run; 

proc sql; 
   create table top as 
   select * from grades where exam1 >= 90; 

   insert into grades  
   select * from top; 

   insert into grades (name, department, exam1)
   select name, department, exam1 from top;
quit; 

proc print data = grades; run; 

/**********************************************************************
 * THE END
 **********************************************************************/
