var bool: p;
var bool: q;
var bool: r;
var bool: result;

constraint 
(p -> q )/\ (p -> r);
constraint result = (p -> r);

solve satisfy;

output[show(result)];