/*
Coloração de Mapas com Busca Tabu

Resolvendo o clássico problema da coloração dos mapas utilizando a busca tabu. 
Considerando que esta estratégia construtiva baseado em busca  locais, uma abordagem
rápida quanto a implementação, pode ser utilizada uma combinação  com uma busca em 
profundidade ou largura.
*/

/* VARIE O TAMANHO DA LISTA TABU E O NUMERO DE PASSOS */
i1 :-inic(5, 10).
i2 :-inic(25,10).
i3 :-inic(3,25).

inic(Tabu_size, N_max) :- 
	conf_inicial(Mapa_inic),
	busca_tabu(0, Tabu_size, Mapa_inic, [Mapa_inic], N_max , Sol),
	format('\n A resposta :: ~w', [Sol]), !.

/* gera uma coloracao INICIAL ao mapa -- CONF_INICIAL */
conf_inicial(L):- 
         findall( (P/X) , ( pais(P) , cor(X)), L ).
%        length(L, N),
%        format('\n Numero de paises: ~w \n :: ~w' , [N, L]).

/* BUSCA TABU:
   Aridade: 5
   N: num interacoes - MAX
   Tam: tamanho da lista tabu 
   Melhor_mapa_sol corrente
   L_Tabu_Historia com as melhores solucoes ateh entao
   Sol: Solução corrente
*/

/* Achou um resultado:  Mapa corrente = Solucao */
busca_tabu(N, Tam, Sol , L_tabu, Nmax, Sol ) :-
    colisoes(Sol,E),
    E == 0, /* é um dos melhores candidatos... */
    format('\n Solucao:: ~w \n Num Passos: ~w ', [Sol,N]),
    write('\n Nenhum pais em colisao :: OK '), !.

/* N = Nmax .. numero de iteracoes... */
busca_tabu(N, _ , Mapa_corrente, L_tabu, N , Mapa_corrente) :-
    length(L_tabu ,X),
    format('\n Tam Tabu: ~w ', [X]),
    imp_lst( L_tabu ), 
    colisoes(Mapa_corrente , Colisoes),
    format('\nMelhor sol: ~w  \n Passo:: ~w  Colisoes:: ~w', 
            [Mapa_corrente, N, Colisoes]),
    write('\n  .... Atingiu o maximo de iteracoes ....'), !.   

busca_tabu(N, Tam, Melhor_sol, L_Tabu_Historia , Nmax, Sol) :- 
      %% aqui admite uma variação ...
      %% nem sempre gerar muitos Candidatos ... 
      gera_N_candidatos( Tam, Melhor_sol , L_candidatos ),
      not(member_aux(L_candidatos ,  L_Tabu_Historia) ),
     
      /* escolher os melhores entre L_candidatos e L_tabu */
      constroi_L_tabu(Tam, L_candidatos, L_Tabu_Historia , L_tabu_nova),
      /* troca um novo estado por algum da lista tabu */
      seleciona_o_melhor(  Novo_Melhor, L_tabu_nova ),
      N_new is (1 + N), 
      colisoes(Novo_Melhor, Colisoes),
      format('\n Melhor: ~w \n => Passo: ~w \t Colisoes: ~w', [Novo_Melhor,N_new,Colisoes]),
%%%   imp_lst(L_tabu_nova),
      busca_tabu(N_new, Tam, Novo_Melhor , L_tabu_nova , Nmax, Sol).   

/* end of tabu search by ccs */
/*****************************************************************/


constroi_L_tabu(N, L1, L2 , L_tabu_nova) :-
/* idéia basica... concatena ... ordena ... selec os melhores */
      append(L1,L2,L3), 
      calc_colisoes(L3,L4),
      sort(L4,L5),
/*      
?- sort([[c]/3,[d]/4,[a]/1],X).
X = [[a]/1, [c]/3, [d]/4].
?- sort([3/[c],4/[d],1/[a]],X).
X = [1/[a], 3/[c], 4/[d]].
*/
      take_N_first(N, L5, L6),
      remove_prefix(L6,L_tabu_nova).

/*  o melhor vai estar na cabeça lista TABU ... sempre 
    devido a ordenaçao */
seleciona_o_melhor( X , [X|_] ) :- !. 
seleciona_o_melhor( _ , _ ) :- write(' Problemas em: seleciona_o_melhor').

