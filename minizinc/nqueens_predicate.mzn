include "globals.mzn";

int: n = 3;
array[1..n] of var 1..n: pos_rainhas;

predicate n_queens(array[int] of var int: queens_pos) =
let {
  int: num_of_queens = length(queens_pos)
} in

  assert(
   n > 3
/\ alldifferent(queens_pos)
/\ forall(i in 1..num_of_queens) (
     forall(j in i+1..num_of_queens) (
       abs(queens_pos[i] - queens_pos[j]) != abs(i - j)
     )
   ), "Deu ruim", true);

constraint n_queens(pos_rainhas);

solve satisfy;

output [show(pos_rainhas)];