% RUNS ON mzn_mer_fd
% RUNS ON mzn_mer_lazyfd
% RUNS ON mzn_mer_lp
% RUNS ON zinc_fdic_mznlib
% RUNS ON zinc_mip_hl
% RUNS ON minizinc_fd
% RUNS ON minizinc_cpx

% n-queens example in Zinc using CP techniques
% By Reza Rafeh July 2005
% MiniZinc version
% Peter Stuckey September 30 2006
/*
minizinc -s -D "n=8;" queen_new.mzn 
*/
int: n ;

array [1..n] of var 1..n: q;

include "alldifferent.mzn";

constraint
    alldifferent(q)     % rows
    /\ 
    alldifferent(i in 1..n)(q[i] + i-1)     % diagonals
    /\
    alldifferent(i in 1..n)(q[i] + n-i);


solve ::
	int_search(
		q,
		largest, %smallest,  %input_order %first_fail,
		%indomain_min, 
        indomain_split,
		complete
	)
	satisfy;

output	["For N queens, CP version:\n"] ++
	[	if fix(q[i]) = j then "Q " else ". " endif ++
	 	if j = n then "\n" else "" endif
	|	i, j in 1..n
	];
