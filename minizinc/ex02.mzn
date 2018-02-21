var  0..10 : x;
var  0..10 : y;

constraint x > y;
constraint x < 5;

solve satisfy;
output ["VAR_X = ", show(x), "\nVAR_Y = ", show(y) ];
