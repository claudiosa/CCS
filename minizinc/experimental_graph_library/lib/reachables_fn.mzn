include "vertex_set_fn.mzn";
include "is_adj_matrix_square.mzn";

/**
  Params:
  graph: an adjacency-matrix representing a graph
  source: a vertex

  Issues:
  - These functions are not working properly with the G12 solver.
*/

/*
  Returns the set of vertexes that the source vertex can reach in the graph.
  The directions of the edges are considered.
*/

/*
function var set of int: reachables(array[int,int] of int: graph, int: source)::promise_total = 
let {
  set of int: V = vertex_set(graph);
  var set of V: reachable_set;
  array[V] of var bool: bool_set;  

  constraint is_adj_matrix_square(graph);
  constraint assert( {source} subset V, "The source must be in graph", true);

  constraint link_set_to_booleans(reachable_set, bool_set);

  constraint bool_set[source] = true;

  constraint forall(v in V, where v != source) (
    bool_set[v] <-> ( exists(u in V, where u != v) (bool_set[u] /\ graph[u,v] != 0) )
  );

} in reachable_set;*/


function var set of int: reachables(array[int,int] of int: graph, int: source)::promise_total = 
let {
  set of int: V = vertex_set(graph);
  var set of V: reachable_set;

  constraint is_adj_matrix_square(graph);
  constraint assert( source in V, "The source must be in graph", true);

  constraint source in reachable_set;

  constraint forall(v in V, where v != source) ( exists_path(graph, source, v) <-> (v in reachable_set) );

} in reachable_set;


/**
  Returns the set of vertexes that the source vertex can reach in the graph.
  The directions of the edges are not considered.
*/
function var set of int: undirected_reachables(array[int,int] of int: graph, int: source)::promise_total = 
let {
  set of int: V = vertex_set(graph);
  var set of V: reachableSet;
  set of int: V_without_source =  V diff {source};

  constraint is_adj_matrix_square(graph);
  constraint assert( {source} subset V, "The source must be in graph", true);

  constraint source in reachableSet;

  constraint
    forall(v in V_without_source) (
      (exists(u in reachableSet) (graph[u,v] != 0 \/ graph[v,u] != 0 )) <-> v in reachableSet
    );

} in reachableSet;