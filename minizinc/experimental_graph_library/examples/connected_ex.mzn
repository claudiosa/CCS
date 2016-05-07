include "../lib/graphs.mzn";

int: N;
array[1..N, 1..N] of int: adj_mat;

%constraint connected(adj_mat);
constraint strongly_connected(adj_mat);

solve satisfy;
N=4;
adj_mat = 
[| 0, 1, 1, 1
 | 0, 0, 0, 0
 | 0, 0, 0, 0
 | 0, 1, 1, 0|];