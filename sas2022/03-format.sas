/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University 
 * 4-18-2022 
 **********************************************************************/

/**********************************************************************
 * sas format
 **********************************************************************/

proc contents data = sashelp.buy; run;

proc print data = sashelp.buy; run;

proc print data = sashelp.buy; 
   format amount comma12.2;
run;

proc print data = sashelp.buy; 
   format amount dollar12.2;
run;

/**********************************************************************
 * SAS date
 **********************************************************************/

proc print data = sashelp.buy; 
   format date comma10.2;
run;

proc print data = sashelp.buy; 
   format date mmddyy10.;
run;

proc print data = sashelp.buy; 
   format date date7.;
run;

proc print data = sashelp.buy; 
   format date worddate.;
run;

proc print data = sashelp.buy; 
   format date weekdate.;
run;

/**********************************************************************
 * compare date
 **********************************************************************/

data example;
   set sashelp.buy;
   if date < '1jan2000'd then time = 'new'; else time = 'old';
run; 

proc print data = example; run;

/**********************************************************************
 * user-defined format 
 **********************************************************************/

proc format;
   value mylabel low-<-10000 = 'worse'
                    -10000-0 = 'bad'
                     0<-high = 'good';
run;

proc print data = sashelp.buy; 
   format amount mylabel.; 
run;

/**********************************************************************
 * THE END
 **********************************************************************/
