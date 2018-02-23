%%%%$ minizinc -z -a eq20.mzn
%%minizinc  --cpviz   -a viz_queens_hakank.mzn 

include "globals.mzn";
int: n = 8;
%% :: is_output
array[1..n] of var 1..n : queens :: viz([
                                              viztype("vector"),
                                              vizpos(0,2),
                                              vizdisplay("expanded"),
                                              vizwidth(n),
                                              vizheight(n),
                                              vizrange(1,n)
                                              ]);

solve :: int_search(
        queens, 
        first_fail, 
        indomain_median, 
        complete) 
    satisfy;

constraint
    forall(i, j in 1..n where i < j) (
         queens[i] != queens[j] /\
         queens[i] + i != queens[j] + j /\
         queens[i] - i != queens[j] - j
    );

output [ show(queens) ++ "\n" ];