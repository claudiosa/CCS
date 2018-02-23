
include "globals.mzn";

int: n = 7;
% array[1..n] of var 1..n: x;
array[1..n] of var 1..n: x;
array[1..n-1] of var 1..n-1: diffs;
int: sum_distinct = ((n+1)*n) div 2;

% max_regret seems to be quite good....
solve :: int_search(x, max_regret, indomain_split, complete) satisfy;

constraint      
  all_different(diffs) :: domain
  /\  
  all_different(x) :: domain
  /\ 
  forall(k in 1..n-1) (
      diffs[k] = abs(x[k+1] - x[k])
  )
  /\ % symmetry breaking
  x[1] < x[n-1]
  /\
  diffs[1] < diffs[2]
;


output [
       show(x) ++ "," % , " ", show(sum_distinct), " diffs: ", show(diffs)
]