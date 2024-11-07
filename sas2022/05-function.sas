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
 * length
 **********************************************************************/

data ex1;
   input x $ @@;
   len1 = lengthn(x);
   len2 = lengthc(x);
datalines;
abc  ab  a  .
;
proc print data = ex1; run;

/**********************************************************************
 * upcase, propcase, lowcase
 **********************************************************************/

data eight;
   text = 'gOOd mORning';
   text1 = upcase(text);
   text2 = lowcase(text);
   text3 = propcase(text);
proc print data = eight; run;

/**********************************************************************
 * !!
 **********************************************************************/

data four;
   text1 = 'Good';
   text2 = 'Morning';
   text = text1 !! text2;
proc print data = four; run;

/**********************************************************************
 * catx
 **********************************************************************/

ods listing file = "/home/zengpen/output.txt";
data six;
   text1 = '   Good   ';
   text2 = '   Moring   ';
   text3 = '!';
   text4 = text1 !! text2 !! text3;
   text5 = catx(' ', text1, text2, text3);
proc print data = six; run;
ods listing close; 

/**********************************************************************
 * remove characters
 **********************************************************************/

data five;
   text1 = 'Good   ';
   text2 = 'Moring   ';
   text3 = '!';
   text4 = text1 !! text2 !! text3;
   text5 = trim(text1) !! trim(text2) !! text3;
   text6 = trim(text1) !! ' ' !! trim(text2) !! text3;
   text7 = compbl(text4);
   text8 = compress(text4, ' o');
proc print data = five; run;

data five_new;
   text = 'X1,y 2z3';
   text1 = compress(text, , 'a');
   text2 = compress(text, , 'd');
   text3 = compress(text, , 'kd');
   text4 = compress(text, , 's');
   text5 = compress(text, , 'p');
   text6 = compress(text, , 'ps');
proc print data = five_new; run;

/**********************************************************************
 * find 
 **********************************************************************/

data seven;
   text = 'This is a string!';
   pos1 = find(text, 'is');
   pos2 = find(text, ' is');
   pos3 = find(text, 'str');
   pos4 = find(text, 'are');
   pos5 = find(text, 'this');
   pos6 = find(text, 'this', 'I');  /* 'I' tells SAS to ignore character case */
proc print data = seven; run;

/**********************************************************************
 * character functions: scan 
 **********************************************************************/

data three;
   text = 'This is a string!';
   text1 = scan(text, 1, ' ');
   text2 = scan(text, 2, ' ');
   text3 = scan(text, 3, ' ');
   text5 = scan(text, 5, ' ');
   text6 = scan(text, -1, ' ');
   text7 = scan(text, countw(text), " ");
   text8 = scan(text, -1);
proc print data = three; run;

/**********************************************************************
 * character functions: substr 
 **********************************************************************/

data one;
   text = 'This is a string!';
   text1 = substr(text, 1, 4);
   text2 = substr(text, 7, 5);
   text3 = text;
   substr(text3, 6, 2) = 'IS';
proc print data = one; run;

/**********************************************************************
 * character functions: right 
 **********************************************************************/

data two;
   input id $6.;
   rightid = right(id);
   textlast = substr(id, 6, 1);
   textlast2 = substr(right(id), 6, 1);
datalines;
F35102
F123
F4215
;

proc print data = two; run;

/**********************************************************************
 * character functions: tranwrd 
 **********************************************************************/

data nine;
   text = 'Apple Pumpkin Apple';
   text1 = tranwrd(text, 'Apple', 'Pumpkin');
   text2 = tranwrd(text, "Apple", "");
proc print data = nine; run;

/**********************************************************************
 * functions on date 
 **********************************************************************/

data example2;
   set sashelp.buy;
   year = year(date);
   month = month(date);
   day = weekday(date);
   quarter = qtr(date);
   today = today();
   format today mmddyy10.;
run; 

proc print data = example2; 
   format date weekdate.;
run;

/**********************************************************************
 * missing
 **********************************************************************/

data one;
   input x $ y;
   if missing(x) then xmiss = 1; else xmiss = 0;
   if missing(y) then ymiss = 1; else ymiss = 0;
datalines;
F  1 
.  2
M  .
M  4
F  .
.  .
;
proc print data = one; run;

/**********************************************************************
 * lag
 **********************************************************************/

data two;
   input x @@;
   xlag = lag(x);
   xlag2 = lag2(x);
   xlag3 = lag3(x);
   xdiff = dif(x);
datalines;
1 2 3 4 5 6
;
proc print data = two; run;

data two_x;
   input x @@;
   if x >= 5 then xlag = lag(x);
datalines;
9 8 7 1 2 12
;
proc print data = two_x; run;

/**********************************************************************
 * input
 **********************************************************************/

data three;
   text1 = '32000';
   text2 = '32,000';
   text3 = '03may2008';
   var1 = input(text1, 5.);
   var2 = input(text2, comma6.);
   var3 = input(text3, date9.);
proc print data = three; run;
proc contents data = three; run;

/**********************************************************************
 * input: be cautious of a mixture of integer and decimal 
 **********************************************************************/

data example;
   input num numch $; 
   wrong = input(numch, 4.1);        /* wrong */
   correct1 = input(numch, 4.);      /* correct */ 
   correct2 = input(numch, best4.);  /* correct */
datalines;
123    123
321    321
11.2   11.2
23.5   23.5
;

proc print data = example; run; 

/**********************************************************************
 * put
 **********************************************************************/

data four;
   nvar1 = 614;
   nvar2 = 55000;
   nvar3 = 366;
   cvar1 = put(nvar1, 3.);
   cvar2 = put(nvar2, dollar7.);
   cvar3 = put(nvar3, date9.);
proc print data = four; run;
proc contents data = four; run;

/**********************************************************************
 * automatic data conversion 
 **********************************************************************/

data ex;
   input char1 $ char2 $ num1 num2;
datalines;
12  34  56  78
90  87  65  43
;

proc print data = ex; run;
proc contents data = ex; run;

data ex2;
   set ex;
   charsum = char1 + char2;  /* character converted to numeric */
   charnum = char1 + num1;   /* character converted to numeric */
   numcon = num1 !! num2;    /* numeric converted to character */
   numchar = char1 !! num2;  /* numeric converted to character */
run;

proc print data = ex2; run; 

/**********************************************************************
 * change type of variables  
 **********************************************************************/

/* it does not work */
data ex;
   set ex;
   char1 = input(char1, 8.);
   num1 = put(num1, 8.);
run; 

proc contents data = ex; run; 

/* create a new variable and rename, drop the old one */
data ex;
   set ex;
   char1num = input(char1, 8.);
   num1ch = put(num1, 8.);
   rename char1num = char1 num1ch = num1;
   drop char1 num1;
run; 

proc print data = ex; run; 
proc contents data = ex; run;

/**********************************************************************
 * THE END
 **********************************************************************/
