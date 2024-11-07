/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022
 **********************************************************************/

/**********************************************************************
 * %substr()  
 **********************************************************************/

title1 "Current month is &sysdate";
title2 "Current month is %substr(&sysdate, 3, 3)";
proc print data = sashelp.buy; run;

/**********************************************************************
 * more macro functions 
 **********************************************************************/

%let mycal = 2 + 3;
%let mystring0 = Good Morning Auburn!;
%let mystring1 = 'Good Morning Auburn!';

data myinfo2;
   mymonth = "%substr(&sysdate, 3, 3)";
   ans = &mycal;                              /* 5 */
   index0 = %index(&mystring0, Mor);          /* 6 */
   index1 = %index(&mystring1, Mor);          /* 7 */
   word0 = "%scan(&mystring0, 2)";            /* Morining */
   word1 = "%scan(&mystring1, 3)";            /* Auburn */
proc print data = myinfo2; run;

/**********************************************************************
 * %sysfunc()
 **********************************************************************/

%let string = willIAM SMITH;
%put %sysfunc(propcase(&string));

/**********************************************************************
 * %eval() and %sysevalf()
 **********************************************************************/

%let d1 = %eval(10 + 20);          /* Correct usage */
%let d2 = %eval(10.0 + 20.0);      /* Incorrect usage */
%let d3 = %sysevalf(10.0 + 20.0);  /* correct usage */

%put d1 is &d1; 
%put d3 is &d3; 

%let a = 12.3; 
%let b = 45.6; 
%put The result with sysevalf() is: %sysevalf(&a + &b);  /* 57.9 */
%put The BOOLEAN value is: %sysevalf(&a+&b, boolean);    /*  1 */
%put The CEIL value is: %sysevalf(&a+&b, ceil);          /* 58 */
%put The FLOOR value is: %sysevalf(&a+&b, floor);        /* 57 */
%put The INTEGER value is: %sysevalf(&a+&b, int);        /* 57 */

/**********************************************************************
 * %str() and %nrstr() 
 **********************************************************************/

%let printit = %str(proc print; run;); 
%put printit is "&printit"; 

%let text2 = %str(Joan%'s Report);    
%put text2 is "&text2"; 

%let Jun = 6; 
%let txt1 = %str(May&Jun);      /* May6 */
%let txt2 = %nrstr(May&Jun);    /* May&Jun */
%put txt1 is &txt1; 
%put txt2 is &txt2; 

/**********************************************************************
 * %superq() 
 **********************************************************************/

data _null_;
   call symputx('mv1', 'Smith&Jones');
   call symputx('mv2', '%macro abc;');
run;

%let testmv1 = %superq(mv1);      /* Smith&Jones */
%let testmv2 = %superq(mv2);      /* %macro abc; */
%put Macro variable TESTMV1 is &testmv1;
%put Macro variable TESTMV2 is &testmv2;

/**********************************************************************
 * %bquote() 
 **********************************************************************/

data _null_;
   call symputx('text', "Sally's Seashell Store at Old Towne's Beach");
run;

%put "%bquote(&text)";

/**********************************************************************
 * macro Q-functions
 **********************************************************************/

%let a = one;
%let b = two;
%let c = %nrstr(&a &b);
%put C: &c;                             /* &a &b */
%put With SUBSTR: %substr(&c, 1, 2);    /* one */
%put With QSUBSTR: %qsubstr(&c, 1, 2);  /* &a */

/**********************************************************************
 * THE END
 **********************************************************************/
