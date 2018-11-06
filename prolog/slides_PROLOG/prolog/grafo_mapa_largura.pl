/* 
BUSCA EM LARGURA - PROBLEMA DO MAPA
*/
/******************************************
 * Rrepresenta��o de um MAPA/GRAFO QUALQUER     *
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

/*
                  casa
            /             \
         hospital          clube
         /    \                \
   parque   farmacia          fabrica   
             /  \                  \
        udesc  teatro             teatro  

*/

/* para n�o ter que reescrever que:
  a(fabrica, teatro) \== a(teatro,fabrica). 
*/

conexao(X,Y) :- a(X,Y).
conexao(X,Y) :- a(Y,X).

/* N�s iniciais e finais do problema */
no_origem(casa).
no_destino(parque).
/*************************************************************/
inicio(Sol_invertida) :-  
    statistics(cputime,T1),
    no_origem(No_inicial),
    busca_L([[No_inicial]], Solucao), /* lista de lista */
    /* N� inicial: entra na lista inicial */
    reverse(Solucao, Sol_invertida),
    length(Sol_invertida, Total),
   	no_destino(FIM), nl,
   	format('\n CAMINHO PERCORRIDO: ~w ', [Sol_invertida]),
	format('\n N� de origem do mapa era: : ~w ', [No_inicial]),
    format('\n N� de destino do mapa era: ~w', [FIM]),
    format('\n Total de estados: ~d', Total), 
    Aux is (Total -1),
    format('\n Total de movimentos: ~w', Aux), 
    statistics(cputime ,T2),
    Temp is T2 - T1, 
    format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
    format('\n Tempo total: ~10f  msec', Temp).
	

inicio('Nao hah mais solucoes'):- !.
       /* para terminar com yes */    
/*********************************************************/
todas_solucoes:- findall(X, inicio(X), L), 
                 write('\n RESUMO DAS SOLUCOES :'),
                 w_L(L).
/*************************************************************/
%% condi��o de parada.... o n� corrente � o desejado
busca_L(  [ [No_corrente|Caminho] |_] , [No_corrente | Caminho ] ):-
          no_destino(No_final),
          member(No_final, [No_corrente|Caminho]). 
          %% termina a busca...

/* parte recursiva geral  => DETALHE: LISTA DE LISTA */
busca_L([Nodo|Caminho],Solucao):-
         expandir(Nodo, Expansao_do_NODO ),
         /* na primeira vez Caminho = [] */
         append(Caminho, Expansao_do_NODO, Novos_caminhos),
         /* observar que o append est� ao contr�rio....  fazendo
         que no pr�ximo passo Nodo, seja um proximo deste n�vel */
         busca_L(Novos_caminhos , Solucao).

expandir([Nodo|Caminho],Novos_caminhos) :-
         findall([Novo_nodo, Nodo|Caminho],
         (conexao(Nodo, Novo_nodo),
          not(member(Novo_nodo,[Nodo|Caminho]))),
          Novos_caminhos), !. /* ultima linha do findall */

expandir(_,[]):- !.

/******************************************************/
w_L([]).
w_L([A|Cauda]):- format('\n ==> ~w ', [A]), 
                 w_L(Cauda).
/******************************************************/
/*
SAIDA:
?- inicio(X).


 CAMINHO PERCORRIDO: [casa, hospital, parque] 
 N� de origem do mapa era: : casa 
 N� de destino do mapa era: parque
 Total de estados: 3
 Total de movimentos: 2
 T1: 0.090000 	 T2: 0.090000  msec
 Tempo total: 0.0000000000  msec
X = [casa, hospital, parque] .

?- todas_solucoes.


 CAMINHO PERCORRIDO: [casa, hospital, parque] 
 N� de origem do mapa era: : casa 
 N� de destino do mapa era: parque
 Total de estados: 3
 Total de movimentos: 2
 T1: 0.090000 	 T2: 0.090000  msec
 Tempo total: 0.0000000000  msec

 CAMINHO PERCORRIDO: [casa, clube, fabrica, teatro, farmacia, hospital, parque] 
 N� de origem do mapa era: : casa 
 N� de destino do mapa era: parque
 Total de estados: 7
 Total de movimentos: 6
 T1: 0.090000 	 T2: 0.090000  msec
 Tempo total: 0.0000000000  msec
 RESUMO DAS SOLUCOES :
 ==> [casa, hospital, parque] 
 ==> [casa, clube, fabrica, teatro, farmacia, hospital, parque] 
 ==> Nao hah mais solucoes 
true.

?- 
*/
