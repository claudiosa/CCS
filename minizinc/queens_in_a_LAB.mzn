%% in lab 07/05

% data
n = 8;
include "globals.mzn";

int: n;
array[1..n] of var 1..n: queens;

solve :: int_search(
        queens, 
        first_fail, 
        indomain_min, 
        complete) 
    satisfy;

% solve satisfy;
%%constraint all_different(queens);

constraint
/*
 HAKAN -- version
    forall(i, j in 1..n where i < j) (
         (queens[i]  != queens[j]) /\
         (queens[i]  != queens[j] + j-i) /\
         (queens[i]  != queens[j] - j+i) 
    ) 
 ;
*/
/* RAFAEL and CC */
  forall(i , j in 1..n where i < j) (
         (queens[i]  != queens[j]) /\
         (queens[i]  != queens[j] + abs(j-i)) /\
         (queens[i]  != queens[j] - abs(i-j)) 
    ) 
 ;

output [show(queens) ++ "\n"]++
  ["Para  " ++show(n)++ "  rainhas .....  temos:\n"]  ++
	[	if fix( queens[i] ) = j then "R " else ". " endif ++
	 	if j = n then "\n" else "" endif
	|	i, j in 1..n
	];



/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
