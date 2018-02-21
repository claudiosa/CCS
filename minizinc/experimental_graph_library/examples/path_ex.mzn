include "../lib/graphs.mzn";

int: N;
array[1..N, 1..N] of 0..50: adj_mat;
array[1..N] of var int: path;
var int: cost;
var 1..N: length;

% constraint exists_path(adj_mat, 3, 2);
constraint path = path(adj_mat, 1, 2, cost, length);

solve minimize cost;
% solve satisfy;

output[show(path) ++ "\nCost: " ++ show(cost) ++ "\nLength: " ++ show(length)];