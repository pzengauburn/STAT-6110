/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022
 **********************************************************************/

data one;
   input x a $;
datalines;
1 a
1 a
1 b
2 c
3 v
4 e
6 g
;
data two;
   input x b $;
datalines;
1 x 
2 y
3 z
3 v
5 w
;
run; 

/**********************************************************************
 * except: select unique observations in one but not in two
 **********************************************************************/

proc sql;
   select * from one 
   except 
   select * from two;
quit; 

/**********************************************************************
 * except: select all observations in one but not in two 
 **********************************************************************/

proc sql; 
   select * from one 
   except all
   select * from two;
quit; 

/**********************************************************************
 * except with corr, non-matching columns are removed 
 **********************************************************************/

proc sql; 
   select * from one 
   except corr
   select * from two;
quit; 

/**********************************************************************
 * intersect: select all observations in both one and two 
 **********************************************************************/

proc sql; 
   select * from one
   intersect
   select * from two;
quit; 

/**********************************************************************
 * intersect with corr: non-matching columns are removed 
 **********************************************************************/

proc sql; 
   select * from one
   intersect corr
   select * from two;
quit; 

/**********************************************************************
 * union: select all observations in either one or two
 **********************************************************************/

proc sql; 
   select * from one
   union
   select * from two;
quit; 

/**********************************************************************
 * union with corr, non-matching columns are removed
 **********************************************************************/

proc sql; 
   select * from one
   union corr
   select * from two;
quit; 

/**********************************************************************
 * outer union 
 **********************************************************************/

proc sql; 
   select * from one
   outer union
   select * from two;
quit; 

/**********************************************************************
 * outer union with corr 
 **********************************************************************/

proc sql; 
   select * from one
   outer union corr
   select * from two;
quit;

/**********************************************************************
 * THE END
 **********************************************************************/
