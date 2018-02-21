include "vertex_set_fn.mzn";
include "is_adj_matrix_square.mzn";
include "order_fn.mzn";
include "globals.mzn";

/**
  Params:
  graph: an adjacency-matrix representing a graph
  size: an integer representing the size of the matching. Can be a decision-variable

  This function finds a matching with the specified size in the graph. It returns a bidimensional array M with the same size of graph, where M[u,v] = 1 iff the edge (u,v) is part of the matching. The resulting matrix is symmetric.
*/

function array[int,int] of var bool: matching(array[int,int] of int: graph, var int: size) =
let {
  set of int: V = vertex_set(graph);

  array[V,V] of var bool: matching;

  constraint is_adj_matrix_square(graph);
  constraint assert(dom(size) subset 0..order(graph), "The domain of the matching size must be [0..order(graph)]", true);

  constraint size = sum(i, j in V, where i < j) (matching[i,j]);
  
  constraint forall(i in V) ( 
    ( sum(j in V)(matching[i,j]) ) <= 1
  );

  constraint forall(u,v in V, where u < v) (
    matching[u,v] -> (matching[v,u] /\ ((graph[u,v] != 0) \/ (graph[v,u] != 0)))
  );
}
in (
  matching
);