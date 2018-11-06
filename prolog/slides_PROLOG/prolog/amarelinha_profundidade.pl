/*
 Fa�a a an�lise do Espa�o de Estados que forne�a o n�mero total de estados. 
	Descubra a express�o combinat�ria que forne�a aproximadamente este valor.

        Resposta: estado inicial: ('b', 'a', 'c','_','_','_','_') 
                  estado final  : ('_', '_', '_','_','c','a','b')
                  numero total de estados: 42
                  Cada posi��o pode ter os valores, a,b,c ou _ .
*/


/* BUSCA em PROFUNDIDADE */

/*
   X2    X5
X1    X4    X7
   X3    X6
*/

/* movimentos permitidos  ===> veja o diagrama*/
move((X1,X2,X3,X4,X5,X6,X7), (X1,X4,X3,X2,X5,X6,X7)) :-  X2 == '_';  X4 == '_'. 
move((X1,X2,X3,X4,X5,X6,X7), (X1,X2,X4,X3,X5,X6,X7)) :-  X3 == '_';  X4 == '_'.
move((X1,X2,X3,X4,X5,X6,X7), (X2,X1,X3,X4,X5,X6,X7)) :-  X2 == '_'.
move((X1,X2,X3,X4,X5,X6,X7), (X3,X2,X1,X4,X5,X6,X7)) :-  X3 == '_'.
move((X1,X2,X3,X4,X5,X6,X7), (X1,X2,X3,X6,X5,X4,X7)) :-  X4 == '_';  X6 == '_'.
move((X1,X2,X3,X4,X5,X6,X7), (X1,X2,X3,X5,X4,X6,X7)) :-  X4 == '_';  X5 == '_'.
move((X1,X2,X3,X4,X5,X6,X7), (X1,X2,X3,X4,X7,X6,X5)) :-  X5 == '_';  X7 == '_'.
move((X1,X2,X3,X4,X5,X6,X7), (X1,X2,X3,X4,X5,X7,X6)) :-  X6 == '_';  X7 == '_'.


inicio :-  
    statistics(cputime,T1),
    pt_origem(X),
    busca([X], Solucao), 
    /* X  � o n� inicial, logo entra na lista inicial */
    reverse(Solucao, Sol_invertida),
    write_L(Sol_invertida),
    length(Sol_invertida, Total),
    pt_destino(Y),
    format('\n Onde a posicao inicial era: ~w ', X),
    format('\n A posicao final era: ~w', Y),
    format('\n Total de estados: ~d', Total), 
    Aux is (Total -1),
    format('\n Total de movimentos: ~w', Aux), 
    statistics(cputime ,T2),
    Temp is T2 - T1, 
    format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
    format('\n Tempo total: ~10f  msec', Temp), !.

inicio:- nl, write('Sem solu��o ... caminho n�o encontrado!').


/* pontos iniciais e finais do problema */
pt_origem(  ('b', 'a', 'c','_','_','_','_') ).
pt_destino( ('_', '_', '_','_','c','a','b') ).

/*************************************************************/

%% cond. de parada.... o n� corrente � o desejado
busca( [ No_final | Caminho] , [No_final|Caminho]):-
           pt_destino(No_final). 

busca( [Nodo|Caminho], Solucao):-
         move(Nodo , Novo_nodo), 
         not( member(Novo_nodo,[Nodo|Caminho])),
         busca( [Novo_nodo , Nodo | Caminho ] , Solucao).

/*************************************************************/
/*
   X2    X5
X1    X4    X7
   X3    X6
*/

w_amarelinha((X1,X2,X3,X4,X5,X6,X7)) :-
       write('  '), write(X2), write('  '), write(X5), nl,
       write(X1), write('  '), write(X4), write('  '), write(X7), nl, 
       write('  '), write(X3), write('  '), write(X6).
       
 
 write_L([]).
 write_L([X|L]):-  w_amarelinha(X), nl, nl, write_L(L).
/************************************************************//*
	(a) Conclua sobre as vantagens de cada algoritmos para este problema.
   
	Resposta: A busca em largura mostrou-se mais eficiente para a resolu��o deste
             problema. Pois alcan�ou a solu��o em somente 9 movimentos e gerando
             apenas 10 estados. J� a busca em profundidade alcan�ou a solu��o em
             28 movimentos, com 29 estados.

	(b) Analise os resultados. Resultados esperados versus obtidos.
	Resposta: Era esperado que a busca em largura fosse a mais eficiente devido a 
             forma que a �rvore � expandida neste tipo de busca. Como a �rvore 
             possui um n�mero finito de ramos todos os n�s da �rvore s�o alcan�a
             dos.


	(c) Sugira uma outra configura��o em que estes esquemas de buscas podem n�o
	funcionar e porque.
	Resposta: No caso de tertarmos chegar na solu��o, adicionando mais um jogador:

			   _    d
			_    a    b
			   _    c
		  
	          o numero de estados e movimentos sofre um aumento consider�vel.*/
