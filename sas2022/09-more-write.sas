/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022 
 **********************************************************************/

/**********************************************************************
 * write txt, formatted report, more examples    
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
   by state notsorted;
   file print notitles;
   if first.state then put / @7 state @;
   put @26 year @53 morning_copies 5.1 @66 evening_copies 5.1;
run;

data _null_;
   set news.circulation;
   by state notsorted;
   file print notitles;
      /* Set values of accumulator variables to 0 */
      /* at beginning of each BY group.           */
      if first.state then
         do;
            morning_total = 0;
            evening_total = 0;
            put / @7 state @;
         end;
   put @26 year @53 morning_copies 5.1 @66 evening_copies 5.1;

      /* Accumulate separate totals for morning and */
      /* evening circulations.                      */
   morning_total + morning_copies;
   evening_total + evening_copies;

      /* Calculate total circulation at the end of  */
      /* each BY group.                             */

   if last.state then
      do;      
         all_totals = morning_total + evening_total;      
         put @52 '------' @65 '------' /            
             @26 'Total for each category'
             @52 morning_total 6.1 @65 evening_total 6.1 / 
             @35 'Combined total' @59 all_totals 6.1;    
      end;
run;

data _null_;
   set circulation;
   by state notsorted;
   file print notitles footnotes;
   if _n_ = 1 then put @16 'Morning and Evening Newspaper Circulation' //
                       @7  'State' @26 'Year' @51 'Thousands of Copies' /
                       @51 'Morning      Evening'; 
   if first.state then
      do;
         morning_total = 0;
         evening_total = 0;
         put / @7 state @;
      end;
   put @26 year @53 morning_copies 5.1 @66 evening_copies 5.1;
   morning_total + morning_copies;
   evening_total + evening_copies;
   if last.state then
      do;
         all_totals = morning_total + evening_total;
         put @52 '------' @65 '------' /
             @26 'Total for each category'
             @52 morning_total 6.1 @65 evening_total 6.1 /
             @35 'Combined total' @59 all_totals 6.1;
      end;
   footnote 'Preliminary Report';
run;

/**********************************************************************
 * THE END
 **********************************************************************/
