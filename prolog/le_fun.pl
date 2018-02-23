/******************** lendo uma lista de functores ..... ****/

le_lista_functor( [ functor_name(X1,X2, X3) | Resto ] ) :-
        nl, write('Digite X1 :: '),
        read(X1),
        nl, write('Digite X2 :: '),
        read(X2),
        nl, write('Digite X3 :: '),
        read(X3),
	le_mais( Resto ),
        le_lista_functor( Resto ).

/* Condicao de Parada */
le_lista_functor([]) :- !.    /*  no caso de falso em le_mais */


le_mais(Y) :-
	nl, 
	write('Press <Enter ou Escape> to terminar:: '),
	get_single_char(X),
	/* confirmar estes ASCII do teclado ... ou melhorar a mensagem acima... */
	(X == 27; X == 13; X == 10) ,
	Y = [], !.

/* OBS: == eh a pergunta de equivalencia logica,
        =  eh uma pergunta se Y pode receber []; Y = [],
	se for possivel.... Y vai receber [],
	e o is eh atribuicao mesmo...
*/	

le_mais(_).


/*************************************************************************/
escreve_lista([]).
escreve_lista([functor_name(X1,X2,X3)|Tail]) :- 	
		        write(' : '),			
			write(X1), 	
		        write(' : '),			
			write(X2), 			
			write(' : '),			
			write(X3), 
			/* ou simplesmente :: write(functor_name(X1,X2,X3)) */
                        escreve_lista(Tail).
/*************************************************************************/

x :- le_lista_functor(X), escreve_lista(X).
/********************************************/