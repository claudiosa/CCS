int: n = 4; %% cte
var int: z;
var {2,4,3} : x1; %%% vars
var {3,2,4} : x2; %%% vars

%%% cte
function var int: mysquare( int: n )
                   = n*n ;
%%% vars
function var int: my_mult_var(var int: m ,var int: n  )
                  = m * n ;

constraint
 	z == mysquare(n);

constraint
 	z == my_mult_var(x1, x2);

solve satisfy;

output [
  "n: ", show(n),  " x1: ", show(x1),  " x2: ", show(x2),"\n",
  "z: ", show(z), "\n",
]; 
