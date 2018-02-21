/*
s(N,Soma_total) :- 
   >(N,1), 
	Aux is (N-1),
	s(Aux, Parcial),
	Soma_total is (Parcial + N).


 
s(1,1).
*/
  s(1,1) :- true.               /* regra #1 */
  s(N, S) :- N > 1,            /* regra #2 */
             Aux is (N-1),
             format('\n N: ~w \t AUX: ~w \t PARC: ~w \t S: ~w', 
                     [N, Aux, Parcial, S]), 
             s(Aux, Parcial),
             format('\n ==> Apos o casamento da  REGRA #1:'),
             S is (N + Parcial),
             format('\n N: ~w \t AUX: ~w \t PARC: ~w \t S: ~w', 
             [N, Aux, Parcial, S]).


/*

m(6,0).
m(5,0).
m(4,0).
m(3,0).
m(2,0).
m(1,0).
m(7,7).

m(N,0) :- N =< 6.
m(N,Soma_total) :-
	>(N,1), 
	Aux is (N-7),
	m(Aux, Parcial),
	Soma_total is (Parcial + N).

m7(X,S) :- Resto is mod(X,7),
	Aux is (X-Resto),
	m(Aux,S).

imp(0).
imp(X) :-
	m7(  X , S),
	write(X), 
	write('.........'),
        write(S), nl,
          Aux is (X - 1),
           imp(Aux).


*/




