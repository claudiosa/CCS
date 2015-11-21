/* 

BUSCA em PROFUNDIDADE LIMITADA

*/

:-inicio. % para nao precisar digitar inicio

inicio :-  
	%%!, %%% forcar novos caminhos nao testados
	Max_Depth = 4,   %%%% defina Max_Depth: 3, 4, 5
	no_origem(No_inicial),
	busca_limitada(Max_Depth , 1, No_inicial,  [No_inicial] , Solucao),
	%%% falhando
	reverse(Solucao, Sol_invertida), 
	no_destino(Y), nl,
	writeln("Onde o no de origem do mapa era: " :No_inicial),
	writeln("E o no de destino do mapa era: " :Y),
	writeln("SOLUCAO FINAL: " :Sol_invertida).

inicio:- write('Nao hah mais solucoes -- ou sem solucao'), !.
       
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

%% 1a cond. de parada.... o nó corrente é o nó desejado = nó final
busca_limitada(Max_Depth, Depth, No_curr, [ No_curr | Caminho] , [No_curr|Caminho]):-
	Depth =<  Max_Depth ,
	no_destino(No_final),
	No_curr == No_final, !.

%%%%% terminar a busca... Depth >  Max_Depth ......
%%% 2a cond. de parada....
busca_limitada(Max_Depth, Depth, No_curr, [ No_curr | _ ] , _ ):-
	no_destino(No_final),
	Depth  >  Max_Depth,  %% falha 1
	No_curr \== No_final, %% falha 2
	writeln("Usou o fail .... mas PARA antes"),
	fail . %% falhou 
%%% nao achou nada por esta instancia 


%% duplicar esta parte com 
busca_limitada(Max_Depth, Depth, Noh,  [Noh|Caminho], Solucao):-
	 %%% adicionando um contador e seu teste ateh....
	 Depth  <  Max_Depth, 
	 conexao(Noh , Novo_nodo), /* proximo no  = estado */
	 /* verifica se não foi visitado */
	 not( member(Novo_nodo,[Noh|Caminho])), 
	 /* imprimindo possiveis bons candidatos */
	 reverse( [Novo_nodo,Noh|Caminho], Sol_PARCIAL),
	 writeln("Sol_PARCIAL" : Sol_PARCIAL),
	 %%% o contador adicionando ....
	 New_Depth is (1+ Depth),
	busca_limitada(Max_Depth, New_Depth, Novo_nodo, [Novo_nodo , Noh | Caminho ] , Solucao).


/******************************************************/
