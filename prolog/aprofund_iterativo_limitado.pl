
:-format('Predicados para teste: inic_1(Step) , inic_2(N), inic_3(N) ').
/* MODELAGEM DO PROBLEMA - UMA BUSCA SIMPLES EM ARVORE -- 04/10 */

/* Inicialmente: desenhe esta árvore como exercício */
arco(1,2). arco(2,3). arco(3,4). arco(4,5). arco(5,6). arco(6,7).
arco(7,8). arco(8,9). arco(9,10). arco(10,11).

arco(1,12). arco(12,13). arco(13,14). arco(14,15). arco(15,16).
arco(16,17). arco(17,18). arco(18,19). arco(19,20). arco(20,21).

arco(1,22). arco(22,23).  arco(23,24). arco(24,25). arco(25,26).
arco(26,27). arco(27,28). arco(28,29). arco(29,30). arco(30,31).

/* definiçao de um nó de parada */
objetivo(7).  /* PARADA OU GOAL */

/* ARGUMENTOS: APROFUNDAMENTO ITERATIVO */
/* aridade: 7
1o. Arg: prof inicial ... 1 considerando a raiz
2o. Arg: Contador do aprofundamente sucessivo
3o. Arg: o nó inicial
4o. Arg: histórico de nós visitados
5o. Arg: Passo do aprofundamento -- BASE ... de B em B
6o. Arg: Recomeçar a partir do nó 1 no caso ...
7o. Arg: Todas solucoes.
*/
inic_1(Step) :- apr_iterativo(1, 0 , 1, [1], Step , 1, X),          
          reverse(X,Y),
          format('\n SOLUCAO (apr_iterativo) :: ~w \n', [Y]).

apr_iterativo(N, H, No_atual, [No_atual|Historia],  _ , _, Ltudo) :-
      objetivo(X),
      nonvar(Ltudo),
      member_aux(X, Ltudo), /* achou em uma lista de retorno */
      write('\n Parou  com:: '),
      write(No_atual),
      write([No_atual|Historia]),
      write('\n N (parte da raiz):: '), write(N),
      write('\n H (foi até esta profundidade):: '), write(H),
      write('\n Todas Soluções:: '), write(Ltudo),!.

apr_iterativo(N, H, No_atual, [No_atual|Historia], Base, No_Inicial, _ ) :-
      Hnew is H + Base,
      %% Base é o incremento do aprofundamento
      findall(Sol,
              profundidade_limitada(N, Hnew , No_atual, [No_atual|Historia], Sol),
              Ltudo),
       write('\n ... Iterativo ::'), write(Ltudo),             
      /* vai recomeçar sempre da raiz, esta parte poderia ser otimizada
        ... recomeçar de onde parou 
        */
      apr_iterativo(N, Hnew, No_Inicial, [No_Inicial|Historia],  Base, No_Inicial, Ltudo).     
     
/*
Exercício: pensar no caso do nó goal não estiver na árvore....
apr_iterativo( _ , _ , _ ,  _ , _ , _ ,  Ltudo) :-
      objetivo(X),
      nonvar(Ltudo),
      not(member_aux(X, Ltudo)),
      write('\n Não ACHOU em :: '), write(Ltudo).
*/

     
/* ARGUMENTOS:  PROFUNDIDADE_LIMITADA */
/* aridade: 5
1o. Arg: profundida do nó corrente
2o. Arg: Limite  De Prof (max)
3o. Arg: No_atual ou corrente
4o. Arg: Historia: armazenamento do caminho
5o. Arg: Sol, retorno por casamento nas clausulas 1 e 2
*/

inic_2(N) :- profundidade_limitada(1, N, 1, [1],X),          
       reverse(X,Y),
       format('\n SOLUCAO (prof_limitada) :: ~w \n', [Y]).

profundidade_limitada(N, _ , No_atual, [No_atual|Historia], [No_atual|Historia]):-
                 objetivo(X), X == No_atual,
                 format('\n Prof. Limitada: ~w \n', [N]), 
                 write([No_atual|Historia]), !.
                 
profundidade_limitada(N, H , No_atual, [No_atual|Historia], [No_atual|Historia]):-
                 N >= H,
                 write('\n Não achou nada com N::'), write(N),
                 objetivo(X), write('\n Nó objetivo era: '),
                 write(X), write('\n Historia ATEH ENTAO:'),
                 write([No_atual|Historia]),!.
/*
%% alcançou a profundidade ... parada com casamento N == LimiteDeProf
profundidade_limitada(LimiteDeProf, LimiteDeProf,  No_atual , [No_atual|Historia], Sol ):-
    profundidade_limitada(LimiteDeProf, LimiteDeProf, No_atual, [No_atual|Historia], Sol).
*/

profundidade_limitada(N, LimiteDeProf, No_atual, Historia, Sol):-
        arco(No_atual,No_Filho),
        not(member(No_Filho, Historia)),
        New is N + 1,
        profundidade_limitada(New, LimiteDeProf, No_Filho, [No_Filho|Historia], Sol).

/************************ */
member_aux( _ , [[]]).
member_aux(X, [A| _]) :- member(X, A), !.
member_aux(X, [_| B]) :- member_aux(X, B).

/*************************/

     
/* ARGUMENTOS:  PROFUNDIDADE_LIMITADA - VERSAO 2*/
/* aridade: 4
1o. Arg: Limite  De Prof (max) -- irá sendo decrementada ....
2o. Arg: No_atual ou corrente -- apenas para fins didáticos
3o. Arg: Historia: armazenamento do caminho
4o. Arg: Sol, retorno por casamento nas clausulas 1 e 2
Idéia vinda dos alunos
*/

inic_3(N) :- prof_limitada_2(  N , 1, [1], X),
             reverse(X,Y),
             format('\n SOLUCAO (prof_limitada_2) :: ~w \n', [Y]).
          
prof_limitada_2( _ , No_atual, [No_atual|Historia], [No_atual|Historia]):-
                 objetivo(X),
                 X == No_atual,
                 length([No_atual|Historia] , N),
                 format('\n Prof. Corrente: ~w \n', [N]), 
                 write([No_atual|Historia]), !.

prof_limitada_2(N, No_atual, Historia, Sol):-
        N > 0,
        arco(No_atual,No_Filho),
        not(member(No_Filho, Historia)),
        New is (N - 1),
        prof_limitada_2(New, No_Filho, [No_Filho|Historia], Sol).
                 
prof_limitada_2( _, No_atual, [No_atual|Historia], [No_atual|Historia]):-
                 write('\n NAO ACHOU NADA '),
                 objetivo(X), write('\n Nó objetivo era: '),
                 write(X),
                 write('\n Última tentativa válida:'),
                 write([No_atual|Historia]),!.
/*************************************************************/
/*
?- inic_3(9).

 Prof. Corrente: 7
[7, 6, 5, 4, 3, 2, 1]
 SOLUCAO (prof_limitada_2) :: [1, 2, 3, 4, 5, 6, 7]
true .

?- inic_2(9).

 Prof. Limitada: 7
[7, 6, 5, 4, 3, 2, 1]
 SOLUCAO (prof_limitada) :: [1, 2, 3, 4, 5, 6, 7]
true .

?-
*/
