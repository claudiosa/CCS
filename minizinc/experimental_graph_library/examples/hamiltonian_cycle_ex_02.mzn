include "../lib/graphs.mzn";

int: N;
var int: K ;   % an estimative of a cost
array[1..N, 1..N] of 0 .. 9999 : adj_mat ;
array[1..N] of var int: hamiltonian_cycle ;

%% A predicate ...HERE the K is boundary for the edges cost 
%% hamiltonian_cycle_WITH_COST(array[int,int] of int: graph, array[int] of var int : cicle_array_R,  var int : cost_R ) 

constraint 
     hamiltonian_cycle_WITH_COST(adj_mat, hamiltonian_cycle, K );

solve minimize K;

% OR solve satisfy;

output["\n One cycle is: "++show(hamiltonian_cycle)++
        " with the cost (edges sums -- minimize or maximize)  " ++ show(K)];

/*

% CASE 1
N=5;
adj_mat = 
[|
  0 , 5 , 10, 0 , 1,|
  5 , 0 , 0 , 10, 1,|
  10, 0 , 0 , 2 , 1,|
  0 , 10, 2 , 0 , 1,|
  1 , 1 , 1 , 1 , 0 |];

% CASE 2
N=5;
adj_mat = 
[|
 0, 10, 999, 14, 10,  |   % School
10,  0,  7, 15, 15,   |   % Movies
999,  7,  0, 20, 999, |   % Snell`s Farm
14, 12, 20,  0,  8,   |   % Planter`s Farm
10, 15, 999,  8,  0   |];  % Gym
*/

% /*     % CASE 3
N = 6;
adj_mat = 
[|
 0, 11, 7, 6,  8, 14, | % city 1
11,  0, 7, 9, 12, 13, | % city 2
 7,  7, 0, 3,  7,  8, | % city 3
 6,  9, 3, 0,  4,  8, | % city 4
 8, 12, 7, 4,  0, 10, | % city 5
14, 13, 8, 8, 10,  0    % city 6
 |];

%SOLUTIONS from others algorithms
% x: [2, 3, 4, 5, 6, 1]
% 49
% ----------
% x: [2, 3, 4, 6, 1, 5]
% 47
% ----------
% x: [2, 3, 6, 1, 4, 5]
% 46
% */
