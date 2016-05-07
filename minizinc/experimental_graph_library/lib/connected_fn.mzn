include "reachables_fn.mzn";
include "vertex_set_fn.mzn";

/**
  Params:
  graph: an adjacency-matrix representing a graph
*/

/*
  Check if the graph is connected or not.
  The directions of the edges are not considered.
*/
function var bool: connected(array[int,int] of int: graph)::promise_total =
let {
  set of int: V = vertex_set(graph);
  int: order = order(graph);
  array[V,V] of int: undir_graph = array2d(V, V, [ if graph[i,j]!=0 \/ graph[j,i]!=0 then 1 else 0 endif | i,j in V]);
  int: target = set2array(V)[1];

  array[int] of int: direct_distance = [if i=target then 0 elseif undir_graph[i,target]!=0 then 1 else order+1 endif | i in V];
  array[V] of var 0..2*(order+1): real_distance;

  constraint forall (i in V) (
    real_distance[i] = min( [direct_distance[i]] ++ [real_distance[j]+1 | j in V where undir_graph[i,j]!=0] )
  );
} in forall(i in V) (
       real_distance[i] <= order
     );

/**
  Check if the graph is strongly connected or not.
  The directions of the edges are considered.
*/
function var bool: strongly_connected(array[int,int] of int: graph)::promise_total =
let {
  set of int: V = vertex_set(graph);
  int: order = order(graph);

  array[V,V] of int: direct_distance = array2d(V,V,[if i=target then 0 elseif graph[i,target]!=0 then 1 else order+1 endif | target,i in V]);
  
  array[V,V] of var 0..2*(order+1): real_distance;

  constraint forall (target,i in V) (
    real_distance[target, i] = min( [direct_distance[target,i]] ++ [real_distance[target,j]+1 | j in V where graph[i,j]!=0] )
  );
} in forall(target,i in V) (
       real_distance[target,i] <= order
     );