include "vertex_set_fn.mzn";
include "is_adj_matrix_square.mzn";

/**
  Params:
  graph: an adjacency-matrix representing a graph

  This predicate constraints the given graph to be a tree
*/

function var set of int: clique(array[int,int] of int: graph, var int: size) =
let {
  set of int: V = vertex_set(graph);
  var set of V: clique_set;

  constraint is_adj_matrix_square(graph);
  constraint assert(dom(size) subset 1..order(graph), "The domain of the clique size must be [1..order(graph)]", true);

  constraint card(clique_set) == size;
  constraint forall(u,v in clique_set, where u!=v) (graph[u,v] != 0 /\ graph[v,u] != 0);
}
in (
  clique_set
);