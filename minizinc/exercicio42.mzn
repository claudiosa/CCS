var bool: p;
var bool: q;
var bool: r;
var bool: result;

constraint 
(p -> q);
constraint result = (p -> (p /\ q));

solve satisfy;

output[show(result)];