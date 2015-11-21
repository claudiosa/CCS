*
k-maiores: Seja uma matriz $m \times n$
que contém valores positivos em cada uma das   
suas $n.m$ células. Faça um programa que       
que escolha os $k$ maiores valores, indicando  
a posição onde cada um se encontra na matriz.  
Quanto aos valores de $k$: $1 \le k \le nm$.   
Ou seja, o número de $k$ pode ser a matriz     
inteira.
*/
int: rows;
int: cols;
array[1..rows, 1..cols] of var 0..1: x;
array[1..rows, 1..cols] of int:  cost;

var int: total_cost = sum(i in 1..rows, j in 1..cols) (x[i,j]*cost[i,j]);
int: k = 3; %% se omitido vai pelo TECLADO

rows = 4;
cols = 5;

% added the fifth column
cost = 
[|14,  5, 8,  7, 15,
 | 2, 12, 6,  5,  3,
 | 7,  8, 3,  9,  7,
 | 2,  4, 6, 10,  1
|]
;

%
% UM K qualquer
%
constraint  
 forall(i in 1..rows) (
        sum(j in 1..cols) (x[i,j]) <= k  %valor <=k / pode ser 0
 );

%
% UM K qualquer
%

constraint 
  forall(j in 1..cols) (
        sum(i in 1..rows) (x[i,j]) <= k %valor <=k / pode ser 0
  );

%%% SUM up to k
constraint
  k = sum(i in 1..rows, j in 1..cols) (x[i,j]);


% maximizar custo total
solve maximize total_cost;

output [  if i = 1 /\ j = 1 then "total_cost: " ++ show(total_cost) else " " endif ++
          if j = 1 then "\n" else " " endif ++ show(x[i,j]) | i in 1..rows, j in 1..cols ] ++ ["\n"];

/**************************************
Compiling k_max_2D.mzn
Running k_max_2D.mzn
total_cost: 41
1  0  0  0  1 
0  1  0  0  0 
0  0  0  0  0 
0  0  0  0  0
----------
==========
Finished in 39msec
*/
