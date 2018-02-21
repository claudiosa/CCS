/* Find distinct non-zero digits such that the following equation holds:
        A        D        G
     ------  + ----- + ------  = 1
       B*C      E*F      H*I
*/
:- use_module(library(clpfd)). 

fracoes(Vars) :-
	Vars = [A,B,C,D,E,F,G,H,I],
	Vars ins 1..9,
	[D1,D2,D3] ins 1..81,
	D1 #= B*C,
	D2 #= E*F,
	D3 #= H*I,
	A*D2*D3 + D*D1*D3 + G*D1*D2 #= D1*D2*D3,
/*	% break the symmetry
	A*D2 #>= D*D1,
	D*D3 #>= G*D2,
	%redundant constraints
	3*A #>= D1,
	3*G #=< D2, */
	all_different(Vars).
	
saida_1 :- fracoes(Vars), labeling([ff], Vars), write(Vars).
saida_2 :- fracoes([A,B,C,D,E,F,G,H,I]), labeling([ff], [A,B,C,D,E,F,G,H,I]), 
format('Saida: ~w \t ~w \t ~w \t ~w \t ~w \t ~w \t ~w \t ~w \t ~w \t', [A,B,C,D,E,F,G,H,I]).

/*
?- saida_2.
 Saida: 7        2       4       5       8       9       1       3       6 
...
Saida: 1         6       3       7       4       2       5       8       9 
...
*/
