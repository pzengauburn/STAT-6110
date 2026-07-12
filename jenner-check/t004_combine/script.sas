/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022
 **********************************************************************/

/**********************************************************************
 * concatenate 
 **********************************************************************/

data one;
   input id y x;
datalines;
1 2 3
3 4 5
5 6 7
;
proc print data = one; run;

data two;
   input id y x;
datalines;
2 3 4
4 5 6
6 7 8
;
proc print data = two; run;

data one_two;
   set one two;
run;

proc print data = one_two; run;

/**********************************************************************
 * concatenate: different variable names
 **********************************************************************/

data three;
   input id y z;
datalines;
2 3 4
4 5 6
6 7 8
;
proc print data = three; run;

data one_three;
   set one three;
run;

proc print data = one_three; run;

data one_three_new;
   set one three (rename = (z = x));
run;

proc print data = one_three_new; run;

data one_three_by;
   set one three (rename = (z = x));
   by id;
run;

proc print data = one_three_by; run;

/**********************************************************************
 * one-to-one reading
 **********************************************************************/

data one_three_2;
   set one;
   set three;
proc print data = one_three_2; run;

/**********************************************************************
 * merge 
 **********************************************************************/

data four;
   input id x u;
datalines;
1 2 3
3 4 5
5 6 7
;
proc print data = four; run;

data one_four;
   merge one four;
   by id;
run;

proc print data = one; run;
proc print data = four; run;
proc print data = one_four; run;

data one_four_new;
   merge one four (rename = (x = x1));
   by id;
run;

proc print data = one_four_new; run;

/**********************************************************************
 * merge (many-to-many)  
 **********************************************************************/

data five;
   input id y;
datalines;
1 2
1 3
1 5
2 4 
2 5
3 4
;
proc print data = five; run;

data six;
   input id x;
datalines;
1 -1
1 -2
2 -3 
2 -4
2 -5
4 -8
;
proc print data = six; run;

data five_six;
   merge five six;
   by id;
run; 
proc print data = five_six; run;

/**********************************************************************
 * merge (with in option)
 **********************************************************************/

data five_six_new;
   merge five (in = infive) six (in = insix);
   by id;
   infiveout = infive;
   insixout = insix;
proc print data = five_six_new; run;

data five_six_left;
   merge five (in = infive) six (in = insix);
   by id; 
   if infive; 
proc print data = five_six_left; run;

data five_six_right;
   merge five (in = infive) six (in = insix);
   by id; 
   if insix; 
proc print data = five_six_right; run;

data five_six_both;
   merge five (in = infive) six (in = insix);
   by id; 
   if infive and insix; 
proc print data = five_six_both; run;

/**********************************************************************
 * THE END
 **********************************************************************/
