/* Ideia de modelagem para o problema de ANAGRAMAS - LMA */

/* Dado um alfabeto: exemplo com 4 letras */
letras(1,a).
letras(2,s).
letras(3,a).
letras(4,c).

/* TODOS anagramas de 3 letras -- por exemplo */
word_3_letras :-
	letras(N1,L1),
	letras(N2,L2),
	letras(N3,L3),
	/* no caso do anagrama é USAR TODAS as letras */
	letras_diferentes( [N1,N2,N3] ),
	format('~w ~w ~w \t ', [L1,L2,L3] ),
	fail.

word_3_letras :- nl, 
    writeln('Não há mais palavras com 3 letras!!!!!').

main :- nl,
	    word_3_letras,
	   /* 	
	     word_4_letras,  analogo ao anterior exceto  que SAO 4
	     word_5_letras, aqui o numero de letras eh insuficiente
           */			    
	    writeln('***********************************************') .
/* Retorna apenas true ou false como retorno*/
letras_diferentes( [ ] ) :- true.
letras_diferentes( [ H | T] ) :- 
			not(member(H,T)),
			letras_diferentes(T).
/****************************************************************/
