include "../lib/graphs.mzn";
/* PENDING
array[1..4, 1..4] of int: graph = [| 1, 0, 0, 0
                                   | 0, 1, 1, 1
                                   | 0, 1, 1, 1
                                   | 0, 1, 1, 1|];
                                 
*/   
int: Source;
Source = 2;                                
int: N;
N=4;
array[1..N, 1..N] of 0..1 : adj_mat ;

adj_mat = [| 1, 0, 0, 0
           | 0, 1, 1, 1
           | 0, 1, 1, 1
           | 0, 1, 1, 1|];

                                
var set of 1..4: r = reachables(adj_mat, Source);

solve satisfy;

output[show(r)];
