/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022
 **********************************************************************/

filename myfile url "http://www.auburn.edu/~zengpen/teaching/datasets/bodymeasure.csv";

proc import out = bodymeasure 
   datafile = myfile 
   dbms = csv replace;
run;

proc contents data = bodymeasure; run;

/**********************************************************************
 * panel 
 **********************************************************************/

proc sgpanel data = bodymeasure;
   panelby race / columns = 2 rows = 3;
   scatter x = age y = height;
run;

proc sgpanel data = bodymeasure;
   panelby race / columns = 3 rows = 2;
   scatter x = age y = height / group = gender;
run;

/**********************************************************************
 * scatter
 **********************************************************************/

proc contents data = sashelp.iris; run;

proc sgscatter data = sashelp.iris;
   matrix PetalLength PetalWidth SepalLength SepalWidth;
run;

proc sgscatter data = sashelp.iris;
   matrix PetalLength PetalWidth SepalLength SepalWidth / diagonal = (histogram normal);
run;

proc sgscatter data = sashelp.iris;
   plot (PetalLength PetalWidth)  * (SepalLength SepalWidth) / group = species;
run;

/**********************************************************************
 * save image
 **********************************************************************/

ods graphics / imagefmt = jpeg height = 6in width = 8in;

proc sgscatter data = sashelp.iris;
   plot (PetalLength PetalWidth)  * (SepalLength SepalWidth) / group = species;
run;

/**********************************************************************
 * THE END
 **********************************************************************/
