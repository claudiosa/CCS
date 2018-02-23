
var -3.0..3.0 : x;
var float : z;
% solve maximize x - exp(x);
solve :: float_search([x], 0.1, input_order, indomain_split, complete) 
maximize z;


constraint 
 z  = x - pow(x,2);
 % -1.0 <= x /\ x <= 3.0


output 
[
   "x: ", show(x), "\n",
   "z: ", show(z), "\n",
]