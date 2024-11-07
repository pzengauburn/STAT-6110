/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022
 **********************************************************************/

/**********************************************************************
 * read data arranged in columns
 **********************************************************************/

filename onion url "http://www.auburn.edu/~zengpen/teaching/STAT-6110/datasets/OnionRing.txt";

data sales;
   infile onion;
   input VisitingTeam $ 1-20 ConcessionSales 21-24 BleacherSales 25-28
         OurHits 29-31 TheirHits 32-34 OurRuns 35-37 TheirRuns 38-40;
run;

proc print data = sales; run;

/**********************************************************************
 * you may skip columns
 **********************************************************************/

data sales2;
   infile onion;
   input VisitingTeam $ 1-20 OurRuns 35-37 TheirRuns 38-40;
run;

proc print data = sales2; run;

/**********************************************************************
 * use informat
 **********************************************************************/

data mynumbers;
   input y 8.2;
datalines;
1234    
1234567 
12345678 
1234.56  
;
proc print data = mynumbers; run;

/**********************************************************************
 * use informat
 * note: +1 means skipping one column
 **********************************************************************/

filename pumpkin url "http://www.auburn.edu/~zengpen/teaching/STAT-6110/datasets/Pumpkin.txt";

data contest;
   infile pumpkin;
   input Name $16. Age 3. +1 Type $1. +1 Date mmddyy10.
         (Score1 Score2 Score3 Score4 Score5) (4.1);
run;

proc print data = contest; run;

/**********************************************************************
 * mixing input styles
 **********************************************************************/

filename natpark url "http://www.auburn.edu/~zengpen/teaching/STAT-6110/datasets/NatPark.txt";

data nationalparks;
   infile natpark;
   input ParkName $ 1-22 State $ Year @40 Acreage comma9.;
run;

proc print data = nationalparks; run;

/**********************************************************************
 * option truncover
 **********************************************************************/

filename address url "http://www.auburn.edu/~zengpen/teaching/STAT-6110/datasets/Address.txt";

data homeaddress;
   infile address truncover;
   input Name $ 1-15 Number 16-19 Street $ 22-37;
run;

proc print data = homeaddress; run;

/**********************************************************************
 * THE END
 **********************************************************************/
