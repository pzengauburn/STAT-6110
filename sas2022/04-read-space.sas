/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022 
 **********************************************************************/

/**********************************************************************
 * read data from a text file using infile statement
 * it is equivalent to datalines 
 **********************************************************************/

filename toad url "http://www.auburn.edu/~zengpen/teaching/STAT-6110/datasets/ToadJump.txt";

data toads;
   infile toad;
   input name $ weight jump1 jump2 jump3;
run;

proc print data = toads; run;

data toads2;
   input name $ weight jump1 jump2 jump3;
datalines;
Lucky 2.3 1.9 . 3.0
Spot 4.6 2.5 3.1 .5
Tubs 7.1 . . 3.8
Hop 4.5 3.2 1.9 2.6
Noisy 3.8 1.3 1.8 1.5
Winner 5.7 . . .
;
run;

proc print data = toads2; run;

/**********************************************************************
 * more than one observation per line
 **********************************************************************/

data dropout;
   input county $ rate @@;
datalines;
 Autauga    40.0  Baldwin    44.6  Barbour    50.9  Bibb       55.3 
 Blount     36.4  Bullock    38.8  Butler     38.6  Calhoun    38.9 
 Chambers   41.6  Cherokee   41.4  Chilton    36.4  Choctaw    31.3 
 Clarke     45.1  Clay       37.0  Cleburne   35.7  Coffee     29.6 
 Colbert    38.8  Conecuh    43.4  Coosa      51.2  Covingto   43.4 
 Crenshaw   33.1  Cullman    38.8  Dale       38.1  Dallas     49.8 
 Dekalb     44.2  Elmore     44.7  Escambia   28.3  Etowah     38.1 
 Fayette    33.5  Franklin   32.1  Geneva     44.3  Greene     56.6 
 Hale       42.8  Henry      52.2  Houston    44.8  Jackson    37.1 
 Jefferso   40.0  Lamar      24.4  Lauderda   38.5  Lawrence   31.6 
 Lee        42.4  Limeston   37.2  Lowndes    41.0  Macon      51.5 
 Madison    39.1  Marengo    32.7  Marion     31.9  Marshall   46.5 
 Mobile     50.0  Monroe     33.9  Montgome   54.7  Morgan     41.7 
 Perry      29.8  Pickens    34.2  Pike       48.4  Randolph   34.5 
 Russell    60.4  Shelby     33.5  St.Clair   48.1  Sumter     34.6 
 Talladeg   48.5  Tallapoo   42.2  Tuscloos   42.9  Walker     35.4 
 Washingt   34.2  Wilcox     38.6  Winston    26.6 
;
proc print data = dropout; run;

/**********************************************************************
 * option firstobs and obs, only read 8 observations
 **********************************************************************/

filename grade url "http://www.auburn.edu/~zengpen/teaching/datasets/grades.txt";

data grades;
   infile grade firstobs = 3 obs = 10;
   input name $ gender $ department $ exam1 exam2;
run;

proc print data = grades; run;

/**********************************************************************
 * option missover
 **********************************************************************/

filename scores url "http://www.auburn.edu/~zengpen/teaching/STAT-6110/datasets/AllScores.txt";

data class102;
   infile scores missover;
   input Name $ Test1 Test2 Test3 Test4 Test5;
run; 

proc print data = class102; run;

/**********************************************************************
 * THE END
 **********************************************************************/
 