take_N_first(_,[], _) :- write(' Problemas em: take_N_first').
take_N_first(1,[A|_],[A]) :- !. 
take_N_first(N,[A|L1],[A|L2]) :- 
             N_ant is (N-1),
             take_N_first(N_ant,L1,L2).

/* inserindo uma Valoração das colisões para cada uma das Soluções
   Sejam N mapas ... N valoraões */              
calc_colisoes([],[]).
calc_colisoes([A|L1],[Colisoes/A|L2]) :-             
              colisoes(A,Colisoes),
              calc_colisoes(L1,L2).

/* foi usado um valor de Colisoes para classificar 
    as melhores solucoes */
remove_prefix([],[]).
remove_prefix([Colisoes/A|L1],[A|L2]) :-             
              remove_prefix(L1,L2).

/* gera N candidatos */
gera_N_candidatos( 0, _ , []).
gera_N_candidatos( N, Melhor , [Cand|L_candidatos] ) :-
     N > 0,
     gera_um_candidato( Melhor , Cand),
     %% not_member ... aqui poderia se verificar ...
     %% aqui repeticoes entre os candidatos podem ocorrer...
     %% pense como gerar novos candidatos sem repetição
     New is (N - 1),
     gera_N_candidatos( New, Melhor, L_candidatos ).
  
/* gera_um_candidato  NOVO :: aleatorio */
gera_um_candidato( Melhor , Novo ):- 
     /* primeiro fazer um para um candidato ... depois reusar a idéia */
     length(Melhor, X),  
     gera_ind_aleat(X,I),
%%%  format('\n Tam Mapa: ~w  ... Indice Aleatorio: ~w', [X, I]),
     n_esimo(I,  Melhor, Novo).

gera_um_candidato( _ , _ ):- format('\n Problema no gera_um_candidato').

/* erro aqui.... */
n_esimo(1,[(P/C1)|L],[(P/C2)|L]):- nova_cor(C1,C2), !.
n_esimo(N,[X|L1],[X|L2]) :-
	   Nant is (N-1),
	   n_esimo(Nant,L1,L2).
     
/* Calcular todas colisoes */

