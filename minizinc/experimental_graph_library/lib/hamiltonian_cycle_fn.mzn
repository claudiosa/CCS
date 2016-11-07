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
 

  To be change HERE .... two functions ....
  
  */

function array [int] of var int: hamiltonian_cycle(array[int,int] of int: graph) :: promise_total =
let {
  int: path_size = order(graph);
  array[1..path_size] of var int: cycle_array;
  var int: cost;
  var 1..path_size: length;

  constraint %% for users proposals ... change one of these two options 
        %% adding cost: cycle_array = cycle(adj_mat, cost, length);
        cycle_array = cycle_without_cost(adj_mat, length);
         %%  a cycle of the graph ... just a true cycle 
         
  constraint 
        length = order(adj_mat); 
        %% card(vertex_set(graph));
} in cycle_array;

/************* by CCS *************/
%% a predicate ............... the cost 
%%% it is an important value from hamiltonian_cycle 
%% hamiltonian_cycle_WITH_COST(input, output_R, output_R)
predicate hamiltonian_cycle_WITH_COST(array[int,int] of int: graph, 
          array[int] of var int : cicle_array_R,  
          var int : cost_R ) =
let {
  int: path_size = order(graph);
  array[1..path_size] of var int: cycle_array;
  var int: cost;
  var 1..path_size: length;

  constraint %% find a cycle with cost below of upper_cost
         cycle_array = cycle(adj_mat, cost, length);
         %% cost ... if the matrix comes with weight values in its edges
         %% the cost sum these weights... length is a constant
                
  constraint 
        length = order(adj_mat); 
        %% card(vertex_set(graph));
} in    %% Returning some values... cycle and its costs
  cicle_array_R == cycle_array 
  /\
  cost_R == cost %% the sum weight's edges
  ;
/* ************************************************************* */