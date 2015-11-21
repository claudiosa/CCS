int: n;
int: m;
n = 7; %% total de elementos
m = 3; %% total a serem selecionados

array[1..n] of var 0..1 : x_decision;

constraint
  m = sum( i in 1..n ) (x_decision[i]);


solve satisfy;
output ["x_decision: " ++ show( x_decision ) ++ "\n" ];


/*
Resposta:
$ minizinc -a sum_vector_fixed_m.mzn 
x_decision: [1, 1, 1, 0, 0, 0, 0]
----------
x_decision: [1, 1, 0, 1, 0, 0, 0]
...........................................
x_decision: [0, 0, 0, 1, 0, 1, 1]
----------
x_decision: [0, 0, 0, 0, 1, 1, 1]
----------
==========
*/
