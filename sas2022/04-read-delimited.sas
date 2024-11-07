/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022
 **********************************************************************/

/**********************************************************************
 * read delimited files
 **********************************************************************/

filename bands url "http://www.auburn.edu/~zengpen/teaching/STAT-6110/datasets/Bands.csv";

data music;
   infile bands dlm = ',' dsd missover;
   input BandName :$30. GigDate :mmddyy10. EightPM NinePM TenPM ElevenPM;
   format GigDate mmddyy10.;   
run;

proc print data = music; run;

/**********************************************************************
 * read delimited files: use informat instead of colon 
 **********************************************************************/

data music2;    
   infile bands dlm = ',' dsd missover;
   informat BandName $30. GigDate mmddyy10.; 
   input BandName $ GigDate EightPM NinePM TenPM ElevenPM;
   format GigDate mmddyy10.;   
run;

proc print data = music2; run;

/**********************************************************************
 * THE END
 **********************************************************************/
