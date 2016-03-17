var bool : p;
var bool : q;
constraint 
    (p /\ q) == true;

solve satisfy;

output [show(p), "     ",show(q)];