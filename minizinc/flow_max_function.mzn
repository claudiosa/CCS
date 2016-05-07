% 
% Maximum Flow Problem, integer programming in MiniZinc.
% 
% From GLPK:s example maxflow.mod
% """
% MAXFLOW, Maximum Flow Problem
%
% Written in GNU MathProg by Andrew Makhorin <mao@mai2.rcnet.ru>
%
% The Maximum Flow Problem in a network G = (V, E), where V is a set
% of nodes, E within V x V is a set of arcs, is to maximize the flow
% from one given node s (source) to another given node t (sink) subject
% to conservation of flow constraints at each node and flow capacities
% on each arc.
% """

% 
% This MiniZinc model was  ORIGINALLY created by Hakan Kjellerstrand, hakank@bonetmail.com
% See also my MiniZinc page: http://www.hakank.org/minizinc
%

%%% MODIFIED by Claudio Cesar de Sá ... transfoming it in a function to Max Flow

% number of nodes 
int: n;

% set of arcs 
int: num_edges;
array[1..num_edges, 1..2] of 1..n: E;

% a[i,j] is capacity of arc (i,j) 
array[1..num_edges] of int: CAPACITY;

% source node 
1..n: s;

% sink node 
1..n: t;

% x[i,j] is elementary flow through arc (i,j) to be found 
array[1..num_edges+1] of var int: x;
%% CCS note: position x[num_edges+1] has the flow
% total flow from s to t 

%% EXAMPLE
%
% data
%

% """
% These data correspond to an example from [Christofides]. 
%
n = 9;
s = 1;
t = n;

num_edges = 14;
E = array2d(1..num_edges, 1..2,
[
       1, 2, 
       1, 4,
       2, 3,
       2, 4,
       3, 5,
       3, 8,
       4, 5,
       5, 2,
       5, 6,
       5, 7,
       6, 7,
       6, 8,
       7, 9,
       8, 9]);

CAPACITY = [14,23,10, 9,12,18,26,11,25, 4, 7, 8,15,20];

%%% function that returns an array ....
% x[i,j] is elementary flow through arc (i,j) to be found 
% and the MAX flow in x[num_edges+1] POSITION
%% the function may returns only value
function array[1..num_edges+1] of var int: max_flow_function(
                          int :n, %% number of nodes
                          int: num_edges,
                          int: source,
                          int: target,
                          array[1..num_edges, 1..2] of 1..n: E,
                          array[1..num_edges] of int: capacity) = 
    let{

         var int  : f_flow;
         %% auxiliary variable
         array[1..num_edges+1] of var int: x;
 
      constraint 
          f_flow >= 0
          /\
          f_flow <= 100
          /\
          forall(i in 1..num_edges) (
          x[i] >= 0
          /\
          x[i] <= capacity[i]
          )
          /\
        forall(i in 1..n) (
      % node[i] is conservation constraint for node i 
      % 
      % summary flow into node i through all ingoing arcs 
      sum(k in 1..num_edges where E[k,2] = i) (x[k]) + f_flow*bool2int(i = source)
      = % must equal 
      % summary flow from node i through all outgoing arcs 
      sum(k in 1..num_edges where E[k,1] = i) (x[k]) + f_flow*bool2int(i = target)
      )
      /\
          x[num_edges+1] ==f_flow;
   }  
   in x
   ;



constraint
      x = max_flow_function(n, num_edges, s, t, E, CAPACITY);

% objective is to maximize the total flow through the network 
solve maximize x[num_edges+1];

output
[
  "x: " ++ show(x) ++ "\n" ++
  "flow: " ++ show(x[num_edges+1])
];

