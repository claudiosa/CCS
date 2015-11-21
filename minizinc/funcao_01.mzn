int: n = 10;
var int: z1;
var int: z2;

function var int: mysquare_F(var int: n) = n*n ;

predicate mysquare_P(int: n, var int: res) = 
          res =  n*n ;

constraint
     z1 = mysquare_F(n) ;

constraint
     mysquare_P(n,z2) ;

solve satisfy;

output [
  "n: ", show(n),"\n",
  "z1: ", show(z1), "\n",
  "z2: ", show(z2), "\n",
   ]; 