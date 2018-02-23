:-lib(ic).
:-lib(ic_search).




go([A, B, C, D, E]) :-
	Comp = [A, B, C, D, E],
	Comp :: [1..5],
	
	(A #\= 1) #\= (B #\= 2),
	(D #\= 2) #\= (E #\= 3),
	(C #=< 3) #\= (D #>= 4),
	(A #=< 3) #\= (C #>= 4),
	(D #=< 3) #\= (E #=< 3),
	
	
	alldifferent(Comp),
	labeling(Comp).
	
	/*resultados
	
	?- go([Joao, Rafael, Paulo, Jose, Eduardo]).
Joao = 1
Rafael = 4
Paulo = 3
Jose = 2
Eduardo = 5
---> quem ganhou as medalhas na sequencia de ouro prata e bronze foram : Joao,Jose,Paulo
more

Yes (0.00s cpu, solution 1, maybe more)
Joao = 1
Rafael = 5
Paulo = 3
Jose = 2
Eduardo = 4

---> quem ganhou as medalhas na sequencia de ouro prata e bronze foram : Joao,Jose,Paulo
mudou apenas o 4 e o 5 lugar da primeira resposta

Yes (0.03s cpu, solution 2, maybe more)

more

No (0.03s cpu)

*/