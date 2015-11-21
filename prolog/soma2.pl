s(1,1) :- true.		/* regra #1 */
s(N, S) :- N > 1,	/* regra #2 */
	Aux is (N-1),
	format('\n N: ~w \t AUX: ~w 
		\t PARC: ~w \t S: ~w', 
		[N, Aux, Parcial, S]), 
	s(Aux, Parcial),
	format('\n ==> 
		Apos o casamento da  REGRA #1:'),
 	S is (N + Parcial),
	format('\n N: ~w \t AUX: ~w 
		\t PARC: ~w \t S: ~w', 
		[N, Aux, Parcial, S]).
