/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University 
 * 4-18-2022 
 **********************************************************************/

/**********************************************************************
 * values seperated by space 
 **********************************************************************/

filename fspace url "http://www.auburn.edu/~zengpen/teaching/STAT-6110/datasets/state_data.txt";

proc import datafile = fspace out = data_space dbms = dlm replace;
    delimiter = " "; 
run;

proc print data = data_space; run;

/**********************************************************************
 * values seperated by ampersand (&)
 **********************************************************************/

filename fileand url "http://www.auburn.edu/~zengpen/teaching/STAT-6110/datasets/delimiter.txt";

proc import datafile = fileand out = data_and dbms = dlm replace;
    delimiter = "&"; 
run;

proc print data = data_and; run;

/**********************************************************************
 * values seperated by comma, no variable names  
 **********************************************************************/

filename filecsv url "http://www.auburn.edu/~zengpen/teaching/STAT-6110/datasets/boot.csv";

proc import datafile = filecsv out = data_csv dbms = csv replace;
    getnames = no; 
run;

proc print data = data_csv; run;

/**********************************************************************
 * values seperated by tab 
 **********************************************************************/

filename filetab url "http://www.auburn.edu/~zengpen/teaching/STAT-6110/datasets/class.txt";

proc import datafile = filetab out = data_tab dbms = tab replace;
    delimiter = "09"x;  
run;

proc print data = data_tab; run;

/**********************************************************************
 * write an external file 
 **********************************************************************/

libname mylib2 "/home/zengpen/datasets/";
filename outfile "/home/zengpen/employees.csv";

proc export data = mylib2.employees outfile = outfile 
    dbms = csv replace; 
run;

/**********************************************************************
 * THE END
 **********************************************************************/
