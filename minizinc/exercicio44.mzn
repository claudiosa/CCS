var bool: p;
var bool: q;
var bool: r;
var bool: g;
var bool: result;

constraint 
(p -> q )/\ (r -> g);
constraint result = ((not q \/ not g) -> (not p \/ not r));

solve satisfy;

output[show(result)];