
int: n = 10;
var int: z;

function var int: mysquare( int: n) = n*n ;


constraint
 
	z = mysquare(n)
    ;

solve satisfy;


output [
  "n: ", show(n),"\n",
  "z: ", show(z), "\n",
]; 
