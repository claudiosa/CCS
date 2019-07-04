
/* AMARELINHA COM BUSCA em PROFUNDIDADE  ITERATIVA n = 3, 5, 7 */
/* Estrategia: usa o com profundidade limitada ... de modo
   a ir incrementado o passo da iteratividade. A respostas
   seguem desde a melhor solucao (menor profundidade) a pior
*/   


/*
								   X2    X5
								X1    X4    X7
								   X3    X6
*/
move((X1,X2,X3,X4,X5,X6,X7), (X1,X4,X3,X2,X5,X6,X7)) :-  X2 == '_';  X4 == '_'. 
move((X1,X2,X3,X4,X5,X6,X7), (X1,X2,X4,X3,X5,X6,X7)) :-  X3 == '_';  X4 == '_'.
%% retornos afim de evitar lacos
move((X1,X2,X3,X4,X5,X6,X7), (X2,X1,X3,X4,X5,X6,X7)) :-  X2 == '_'. %%;  X1 == '_'.
move((X1,X2,X3,X4,X5,X6,X7), (X3,X2,X1,X4,X5,X6,X7)) :-  X3 == '_' . %%%;  X3 == '_'.
move((X1,X2,X3,X4,X5,X6,X7), (X1,X2,X3,X6,X5,X4,X7)) :-  X4 == '_';  X6 == '_'.
move((X1,X2,X3,X4,X5,X6,X7), (X1,X2,X3,X5,X4,X6,X7)) :-  X4 == '_';  X5 == '_'.
move((X1,X2,X3,X4,X5,X6,X7), (X1,X2,X3,X4,X7,X6,X5)) :-  X5 == '_';  X7 == '_'.
move((X1,X2,X3,X4,X5,X6,X7), (X1,X2,X3,X4,X5,X7,X6)) :-  X6 == '_';  X7 == '_'.

/* Responda:
1. Alguns movimentos poderiam ser suprimidos... quais? 
2. Isto implica em que? 
3. Indica quais sao redundantes e execute novamente o experimento.
4. Conclua o que.
*/


/* profundidade_limitada(Vi, Vf , No_atual, [No_atual|Historia], [No_atual|Historia]) Uma primeira solucao ... */
t0 :- profundidade_limitada(0, 30 , ('b', 'a', 'c','_','_','_','_'),
                      [ ('b', 'a', 'c','_','_','_','_') ], Sol), 
        reverse(Sol,INV), 
        length(Sol,N),
        format('\n Resposta sem formatacao:: \n ~w', [INV]),
        format('\n Profundidade da 1a. solucao::  ~w', [N]).
         %%%   write_L(INV).

/* todas solucoes até um limite de 10 */
t1:-  findall( Sol, (apenas_sol_OK_prof_limitada(1, 10 ,
		  ('b', 'a', 'c','_','_','_','_'),
		  [ ('b', 'a', 'c','_','_','_','_') ] , Sol)),
		Ltodas),
       length(Ltodas,N), 
       format('\n Respostas sem formatacao:: \n ~w', [Ltodas]),
       write_lista_linha(Ltodas),
       format('\n Total de solucoes ateh 10 ::  ~w', [N]).
       

/* Estudando o numero de solucoes */
n_sol(0).
n_sol(N) :- 
   findall( Sol,  apenas_sol_OK_prof_limitada(1, N , ('b', 'a', 'c','_','_','_','_'),[ ('b', 'a', 'c','_','_','_','_') ], Sol), L),
 length(L,Tam), 
 format('\n Numero de solucoes:: ~w :: ateh a profundidade:: ~w', [Tam,N]),
 N1 is N-1,
 n_sol(N1).

inic_2 :- %% saltos de 2
      statistics(cputime,T1),
      apr_iterativo(1, 1 , ('b', 'a', 'c','_','_','_','_'),
                   [ ('b', 'a', 'c','_','_','_','_') ],
                   2, ('b', 'a', 'c','_','_','_','_'),  _ ),
                     
      %write('\n Todas as Soluções:: '),  write_L(Ltudo), 
      %length(Ltudo,X), 
      %format('\n Numero de solucoes:: ~w', [X]),
      statistics(cputime ,T2),
      Temp is T2 - T1, 
      format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
      format('\n Tempo total: ~10f  msec', Temp).


inic_5 :- 
	 %var(Ltudo), 
	 statistics(cputime,T1),
	 apr_iterativo(1, 1 , ('b', 'a', 'c','_','_','_','_'),
			   [ ('b', 'a', 'c','_','_','_','_') ],
			   5, ('b', 'a', 'c','_','_','_','_'),  _ ),
	statistics(cputime ,T2),
	Temp is T2 - T1, 
	format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
	format('\n Tempo total: ~10f  msec', Temp).


