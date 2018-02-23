/* 
BUSCA em PROFUNDIDADE - ILUSTRANDO as "montagens e desmontagens" das ARVORE
*/

:-inicio. % para nao precisar digitar inicio

inicio :-  
	no_origem(No_inicial),
	busca(No_inicial,  [No_inicial] , Solucao),
	reverse(Solucao, Sol_invertida), 
	no_destino(Y), nl,
	writeln("Onde o no de origem do mapa era: " :No_inicial),
	writeln("E o no de destino do mapa era: " :Y),
	writeln("SOLUCAO FINAL: " :Sol_invertida).

inicio:- write('Nao hah mais solucoes'), !.
       /* para terminar com yes */    
/************************************************/

/* Nós iniciais e finais do problema */
no_origem(1).
no_destino(9).

/******************************************
 * Rrepresentação de um MAPA QUALQUER     *
 *****************************************/
/* MODELAGEM do Problema ===> desenhe o mapa */
a(1, 2).   a(1, 3). 
a(2, 4).   a(2, 6).
a(4, 8).   a(6, 10).
a(8, 12).  a(14, 12).
a(7, 3).   a(7, 11). a(11, 13). a(13, 15). 
a(5, 3).   a(5, 9). 

/* Desenhe as DIVERSAS ARVORES POSSIVEIS */
/* contudo a TOPOLOGIA (formato) eh UNICA */
/* para não ter que reescrever que:
  a(X) \== a(Y). 
*/

conexao(X,Y) :- a(X,Y).
conexao(X,Y) :- a(Y,X).

/*************************************************************/

%% cond. de parada.... o nó corrente é o nó desejado = nó final
busca( No_final, [ No_final | Caminho] , [No_final|Caminho]):-
           no_destino(No_final). 
%% termina a busca...

busca(Noh,  [Noh|Caminho], Solucao):-
	 conexao(Noh , Novo_nodo), /* proximo no  = estado */
	 not( member(Novo_nodo,[Noh|Caminho])), 
	 /* verifica se não foi visitado */
	 /* imprimindo possiveis bons candidatos */
	 reverse( [Novo_nodo,Noh|Caminho], Sol_PARCIAL),
	 writeln("Sol_PARCIAL" : Sol_PARCIAL),
	 
	 busca( Novo_nodo, [Novo_nodo , Noh | Caminho ] , Solucao).

/******************************************************/
