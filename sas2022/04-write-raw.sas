/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022 
 **********************************************************************/

/**********************************************************************
 * write data to files, separated by space  
 **********************************************************************/

proc print data = sashelp.buy; run;

filename buytxt "/home/zengpen/buy.txt";

data _null_;
   set sashelp.buy;
   file buytxt;
   put date : mmddyy10. amount : dollar12.2;
run;

/**********************************************************************
 * write data to files, separated by comma 
 **********************************************************************/
 
data _null_;
   set sashelp.buy;
   file buytxt dlm = ',';
   put date : mmddyy10. amount : dollar12.2;
run;

/**********************************************************************
 * write data to files, separated by space, with titles   
 **********************************************************************/

data _null_;
   set sashelp.buy;
   file buytxt;
   if _n_ = 1 then put 'date ' 'amount';
   put date : mmddyy10. amount : dollar12.2;
run;

/**********************************************************************
 * write csv   
 **********************************************************************/

filename buycsv "/home/zengpen/buy.csv";

data _null_;
   set sashelp.buy;
   file buycsv dlm = ',';
   if _n_ = 1 then put 'date,amount';
   put date : mmddyy10. amount : 12.2;
run;

/**********************************************************************
 * write txt, with end option   
 **********************************************************************/

data _null_;
   set sashelp.buy end = ifend;
   file '/home/zengpen/buy.txt';
   if _n_ = 1 then put 'date ' 'amount';
   put date : mmddyy10. amount : dollar12.2;
   if ifend = 1 then put 'Create in SAS 5110/6110.';
run;

/**********************************************************************
 * write txt, formatted report   
 **********************************************************************/

data circulation;
   length state $ 15;
   input state $ morning_copies evening_copies year;
datalines;
Massachusetts 798.4 984.7 1999
Massachusetts 834.2 793.6 1998
Massachusetts 750.3 .     1997
Alabama       .     698.4 1999
Alabama       463.8 522.0 1998
Alabama       583.2 234.9 1997
Alabama       .     339.6 1996
;
proc print data = circulation; run; 

data _null_;
   set circulation; 
   file print notitles;
   put @26 year @53 morning_copies @66 evening_copies;
run;

data _null_;
   set circulation;
   file print notitles;
   put @26 year @53 morning_copies 5.1 @66 evening_copies 5.1;
run; 

/**********************************************************************
 * THE END
 **********************************************************************/
