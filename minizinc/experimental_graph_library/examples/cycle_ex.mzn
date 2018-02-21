include "../lib/graphs.mzn";

int: N;
array[1..N, 1..N] of 0..50: adj_mat;
array[1..N] of var int: cycle;
var int: cost;
var 1..N: length;

constraint cycle = cycle(adj_mat, cost, length);

solve maximize length;

output[show(cycle) ++ "\nCost: " ++ show(cost) ++ "\nLength: " ++ show(length)];