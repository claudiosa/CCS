include "globals.mzn";

int: n = 8;
array[1..n] of var 1..n: pos_rainhas;

function array[int] of var int: n_queens(int: num_of_queens) =
let {
  array[1..num_of_queens] of var 1..num_of_queens: queens;
  constraint num_of_queens > 3;
  constraint alldifferent(queens);
  constraint forall(i in 1..(num_of_queens-1)) (
               forall(j in (i+1)..num_of_queens) (
                 abs(queens[i] - queens[j]) != abs(i - j)
               )
             );
} in queens;

constraint pos_rainhas = n_queens(n);

solve satisfy;

output [show(pos_rainhas)];