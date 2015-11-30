include "globals.mzn";
array[1..3] of var int: x;
array[1..7] of var int: y;
var int: a;
var int: b;
var bool: result;
x = [0, 2, 4];
y = [5, 3, 0, 8, 4, 2, 6];

constraint (forall (i in 1..3)(exists(j in 1..7)(
((2*x[i] - y[j]) <= 0)
)))<-> result;

solve satisfy;

output["x:" ++ show(x) ++ "  y:" ++ show(y) ++ "result: " ++ show(result)]; 