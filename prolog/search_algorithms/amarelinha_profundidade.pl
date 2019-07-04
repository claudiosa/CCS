/*
 Faça a análise do Espaço de Estados que forneça o número total de estados. 
	Descubra a expressão combinatória que forneça aproximadamente este valor.

        Resposta: estado inicial: ('b', 'a', 'c','_','_','_','_') 
                  estado final  : ('_', '_', '_','_','c','a','b')
                  numero total de estados: 42
                  Cada posição pode ter os valores, a,b,c ou _ .
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
    /* X  é o nó inicial, logo entra na lista inicial */
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

inicio:- nl, write('Sem solução ... caminho não encontrado!').


/* pontos iniciais e finais do problema */
pt_origem(  ('b', 'a', 'c','_','_','_','_') ).
pt_destino( ('_', '_', '_','_','c','a','b') ).

/*************************************************************/

%% cond. de parada.... o nó corrente é o desejado
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
   
	Resposta: A busca em largura mostrou-se mais eficiente para a resolução deste
             problema. Pois alcançou a solução em somente 9 movimentos e gerando
             apenas 10 estados. Já a busca em profundidade alcançou a solução em
             28 movimentos, com 29 estados.

	(b) Analise os resultados. Resultados esperados versus obtidos.
	Resposta: Era esperado que a busca em largura fosse a mais eficiente devido a 
             forma que a árvore é expandida neste tipo de busca. Como a árvore 
             possui um número finito de ramos todos os nós da árvore são alcança
             dos.


	(c) Sugira uma outra configuração em que estes esquemas de buscas podem não
	funcionar e porque.
	Resposta: No caso de tertarmos chegar na solução, adicionando mais um jogador:

			   _    d
			_    a    b
			   _    c
		  
	          o numero de estados e movimentos sofre um aumento considerável.*/
