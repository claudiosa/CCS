include "../lib/graphs.mzn";

int: N;
%%%int: K = 5; % an estimative of a cost === UNSATISFIABLE=====
var int: K ; % an estimative of a cost
array[1..N, 1..N] of 0..50 : adj_mat;
array[1..N] of var int: hamiltonian_cycle;

%% it will be in a predicate ...HERE the K is boundary for the edges cost
%%hamiltonian_cycle_WITH_COST(array[int,int] of int: graph, array[int] of var int : cicle_array_R,  var int : cost_R ) 
constraint 
     hamiltonian_cycle_WITH_COST(adj_mat, hamiltonian_cycle, K );

solve minimize K;

output["\n One cycle is: "++show(hamiltonian_cycle)++
        " with the cost (edges sums -- minimize or maximize)  " ++ show(K)];


N=5;
adj_mat = 
[|
  0 , 5 , 10, 0 , 1,|
  5 , 0 , 0 , 10, 1,|
  10, 0 , 0 , 2 , 1,|
  0 , 10, 2 , 0 , 1,|
  1 , 1 , 1 , 1 , 0 |];