include "../lib/graphs.mzn";

int: N;
int: source;
source = 2;
array[1..N, 1..N] of int: adj_mat;
var set of 1..N: reachable_vertexes;
%array[1..N] of var int: reachable_vertexes;

%constraint reachable_vertexes = reachables(adj_mat, 1);
 constraint reachable_vertexes = undirected_reachables(adj_mat, source);

solve satisfy; %maximize card(reachable_vertexes);

output [show(reachable_vertexes)];



/*
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
 ORIGINAL
 */
 
%% STUCKEY
N=4;
adj_mat = [| 1, 0, 0, 0
           | 0, 1, 1, 1
           | 0, 1, 1, 1
           | 0, 1, 1, 1|];


