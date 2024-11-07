/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022
 **********************************************************************/

/**********************************************************************
 * define a macro variable 
 **********************************************************************/

%let size = 50;
data mydata;
   do i = 1 to &size;
      x = rand('Normal');
      output;
   end;
   drop i;
run;
proc print data = mydata; run;

/**********************************************************************
 * need to use DOUBLE quotation mark 
 **********************************************************************/

title "Current time is &systime, &sysday, &sysdate";
footnote "system is &sysscp";
proc print data = mydata; run;

data myinfo;
   mydate = input("&sysdate", date7.);
   myday = "&sysday";
   myversion = "&sysver";
   format mydate mmddyy10.;
run;
proc print data = myinfo; run;

%put _user_;  /** user defined macro variables **/
%put _all_;   /** all macro variables **/

/**********************************************************************
 * more examples of macro variable  
 **********************************************************************/

options symbolgen; 

%let name= Ed Norton ;
%let name2=' Ed Norton ';
%let title="Joan's Report";
%let start=;
%let sum=3+4;
%let total=0;
%let total=&total+&sum;
%let x=varlist;
%let &x=name age height;

%put "name is &name";   /* double quotation mark */
%put 'name is &name';   /* single quotation mark */
%put  name is &name;    /* no quotation mark */
%put name2 is &name2; 
%put title is &title; 
%put start is &start;
%put sum is &sum;
%put total is &total;
%put x is &x;
%put varlist is &varlist;

/**********************************************************************
 * multiple macro variables  
 **********************************************************************/

%let year = 2020; 
%let month = jan; 
%let lib = mylib; 

%put '&year&month' is &year&month;              
%put 'Y&year&month' is Y&year&month;
%put '&year.jan' is &year.jan;                    
%put '&yearjan' is &yearjan; 
%put '&lib..&year&month' is &lib..&year&month;    /* two dots */
%put '&lib.&year&month' is &lib.&year&month;      /* one dot */
%put '&lib&year&month' is &lib&year&month;        /* no dot */

/**********************************************************************
 * reference indirectly 
 **********************************************************************/

%let a = b;
%let b = c;
%let c = 1;
%let a1 = 2;

option symbolgen; 
%put 'single &' is &a;    /* b */
%put 'double &' is &&a;   /* -> &a -> b */
%put 'triple &' is &&&a;  /* -> &b -> c */
%put '&&a&c' is &&a&c;    /* -> &a1 -> 2 */

/**********************************************************************
 * symget function 
 **********************************************************************/

%let g = 100;
%let SAS = "STAT 5110/6110";
%let R = STAT 6210;
%let subject1 = Mathematics;
%let subject2 = "Statistics";

data example;
   input course $;
   x = symget("g");     /* character */
   y = &g;              /* numeric */ 
   number = symget(course);
   major = symget("subject" !! left(_n_));
datalines; 
SAS 
R
;

proc print data = example; run; 
proc contents data = example; run; 

/**********************************************************************
 * THE END
 **********************************************************************/
