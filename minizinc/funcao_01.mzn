int: n = 3;
var int: z1;
var int: z2;

function var int: pot_3_F(var int: n) = n*n*n ;

predicate pot_3_P(int: n, var int: res) = 
          res =  n*n*n ;

constraint
     z1 = pot_3_F(n) ;

constraint
     pot_3_P(n,z2) ;

solve satisfy;

output ["n: ", show(n),"\n", "z1: ", show(z1), "\n",
        "z2: ", show(z2), "\n"]; 