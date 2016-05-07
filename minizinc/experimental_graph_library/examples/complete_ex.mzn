include "../lib/graphs.mzn";

int: N;
array[1..N, 1..N] of int: adj_mat;

constraint complete(adj_mat);

solve satisfy;