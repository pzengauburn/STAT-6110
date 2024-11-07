/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022
 **********************************************************************/

/**********************************************************************
 * A simple macro
 **********************************************************************/

%macro time;
   %put The current time is %sysfunc(time(), time11.2).;
%mend time;

/*** call the macro ***/
%time;

/**********************************************************************
 * A simple macro with parameters
 **********************************************************************/

%macro myprint(mydata, varlist);
   proc print data = &mydata;
      var &varlist;
   run;
%mend myprint;  

%myprint(sashelp.buy, amount);

/**********************************************************************
 * example: Step 1
 **********************************************************************/

data buy; set sashelp.buy; run;
proc print data = buy; run;

proc sql;
   create table buy as 
   select *, mean(amount) as meanamt
   from buy;
quit;

proc print data = buy; run;

/**********************************************************************
 * example: Step 2
 **********************************************************************/

%let dataname = buy;
%let varname = amount;
%let meanname = meanamt;

proc sql;
   create table &dataname as 
   select *, mean(&varname) as &meanname
   from &dataname;
quit;

proc print data = buy; run;

/**********************************************************************
 * example: Step 3
 **********************************************************************/

%macro addmean(dataname, varname, meanname);
proc sql;
   create table &dataname as 
   select *, mean(&varname) as &meanname
   from &dataname;
quit;
%mend addmean;

%addmean(buy, amount, meanamt);
proc print data = buy; run;

/**********************************************************************
 * THE END
 **********************************************************************/