colisoes(Mapa , Colisoes) :- col_aux(Mapa, Mapa, Total),  
			     Colisoes is (Total//2).
			     %% // divisao truncada

col_aux([], _, 0).
col_aux([(P/C) | T ], Mapa , E) :-
	 vizinho( P ,  Lviz), 
	 cores_dos_vizinhos( Lviz, Mapa, L_cores_viz ),
	 colisao_1( (P/C) , L_cores_viz , E_1 ), 
%	 format('\n Pais ~w ... Colisao individual:  ~w', [P, E_1]),
%	 format('\n Vizinhos e cores:: ~w', [L_cores_viz]),
         col_aux( T  , Mapa , E_2 ),
	 E is (E_1 + E_2).
%%	 format('\n Total de Colisoes:  ~w', [E]).


t1 :- conf_inicial(L) ,  colisoes(L,E),
      format('\n Total de Colisoes:  ~w', [E]).
t2 :- conf_inicial(L) ,  
       colisoes(L,E), 
       format('\n Candidato Inicial:  ~w', [L]),
       format('\n Total de Colisoes:  ~w', [E]), 
       gera_um_candidato( L , L2),
       colisoes(L2,E2), 
       format('\n Novo Candidato:  ~w', [L2]),
       format('\n Total de Colisoes:  ~w', [E2]).

t3 :-  conf_inicial(L) ,  
       gera_N_candidatos( 3, L , N_candidatos),
       length(N_candidatos,X), 
       imp_lst(N_candidatos),nl,
       write(X).             
       
t4:- conf_inicial([(A/C)|L]) , 
     t2([(A/C)|L]).

t2([(A/C)|L]) :-
     format('\n Pais :: ~w ', [A]),
      vizinho(A ,  Lviz), /* %% lista pronta abaixo */
	 cores_dos_vizinhos( Lviz, [(A/C)|L], L_viz_cores ),
	 format('\n Cores dos Vizinhos::  ~w', [L_viz_cores] ),
	 colisao_1( (A/C) , L_viz_cores , E_1 ), 
	 nl, 
	 write(E_1).
	

/* uma lista com as cores dos vizinhos */
/* passa a lista dos vizinhos ... e retorna este com cores .... */
cores_dos_vizinhos([], _ , [] ) :- !.
cores_dos_vizinhos( [A|B] , L_cand , [ (A/Cor) | T ] ) :-
    busca_cor(A, L_cand , Cor),
    cores_dos_vizinhos(B , L_cand, T ).

/*
?- cores_dos_vizinhos([brazil,bolivia, argentina],[argentina/2, antilles/4, bolivia/1, brazil/3, columbia/4, chile/3, ecuador/3, french_guiana/2, guyana/1, paraguay/1, peru/4, surinam/3, uruguay/4, venezuela/3],X).
*/

/* qual a cor do Pais na lista Candidata :: [ _ |T] */    
busca_cor(P, [], Cor) :- format('\n Problema na busca da cor').
busca_cor(P, [(P/Cor)|_], Cor) :- !.  %% ?- [a|[]] == [a].
busca_cor(P, [ _ |T ], Cor) :- 
         busca_cor(P, T , Cor).
/*
?- busca_cor(peru, [argentina/2, antilles/4, bolivia/1, brazil/3, columbia/4, chile/3, ecuador/3, french_guiana/2, guyana/1, paraguay/1, peru/4, surinam/3, uruguay/4, venezuela/3]
, X).
X = 4.
*/

/* Um Pais com todos vizinhos... mas tem que vir apenas os vizinhos */
colisao_1((P/C1), [], 0 ) :- !.
colisao_1((P1/C1), [(_/C2) | T], N) :- 
          C1 == C2, %% poderia ser omitidos.....
          colisao_1( (P1/C1) , T, N1), 
          N is (N1 + 1).
colisao_1( (P1/C1), [(P2/C2)|T], N ) :- 
          P1 \== P2, %% poderiam ser omitidos.....
          C1 \== C2,  %% idem ...
          colisao_1( (P/C1) , T, N). 
            

member_cor((P/C1), []) :- write(' nenhuma colisao  '), fail.
member_cor((_/C1), [(_/C1) | _]) :- !.
member_cor((_/C1), [ _| T]) :- 
           member_cor( (_/C1) , T). 

/*
?- member([a,b],[[a,a],[b],[a,b]]).
true .
*/
member_aux([], _).
member_aux([A|L1], L2) :-
         member(A,L2),
         member_aux(L1, L2).                    
        
/* gerador de numero aletorio de 1 a 4 */
num_aleat(X) :- 
        statistics(cputime ,T), 
        Semente is T * 100, 
        Temp is random(integer(Semente)), %% apenas random está OK
        X is (Temp mod 5) , 
        X > 0, X < 5, !.
num_aleat(Y) :- num_aleat(Y).

/* uma opção mais simples */
cor(X) :- X is random(5), /* sem backtraking */
          X > 0, !.
cor(X) :- cor(X).

/* simplesmente uma nova cor C2... a proxima  */     
nova_cor(C1,C2) :- C2 is random(5), /* sem backtraking */
                   C2 > 0, 
                   C2 \== C1, !.
nova_cor(C1,C2) :-  nova_cor(C1,C2).

/* algum valor entre 1 e X */
gera_ind_aleat(X,I):- 
                Aux is (X+1),
		I is random(Aux),
		I > 0, !.
gera_ind_aleat(X,I):- gera_ind_aleat(X,I).
         
imp_lst([]).
imp_lst([Cabeca|Cauda]):- nl,
                 write(Cabeca), 
                 imp_lst(Cauda).

/* MAPA DA AMÉRICA DO SUL */

pais(argentina).      pais(antilles).
pais(bolivia).        pais(brazil).
pais(columbia).       pais(chile).
pais(ecuador).        pais(french_guiana).
pais(guyana).         pais(paraguay).
pais(peru).           pais(surinam).
pais(uruguay).        pais(venezuela).


vizinho(argentina,[brazil,paraguay,bolivia,chile,uruguay]).
vizinho(bolivia,[brazil,paraguay,argentina,chile,peru]).
vizinho(brazil,[argentina,bolivia,columbia,guyana,peru,uruguay,french_guiana,paraguay,surinam,venezuela]).
vizinho(antilles,[venezuela]).
vizinho(chile,[peru,argentina,bolivia]).
vizinho(columbia,[brazil,ecuador]).
vizinho(ecuador,[columbia]).
vizinho(french_guiana,[brazil]).
vizinho(guyana,[brazil]).
vizinho(paraguay,[argentina,bolivia,brazil]).
vizinho(peru,[brazil,chile,bolivia]).
vizinho(surinam,[brazil]).
vizinho(uruguay,[brazil,argentina]).
vizinho(venezuela,[brazil,antilles]).%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
