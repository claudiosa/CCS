\begin{verbatim}
/* Exemplo do uso de Functores na Resoluçao de Problemas
   com Prolog*/


estado( ((X,Y,Z) ,W) ) :- W is (X mod 4) , regras_de_estado( W, (X,Y,Z) ).

/* regras ... condicionais do problema.... */
regras_de_estado( 0, (X,Y,Z) ):-  Y =\= 0, Z is (X / Y). /* a divisao */
regras_de_estado( 0, (_,0,0) ).   /* se denominador Y for 0... retorne 0) */
regras_de_estado( 1, (X,Y,Z) ) :- Z is (X * Y).
regras_de_estado( 2, (X,Y,Z) ) :- Z is (X + Y).
regras_de_estado( 3, (X,Y,Z) ) :- Z is (X - Y).
/* ... essas representam as condicoes de contorno do problema,
  restricoes... e permissoes... declaradas */


cod(0, divide).
cod(1, mult).
cod(2, soma).
cod(3, subtrai).

inicio :-
     busca([((0,0, _), _ )], Solution),
     reverse(Solution, ReversedSolution), /* inverte a lista */
     imprime(ReversedSolution).

imprime(X) :- w_l(X).
/* uma saida formatada */
w_l([]).
w_l([((X,Y,Z),W)|L]) :-  
	nl, 
	cod(W, Op),
	write(X), write(' .. '), write(Op), write(' .. '), write(Y), write('....  é: '),
	write(Z),
	w_l(L).

/* Núcleo do processo de busca...*/
busca( [ ((X,Y,Z), W1_op) | Resto ], Solution) :-
   
     estado( ((X,Y,Z),W1_op) ),
     Xnovo is 	(X + 1),
     Ynovo is 	(Y + 1),
     Xnovo =< 17,
     Ynovo =< 17,
     estado( ((Xnovo,Ynovo,Znovo),W2_op) ),

     \+member( ((Xnovo,Ynovo,Znovo),W2_op) , Resto), /* não é menbro */
     busca([((Xnovo,Ynovo,Znovo),W2_op),((X,Y,Z),W1_op)|Resto], Solution).

/*
 Condição de Parada, um estado final... 17
*/

busca([((17,17, X),W) | Resto],[((17,17, X ),W) | Resto]).

/*  vem o primeiro argumento de lista, e volta a mesma como parada */

\end{verbatim}
