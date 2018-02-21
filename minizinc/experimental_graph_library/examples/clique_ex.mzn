include "../lib/graphs.mzn";

int: N;
array[1..N, 1..N] of int: adj_mat;
var set of 1..N: clique_vertexes;
var 1..N: clique_size;

constraint clique_vertexes = clique(adj_mat, clique_size);

solve maximize clique_size;

output["Clique size MAX:" ++ show(clique_size) ++ "\n" ++ "Solution MAX: "++show(clique_vertexes)];

%% TO RUN
%% $ mzn-gecode -d example_data.dzn clique_ex.mzn 
