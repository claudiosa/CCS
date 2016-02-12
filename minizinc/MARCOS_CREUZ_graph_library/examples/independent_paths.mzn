include "../lib/graphs.mzn";

int: N;
int: from;
int: to;
array[1..N, 1..N] of 0..50: adj_mat;
array[1..N] of var int: p1;
array[1..N] of var int: p2;
var int: c1;
var 1..N: l1;
var int: c2;
var 1..N: l2;

constraint p1 = path(adj_mat, from, to, c1, l1);
constraint p2 = path(adj_mat, from, to, c2, l2);

constraint forall( i in 2..l1 ) (
  forall( j in 2..l2 ) (
    p1[i] != p2[j]
  )
);

solve minimize c1+c2;

output["Path 1: " ++ show(p1) ++ "\nPath 2: " ++ show(p2) ++ "\nTotal cost: " ++ show(c1+c2)];

from = 1;
to = 6;
N = 6;
adj_mat = [|
    0, 3, 4, 1, 5, 0, |
    0, 0, 0, 0, 0, 2, |
    0, 0, 0, 0, 0, 3, |
    0, 0, 0, 0, 0, 2, |
    0, 0, 0, 0, 0, 1, |
    0, 0, 0, 0, 0, 0  |];