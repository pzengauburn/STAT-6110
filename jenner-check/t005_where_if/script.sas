/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 05-24-2024 
 **********************************************************************/

/**********************************************************************
 * examples that where and if statements are exchangable 
 * create a subset containing females who are taller than 62 
 **********************************************************************/

proc print data = sashelp.class; 
run;      /* 5 variables (Name, Sex, Age, Height, Weight) and  19 obs */

data female1; 
   set sashelp.class;
   if sex = "F" and height > 62;
run; 
proc print data = female1; run; 

data female2; 
   set sashelp.class;
   where sex = "F" and height > 62;
run; 
proc print data = female2; run; 

/**********************************************************************
 * multiple where or if statements 
 **********************************************************************/

/* the second where statement replaces the first where statement */
data test1;
   set sashelp.class;
   where sex = "F";    /* this statement is ignored by SAS */
   where height > 62;
run;  /* both males and females taller than 62 */
proc print data = test1; run; 

/* the second if condition and the first if condition */
data test2;
   set sashelp.class;
   if sex = "F";
   if height > 62;  /* same as if sex = "F" and height > 62; */
run;  /* only females taller than 62 */
proc print data = test2; run; 

data test3;
   set sashelp.class;
   where sex = "F";
   if height > 62;  /* same as if sex = "F" and height > 62; */
run;  /* only females taller than 62 */
proc print data = test3; run; 

/**********************************************************************
 * operators only applicable for where statements 
 **********************************************************************/

data ex1;
   set sashelp.class; 
   where height between 57 and 66;  
run; 
proc print data = ex1; run; 

data ex2;
   set sashelp.class; 
   where name contains "Al";  
run; 
proc print data = ex2; run; 

data ex1a;
   set sashelp.class; 
   if height >= 57 and height <= 66;   
run; 
proc print data = ex1a; run; 

data ex2a;
   set sashelp.class; 
   if find(name, "Al") > 0; 
run; 
proc print data = ex2a; run; 

/**********************************************************************
 * use where for SAS procedures 
 **********************************************************************/

proc means data = sashelp.class;
   var height weight; 
   where sex = "M"; 
run;

/**********************************************************************
 * use where as a dataset option 
 **********************************************************************/

proc means data = sashelp.class (where = (sex = "M"));
   var height weight; 
run;

data BMI; 
   set sashelp.class (where = (sex = "M"));
   BMI = weight / (height * height) * 703;
run; 
proc print data = BMI; run; 

/**********************************************************************
 * use if statement with input statement 
 **********************************************************************/

data exam; 
   input name $ sex $ score; 
   if sex = "F";
datalines; 
Alfred  M  85
Alice   F  90
Barbara F  88
Henry   M  82
; 
proc print data = exam; run; 

/**********************************************************************
 * use if statement with newly created variables 
 **********************************************************************/

data example;
   set sashelp.class;
   BMI = weight / (height * height) * 703;
   if BMI < 18.5; 
run;
proc print data = example; run; 

/**********************************************************************
 * use if statement with automatic variables 
 **********************************************************************/

proc sort data = sashelp.class out = class; 
   by sex descending height;
run; 

data tallest_gender;
   set class;
   if first.sex;
   by sex descending height;
run; 

proc print data = tallest_gender; run; 

/**********************************************************************
 * where and if statements behave differently with dataset options 
 **********************************************************************/

proc print data = sashelp.class; run; 

data selected1;
   set sashelp.class (obs = 4); 
   if sex = "F";
run;        /* three observations in selected1 */
proc print data = selected1; run; 

data selected2;
   set sashelp.class (obs = 4); 
   where sex = "F";
run;         /* four observations in selected1 */
proc print data = selected2; run; 

/**********************************************************************
 * where and if statements behave differently when merging datasets  
 **********************************************************************/

data schoolA; 
   input name $ class $ score; 
datalines; 
A math 10 
B history 10 
C science 10 
;
proc print data = schoolA; run; 

data schoolB;
   input name $ class $ score; 
datalines; 
A math 10 
B history 8 
C science 7
;
proc print data = schoolB; run; 

data school_where;
   merge schoolA schoolB;
   by name;
   where score = 10;   /* subset BEFORE merging */
run; 
proc print data = school_where; run; 

data school_if;
   merge schoolA schoolB;
   by name;
   if score = 10;     /* subset after merging */
run; 
proc print data = school_if; run; 

/**********************************************************************
 * THE END
 **********************************************************************/
