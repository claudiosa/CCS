%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-lib(ic).

go:-
	cputime(T1), write(T1), nl,
	statistics(event_time, Tcpu1), writeln( tcpu1: Tcpu1),
	quad,
	cputime(T2), write(T2), nl,
	statistics(event_time, Tcpu2), writeln( tcpu2: Tcpu2),
	T is (T2 - T1),
	Tstatistics is (Tcpu2 - Tcpu1),
	writeln( tudo_Gastou: T  ; segundos),
	writeln( via_statistics: Tstatistics ; segundos).
	

adj(_, []) :-  !.
adj(N, [H|T]) :-  N #< H - 1, adj(N, T).
adj(N, [H|T]) :-  N #> H + 1, adj(N, T).


quad:-
	Quad = [Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8],
	Quad :: 1..8,
	% as restricoes locais
	adj(Q1, [Q2, Q3, Q4, Q5]),  
	adj(Q2, [Q4, Q5, Q6]),
	adj(Q3, [Q4, Q7]),
	adj(Q4, [Q5, Q7, Q8]),
	adj(Q5, [Q6, Q7, Q8]),
	adj(Q6, [Q8]),
	adj(Q7, [Q8]),
	% uma restricao do tipo global
	alldifferent([Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8]),
	% a etiquetagem ... search
	labeling(Quad),
       writeln( vetorSOL: Quad).

/*
 Considerando o quadrado inicial:
       Q1 Q2
Q3 Q4  Q5 Q6
      Q7  Q8
    
Saida:
	?- quad(Q).
	Q = [3, 5, 7, 1, 8, 2, 4, 6]
	Yes (0.00s cpu, solution 1, maybe more)
	Q = [4, 6, 7, 1, 8, 2, 3, 5]
	Yes (0.00s cpu, solution 2, maybe more)
	Q = [5, 3, 2, 8, 1, 7, 6, 4]
	Yes (0.02s cpu, solution 3, maybe more)
	Q = [6, 4, 2, 8, 1, 7, 5, 3]
	Yes (0.03s cpu, solution 4, maybe more)


Exemplos do resultado:
	   3 5
	 7 1 8 2
	   4 6
	   
	   4 6
	 7 1 8 2
	   3 5
	   
	   5 3
	 2 8 1 7
	   6 4
	   
	   6 4
	 2 8 1 7
	   5 3
*/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
