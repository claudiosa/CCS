% This is the working function that returns the path array:

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

  constraint forall(i in 2 .. path_nodes_count) ( graph[ path_array[i-1], path_array[i] ] != 0 );

  constraint forall(i in indexes, where i > path_nodes_count) ( path_array[i] = -1 );

  constraint forall(i,j in indexes, where i<j /\ j<path_nodes_count) ( path_array[i] != path_array[j] );
} in path_array;

%----------------------------------------------------

% Two attempts:

/*
function var bool: exists_path(array[int,int] of int: graph, int: source, int: target) =
let {
  set of int: V = index_set_1of2(graph);
  int: order = card(V);
  set of int: indexes = 1..order;
  array[indexes] of var (V union {-1}): path_array;
  var indexes: path_nodes_count; % the 'size' of the path

  constraint assert(index_set_1of2(graph) = index_set_2of2(graph), "The adjacency matrix is not square", true);
  constraint assert({source, target} subset V, "Source and target must be vertexes", true);
}
in
exists(path_nodes_count in indexes) (
  path_array[1] == source /\
  path_array[path_nodes_count] == target /\
  forall(i in 2..path_nodes_count) ( graph[ path_array[i-1], path_array[i] ] != 0 ) /\
  forall(i,j in indexes, where i<j /\ j<path_nodes_count) ( path_array[i] != path_array[j] )
);
*/

/*
predicate exists_path(array[int,int] of int: graph, var int: source, var int: target) =
let {
   set of int: V = index_set_1of2(graph);
}
in (
  if graph[source, target] = 1 then true
  else (exists(x in V, where graph[source,x]=1) (exists_path(graph, x, target)))
  endif
);
*/

%----------------------------------------------------

int: N;
array[1..N, 1..N] of 0..1: adj_mat;
array[1..N] of var int: path;

% constraint path = path(adj_mat, 1, 4); % <- finds out that it is unsatisfiable
constraint exists_path(adj_mat, 1, 4); % <- keep running or crash...

solve satisfy;

% output[show(path)];

%----------------------------------------------------

/* Examaple data: Disconnected graph

1---2---6     4
 \ /          |
  3           5

*/

N=6;
adj_mat = [|
    0, 1, 1, 0, 0, 0, |
    1, 0, 1, 0, 0, 1, |
    1, 1, 0, 0, 0, 0, |
    0, 0, 0, 0, 1, 0, |
    0, 0, 0, 1, 0, 0, |
    0, 1, 0, 0, 0, 0  |];