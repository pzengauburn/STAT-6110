/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022 
 **********************************************************************/

/**********************************************************************
 * round
 **********************************************************************/

data one;
   x1 = round(12.12);
   x2 = round(42.65, 0.1);
   x3 = round(95.13, 10);
proc print data = one; run;

/**********************************************************************
 * ceiling floor int
 **********************************************************************/

data two;
   input x @@;
   xround = round(x);
   xceil = ceil(x);
   xfloor = floor(x);
   xint = int(x);
datalines;
1.2  1.8  -1.2 -1.8
;
proc print data = two; run;

/**********************************************************************
 * variable list
 **********************************************************************/

data example;
   input x1-x4;
   sum1 = sum(x1, x2, x3, x4);
   sum2 = sum(of x1-x4);
   sum3 = sum(of x:); 
   y1 = largest(1, of x1-x4);
   y3 = largest(3, of x1-x4);
datalines;
1 4 3 2
8 6 5 6
;
proc print data = example; run;

/**********************************************************************
 * mathematical function
 **********************************************************************/

data ex1;
   pi = constant('pi');
   e = constant('e');
   x1 = log(e);
   x2 = log10(10);
   x3 = exp(1.0);
proc print data = ex1; run;

/**********************************************************************
 * probability and quantile functions for standard normal distribution
 **********************************************************************/

data one;
   pleft  = cdf('normal', 1.04);
   pright = 1 - cdf('normal', 1.04);
   z0 = probit(0.95);
proc print data = one; run;

/**********************************************************************
 * probability and quantile functions for t distribution
 **********************************************************************/
 
data two;
   pleft = cdf('t', 3.747, 4);   
   pright = 1 - cdf('t', 3.747, 4);
   t0 = tinv(0.95, 5);
proc print data = two; run;

/**********************************************************************
 * probability and quantile functions for F distribution
 **********************************************************************/

data three;
   pright = 1 - cdf('F', 1.54, 12, 10);
   f0 = finv(0.95, 10, 30);
proc print data = three; run;

/**********************************************************************
 * probability and quantile functions for chi-squared distribution
 **********************************************************************/

data four;
   pright = 1 - cdf('chisquare', 19.68, 11);
   c0 = cinv(0.95, 10);
proc print data = four; run;

/**********************************************************************
 * random number
 **********************************************************************/

data ex2;
   x1 = ranuni(0);
proc print data = ex2; run;

data ex3;
   x1 = ranuni(1234567890);
proc print data = ex3; run;

/**********************************************************************
 * THE END
 **********************************************************************/
