/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University 
 * 4-18-2022 
 **********************************************************************/

filename myfile2 url "http://www.auburn.edu/~zengpen/teaching/datasets/grades.csv";

proc import out = grades datafile = myfile2 
   dbms = csv replace;
run;

proc print data = grades; run;

/**********************************************************************
 * proc report 
 **********************************************************************/

proc report data = grades;
   column name gender exam1;
run;

proc format;
   value $mygender 'F' = 'Female' 'M' = 'Male';
run;

proc report data = grades;
   column gender name exam1;
   define name / "Student's Name" width = 15;
   define gender / order 'Gender' width = 8 format = $mygender.;
   define exam1 / 'Exam I';
run;

proc report data = grades headline headskip;
   column department gender exam1;
   define department / group 'Department' width = 12;
   define gender / group 'Gender' width = 8 format = $mygender.;
   define exam1 / mean 'Exam I' width = 8 format = 4.1;
run;

proc report data = grades headline headskip;
   column department gender exam1;
   define department / group 'Department' width = 12;
   define gender / group 'Gender' width = 8 format = $mygender.;
   define exam1 / mean 'Exam I' width = 8 format = 5.0;
   rbreak after / summarize dol;
run;

/**********************************************************************
 * THE END
 **********************************************************************/
