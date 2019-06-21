
/*
Coloração de Mapas com SA e Hill-Climbing

Reuso de predicados da Busca Tabu para o mesmo problema.
Foram predicados adaptados ... ou reusados.
CONSTRUA O MAPA, DEFINIDO AO FINAL DESTE CÓDIGO
*/

inic:-
  conf_inicial(Mapa_inic,Size),
   
  T is 5 * Size,   /* Uma heuristica: number of iterations per temperature  */
  Alfa is 0.9,     /* Taxa de redução da temperatura. Ex:  90% da anterior */
  %colisoes(Mapa_inic,Col),
  format('\n Mapa Inicial:: ~w \n Alfa: ~w \n Temperatura: ~w  ',[Mapa_inic, Alfa, T]),
  %trace,
  busca_SA(0, T, Alfa,  Mapa_inic, 100 , Sol),
  format('\n A resposta :: ~w', [Sol]), !.

/* ARIDADE DO SA:
   N: num interacoes
   T: temperatura ... para do problema
   Melhor_mapa_sol corrente
   N_max: parada após xxx iterações
*/

/* Achou resultado  Mapa corrente = Solucao */
busca_SA(N, T, _ ,  Sol , _ , Sol) :-
    colisoes(Sol,E),
    E == 0, /* é um dos melhores candidatos... */
    format('\n Solucao:: ~w \n Num Passos: ~w \n Temperatura: ~w ', [Sol,N, T]),
    write('\n Nenhum pais em colisao :: OK '), !.

/* N = Nmax .. numero de iteracoes... */
busca_SA(N, T , _, Mapa_corrente,  N , Mapa_corrente) :-
    length(L_tabu ,X),
    format('\n Solucao:: ~w \n Num Passos: ~w \n Temperatura: ~w  ', [Sol,N, T]),
    colisoes(Mapa_corrente , Colisoes),
    format('\nMelhor sol: ~w  \n Passo:: ~w  Colisoes:: ~w', [Mapa_corrente, N, Colisoes]),
    write('\n  .... Atingiu o maximo de iteracoes ....'), !.   

busca_SA(N, T , Alfa, Melhor_sol,  N_max, Sol) :- 
       gera_um_candidato( Melhor_sol , Candidato ),
%%    format('\n Melhor: ~w \n => Candidato: ~w \t ', [Melhor_sol , Candidato ]),       
      /* aplicar criterios do SA com base neste vizinho da Melhor_sol */
      
      aplica_anneal( T, Melhor_sol , Candidato , Novo_Melhor ) ,
      
      N_new is (1 + N), 
      T_new is Alfa * T,
      format('\n Melhor: ~w \n => Passo: ~w \t ', [Novo_Melhor , N_new]),
      busca_SA(N_new , T_new , Alfa,  Novo_Melhor ,  N_max, Sol).   

/*****************************************************************/
/* 	APLICAR O RECOZIMENTO -- ANNEALING */

aplica_anneal( _ , Melhor_sol, Candidato,  Candidato):- 
  colisoes(Melhor_sol , E1),
  colisoes(Candidato , E2),
  Delta is (E2 - E1),  
  /* se Delta < 0 .... logo o Candidato era melhor */
  Delta < 0, 
  format('\n Trocou ::  Delta: ~w \t E_ant: ~w \t E_novo: ~w  ', [Delta, E1, E2]), !.

/* PARA O CASO DO HILL-CLIMBING ... BASTA REMOVER ESTA PARTE DO PREDICADO
   AQUI ESTÁ O SALTO ESTOCÁSTICO, O QUE NO HILL-CLIMBING É POR VIZINHANÇA */
/* Delta >= 0 ... ou está parado (E1 = E2) .... 
   ou o Melhor ... é melhor por enquanto 
*/
aplica_anneal( Temp, Melhor_sol , Candidato ,  Novo_melhor):- 
  colisoes(Melhor_sol , E1),
  colisoes(Candidato , E2),
  Delta is (E2 - E1), 
  Probabilidade is 1/(exp( (Delta) / Temp)) , 
  /*  PROBABILIDADE =  -(exp( (Delta) / Temp)) */
  Num_perturbar is round( (Probabilidade * E1 )),
  %%% round arredonda para cima
  %%% floor para baixo ... 
 format('\n Delta: ~w \t E1: ~w \t Probabilidade: ~w  \t  Perturbar: ~w  \t  Temp: ~w ', 
        [Delta, E1,  Probabilidade, Num_perturbar, Temp ]), 
 %% NESTE PREDICADO PODE MODIFICAR A HEURISTICA DE TUDO
  perturbacao(Num_perturbar, Melhor_sol, Novo_melhor), !.
  
 aplica_anneal( _ , _ , _ , _) :-  format('\n Problemas no aplica_anneal').
 
