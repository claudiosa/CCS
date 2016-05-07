include "globals.mzn";

int: n = 8;
array[1..n] of var 1..n: pos_rainhas;

constraint n > 3;

constraint alldifferent(pos_rainhas);

constraint forall(i in 1..n-1) (
             forall(j in i+1..n) (
               abs(pos_rainhas[i] - pos_rainhas[j]) != abs(i - j)
             )
           );

solve satisfy;

output [show(pos_rainhas)];
