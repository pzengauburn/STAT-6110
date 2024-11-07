/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022
 **********************************************************************/

/**********************************************************************
 * call symputx 
 **********************************************************************/

data courses; 
   infile datalines dlm = "," dsd;
   input course :$10. title :$40.;
datalines; 
STAT6110,"SAS Programming and Applications"
STAT7020,"Regression Analysis"
STAT7030,"Categorical Data Analysis"
;

proc print data = courses; run; 

/* create 1 macro variable: thiscourse */

data _null_; 
   set courses;
   if course = "STAT6110" then call symputx('thiscourse', title);
run; 

%put This course is &thiscourse; 

/* create 3 macro variables: course1, course2, course3 */

data _null_;
   set courses; 
   call symputx('course' || left(_n_), title);
run;

%put course1 is &course1;
%put course2 is &course2;
%put course3 is &course3; 

/* create 3 macro variables: STAT6110, STAT7020, STAT7030 */

data _null_;
   set courses; 
   call symputx(course, title);
run;

%put STAT6110 is &STAT6110;
%put STAT7020 is &STAT7020;
%put STAT7030 is &STAT7030; 

/**********************************************************************
 * create macro variable using into clause in proc sql 
 **********************************************************************/

filename myfile url "http://www.auburn.edu/~zengpen/teaching/datasets/grades.csv";

proc import out = grades datafile = myfile 
   dbms = csv replace;
run;

proc print data = grades; run;

/* demonstration of into clause */

proc sql;
   select count(*) into: size 
   from grades; 
quit; 

%put sample size is &size; 

/* trimmed option: removing leading and trailing blanks */

proc sql;
   select count(*) into: size2 trimmed 
   from grades; 
quit; 

%put sample size is &size2; 

/* multiple macro */

proc sql; 
   select 
        sum(exam1), 
        mean(exam2) as exam2_mean format = 5.1
   into :exam1_sum trimmed,   
        :exam2_mean trimmed 
   from grades; 
quit; 

%put sum of exam1 is &exam1_sum; 
%put mean of exam2 is &exam2_mean; 

/* a list of macro variables */

proc sql; 
   select distinct department into: dept1-   
   from grades; 
quit; 

%put '&sqlobs' is &sqlobs; 
%put department 1 is &dept1; 
%put department 2 is &dept2; 
%put department 3 is &dept3; 
%put department 4 is &dept4; 

/* concatenate values as a list */

proc sql; 
   select distinct department into: dept_list separated by ','   
   from grades
   order by department; 
quit; 

%put department list is &dept_list; 

/**********************************************************************
 * THE END
 **********************************************************************/
