/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022 
 **********************************************************************/

/**********************************************************************
 * do loop 
 **********************************************************************/

data compound; 
   Amount = 50000; 
   Rate = 0.075; 
   Yearly = Amount * Rate; 
   Quarterly + ((Quarterly + Amount) * Rate / 4); 
   Quarterly + ((Quarterly + Amount) * Rate / 4); 
   Quarterly + ((Quarterly + Amount) * Rate / 4);  
   Quarterly + ((Quarterly + Amount) * Rate / 4); 
run;

proc print data = compound; run;

data compound2(drop = Qtr);
   Amount = 50000;
   Rate = 0.075;
   Yearly = Amount * Rate;
   do Qtr = 1 to 4;
      Quarterly + ((Quarterly + Amount) * Rate / 4);
   end;
run;

proc print data = compound2; run;

/**********************************************************************
 * invest
 **********************************************************************/

data invest;
   do Year = 2001 to 2003;
      Capital + 5000;
      Capital + (Capital * 0.075);
   end;
run;  

proc print data = invest; run;

data invest2;
   do Year = 2001 to 2003;
      Capital + 5000;
      Capital + (Capital * 0.075);
	  output;
   end;
run;  

proc print data = invest2; run;

/**********************************************************************
 * do until 
 **********************************************************************/

data invest3;
   do until(Capital > 1000000);
      Year + 1;
      Capital + 5000;
      Capital + (Capital * 0.075);
      output;
   end;
run;

proc print data = invest3; run;

data invest4;
   do Year = 1 to 25 until(Capital > 250000);
      Capital + 5000;
      Capital + (Capital * 0.075);
	  output;
   end;
run;

proc print data = invest4; run;

/**********************************************************************
 * nested loop 
 **********************************************************************/

data invest5 (drop = Quarter);
   do Year = 1 to 5;
      Capital + 5000;
      do Quarter = 1 to 4;
         Capital + (Capital * (0.075/4));
      end;
      output;
   end;
run;
proc print data = invest5; run;

/**********************************************************************
 * different bank 
 **********************************************************************/

data banks;
   input name $ rate;
datalines;
Calhoun  0.0718 
State    0.0721 
National 0.0728 
;
proc print data = banks; run;

data invest6 (drop = Quarter Year);
   set banks;
   Capital = 0;
   do Year = 1 to 5;
      Capital + 5000;
      do Quarter = 1 to 4;
         Capital + (Capital*(Rate / 4));		 
      end;
   end;
run;

proc print data = invest6; run;

/**********************************************************************
 * THE END
 **********************************************************************/
