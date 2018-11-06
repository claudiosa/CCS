somatorio([], 0).
somatorio([Y | R], X):- 
					somatorio(R, S),
					X is S + Y.
comprimento([], 0).
comprimento([_|R], N):-
					 comprimento(R, N1),
					 N is 1 + N1.

med_lista([], 0):- !.
med_lista(N, X):-
				 comprimento(N, C),
				 somatorio(N, S),
				 X is S/C, !.
				 
/*conta*/

conta(Y, [], 0).
conta(Y, L, X):- func(Y, L,0).

func(X, [], N):- format('~w ',[N]), !.
func(X, [Z | W], N):-
					  X == Z,
					  J is N+1,
					  func(X, W, J).
					  				  
									
func(X, [Z | W], N):-
					  X \== Z,
					  func(X, W, N).


/*exercicio 5*/


membro(X, [X | T]):- !.
membro(X, [H | T]) :-
					membro(X, T).


intersec([],Z,[]).
intersec([X|Y],M,[X|Z]) :- 
						membro(X,M),
						intersec(Y,M,Z).
intersec([X|Y],M, Z) :- 
					\+ membro(X,M),
					intersec(Y,M,Z).

inter(L1,L2,L3):- 
				intersec(L1, L2, L3).


/*exercicio 2*/

ad_depois(L1,X,Y,L2):- funss(L1,X,Y,L2).

funss([],X,Y,[]).
funss([H|T],X,Y,[H,Y|L2]):- 
					H == X,
					funss(T,X,Y,L2).
funss([H|T],X,Y,[H|L2]):- 
					funss(T,X,Y,L2).



troca(X, Y , L1, L2):- trk(X,Y,L1,L2).

trk(X,Y,[],[]).
trk(X,Y,[H|T],[X|L2]):-
					H == Y,
					trk(X, Y, T, L2).

trk(X,Y,[H|T],[H|L2]):-
					trk(X, Y, T, L2).
				
/*exercicio4*/
				
elem_resto(_,[],'Elemento nao estah na lista') :- !.
elem_resto(X, [X|LEnt], LEnt) :- !.
elem_resto(X, [_|LEnt], LSai) :-
elem_resto(X, LEnt, LSai).



/*conta(_, [], 0) :- !.

conta(X, [X|L], Nm1) :-
 						conta(X, L, N),
 						Nm1 is N+1.

conta(X, [_|L], N) :-
					 conta(X, L, N).*/
