include "../lib/graphs.mzn";

int: N;
array[1..N, 1..N] of 0..50: adj_mat;
array[1..N] of var int: cycle;
var int: cost;

constraint cycle = hamiltonian_cycle(adj_mat, cost);

solve minimize cost;

output[show(cycle) ++ "\nCost: " ++ show(cost)];