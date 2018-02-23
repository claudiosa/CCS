include "vertex_set_fn.mzn";
include "order_fn.mzn";
include "is_adj_matrix_square.mzn";

/*
  Functions related to cycles in graphs.
  All the functions (except exists_cycle) returns a simple cycle.

  Params:
  graph: an adjacency-matrix representing a graph
  cost: the value of the sum of all the edges in the cycle. Can be a decision-variable (optional param)
  length: the number of edges in the cycle. Can be a decision-variable (optional param)

  Issues:
  - The size of the cycle array should be exactly equals to the size of the cycle, instead of using -1s to denote the end of the cycle
*/


/**
  Returns true if there is any cycle in the graph from source to target. Otherwise, returns false.
*/
function var bool: exists_cycle(array[int,int] of int: graph) =
let {
  int: order = order(graph);
  set of int: indexes = 1..order;
  set of int: V = vertex_set(graph);
  array[indexes] of var (V union {-1}): cycle_array;
  var indexes: length;
  var V: source;
  var V: target;
}
in (
  is_adj_matrix_square(graph)    /\
  cycle_array[1] == source       /\
  cycle_array[length] == target  /\
  graph[target,source] != 0      /\
  forall(i in 2..length) (
   graph[ cycle_array[i-1], cycle_array[i] ] != 0 ) /\
     forall(i,j in indexes, where i<j /\ j<=length) ( 
      cycle_array[i] != cycle_array[j] )
);

/**
  Returns a cycle of the graph.
  The returned cycle is represented by an array, containing the sequence of vertexes that makes up the cycle.
  The value -1 is used to fill the array after the end of the cycle.
  If the cycle has more than one vertex, then the last vertex in the array is not equals to the first one, but they are connected by an edge.
*/
function array [int] of var int: cycle(array[int,int] of int: graph)::promise_total =
let {
  int: order = order(graph);
  set of int: indexes = 1..order;
  set of int: V = vertex_set(graph);
  array[indexes] of var (V union {-1}): cycle_array;
  var indexes: length;
  var V: source;
  var V: target;

  constraint is_adj_matrix_square(graph);

  constraint cycle_array[1] == source;
  constraint cycle_array[length] == target;
  constraint graph[target,source] != 0;

  constraint 
      forall(i in 2..length) (
         graph[ cycle_array[i-1], cycle_array[i] ] != 0 );

  constraint 
      forall(i in indexes, where i > length) ( 
         cycle_array[i] = -1 );

  constraint 
      forall(i,j in indexes, where i<j /\ j<=length) (
         cycle_array[i] != cycle_array[j] );
} in cycle_array;


/**
  Returns a cycle of the graph with the specified cost.
  The returned cycle is represented by an array, containing the sequence of vertexes that makes up the cycle.
  The value -1 is used to fill the array after the end of the cycle.
  If the cycle has more than one vertex, then the last vertex in the array is not equals to the first one, but they are connected by an edge.
*/

function array [int] of var int: cycle(array[int,int] of int: graph, var int: cost)::promise_total =
let {
  int: order = order(graph);
  set of int: indexes = 1..order;
  set of int: V = vertex_set(graph);
  array[indexes] of var (V union {-1}): cycle_array;
  var indexes: length;
  var V: source;
  var V: target;

  constraint is_adj_matrix_square(graph);

  constraint cycle_array[1] == source;
  constraint cycle_array[length] == target;
  constraint graph[target,source] != 0;

  constraint 
      forall(i in 2..length) ( 
         graph[ cycle_array[i-1], cycle_array[i] ] != 0 );

  constraint 
      forall(i in indexes, where i > length) (
         cycle_array[i] = -1 );

  constraint 
      forall(i,j in indexes, where i<j /\ j<=length) ( 
         cycle_array[i] != cycle_array[j] );

  constraint 
     cost = (sum(i in 2..length) ( 
     graph[ cycle_array[i-1], cycle_array[i] ] )) + graph[target,source];
} in cycle_array;



/**
  Returns a cycle of the graph with the specified cost and length.
  The returned cycle is represented by an array, containing the sequence of vertexes that makes up the cycle.
  The value -1 is used to fill the array after the end of the cycle.
  If the cycle has more than one vertex, then the last vertex in the array is not equals to the first one, but they are connected by an edge.
*/
function array [int] of var int: cycle(array[int,int] of int: graph, 
               var int: cost, var int: length) :: promise_total =
let {

  int: order = order(graph);
  set of int: indexes = 1 .. order;
  set of int: V = vertex_set(graph);
  array[indexes] of var (V union {-1}): cycle_array;
  var V: source;
  var V: target;

  constraint 
      is_adj_matrix_square(graph);

  constraint 
      cycle_array[1] == source;
  constraint 
      cycle_array[length] == target;
  constraint 
      graph[target,source] != 0;

  constraint 
      forall(i in 2..length) ( 
        graph[ cycle_array[i-1], cycle_array[i] ] != 0 );

  constraint 
      forall(i in indexes, where i > length) ( 
         cycle_array[i] = -1 );

  constraint 
      forall(i,j in indexes, where i<j /\ j<=length) ( 
         cycle_array[i] != cycle_array[j] );

  constraint 
      cost = (sum(i in 2..length) 
         ( graph[ cycle_array[i-1], cycle_array[i] ] )) + graph[target,source];
} in cycle_array;


/**
  Returns a cycle of the graph with the specified ONLY the length.
  The cost of edges are not take into account (considered)
  The returned cycle is represented by an array, containing the sequence of vertexes that makes up the cycle.
  The value -1 is used to fill the array after the end of the cycle.
  If the cycle has more than one vertex, then the last vertex in the array is not equals to the first one, but they are connected by an edge.
  ADDED by CCS 
*/

function array [int] of var int: cycle_without_cost(array[int,int] of int: graph, 
               var int: length) :: promise_total =
let {

  int: order = order(graph);
  set of int: indexes = 1 .. order;
  set of int: V = vertex_set(graph);
  array[indexes] of var (V union {-1}): cycle_array;
  var V: source;
  var V: target;

  constraint 
      is_adj_matrix_square(graph);

  constraint 
      cycle_array[1] == source;
  constraint 
      cycle_array[length] == target;
  constraint 
      graph[target,source] != 0;

  constraint 
      forall(i in 2..length) ( 
        graph[ cycle_array[i-1], cycle_array[i] ] != 0 );

  constraint 
      forall(i in indexes, where i > length) ( 
         cycle_array[i] = -1 );

  constraint 
      forall(i,j in indexes, where i<j /\ j<=length) ( 
         cycle_array[i] != cycle_array[j] );

} in cycle_array;

