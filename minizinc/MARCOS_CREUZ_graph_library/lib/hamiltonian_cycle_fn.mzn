include "cycle_fn.mzn";
include "order_fn.mzn";

/*
  Returns an array representing a hamiltonian cycle of the graph.

  Params:
  graph: an adjacency-matrix representing a graph
  cost: the value of the sum of all the edges in the cycle. Can be a decision-variable (optional param)
*/

function array [int] of var int: hamiltonian_cycle(array[int,int] of int: graph)::promise_total =
let {
  int: order = order(graph);
  array[1..order] of var int: cycle_array;
  var int: cost;
  var 1..order: length;

  constraint cycle_array = cycle(adj_mat, cost, length);
  constraint length = order(adj_mat);
} in cycle_array;


function array [int] of var int: hamiltonian_cycle(array[int,int] of int: graph, var int: cost)::promise_total =
let {
  int: order = order(graph);
  array[1..order] of var int: cycle_array;
  var 1..order: length;

  constraint cycle_array = cycle(adj_mat, cost, length);
  constraint length = order(adj_mat);
} in cycle_array;