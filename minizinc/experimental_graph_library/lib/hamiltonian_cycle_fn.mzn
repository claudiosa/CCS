include "cycle_fn.mzn";
include "order_fn.mzn";

/*

Original coded by Marcos -- 2015
Modified and revised by Claudio - Oct. 21 / 2016
*/

/*
  Returns an array representing a hamiltonian cycle of the graph.

  Params:
  graph: an adjacency-matrix representing a graph
  cost: the value of the sum of all the edges in the cycle. 
  Can be a decision-variable (an optional param)
  */

function array [int] of var int: hamiltonian_cycle(array[int,int] of int: graph)::promise_total =
let {
  int: path_size = order(graph);
  array[1..path_size] of var int: cycle_array;
  var int: cost;
  var 1..path_size: length;


  constraint %% for users proposals ... change one of two options 
        %% adding cost: cycle_array = cycle(adj_mat, cost, length);
        cycle_array = cycle_without_cost(adj_mat, length);
         %%  a cycle of the graph ... just a cycle true
         
  constraint 
        length = order(adj_mat); 
        %% card(vertex_set(graph));
} in cycle_array;

