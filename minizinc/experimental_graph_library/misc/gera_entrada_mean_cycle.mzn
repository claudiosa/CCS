include "globals.mzn";

var 1..10: a;
var 1..10: b;
var 1..10: c;
var 1..10: d;
var 1..10: e;

var float: x;
var float: y;
var float: z;

constraint x = (int2float(a) + int2float(b) + int2float(c)) / 3.0;
constraint y = (int2float(c) + int2float(d) + int2float(e)) / 3.0;
constraint z = (int2float(a) + int2float(b) + int2float(d) + int2float(e)) / 4.0;

constraint z < x;
constraint z < y;
constraint x < y - 0.1;

constraint alldifferent([a,b,c,d,e]);

solve minimize a+b+c+d+e; 