include "../lib/graphs.mzn";

int : N;
array[1..N, 1..N] of int: adj_mat;
var bool : x;

/*
constraint 
      complete(adj_mat) ;
*/

constraint 
    x = complete_FUNCTION(adj_mat) ;

solve satisfy;

output [ " this graph is:    " ] ++
  %%% [ show(fix(x))  ];
[show(
	if (fix(x) == true)
	then 
		"COMPLETE"
	else
		"INCOMPLETE"
	endif)
  ]; 
/*** OK in NOV-2016 -- CLOSED */
