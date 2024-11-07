/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University 
 * 4-18-2022 
 **********************************************************************/

/**********************************************************************
 * multiple lines for one observation 
 **********************************************************************/

filename file1 url "http://www.auburn.edu/~zengpen/teaching/STAT-6110/datasets/rawdata-ex1.txt";

data address;
   length LName FName $ 20 City $ 25 State $ 2 Phone $ 8;
   infile file1 dlm = ',';
   input LName $ FName $;
   input City $ State $;
   input Phone $;
run;
proc print data = address; run;

data address2;
   length LName FName $ 20 City $ 25 State $ 2 Phone $ 8;
   infile file1 dlm = ',';
   input LName $ FName $ / City $ State $ / Phone $;
run;
proc print data = address2; run;

/**********************************************************************
 * contorl input 
 **********************************************************************/

filename file2 url "http://www.auburn.edu/~zengpen/teaching/STAT-6110/datasets/rawdata-ex2.txt";

data sales;
   length SalesID $ 4 Location $ 3;
   infile file2;
   input SalesID $ Location $ @;
   if Location = 'USA' then
      input SaleDate : mmddyy10. Amount;
   else if location = 'EUR' then
      input SaleDate : date9. Amount : commax8.;
run;
proc print data = sales; run;

data sales2;
   length SalesID $ 4 Location $ 3;
   infile file2;
   input SalesID $ Location $ @;
   if Location = 'USA';
   input SaleDate : mmddyy10. Amount;
run;
proc print data = sales2; run;

/**********************************************************************
 * hierarchical files
 **********************************************************************/

filename file3 url "http://www.auburn.edu/~zengpen/teaching/STAT-6110/datasets/rawdata-ex3.txt";

data dependants (drop = type);
   length type $ 1 LName FName DepName $ 20 relation $ 1;
   retain LName FName;
   infile file3 dlm = ':';
   input type $ @;
   if type = 'E' then
      input LName $ FName $;
   else do;
      input DepName $ relation $;
      output;
   end;
run;
proc print data = dependants; run;

/**********************************************************************
 * example 
 **********************************************************************/

filename file4 url "http://www.auburn.edu/~zengpen/teaching/STAT-6110/datasets/rawdata-ex4.txt";

data insurance (drop = Type DepName Relation);
   length Type $ 1 ID $ 6 DepName $ 20 Relation $ 1;
   retain ID;
   infile file4 dlm = ':' end = LastRec;
   input Type $ @;
   if Type = 'E' then do;
   if _N_ > 1 then output;
      input ID $; 
      Deduct = 0;
   end;
   else do;
      input DepName $ Relation $;
      if Relation = 'C' then Deduct + 25; 
      else Deduct + 50;
   end;
   if LastRec then output;
run;
proc print data = insurance; run;

/**********************************************************************
 * example: VA Lung  
 **********************************************************************/

filename lung url "http://www.auburn.edu/~zengpen/teaching/STAT-6110/datasets/VAlung.txt";

data VALung;
   drop check m;
   retain Therapy Cell;   
   infile lung column = column;
   length Check $ 1;
   label SurvTime  = 'Failure or Censoring Time'
         Kps       = 'Karnofsky Index'
         DiagTime  = 'Months till Randomization'
         Age       = 'Age in Years'
         Prior     = 'Prior Treatment?'
         Cell      = 'Cell Type'
         Therapy   = 'Type of Treatment'
         Treatment = 'Treatment Indicator';
   M = Column;
   input Check $ @@;
   if M > Column then M = 1;
   if Check = 's' | Check = 't' then input @M Therapy $ Cell $;
   else input @M SurvTime Kps DiagTime Age Prior @@;
   if SurvTime > .;
   censor = (SurvTime < 0);
   SurvTime = abs(SurvTime);
   Treatment = (Therapy = 'test');
run; 

proc print data = VAlung; run; 

/**********************************************************************
 * THE END
 **********************************************************************/
