/*
Solucao como saida MATRIX (M x N)
m: varas ou sarrafos disponiveis -- repetidas ou nao
n: distancias CONTINUAS a cobrir .. 1 a n+1 pontos
*/
int: m = 6; %% num de varas -- LINHAS
int: n = 4; %% num de intervalos entre (n+1) mouroes -- COLUNAS

array[1..m] of int : varas;      %% LINHAS
array[1..n] of int : dist_N_col; %% COLUNAS

varas =  [4, 5, 4, 7, 8, 9]; % n
dist_N_col = [4, 5, 4, 9]; % m

array[1..m , 1..n] of var 0..1 : Mat_Sol;
array[1..m] of var 0..1 : QUAIS_USADAS;
var   int:  melhor_dist; %% Funcao objetivo

%% todas as COLUNAS devem ser selecionadas == 1
constraint
  forall(j in 1..n )(
     sum( i in 1..m ) (Mat_Sol[i,j]) == 1);

%% A soma de cada COLUNA em todas dist_N_col selecionadas
%% devem ser menor ou igual ao tamanho da vara i
constraint
forall(i in 1..m )(
     (sum( j in 1..n ) (Mat_Sol[i,j] * dist_N_col[j] )) 
      <= varas[i]);

%%% GARANTE A CONTIGUIDADE da VARA sob os PILARES
constraint
  forall(i in 1..m )(
     if (sum( j in 1..n ) (Mat_Sol[i,j])) > 1
       then
          forall(j in 2..n-1 )(  
           (Mat_Sol[i,j] == 1
             <->   
           (Mat_Sol[i,j-1]==1 \/ Mat_Sol[i,j+1]==1))
           )
       else
       true
       endif
     );

%%% construindo uma saida mais elucidativa
constraint
  forall(i in 1..m )(
     if 
       (sum( j in 1..n ) (Mat_Sol[i,j])) >= 1
       then
       QUAIS_USADAS[i]==1
       else
       QUAIS_USADAS[i]==0
       endif
     );

%%% construindo UMA funcao minimizadora em NUM DE VAROES USADOS
constraint
   melhor_dist = sum( i in 1..m ) (QUAIS_USADAS[i]*varas[i]) 
               + sum( i in 1..m ) (QUAIS_USADAS[i]);

solve minimize melhor_dist;
%solve  satisfy;
%solve maximize total_VALOR;

output
 ["Sticks ou Varas : " ++ show( varas )   ++ "\n" ++
  "Distancias : " ++ show( dist_N_col )   ++ "\n" ++
 % "Matriz Solucao: \n" ++ show2d( Mat_Sol ) ++ "\n" ++
  "Varas usadas: " ++ show( QUAIS_USADAS ) ++ "\n" ++   
  "UMA MELHOR DISTANCIA: " ++ show( melhor_dist ) 
   ++ "\n VARAS (i) x Distancias (j) - Vert\n" ] ++
  ["\n  :"] ++
  [" " ++ show(j) |  j in 1..n] %%  1o. ITERADOR
   ++ ["\n"] ++  %%  2o. ITERADOR
  [if j == 1 then show(i) ++ " : " else "" endif ++
    show( Mat_Sol[i,j] )  ++ 
    if j = n then " .... VARA " ++ show(i)++ "\n" else " " endif
    | i in 1..m, j in 1..n ] ;
