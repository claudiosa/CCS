int: n;
n = 7; %% total de elementos
int: K = 2; %% K > n TOMAR 2 elementos NAO CONTIGUOS

array[1..n] of var 0..1 : x_decision;

array[1..n] of int : v_valor;
v_valor = [3, 4, 15, -77, -9, 100, 1];

var int: total_VALOR;

constraint
  total_VALOR = sum( i in 1..n ) (x_decision[i]* v_valor[i]);

constraint
   K == sum( i in 1..n ) (x_decision[i] );

% minimize or maximize something
%solve satisfy; 
solve maximize total_VALOR;

output [
  "Total_VALOR: " ++ show(total_VALOR) ++"\n"++
   "x_decision: " ++ show( x_decision ) ++ "\n" ];

/*
Respostas:
$ minizinc -a sum_vector_k.mzn
Total_VALOR: 0
x_decision: [0, 0, 0, 0, 0, 0, 0]
----------
Total_VALOR: 3
x_decision: [1, 0, 0, 0, 0, 0, 0]
----------
..........................................
Total_VALOR: 10
x_decision: [0, 0, 0, 0, 1, 0, 1]
----------
Total_VALOR: 13
x_decision: [1, 0, 0, 0, 1, 0, 1]
-----------
Total_VALOR: 14
x_decision: [0, 1, 0, 0, 1, 0, 1]
----------
==========

*/
