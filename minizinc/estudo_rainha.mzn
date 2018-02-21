
int: n =8  ;

array [1..n] of var 1..n: q;

/*
constraint forall (i in 1..n, j in 1..n where i!=j) (
	q[i] != q[j]
	/\
	q[i] +i != q[j]+j
	/\
	q[i] -i != q[j]-j
      );
*/

constraint
      forall (i in 1 .. n, j in 1 .. n where i < j )
       (  q[i] != q[j]
       );

constraint
     forall (i in 1 .. n, j in 1 .. n where i < j )
       (  q[i] +i != q[j] +j 
       );

constraint
     forall (i in 1 .. n, j in 1 .. n where i < j )
       (  q[i] -i != q[j] -j 
       );

/*
solve ::
	int_search(
		q,
		largest, %smallest,  %input_order %first_fail,
		%indomain_min, 
               indomain_split,
		complete
	)
	satisfy;
*/
solve satisfy;

output [show(q)];

/*
output ["For N queens, CP version:\n"] ++
	[	if fix(q[i]) = j then "Q " else ". " endif ++
	 	if j = n then "\n" else "" endif
	|	i, j in 1..n
	];

*/