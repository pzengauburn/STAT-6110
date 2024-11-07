/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022
 **********************************************************************/

/**********************************************************************
 * three generations of SAS graphs
 **********************************************************************/

ods listing gpath = '/home/zengpen';

proc print data = sashelp.iris; run;

proc plot data = sashelp.iris;
   plot SepalLength * SepalWidth;
run;

proc gplot data = sashelp.iris;
   plot SepalLength * SepalWidth;
run;

proc sgplot data = sashelp.iris;
   scatter y = SepalLength x = SepalWidth;
run;

/**********************************************************************
 * bar
 **********************************************************************/

filename myfile url "http://www.auburn.edu/~zengpen/teaching/datasets/bodymeasure.csv";

proc import out = bodymeasure 
   datafile = myfile 
   dbms = csv replace;
run;

proc contents data = bodymeasure; run;

proc sgplot data = bodymeasure;
   vbar marital;
   title 'Bar Chart of Marital Status';
   label marital = 'Marital Status';
run;

proc format;
   value $gendername 'F' = 'Female' 'M' = 'Male';
run;

proc sgplot data = bodymeasure;
   vbar marital / group = gender groupdisplay = cluster;
   format gender $gendername.;
   title 'Bar Chart of Marital Status';
   label marital = 'Marital Status';
run;

/**********************************************************************
 * histogram
 **********************************************************************/

proc sgplot data = bodymeasure;
   histogram height;
   density height;
   density height / type = kernel;
   title 'Histogram of Height (cm)';
   label height = 'Standing Height (cm)';
run;

/**********************************************************************
 * boxplot
 **********************************************************************/

proc sgplot data = bodymeasure;
   vbox height / category = race;
   title 'Side-by-side Boxplots of Height (cm)';
run;

proc sgplot data = bodymeasure;
   vbox height / category = race group = gender;
   title 'Side-by-side Boxplots of Height (cm)';
run;

/**********************************************************************
 * scatter plot
 **********************************************************************/

filename grades url "http://www.auburn.edu/~zengpen/teaching/datasets/grades.csv";

proc import out = grades datafile = grades
   dbms = csv replace;
run;

proc print data = grades; run;

proc sgplot data = grades;
   scatter x = exam1 y = exam2; 
   title 'Exam II against Exam I';
run;

proc sgplot data = grades;
   scatter x = exam1 y = exam2 / group = gender datalabel = name; 
   title 'Exam II against Exam I';
run;

/**********************************************************************
 * dot plot
 **********************************************************************/

data body_new;
   set bodymeasure;
   heightclass = round(height, 5);

proc sgplot data = body_new;
   dot heightclass / response = weight stat = mean limitstat = clm;
run;

/**********************************************************************
 * series plot
 **********************************************************************/

data electricity;
   input time kWh @@;
datalines;
0 .22 1 .15 2 .17 3 .18 4 .19 5 .23
6 .5 7 .63 8 .61 9 .6 10 .48 11 .45
12 .44 13 .44 14 .39 15 .35 16 .42 17 .47
18 .7 19 .66 20 .7 21 .69 22 .6 23 .4
;
proc print data = electricity; run;

proc sgplot data = electricity;
   series x = time y = kWh / markers;
   title 'Hourly Use of Electricity';
run;

/**********************************************************************
 * fitted curves
 **********************************************************************/

proc sgplot data = grades;
   reg x = exam1 y = exam2 / group = gender; 
   title 'Exam II against Exam I';
run;

proc sgplot data = grades;
   loess x = exam1 y = exam2 / group = gender; 
   title 'Exam II against Exam I';
run;

proc sgplot data = grades;
   pbspline x = exam1 y = exam2 / group = gender; 
   title 'Exam II against Exam I';
run;

/**********************************************************************
 * control axes
 **********************************************************************/

proc sgplot data = grades;
   scatter x = exam1 y = exam2 / group = gender; 
   xaxis label = 'score of Exam I';
   yaxis label = 'score of Exam II';
   refline 85 / axis = x  transparency = 0.5;
   refline 80 90 / axis = y label = ('B cutpoint' 'A cutpoint') transparency = 0.5;
   title 'Exam II against Exam I';
run;

/**********************************************************************
 * legend
 **********************************************************************/

proc sgplot data = grades;
   scatter x = exam1 y = exam2 / group = gender; 
   xaxis label = 'score of Exam I';
   yaxis label = 'score of Exam II';
   keylegend / title = 'Gender' location = inside position = bottomleft;
   inset 'STAT 5110/6110' 'Instructor: Dr. Zeng' / border position = topright;
   title 'Exam II against Exam I';
run;

/**********************************************************************
 * legend
 **********************************************************************/

proc sgplot data = grades;
   reg x = exam1 y = exam2 / group = gender 
                             markerattrs = (symbol = triangle size = 2mm)
                             lineattrs = (color = blue thickness = 5px pattern = dash); 
   keylegend / title = 'Gender' location = inside position = bottomright;
   xaxis label = 'score of Exam I' labelattrs = (style = italic);
   yaxis label = 'score of Exam II' labelattrs = (weight = bold);
   title bold 'Exam II against Exam I';
run;

/**********************************************************************
 * THE END
 **********************************************************************/
