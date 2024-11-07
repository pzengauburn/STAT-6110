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
 * proc means: summary statistics 
 **********************************************************************/

proc means data = body; 
   var height weight;
run;

proc means data = body n min max range mean mode nmiss Q1 median Q3 Qrange std stderr sum var clm maxdec = 4;
   var height weight; 
run;

/**********************************************************************
 * proc means: where, class, by  
 **********************************************************************/

proc means data = body n mean std median;
   var height weight; 
   where gender = 'M';
run;

proc means data = body n mean std median;
   class gender;
   var  height weight; 
run;

proc sort data = body; by gender; 
proc means data = body n mean std median;
   by gender;
   var height weight; 
run;

/**********************************************************************
 * proc means: output 
 **********************************************************************/

proc means data = body n mean std median;
   class gender;
   var height weight; 
   output out = summary mean(height weight) = htmean wtmean std(height weight) = htstd wtstd;
run;

proc print data = summary; run;

proc means data = body n mean std median;
   class gender race;
   var height weight; 
   output out = summary2 mean(height weight) = htmean wtmean std(height weight) = htstd wtstd;
run;

proc print data = summary2; run;

/**********************************************************************
 * proc freq  
 **********************************************************************/

proc format;
   value $mygender 'F' = 'Female' 'M' = 'Male';
run;

proc freq data = body nlevels;
   tables gender race;
   format gender $mygender.;
run;

proc freq data = body;
   tables race * gender;
run;

proc freq data = body;
   tables race * gender / crosslist;
run;

proc freq data = body;
   tables race * gender / nocol norow nopercent out = mytable;
run;

proc print data = mytable; run; 

/**********************************************************************
 * check the uniqueness of values using proc freq  
 **********************************************************************/

proc freq data = body noprint; 
   tables SEQN / out = SEQN_table;
run; 

proc freq data = SEQN_table;
   tables count; 
run; 

/**********************************************************************
 * THE END
 **********************************************************************/
