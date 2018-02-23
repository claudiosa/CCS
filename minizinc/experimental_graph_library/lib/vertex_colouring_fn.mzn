include "nvalue.mzn";
include "order_fn.mzn";
include "vertex_set_fn.mzn";
include "is_adj_matrix_square.mzn";

/**
  Params:
  graph: an adjacency-matrix representing a graph
  n: the number of different colours that must be used. Can be a decision-variable

  The function returns an array in which the positions represent vertexes, and the value of each position indicates the assigned colour for that vertex. 
  The colours are represented by integers between 1 and the number of vertexes, and they are assigned in a way to ensure that no neighbour vertexes have the same colour.
*/

function array[int] of var int: vertex_colouring(array[int,int] of int: graph, var int: n) =
let {
  set of int: V = vertex_set(graph);
  array[V] of var 1..order(graph): colours;

  constraint is_adj_matrix_square(graph);
  constraint assert(dom(n) subset 1..order(graph), "The domain of the number of colours must be [1..order(graph)]", true);

  constraint forall(u, v in V, where graph[u,v] != 0) (colours[u] != colours[v]);
  constraint nvalue(n, colours);
} in colours;
