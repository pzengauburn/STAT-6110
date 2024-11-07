/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-18-2022 
 **********************************************************************/

/**********************************************************************
 * demonstrate keep/drop option and keep/drop statement  
 **********************************************************************/

proc print data = sashelp.baseball; 
run; 

data selected1;
   set sashelp.baseball (keep = name team Salary); 
run;

proc print data = selected1; run; 

data selected2 (keep = name team Salary);
   set sashelp.baseball; 
run;

proc print data = selected2; run; 

data selected3;
   set sashelp.baseball; 
   keep name team Salary; 
run;

proc print data = selected3; run; 

/**********************************************************************
 * demonstrate defining new variables   
 **********************************************************************/

data salary; 
   set sashelp.baseball; 
   salary = salary * 1000;   /* change unit from thousand $ to $ */
   rate = nHome / CrHome;    /* percent of 1986 homerun out of career homerun */
run;

proc print data = salary; run;

/**********************************************************************
 * conditional execution    
 **********************************************************************/

filename myfile1 url "http://www.auburn.edu/~zengpen/teaching/datasets/blood-pressure.csv";

proc import out = blood datafile = myfile1 
   dbms = csv replace;
run;

data bloodnew;
   set blood;
   ave = (systolic + diastolic) / 2;
   if (systolic >= 140) or (diastolic >= 90)
   then high = "T";
   else high = "F";
   if patient in ("CP", "GS", "SB") then selected = 1; 
run;

proc print data = bloodnew; run; 

/**********************************************************************
 * lower and upper case
 **********************************************************************/

data test;
   input name $;
   first = (name = 'ABC'); 
   second = (upcase(name) = 'ABC'); 
   third = (lowcase(name) = 'abc'); 
datalines;
ABC
Abc
abc
;
proc print data = test; run;

/**********************************************************************
 * conditional execution, second example   
 **********************************************************************/

data baseball; 
   set sashelp.baseball; 
   if salary < 190 then group = "less than 190K";
   else if salary < 425 then group = "between 190K and 425K";
   else if salary < 750 then group = "between 425K and 750K";
   else group = "larger than 750K";
run;

proc print data = baseball; run;

data baseball2; 
   length group $25;
   set sashelp.baseball; 
   if missing(salary) then group = "";
   else if salary < 190 then group = "less than 190K";
   else if salary < 425 then group = "between 190K and 425K";
   else if salary < 750 then group = "between 425K and 750K";
   else group = "larger than 750K";
run;

proc print data = baseball2; run;

proc freq data = baseball2; 
    table group; 
run;

/**********************************************************************
 * subset: if     
 **********************************************************************/

/***** delete observations with high = 'T' *****/

data bloodnew2;
   set bloodnew;
   if high = 'T' then delete;
run;

proc print data = bloodnew2; run;

/***** keep observations with systolic > 120 *****/

data bloodnew3;
   set bloodnew;
   if systolic > 120; 
run;

proc print data = bloodnew3; run;

/**********************************************************************
 * subset: where statement or where option    
 **********************************************************************/

data complete; 
   set sashelp.baseball (where = (salary is not missing)); 
run;

proc print data = complete; run; 

data complete; 
   set sashelp.baseball; 
   where salary is not missing; 
run;

proc print data = complete; run; 

proc print data = sashelp.baseball (where = (salary between 500 and 600)); 
run;

proc print data = sashelp.baseball (where = (name contains "And")); 
run;

proc print data = sashelp.baseball (where = (Division not in ("East"))); 
run;

/**********************************************************************
 * THE END
 **********************************************************************/
