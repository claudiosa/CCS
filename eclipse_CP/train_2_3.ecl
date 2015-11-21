:- lib(ic).
:- lib(ic_edge_finder3).
:- lib(branch_and_bound).

train([A1,A2,A3,B1,B2,B3]) :-
	[A1,A2,A3,B1,B2,B3] :: 0..10000,
	A1 #= 40,
	B1 #= 7,
	A2 #>= A1 + 10,
	A3 #>= A2 + 10,
	B2 #>= B1 + 10,
	B3 #>= B2 + 10,
	disjunctive([A1,B2],[10,10]),
	disjunctive([A2,B1],[10,10]),
	Cost #= A3+B3,
	bb_min(labeling([A1,A2,A3,B1,B2,B3]), Cost, bb_options{strategy:dichotomic, from: 54, to: 540, timeout: 10}).
    
