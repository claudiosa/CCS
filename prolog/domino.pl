\begin{verbatim}
/* Exemplo do uso de Functores na Resoluçao de Problemas
   com Prolog ==> Dominó de um lado só....*/

/* por uma peça... pedra... no domino....*/

muda_estado( (X,Y) , (Z,W) ) :-  pc( (Z,W ) ),  Y == Z, X =\= W.
muda_estado( (X,Y) , (W,Z) ) :-  pc( (Z,W ) ),  Y == W, X =\= Z.

/* esta ultima condicao.... evita que a mesma peca seja usada....duas veze */

/* a ponta livre Y, encaixa com um dado Z ... tem que ser uma peça livre...*/

/* regras ... condicionais do problema.... */

/* ... essas representam as condicoes de contorno do problema,
  restricoes... e permissoes... declaradas 
*/

pc( (1,1) ). pc( (1,2) ).  pc( (1,3) ). pc( (1,4) ).
pc( (2,2) ). pc( (2,3) ).  pc( (2,4) ).
pc( (3,3) ). pc( (3,4) ).
pc( (4,4) ).


inicio :-
     busca([ (1,1) ], Solution),
     reverse(Solution, ReversedSolution), /* inverte a lista */
     imprime(ReversedSolution),
     write('\n***************************').
     

tudo  :-      
		findall( Solucao, busca([ (1,1) ], Solucao), Todas_Sol),
		elimina_duplicados( Todas_Sol,Lista_solucoes),
		/* reverse(Lista_solucoes, Lista_solucoes_r), */
		imp_l(Lista_solucoes),
		nl,
		write(' Número de solucoes é :'),
		comp(Lista_solucoes, T),
		write(T).


elimina_duplicados( [],[] ).
elimina_duplicados( [X|L1] , [X|L2]) :- 
       \+pertence( X , L1 ),
	elimina_duplicados( L1 , L2).
elimina_duplicados( [ _ |L1] , L2 ) :- 
	elimina_duplicados( L1 , L2).

pertence( X, [X|_]).
pertence( X, [_|L]) :-  pertence( X, L ).


imp_l([]).
imp_l([X|L]) :- nl, 
		/* write(X), */
		reverse(X,Y),
	        w_l(Y),
		imp_l(L).


imprime(X) :- w_l(X).
/* uma saida formatada */
w_l([]).
w_l([(X,Y)|L]) :-  
	nl, 
	write('----------------'), nl,
	write('  |  '),write(X),write('  |  '), write(Y),write('  |'),
	w_l(L).

/*
 Condição de Parada, um estado final... sem peças... ou sem casamentos...
*/

busca(L,L) :-  comp(L,X) , X == 5. 
/* >=( X , 4 ).   */
/* =<( X , 4 ). */


/* observe que Solution da chamada anterior ... é instanciada por casamento...
   nada de atribuições...
*/   


/* Núcleo do processo de busca...*/
busca( [ (X,Y) | Resto ], Solution) :-
   
     muda_estado(    (X,Y),  (Xnovo,Ynovo)   ),
     /* estados/peças novos   */

     \+pertence_jogo( (Xnovo,Ynovo) , Resto), 
     /* se esta peça não é menbro do jogo ainda... */
     busca([(Xnovo,Ynovo) , (X,Y) | Resto], Solution).



comp([],0).
comp([_|Resto],Total):- comp(Resto,P_resto), Total  is (P_resto +1).

/*  ve se o primeiro argumento de lista, pertence a ela...e volta como parada: yes */
pertence_jogo( (X,Y), [(X,Y) | _]).
pertence_jogo( (X,Y), [(Y,X) | _]).
pertence_jogo( (X,Y), [ _ | Resto]) :-  pertence_jogo( (X,Y), Resto ).
\end{verbatim}