/***********************************************************************************/
/* gera uma coloracao inicial ao mapa  */
conf_inicial(L,N):- 
         findall( (P/X) , ( pais(P) , cor(X)), L ),
         length(L, N).
/***********************************************************************************/
%% NESTE PREDICADO PODE MODIFICAR A HEURISTICA DE TUDO
/* gera_um_candidato  NOVO :: aleatorio */
gera_um_candidato( Melhor , [(Pais/C2)|L] ):- 
/* primeiro fazer um para um candidato ... depois reusar a idéia */
      calc_colisoes_pais(Melhor,L4, Melhor),
      sort(L4,L5),
      reverse(L5,L6),
      remove_prefix(L6, [(Pais/C1)|L]),
%     format('\n L6: ~w \n Cand_melhor :: ~w\n' , [L6, [(Pais/C1)|L]]),
      nova_cor(C1,C2), !.
gera_um_candidato( _ , _ ):- format('\n Problemas no gera_um_candidato').
            
/* Heurisitica usada :
   Se criou um novo candidato ... com base no pais com
   maior numero de colisoes      
   Uma única vez !!!!
   
 ?- gera_um_candidato([argentina/1, antilles/4, bolivia/2, brazil/3, columbia/1, chile/4, ecuador/2, french_guiana/2, guyana/1, paraguay/3, peru/2, surinam/4, uruguay/1, venezuela/1],X).
*/   
/***********************************************************************************/
/* perturbar apenas os N primeiros.... melhorar aqui.... 
   Ordenando os que mais colidem 
   Pense outras maneiras de fazer esta perturbacao 
*/
         
perturbacao(N, Melhor, Novo_melhor) :- 
/*   acerta o mapa em funçaão do numero de colisoes */
/*   modo ascendente */
	calc_colisoes_pais(Melhor,L4, Melhor),
    sort(L4,L5),
    reverse(L5,L6),
    remove_prefix(L6, [(Pais/Cor)|L]),
%%% format('\n L6: ~w \n outro :: ~w' , [L6, [(Pais/Cor)|L]]),            
    aux_pertur(N, [(Pais/Cor)|L], Novo_melhor). 

/* ****************************** ************************** */
/* TROCAR A COR DE N PAISES .... E OS MAIS CONFLITANTES.... */
aux_pertur(0, X, X). 
aux_pertur(N, [(A/C1)|Melhor_sol], [(A/C2)|Novo_melhor]) :-
     nova_cor(C1,C2),
     Nant is (N-1),
     aux_pertur(Nant, Melhor_sol, Novo_melhor).
/* ****************************** */  
  
/* inserindo uma Valoração de quanto cada país colide com seu vizinho  */            

t0 :- calc_colisoes_pais([argentina/2, antilles/4, bolivia/1, brazil/3, columbia/4, chile/3, ecuador/3, french_guiana/2, guyana/1, paraguay/1, peru/4, surinam/3, uruguay/4, venezuela/3],X, 
[argentina/2, antilles/4, bolivia/1, brazil/3, columbia/4, chile/3, ecuador/3, french_guiana/2, guyana/1, paraguay/1, peru/4, surinam/3, uruguay/4, venezuela/3]), write(X).

calc_colisoes_pais( [] , [], Mapa_aux).
calc_colisoes_pais([(P/C)|L1], [(Colisao/P/C)| L2], Mapa_aux) :-
     	vizinho( P ,  Lviz), 
	 	cores_dos_vizinhos( Lviz, Mapa_aux, L_cores_viz ),
	 	colisao_1( (P/C) , L_cores_viz , Colisao ),      
		calc_colisoes_pais( L1 ,  L2, Mapa_aux ).        

/* foi usado um valor de Colisoes para classificar 
    as melhores solucoes */
remove_prefix([],[]).
remove_prefix([Colisoes/Pais/Cor|L1],[Pais/Cor|L2]) :-             
              remove_prefix(L1,L2).

/* Calcular todas colisoes e divide por dois */
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

/*****************************************************/

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
            
/* ************************************************ */
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
/* Apenas 04 cores são o suficiente = {1,2,3,4} */

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

/* RETIRADO DO LIVRO DO COVINGTON :: Geographical data for South America. */

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
/* *************************************************** */
do_insert(X, Y, [X|Y]).
do_insert(X,[Y1|Y2],[Y1|Z]) :- do_insert(X,Y2,Z).

permute([X],[X]).
permute([X|Y],Z) :- permute(Y,Z1), do_insert(X,Z1,Z).
/************************************************************/
