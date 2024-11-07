/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022
 **********************************************************************/

/**********************************************************************
 * example 
 **********************************************************************/

%macro calsummary(mydata, myvar, mystat);
%if %upcase(&mystat) = 'MEAN' 
   %then %do;
     proc means data = &mydata mean;
        var &myvar;
     run;
   %end;
   %else %if  %upcase(&mystat) = 'MEDIAN'
         %then %do;
           proc means data = &mydata median;
              var &myvar;
           run;
		 %end;
		 %else %put the statistics, &mystat, is not supported. use default (mean);
%mend calsummary;

%calsummary(sashelp.buy, amount, 'mean');
%calsummary(sashelp.buy, amount, 'median');
%calsummary(sashelp.buy, amount, 'std');

/**********************************************************************
 * second example 
 **********************************************************************/

%macro calsummary2(mydata, myvar, mystat);
%let statlist = *mean*median*;
%if %upcase(&mystat) = 'MEAN' 
   %then %let mystatcode = mean;
   %else %if  %upcase(&mystat) = 'MEDIAN'
         %then %let mystatcode = median;		 
         %else %do; 
            %let mystatcode = ;
            %put the statistics, &mystat, is not supported. use default (mean);
         %end;

%if %index(&statlist, *&mystatcode*) > 0 %then %do;
proc means data = &mydata &mystatcode;
   var &myvar;
run;
%end;
%mend calsummary2;

%calsummary2(sashelp.buy, amount, 'mean');
%calsummary2(sashelp.buy, amount, 'median');
%calsummary2(sashelp.buy, amount, 'std');

/**********************************************************************
 * print the first five observations for each data set in a library
 **********************************************************************/

%macro printlib(lib = WORK, obs = 5);
   %let lib = %upcase(&lib);
   data _null_;
      set sashelp.vstabvw end = final;
      where libname = "&lib";
      call symputx('dsn'||left(_n_), memname);
      if final then call symputx('totaldsn', _n_);
   run;

   %do i = 1 %to &totaldsn;
      proc print data = &lib..&&dsn&i (obs = &obs);
         title "&lib..&&dsn&i Data Set";
      run;
   %end;
%mend printlib;

%printlib (lib = sashelp);
%printlib ();

proc print data = sashelp.vstabvw; run;

/**********************************************************************
 * macro can be used within a data step 
 **********************************************************************/

%macro find_word(vartxt, var_name, string);
do i = 1 to countw(&vartxt, " ");
   if find(scan(&vartxt, i, " "), &string)
   then &var_name = scan(&vartxt, i, " ");
end;
%mend find_word;

data example;
   length word1 word2 $20;
   input text $25.;
   %find_word(text, word1, "&");
   %find_word(text, word2, "-");
   %find_word(text, word3, "n"); 
   drop i; 
datalines; 
Tom&Jerry  is  a  cartoon
The number is  forty-five
;

proc print data = example; run; 

/**********************************************************************
 * THE END
 **********************************************************************/
