/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-18-2022
 *
 * Jenner compatibility bundle note: the upstream script fetches its
 * input over the network (filename myfile url ".../bodymeasure.csv";
 * proc import ... dbms = csv;). This bundle inlines the same 35-row
 * sample (already checked into this repo's datasets/bodymeasure.csv)
 * as DATALINES instead, so the bundle is fully self-contained and the
 * SAS runner (which sends only script text, never data files) can run
 * it unmodified. Every PROC step below is byte-identical to the
 * original.
 **********************************************************************/

data body;
   length race $25 marital $25 gender $1;
   infile datalines dsd dlm=',' missover;
   input SEQN age edukid eduadult incomehouse weight recumbent height
         leg armlength armcircum waist triceps subscapular
         race marital gender;
datalines;
51624,34,,3,6,87.4,,164.7,41.5,40,36.4,100.4,16.4,24.9,Non-Hispanic White,married,M
51878,75,,3,6,88.3,,173.1,41.2,37.7,36.8,107.4,17,17.6,Non-Hispanic White,married,M
52129,74,,2,4,78.8,,171.9,40.8,37.1,31.1,106,14,16.8,Non-Hispanic White,married,M
52383,2,,,5,14.1,91.6,91.3,,18.2,15.7,49,7.5,5.9,Other Hispanic,,M
52650,36,,3,14,117.5,,183.1,40.5,,,119,,,Non-hispanic Black,divorced,M
52919,80,,4,15,61.8,,160,33.5,36,25,86,19.8,13,Non-Hispanic White,widowed,F
53182,62,,4,15,71.9,,165.3,34.8,34.9,32.7,95,16.2,35.6,Other,married,M
53453,33,,1,2,52.1,,151.6,33.5,31.8,28.5,81.2,26.6,19.4,Mexican American,separated,F
53715,74,,4,6,76.7,,160.5,33.8,39.5,33.9,105,20.4,23.4,Non-Hispanic White,widowed,F
53973,35,,1,7,72,,162.8,37.3,37.6,33,91.8,11,19.2,Mexican American,living with partner,M
54239,70,,3,6,104.1,,176.6,43.2,37.4,33.2,124.2,6,17.4,Other Hispanic,living with partner,M
54499,15,9,,15,57.7,,150.3,,,,,,,Non-Hispanic White,,F
54765,10,4,,8,31.1,,145.2,32.3,30.6,19.5,59.4,6.8,5,Mexican American,,M
55029,9,3,,15,29,,135.9,,,,,,,Non-Hispanic White,,F
55297,68,,3,12,59.1,,149.1,34.1,33.3,30.1,90.9,27.6,25,Non-Hispanic White,married,F
55542,9,2,,1,50.9,,146.8,,,,,,,Non-hispanic Black,,F
55813,45,,4,6,68.4,,169.5,41.5,36,32.4,89.1,13.4,19.4,Non-Hispanic White,married,M
56081,31,,3,6,73,,164.9,39.7,34.4,32.8,86.8,27,23.6,Non-Hispanic White,living with partner,F
56340,9,3,,7,23.3,,128.3,30,27.7,16.3,53,5,5.2,Non-hispanic Black,,M
56607,29,,4,8,75.7,,164.9,41.6,37,33,99,35,36.2,Non-Hispanic White,married,F
56868,33,,5,6,101.9,,171.9,39,40,37.9,114.7,35,,Other Hispanic,married,F
57136,49,,4,7,111.9,,190.7,44.5,41.6,35,117,,,Non-Hispanic White,divorced,M
57396,45,,4,7,137.9,,191.8,47.5,43.3,39.8,127.3,23,26,Non-Hispanic White,married,M
57657,14,8,,5,69.8,,156.9,38.3,34,29.6,81.5,23,18.7,Non-hispanic Black,,F
57917,54,,2,12,73.8,,169.9,38.5,40,32.5,92,14.2,,Non-hispanic Black,never married,M
58179,12,5,,6,42.9,,159.2,39,34,23.3,63.5,14.6,6.9,Non-Hispanic White,,F
58440,74,,4,8,69.9,,172.9,32.8,37,28.5,93.5,16.8,18.6,Non-Hispanic White,married,F
58713,2,,,15,15.3,,101.8,,20.6,15.2,50.7,8.2,4.2,Other Hispanic,,M
58973,8,1,,8,22.1,,125.3,28.5,24.9,16.8,51.8,7,4.3,Other Hispanic,,M
59232,70,,2,6,81,,174.5,40.2,38.3,30.8,100.7,13.3,26.4,Non-Hispanic White,married,M
59492,8,1,,3,25.5,,123.7,28.3,26.5,20,63.5,10.4,13,Non-Hispanic White,,M
59759,32,,4,14,85.7,,164.1,38.7,38.5,33.4,101,34.8,33.6,Non-hispanic Black,living with partner,F
60021,11,6,,5,73.5,,163.6,40.5,36,30.1,90.6,13.4,16.2,Non-hispanic Black,,F
60284,17,11,,15,70.9,,176,42.3,38.4,30.3,80.5,11,11.6,Other,,M
60554,4,,,2,17,,107.4,,,,,,,Non-hispanic Black,,F
;
run;

proc contents data = body; run;

/**********************************************************************
 * proc means: summary statistics
 **********************************************************************/

proc means data = body;
   var height weight;
run;

proc means data = body n min max range mean mode nmiss Q1 median Q3 Qrange std stderr sum var clm maxdec = 4;
   var height weight;
run;

/**********************************************************************
 * proc means: where, class, by
 **********************************************************************/

proc means data = body n mean std median;
   var height weight;
   where gender = 'M';
run;

proc means data = body n mean std median;
   class gender;
   var  height weight;
run;

proc sort data = body; by gender;
proc means data = body n mean std median;
   by gender;
   var height weight;
run;

/**********************************************************************
 * proc means: output
 **********************************************************************/

proc means data = body n mean std median;
   class gender;
   var height weight;
   output out = summary mean(height weight) = htmean wtmean std(height weight) = htstd wtstd;
run;

proc print data = summary; run;

proc means data = body n mean std median;
   class gender race;
   var height weight;
   output out = summary2 mean(height weight) = htmean wtmean std(height weight) = htstd wtstd;
run;

proc print data = summary2; run;

/**********************************************************************
 * proc freq
 **********************************************************************/

proc format;
   value $mygender 'F' = 'Female' 'M' = 'Male';
run;

proc freq data = body nlevels;
   tables gender race;
   format gender $mygender.;
run;

proc freq data = body;
   tables race * gender;
run;

proc freq data = body;
   tables race * gender / crosslist;
run;

proc freq data = body;
   tables race * gender / nocol norow nopercent out = mytable;
run;

proc print data = mytable; run;

/**********************************************************************
 * check the uniqueness of values using proc freq
 **********************************************************************/

proc freq data = body noprint;
   tables SEQN / out = SEQN_table;
run;

proc freq data = SEQN_table;
   tables count;
run;

/**********************************************************************
 * THE END
 **********************************************************************/
