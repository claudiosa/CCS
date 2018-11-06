/* 
BUSCA em PROFUNDIDADE - MAPA da CIDADE 
*/

inicio(Sol_invertida) :-  
	no_origem(No_inicial),
	busca(No_inicial,  [No_inicial] , Solucao),
	reverse(Solucao, Sol_invertida), 
	write(Sol_invertida),
	no_destino(Y), nl,
	write('Onde o no de origem do mapa era: '), write(No_inicial), nl,
	write('E o no de destino do mapa era: '), write(Y).

inicio('Nao hah mais solucoes'):- !.
       /* para terminar com yes */    
/************************************************/

/* Nós iniciais e finais do problema */
no_origem(casa).
no_destino(teatro).

/******************************************
 * Rrepresentação de um MAPA QUALQUER     *
 *****************************************/
/* MODELAGEM do Problema ===> parte mais dificil */
a(casa, hospital). 
a(casa, clube).
a(hospital, parque).
a(hospital, farmacia ).
a(farmacia, udesc).
a(teatro, farmacia ).
a(fabrica, clube).
a(fabrica, teatro).

/* para não ter que reescrever que:
  a(fabrica, teatro) \== a(teatro,fabrica). 
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
	 busca( Novo_nodo, [Novo_nodo , Noh | Caminho ] , Solucao).

/******************************************************/
/*
?- inicio(X).
[casa, hospital, farmacia, teatro]
Onde o no de origem do mapa era: casa
E o no de destino do mapa era: teatro

X = [casa, hospital, farmacia, teatro] ;
[casa, clube, fabrica, teatro]
Onde o no de origem do mapa era: casa
E o no de destino do mapa era: teatro

X = [casa, clube, fabrica, teatro] ;

X = 'Nao hah mais solucoes' ;

No
?- 
*/
