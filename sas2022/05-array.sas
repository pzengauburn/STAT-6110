/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022 
 **********************************************************************/

libname mylib '/home/zengpen/datasets';

data donate;
   set mylib.donate;
run;

proc contents data = donate; run;

/**********************************************************************
 * first code 
 **********************************************************************/

data charity; 
   set donate; 
   Qtr1 = Qtr1 * 1.25; 
   Qtr2 = Qtr2 * 1.25;
   Qtr3 = Qtr3 * 1.25; 
   Qtr4 = Qtr4 * 1.25;
run;
proc print data = charity; run;

/**********************************************************************
 * using array
 **********************************************************************/

data charity2 (drop = Qtr); 
   set donate;
   array Contrib{4} Qtr1 Qtr2 Qtr3 Qtr4;
   do Qtr = 1 to 4;
      Contrib{Qtr} = Contrib{Qtr} * 1.25;
   end;
run;
proc print data = charity2; run;

/**********************************************************************
 * calculate percentage
 **********************************************************************/

data percent (drop = Qtr); 
   set donate; 
   Total = sum(of Qtr1-Qtr4); 
   array Contrib{4} Qtr1-Qtr4; 
   array Percent{4}; 
   do Qtr = 1 to 4; 
     Percent{Qtr} = Contrib{Qtr} / Total;
   end; 
run;

proc print data = percent; 
   var ID percent1-percent4;
   format percent1-percent4 percent6.;
run;

/**********************************************************************
 * calculate difference
 **********************************************************************/

data change (drop = i); 
   set donate; 
   array Contrib{4} Qtr1-Qtr4; 
   array Diff{3}; 
   do i = 1 to 3; 
      Diff{i} = Contrib{i+1} - Contrib{i};
   end; 
run;

proc print data = change; run;

/**********************************************************************
 * goal
 **********************************************************************/

data compare(drop = Qtr Goal1-Goal4);
   set donate;
   array Contrib{4} Qtr1-Qtr4;
   array Diff{4};
   array Goal{4} Goal1-Goal4 (10,15,5,10);
   do Qtr = 1 to 4;
      Diff{Qtr} = Contrib{Qtr} - Goal{Qtr};
   end;
run;
proc print data = compare; run;

data compare2(drop = Qtr);
   set donate;
   array Contrib{4} Qtr1-Qtr4;
   array Diff{4};
   array Goal{4} _temporary_ (10,15,5,10);
   do Qtr = 1 to 4;
      Diff{Qtr} = Contrib{Qtr} - Goal{Qtr};
   end;
run;
proc print data = compare2; run;

/**********************************************************************
 * rotate
 **********************************************************************/

data rotate(drop = Qtr1-Qtr4); 
   set donate; 
   array Contrib{4} Qtr1-Qtr4;
   do Qtr = 1 to 4; 
      Amount = Contrib{Qtr}; 
      output; 
   end; 
run;
proc print data = rotate; run;

/**********************************************************************
 * THE END
 **********************************************************************/
