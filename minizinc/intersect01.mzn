int: n=4;
int: m=5;
int: o=5;
var set of int: x;
var set of int: y;
var set of int: z= x intersect y;
x = { 0, -1, 1, 5};
y = { 0, -5, 10, 8, 3 };


solve satisfy;

output[show(z)];



