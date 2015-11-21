/* Permutacao de elementos */

permutar([], []). /* Condicao de parada*/
permutar([X|L], Lpermutada):-
  	permutar(L, L1), 
	exclui_1a(X, Lpermutada, L1).


/* Exclui  X apenas em sua primeira ocorrencia */
exclui_1a(X, [X|L], L).
exclui_1a(X, [Y|L], [Y|L1]):- exclui_1a(X, L, L1).

/* executando */
init :- permutar([5,7,9],X), nl , write(X), fail.
