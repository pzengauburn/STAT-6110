/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022 
 **********************************************************************/

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
 * from FIPS codes to state names or abbreviations 
 **********************************************************************/

data fips;
   input fips;
   name1 = fipname(fips);
   name2 = fipnamel(fips);
   state = fipstate(fips);
datalines; 
1
3
13
99
;

proc print data = fips; run; 

/**********************************************************************
 * from state abbreviations to state names or FIPS 
 **********************************************************************/

data state;
	input state $;
	fips = stfips(state);
	name1 = stname(state);
	name2 = stnamel(state); 
datalines;
AL
ga
nC
XX
;

proc print data = state; run;

/**********************************************************************
 * from zip code to state names or FIPS 
 **********************************************************************/

data zipcode;
   input zip;
   name1 = zipname(zip); 
   name2 = zipnamel(zip);
   state = zipstate(zip);
   fips = zipfips(zip); 
datalines; 
30022
36849
;

proc print data = zipcode; run; 

/**********************************************************************
 * compute distance between latitude/longitude coordinates or zip codes
 **********************************************************************/

data distance; 
   dist1 = geodist(32.6099, -85.4808, 34.0754, -84.2941, 'm');
   dist2 = zipcitydistance(36849, 30022);
;

proc print data = distance; run; 


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
