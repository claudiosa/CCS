% include "../lib/graphs.mzn";


function array [int] of var int: path(array[int,int] of int: graph, int: source, int: target)::promise_total =
let {
  set of int: V = index_set_1of2(graph);
  int: order = card(V);
  set of int: indexes = 1..order;
  array[indexes] of var (V union {-1}): path_array;
  var indexes: path_nodes_count; % the 'size' of the path

  constraint assert(index_set_1of2(graph) = index_set_2of2(graph), "The adjacency matrix is not square", true);
  constraint assert({source, target} subset V, "Source and target must be vertexes", true);

  constraint path_array[1] == source;
  constraint path_array[path_nodes_count] == target;

  constraint forall(i in 2..path_nodes_count) ( graph[ path_array[i-1], path_array[i] ] != 0 );

  constraint forall(i in indexes, where i > path_nodes_count) ( path_array[i] = -1 );

  constraint forall(i,j in indexes, where i<j /\ j<=path_nodes_count) ( path_array[i] != path_array[j] );
} in path_array;


int: N;
array[1..N, 1..N] of 0..50: adj_mat;
%var set of 1..N: x;
array[1..N] of var int: path;

%constraint forall(v in 1..N) (exists_path(adj_mat, 1, v) <-> v in x);

%constraint exists_path(adj_mat, 1, 1) = false;

constraint path = path(adj_mat, 3, 2);

solve satisfy;

output[show(path)];