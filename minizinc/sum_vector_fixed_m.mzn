int: n;
int: m;
n = 7; %% total de elementos
m = 3; %% m itens a serem selecionados

array[1..n] of var 0..1 : x_decision;

function var int:sum_array_1d(array[1..n] of var int: vetor_1d) =
                              sum( i in 1..n ) (vetor_1d[i]);

%% por enquanto 
/* 
 let{
      var int : temp;
      temp = 0; %%%% HUM
    %%  constraint
      forall(i in 1..n)
         temp = temp + vetor_1d[i] %%%% HUM%%%% HUM

     } in temp
   ;
*/
%constraint
%  m == sum( i in 1..n ) (x_decision[i]);

constraint
   m == sum_array_1d( x_decision );

solve satisfy;
output ["x_decision: " ++ show(x_decision) ++ "\n"];


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
