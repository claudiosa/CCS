include "vertex_set_fn.mzn";
include "order_fn.mzn";
include "is_adj_matrix_square.mzn";

/*
  Functions related to paths in graphs.
  All the functions (except exists_path) returns a simple path.

  Params:
  graph: an adjacency-matrix representing a graph
  source: the starting vertex
  target: the final vertex
  cost: the value of the sum of all the edges in the path. Can be a decision-variable (optional param)
  length: the number of edges in the path. Can be a decision-variable (optional param)
*/


/**
  Returns true if there is any path in the graph from source to target. Otherwise, returns false.
*/
function var bool: exists_path(array[int,int] of int: graph, int: source, int: target)::promise_total =
  let {
    set of int: V = vertex_set(graph);
    int: order = order(graph);
    array[int] of int: direct_distance = [if i=target then 0 elseif graph[i,target]!=0 then 1 else order+1 endif | i in V];
    array[V] of var 0..2*(order+1): real_distance;

    constraint forall (i in V) (
      real_distance[i] = min( [direct_distance[i]] ++ [real_distance[j]+1 | j in V where graph[i,j]!=0] )
    );

  } in real_distance[source] <= order;


/**
  Returns a path in graph from source to target.
  The returned path is represented by an array, containing the sequence of vertexes that makes up the path.
  The value -1 is used to fill the array after the end of the path.
*/
function array [int] of var int: path(array[int,int] of int: graph, int: source, int: target)::promise_total =
let {
  int: order = order(graph);
  set of int: indexes = 1..order;
  set of int: V = vertex_set(graph);
  array[indexes] of var (V union {-1}): path_array;
  var indexes: path_nodes_count;

  constraint is_adj_matrix_square(graph);
  constraint assert({source, target} subset V, "Source and target must be vertexes", true);

  constraint path_array[1] == source;
  constraint path_array[path_nodes_count] == target;

  constraint forall(i in 2..path_nodes_count) ( graph[ path_array[i-1], path_array[i] ] != 0 );

  constraint forall(i in indexes, where i > path_nodes_count) ( path_array[i] = -1 );

  constraint forall(i,j in indexes, where i<j /\ j<path_nodes_count) ( path_array[i] != path_array[j] );
} in path_array;

/**
  Returns a path in graph from source to target, with the specified cost.
  The returned path is represented by an array, containing the sequence of vertexes that makes up the path.
  The value -1 is used to fill the array after the end of the path.
*/
function array [int] of var int: path(array[int,int] of int: graph, int: source, int: target, var int: cost) =
let {
  int: order = order(graph);
  set of int: indexes = 1..order;
  set of int: V = vertex_set(graph);
  array[indexes] of var (V union {-1}): path_array;
  var indexes: path_nodes_count;

  constraint is_adj_matrix_square(graph);
  constraint assert({source, target} subset V, "Source and target must be vertexes", true);

  constraint path_array[1] == source;
  constraint path_array[path_nodes_count] == target;

  constraint forall(i in 2..path_nodes_count) ( graph[ path_array[i-1], path_array[i] ] != 0 );

  constraint forall(i in indexes, where i > path_nodes_count) ( path_array[i] = -1 );

  constraint forall(i,j in indexes, where i<j /\ j<path_nodes_count) ( path_array[i] != path_array[j] );

  constraint cost = sum(i in 2..path_nodes_count) ( graph[ path_array[i-1], path_array[i] ] ) ;

} in path_array;


/**
  Returns a path in graph from source to target, with the specified cost and length.
  The returned path is represented by an array, containing the sequence of vertexes that makes up the path.
  The value -1 is used to fill the array after the end of the path.
*/
function array [int] of var int: path(array[int,int] of int: graph, int: source, int: target, var int: cost, var int: length) =
let {
  int: order = order(graph);
  set of int: indexes = 1..order;
  set of int: V = vertex_set(graph);
  array[indexes] of var (V union {-1}): path_array;
  var indexes: path_nodes_count;
  
  constraint is_adj_matrix_square(graph);
  constraint assert({source, target} subset V, "Source and target must be vertexes", true);
  constraint assert(dom(length) subset 0..order, "The domain of the length of the path must be [0..order(graph)]", true);
  constraint path_nodes_count = length + 1;

  constraint path_array[1] == source;
  constraint path_array[path_nodes_count] == target;

  constraint forall(i in 2..path_nodes_count) ( graph[ path_array[i-1], path_array[i] ] != 0 );

  constraint forall(i in indexes, where i > path_nodes_count) ( path_array[i] = -1 );

  constraint forall(i,j in indexes, where i<j /\ j<path_nodes_count) ( path_array[i] != path_array[j] );

  constraint cost = sum(i in 2..path_nodes_count) ( graph[ path_array[i-1], path_array[i] ] ) ;
} in path_array;