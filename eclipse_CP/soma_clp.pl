
:-lib(ic).

go:- cputime(T1), write(T1), nl,
	 statistics(event_time, Tcpu1), writeln( tcpu1: Tcpu1),
	 (count(I,10,15) do
	  s( I, S), 
	  write(I),
	  writeln( a_soma_eh: S)
     ),
     cputime(T2), write(T2), nl,
     statistics(event_time, Tcpu2), writeln( tcpu2: Tcpu2),
     T is (T2 - T1), 
     Tstatistics is (Tcpu2 - Tcpu1),
     writeln( tudo_Gastou: T),
     writeln( via_statistics: Tstatistics).

     
s(1,1).                         /* regra #1 */
s(N, S) :-
     N > 1,                        /* regra #2 */
     Nant is N-1,
     s(Nant, Parcial),
     S is (N + Parcial).
    
