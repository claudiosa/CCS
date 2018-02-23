include "../lib/graphs.mzn";

int: N;
array[1..N, 1..N] of int: adj_mat;
array[1..N, 1..N] of var bool: matching;
var 1..N: matching_size;

constraint matching = matching(adj_mat, matching_size);

solve maximize matching_size;

output[
  "Matching size:" ++ show(matching_size) ++ "\n"
]++
[
  if fix(matching[i,j]) then 
    "(" ++ show(i) ++ ", " ++ show(j) ++ ")\n"
  else
    "" 
  endif
  | i in 1 .. N, j in i .. N
];