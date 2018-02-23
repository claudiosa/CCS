:- lib(ic).
:- lib(ic_edge_finder3).
:- lib(branch_and_bound).

train([A1,A2,A3,B1,B2,B3,C1,C2,C3,D1,D2,D3]) :-
	[A1,A2,A3,B1,B2,B3,C1,C2,C3,D1,D2,D3] :: 0..10000,
	A1 #= 80,
	B1 #= 39,
	C1 #= 72,
	D1 #= 96,
	A2 #>= A1 + 10,
	A3 #>= A2 + 10,
	B2 #>= B1 + 10,
	B3 #>= B2 + 10,
	C2 #>= C1 + 10,
	C3 #>= C2 + 10,
	D2 #>= D1 + 10,
	D3 #>= D2 + 10,
	disjunctive([A1,C2],[10,10]),
	disjunctive([A1,D2],[10,10]),
	disjunctive([B1,C2],[10,10]),
	disjunctive([B1,D2],[10,10]),
	disjunctive([A2,C1],[10,10]),
	disjunctive([A2,D1],[10,10]),
	disjunctive([B2,C1],[10,10]),
	disjunctive([B2,D1],[10,10]),
	alldifferent([A1,B1]),
	alldifferent([C1,D1]),
	alldifferent([A2,B2]),
	alldifferent([C2,D2]),
	alldifferent([A3,B3]),
	alldifferent([C3,D3]),
	Cost #= A3+B3+C3+D3,
	bb_min(labeling([A1,A2,A3,B1,B2,B3,C1,C2,C3,D1,D2,D3]), Cost, bb_options{strategy:dichotomic, from: 108, to: 1080, timeout: 10}).
    
