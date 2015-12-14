include "vertex_set_fn.mzn";
include "is_adj_matrix_square.mzn";

/**
  Params:
  graph: an adjacency-matrix representing a graph

  This predicate simply assures that the given graph is complete
*/

predicate complete(array[int,int] of int: graph) =
let {
  set of int: V = vertex_set(graph);
}
in (
  is_adj_matrix_square(graph) /\
  forall(u, v in V, where u < v) (graph[u,v] != 0 /\ graph[v,u] != 0)
);