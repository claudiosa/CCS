% 
% This MiniZinc model was created by CCS
%

%------------------------------------------------------%

include "globals.mzn";
%%% estudo de matriz adjacencia, INCIDENCIA etc
array[1..n, 1..n] of int : G = [|
    %   1   2   3   
        0,  11, 14 |   % 1
        11, 0,  13 |   % 2
        7,  7,  0  |]; % 6
    

array[1..n, 1..n] of int : TESTE = [|
    %   1   2   3   
        0,  1,  1 |   % 1
        1,  0,  1 |   % 2
        1,  1,  0 |]; % 6
    

% INSTANCIA DO PROBLEMA:
int : n = 3;
var int : custo; %% custo total
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
var int : n_arcs;
array[1..n, 1..n] of var 0..1 : MAT_ADJ;
%%% futuro 
array[1..n*n, 1..2] of var 0 .. n : INDEX_INCIDENCIA;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% grafo de DECISAO que representa o resultado dos nos escolhidos
array[1..n, 1..n] of var 0..1 : x_DECISION;

%%% calcula o numero de ARCOS -- STATUS OK
function var int: num_arcos(array[int,int] of int: Weight_M, int: n) =
   let{
       array [1 .. n*n] of var 0..1 : v_aux;
       var int : temp;
    constraint 
         forall(i,j in 1..n )
         (
          if (Weight_M[i,j] == 0)
          then
           v_aux[j + (i-1)*n] = 0
          else
           v_aux[j + (i-1)*n ] = 1
          endif
         )
         /\
        temp == sum( v_aux ); 
      %% Varias maneiras de fazer a soma acima
         }
          in
      temp 
    %%% OR  directly .... 
  %% somethink as:   sum([v_aux[i] | i in 1..n*n])
         ;

%%% constroi  uma matriz de adjacencia  -- STATUS OK
function array [int,int] of var {0,1}: matriz_adjacencia(array[int,int] of int: Weight_M, int: n) =
   let{
       array[1 .. n, 1 .. n] of var 0..1 : v_aux;
    constraint 
         forall(i,j in 1..n )
         (
          if (Weight_M[i,j] == 0)
          then
           v_aux[i,j] = 0
          else
           v_aux[i,j] = 1
          endif
         )
         }
         in
         v_aux
         ;

%%% uma matriz de INDICES para matriz de INCIDENCIA  -- STATUS NAO OK
function array [int , {1,2} ] of var 0 .. n : matriz_index_incidencia(array[int,int] of var 0..1: M_ADJ, int: n) =
%%, var int: num_arcos) =
/*
Solucao
1. Estimar um comprimento MAXIMO para este novo ARRAY
2.
*/
   let{
  %     int : x = num_arcos;
       set of int : ONE_TWO = {1,2};
       set of int : N_ARCS = 1 .. n*n; %%num_arcos; %% variable to FIX in function
       array[N_ARCS, ONE_TWO] of var 0 .. n : v_aux_0; %%%% incluir o ZERO
    constraint 
      forall(i , j  in 1..n,  k in N_ARCS) %% num_arcos j in 1..n,
         (
          if (M_ADJ[i,j] == 1)
          then
           (v_aux_0[k,1] = i /\
            v_aux_0[k,2] = j 
            )
         else
           (v_aux_0[k,1] = 0 /\
            v_aux_0[k,2] = 0 
            )
        %%% true
         endif
        )
         %% DEPOIS eliminar TODOS OS ZEROS  de V_AUX 
       } 
       in
         v_aux_0
      ;

constraint
        n_arcs = num_arcos(G,n);
constraint
        MAT_ADJ = matriz_adjacencia(G,n);
constraint
        INDEX_INCIDENCIA = matriz_index_incidencia(TESTE, n);



%%% EXPLORE HERE
solve satisfy;
%minimize custo;

% Output from Hakank ...OK
% to be improved
output 
 %      [" \n "] ++ [ show(fix(num_arcos(G,n))) ];
       [" \n "] ++ [ show(fix( n_arcs ))] ++[" \n "] ++
[ %%% matriz de adjacencia
  if j == 1 then "\n" else " "  endif ++
       show(MAT_ADJ[i,j]) 
       | i in 1..n, j in 1..n
]
%%++[show(matriz_index_incidencia(MAT_ADJ, n, n_arcs  ))]
++[show(INDEX_INCIDENCIA)]
%
%[ %%% matriz de adjacencia
%  if k == 1 then "\n" else " "  endif ++
%       show(fix(INDEX_INCIDENCIA[iz,k])) 
%       | iz in 1..n*n, k in {1,2}
%]
;
