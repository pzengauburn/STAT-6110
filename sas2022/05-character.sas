/**********************************************************************
 * STAT 5110/6110 - SAS Programming and Applications
 * Peng Zeng - Auburn University
 * 4-20-2022 
 **********************************************************************/

/**********************************************************************
 * length
 **********************************************************************/

data ex1;
   input x $ @@;
   len1 = lengthn(x);
   len2 = lengthc(x);
datalines;
abc  ab  a  .
;
proc print data = ex1; run;

/**********************************************************************
 * upcase, propcase, lowcase
 **********************************************************************/

data eight;
   text = 'gOOd mORning';
   text1 = upcase(text);
   text2 = lowcase(text);
   text3 = propcase(text);
proc print data = eight; run;

/**********************************************************************
 * !!
 **********************************************************************/

data four;
   text1 = 'Good';
   text2 = 'Morning';
   text = text1 !! text2;
proc print data = four; run;

/**********************************************************************
 * catx
 **********************************************************************/

ods listing file = "/home/zengpen/output.txt";
data six;
   text1 = '   Good   ';
   text2 = '   Morning   ';
   text3 = '!';
   text4 = text1 !! text2 !! text3;
   text5 = catx(' ', text1, text2, text3);
proc print data = six; run;
ods listing close; 

/**********************************************************************
 * remove characters
 **********************************************************************/

data five;
   text1 = 'Good   ';
   text2 = 'Morning   ';
   text3 = '!';
   text4 = text1 !! text2 !! text3;
   text5 = trim(text1) !! trim(text2) !! text3;
   text6 = trim(text1) !! ' ' !! trim(text2) !! text3;
   text7 = compbl(text4);
   text8 = compress(text4, ' o');
proc print data = five; run;

data five_new;
   text = 'X1,y 2z3';
   text1 = compress(text, , 'a');
   text2 = compress(text, , 'd');
   text3 = compress(text, , 'kd');
   text4 = compress(text, , 's');
   text5 = compress(text, , 'p');
   text6 = compress(text, , 'ps');
proc print data = five_new; run;

/**********************************************************************
 * find 
 **********************************************************************/

data seven;
   text = 'This is a string!';
   pos1 = find(text, 'is');
   pos2 = find(text, ' is');
   pos3 = find(text, 'str');
   pos4 = find(text, 'are');
   pos5 = find(text, 'this');
   pos6 = find(text, 'this', 'I');  /* 'I' tells SAS to ignore character case */
proc print data = seven; run;

/**********************************************************************
 * character functions: scan 
 **********************************************************************/

data three;
   text = 'This is a string!';
   text1 = scan(text, 1, ' ');
   text2 = scan(text, 2, ' ');
   text3 = scan(text, 3, ' ');
   text5 = scan(text, 5, ' ');
   text6 = scan(text, -1, ' ');
   text7 = scan(text, countw(text), " ");
   text8 = scan(text, -1);
proc print data = three; run;

/**********************************************************************
 * character functions: substr 
 **********************************************************************/

data one;
   text = 'This is a string!';
   text1 = substr(text, 1, 4);
   text2 = substr(text, 7, 5);
   text3 = text;
   substr(text3, 6, 2) = 'IS';
proc print data = one; run;

/**********************************************************************
 * character functions: right 
 **********************************************************************/

data two;
   input id $6.;
   rightid = right(id);
   textlast = substr(id, 6, 1);
   textlast2 = substr(right(id), 6, 1);
datalines;
F35102
F123
F4215
;

proc print data = two; run;

/**********************************************************************
 * character functions: tranwrd 
 **********************************************************************/

data nine;
   text = 'Apple Pumpkin Apple';
   text1 = tranwrd(text, 'Apple', 'Pumpkin');
   text2 = tranwrd(text, "Apple", "");
proc print data = nine; run;

/**********************************************************************
 * THE END
 **********************************************************************/
