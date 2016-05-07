include "../lib/graphs.mzn";

int: N;
array[1..N, 1..N] of int: adj_mat;
var set of 1..N: reachable_vertexes;
%array[1..N] of var int: reachable_vertexes;

constraint reachable_vertexes = reachables(adj_mat, 2);
% constraint reachable_vertexes = undirected_reachables(adj_mat, source);

solve satisfy; %maximize card(reachable_vertexes);

output [show(reachable_vertexes)];