inic_7 :- %%% idem 7
      statistics(cputime,T1),
      apr_iterativo(1, 1 , ('b', 'a', 'c','_','_','_','_'),
                   [ ('b', 'a', 'c','_','_','_','_') ],
                   7, ('b', 'a', 'c','_','_','_','_'),  _ ),
      statistics(cputime ,T2),
      Temp is T2 - T1, 
      format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
      format('\n Tempo total: ~10f  msec', Temp).

/* Noh final */
objetivo( ('_', '_', '_','_','c','a','b') ).

/* 
No do aprofundamento  ir além de um valor estimado de profundidade:: profundidade_limitada      
ou no caso do nó goal não estiver na árvore....
*/  

/* aridade: 7
1o. Arg: Uma profundidade do inicial ... 1 considerando a raiz {0 ou 1}
2o. Arg: O limite do aprofundamente sucessivo -- H
3o. Arg: O nó inicial do problema
4o. Arg: Histórico de nós visitados  a partir do noh inicial
5o. Arg: Passo do aprofundamento -- BASE ou Salto ... de B em B
6o. Arg: Recomeçar a partir do noh 1 no caso ...
7o. Arg: Retorna todas solucoes ateh o limite H
*/
apr_iterativo(_, H , _, _,  _ , _,  _) :-
      H > 33, %%% deve estourar a heap ...
      write('\n Ultrapassou um limite estimado de aprofundamento e sem uma solucao '), 
      !.

apr_iterativo(N, Hmax, No_atual, [No_atual|Historia], Base, _, Ltudo ) :- 

findall(Sol, 
	apenas_sol_OK_prof_limitada(N, Hmax , No_atual, [No_atual|Historia], Sol), 
    	Ltudo),
	length(Ltudo,X), 
	format('\n Respostas uma por linha:'),              
	write_lista_linha(Ltudo),  
	format('\n Numero de solucoes:: ~w  ateh o limite profundidade:: ~w', [X,Hmax]),         
	Ltudo \== [] , 
%%   get(_),
   !. 
	  
/* aprofunda, pois não achou ainda a solução até H */          
apr_iterativo(N, H, No_atual, [No_atual|Historia], Base, No_Inicial, _ ) :- 
  	Hnew is H + Base, 
  	%% Base é o incremento do aprofundamento        
    %% write('\n Iterativo ::'), write(Ltudo),           
    apr_iterativo(N, Hnew, No_Inicial, [No_Inicial|Historia],  Base, No_Inicial, _).

/* 
  Antes de chamar um novo aprofundamento iterativo ... pegar apenas SOL com
  respostas validas do prof. limitada
 */   
 
apenas_sol_OK_prof_limitada(N, Hnew , No_atual, [No_atual|Historia], Sol) :-
    profundidade_limitada(N, Hnew , No_atual, [No_atual|Historia], Sol),
	objetivo(X),
    nonvar(Sol),
    member(X, Sol).

%%% apenas_sol_OK_prof_limitada(_, _ , _, _, []) :- fail.    

/************ Profundidade Limitada *************/
/* aridade: 5
1o. Arg: Profundidade do nó corrente inicial (1 ou 0)
2o. Arg: Limite  De Prof (max)
3o. Arg: No_atual ou corrente
4o. Arg: Historia: armazenamento do caminho
5o. Arg: Sol, retorno por casamento nas clausulas 1 e 2
*/

profundidade_limitada(N, H , No_atual, [No_atual|Historia], [No_atual|Historia]):-
     objetivo(X), X == No_atual, 
%     format('\n Uma solucao com prof. limitada em: ~w \n',  N ),
%     write_L([No_atual|Historia]),  
     !.
                
%% profundidade_limitada(N, LimiteDeProf , No_atual, [No_atual|Historia], [No_atual|Historia]):-
%% retorna  lista vazia caso N >= LimiteDeProf talvez a opcao acima possa 
%% ser interessante
profundidade_limitada(N, LimiteDeProf , No_atual, [No_atual|Historia], []):-
      N > LimiteDeProf,
/*    
   write('\n Não achou nada com N::'), write(N),
   objetivo(X), write('\n Nó objetivo era: '),
   write(X), write('\n Historia:'),
   write([No_atual|Historia]),
*/               
     !.

profundidade_limitada(N, LimiteDeProf, No_atual, Historia, Sol):-
	/* arco(No_atual, No_Filho), modelagem do problema */
	move(No_atual , No_Filho), 
	not(member(No_Filho, Historia)),
	New is N + 1,
	profundidade_limitada(New, LimiteDeProf, No_Filho, [No_Filho|Historia], Sol).

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

 write_lista_linha([]).
 write_lista_linha([X|L]):- format('\n ==> ~w' , [X]), write_lista_linha(L).

/************************************************************/
member_aux( _ , [[]]).
member_aux(X, [A| _]) :- member(X, A), !.
member_aux(X, [_| B]) :- member_aux(X, B).
/*************************************************************/
