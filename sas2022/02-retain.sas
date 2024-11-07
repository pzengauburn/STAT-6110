/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-18-2022 
 **********************************************************************/

/**********************************************************************
 * accumulating total     
 **********************************************************************/

data buy; 
   set sashelp.buy;
   cumsum + amount;
run;

proc print data = buy; run; 

data buy2;
   set sashelp.buy;
   retain cumsum 200000;  
   cumsum + amount;
run;

proc print data = buy2; run; 

/**********************************************************************
 * accumulating total with missing values 
 **********************************************************************/

data example;
   input id y;
datalines;
1 2
1 3
1 .
2 4 
2 5
3 4
;
proc print data = example; run;

data example_sum;
   set example;   
   cumsum + y;
proc print data = example_sum; run;

data example_sum2;
   set example;
   retain cumsum 0;
   cumsum = cumsum + y;
proc print data = example_sum2; run;

/**********************************************************************
 * retain statement      
 **********************************************************************/

data example;
   input month balance; 
datalines;
1 100
2 110
3 .
4 .
5 90 
6 .
;

data example; 
   set example; 
   retain balance_updated;
   if not missing(balance) then balance_updated = balance; 
run; 

proc print data = example; 
run; 

/**********************************************************************
 * THE END
 **********************************************************************/
