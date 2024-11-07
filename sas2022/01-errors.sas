/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-15-2022 
 **********************************************************************/

/************************************************************/
/**********         a sas code with errors         **********/
/************************************************************/

daat second;
  input 2subject gender $ exam#1 exam2 homework; 
datalines;
10 M 80 84 A
 7 M 85 89 A
 4 F 90 86 B
20 M 82 85 B
25 F 94 94 A
14 F 88 84 C
;

proc print data = second run;

proc means data = second; run;

/************************************************************/
/**********       a sas code without errors        **********/
/************************************************************/

data first;  
  input subject gender $ exam1 exam2 homework $;
datalines;
10 M 80 84 A
 7 M 85 89 A
 4 F 90 86 B
20 M 82 85 B
25 F 94 94 A
14 F 88 84 C
;

proc print data = first; run;

proc means data = first; run;  

/**********************************************************************
 * THE END
 **********************************************************************/
