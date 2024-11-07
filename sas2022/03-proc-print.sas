/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University 
 * 4-18-2022 
 **********************************************************************/

/**********************************************************************
 * proc contents and print 
 **********************************************************************/

proc contents data = sashelp.demographics; run;

proc print data = sashelp.demographics; run;

/**********************************************************************
 * display selected variables, without obs, with id 
 * where statement 
 **********************************************************************/

proc print data = sashelp.demographics noobs; 
   id name; 
   var region pop; 
   where pop < 50000000; 
run;

/**********************************************************************
 * where statement: more examples 
 **********************************************************************/

proc print data = sashelp.demographics noobs;
   var name region pop;
   where region eq 'WPR';
run;

proc print data = sashelp.demographics noobs;
   var name region pop;
   where pop between 10000000 and 50000000;
run;

proc print data = sashelp.demographics noobs;
   var name region pop;
   where region eq 'WPR' and pop > 50000000;
run;

proc print data = sashelp.demographics noobs;
   var name region pop;
   where name contains 'UNITED';
run;

proc print data = sashelp.demographics noobs;
   var name region pop;
   where name not contains 'A';
run;

proc print data = sashelp.demographics noobs;
   var name region pop;
   where name in ('CANADA', 'CHINA', 'INDIA', 'UNITED STATES');
run;

/**********************************************************************
 * use options to select rows 
 **********************************************************************/

proc print data = sashelp.demographics (where = (name contains 'UNITED'));
   var name region pop;
run;

proc print data = sashelp.demographics (firstobs = 3 obs = 10);
   var name region pop;
run; /* from 3rd to 10th observations */

/**********************************************************************
 * by statement
 **********************************************************************/

proc sort data = sashelp.demographics out = demographics;
   by region; 
run;

proc print data = demographics; 
   var name region pop;
   by region; 
run;

/**********************************************************************
 * sum statement and pageby statement 
 **********************************************************************/

proc print data = demographics;
   var name region pop;
   where pop > 50000000;
   sum pop;
run;

proc print data = demographics;
   var name region pop;
   where pop > 50000000;
   by region; 
   sum pop;
run;

ods pdf file = "/home/zengpen/output.pdf";
proc print data = demographics;
   var name region pop;
   where pop > 50000000;
   by region;
   sum pop;
run;

proc print data = demographics;
   var name region pop;
   where pop > 50000000;
   by region;
   sum pop;
   pageby region;
run;
ods pdf close; 

/**********************************************************************
 * column labels
 **********************************************************************/

proc print data = sashelp.demographics label split = ' ' noobs;
   var name region pop;
   where name not contains 'A';
run;

proc print data = sashelp.demographics label noobs;
   var name region pop;
   label name = 'Name of Country'
         pop = 'Population (2005)';
   where name not contains 'A';
run;

/**********************************************************************
 * title and footnote
 **********************************************************************/

ods pdf file = "/home/zengpen/output2.pdf";
proc print data = sashelp.demographics noobs;
   id name; 
   var name region pop;
   where name not contains 'A';
   title 'List of countries with letter A in the name';
   footnote 'STAT 5110/6110: SAS Example';
run;

options nodate nonumber;
proc print data = sashelp.demographics noobs;
   id name; 
   var region pop;
   where name not contains 'A';
   title1 'List of countries with letter A in the name';
   title2 'SAS Example in STAT 5110/6110';
   footnote1 'Dr. Peng Zeng';
   footnote2 'Department of Mathematics and Statistics';
   footnote3 'Auburn University, Auburn, AL 36849';
run;
ods pdf close; 

/**********************************************************************
 * THE END
 **********************************************************************/
