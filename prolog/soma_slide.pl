s(1,1) :- true.       /* REGRA #1 */
s(N, S) :-          /* REGRA #2 */
     N > 1,
	 Aux is (N-1),
	 format('\n N: ~w \t AUX: ~w \t PARCIAL: ~w \t S: ~w', 
			 [N, Aux, Parcial, S]), 
	 s(Aux, Parcial),
	 format('\n ==> Apos o casamento da  REGRA #1:'),
	 S is (N + Parcial),
	 format('\n N: ~w \t AUX: ~w \t PARCIAL: ~w \t S: ~w', 
		     [N, Aux, Parcial, S]).
