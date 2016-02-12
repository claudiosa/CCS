include "../lib/graphs.mzn";

int: N;
array[1..N, 1..N] of 0..50: adj_mat;
array[1..N] of var int: cycle;
var int: cost;
var 1..N: length;
var float: mean_cost;

constraint cycle = cycle(adj_mat, cost, length);
constraint mean_cost = int2float(cost) / int2float(length);

solve minimize mean_cost;

output[show(cycle) ++ "\nCost: " ++ show(cost) ++ "\nLength: " ++ show(length) ++ "\nMean_cost: " ++ show(mean_cost)];

N=4;
adj_mat = [|
    0, 0, 0, 2,|
    3, 0, 0, 4,|
    0, 5, 0, 0,|
    0, 4, 1, 0 |];