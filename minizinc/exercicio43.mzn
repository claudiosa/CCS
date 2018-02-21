var bool: p;
var bool: q;
var bool: r;
var bool: g;
var bool: result;

constraint 
(p -> q )/\ (r -> g);
constraint result = ((p \/ r) -> (q \/ g));

solve satisfy;

output[show(result)];