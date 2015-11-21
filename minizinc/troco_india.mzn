%%%% Comes from India
/*
Decision variables
are like variables in mathematics. They
are declared with a type and the var keyword. Their value is computed by MiniZinc so that they satisfy the model Typically they are declared using a range
or a set rather than a type name
The range or set gives the domain for the variable.
The following are equivalent

var int: i; 
constraint 
     i >= 0; 
constraint 
     i <= 4;
var 0..4: i;
var {0,1,2,3,4}: i;
*/
int: Valor = 30 ;

var {1,3,5,7,9,11,13,15} : M1;
var {1,3,5,7,9,11,13,15} : M2;
var {1,3,5,7,9,11,13,15} : M3;

constraint
     M1 + M2 + M3 = Valor;

%solve minimize  Qt ;
solve satisfy;

output ["  M1:", show(M1), "  M2:", show(M2),
        "  M3:", show(M3) ++"\n" ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%