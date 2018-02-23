%% Escolha de 3 tarefas para cada UMA unica maquina...
%%
include "globals.mzn"; 
int: tarefas = 5;
int: maquinas = 3;
int: K = 10;

array[1 .. maquinas, 1..tarefas] of int :  custo;
        %  T1  T2   T3  T4   T5   
custo = [| 1 , 11 , 5 , 7 , 13,   %% MAQ1
         | 4 , 6 , 2 , 8  , 10,   %% MAQ2
         | 6 , 3 , 9 , 12 , 15    %% MAQ2
         |]
         ;

%INDICES >>>> 3 escolhas APENAS tarefas....
var 1 .. tarefas : A; %%% indice para MAQ1 ....
var 1 .. tarefas : B; 
var 1 .. tarefas : C;
var int : result;  
array[1 .. maquinas] of var 1 .. tarefas : maq_selec;

%array[1 .. tarefas] of var 1 .. maquinas: tar_selec;
% PROBLEMA AQUI .... pois aqui #maquinas < #tarefas
% se UMA MAQUINA = UMA TAREFA .... seria BEM diferente

constraint all_different([A,B,C]);
%constraint 
%   all_different(tar_selec); %%% APENAS se tarefas = maquinas....


constraint
%exists(i in 1..tarefas)  ( 
  % element(tar_selec[i] , [1 , 11 , 5 , 7 ,  13] , maq_selec[1])
   element(A , [1 , 11 , 5 , 7 ,  13] , maq_selec[1]) 
  %% The same as A[i] = y. That is, y is the ith element of the array A.
  %% resumindo o  element(INDEX, ARRAY, CONTEUDO) 
   ;

constraint
    element(B , [4 , 6  , 2 , 8  , 10], maq_selec[2])
    ;

constraint
    element(C , [6 , 3  , 9 , 12 , 15], maq_selec[3])
    ;

%% objetivo
constraint
     result = sum( [maq_selec[i] | i in 1..maquinas] ) ;

constraint
     result <= K ;
%     result > K ;

solve minimize result;

output [
  " Indices: " ++ show(A) ++ " : " ++ show(B) ++ " : " ++ show(C) ++ 
  "\n Tarefas: " ++ show(maq_selec[1]) ++ " : " ++ show(maq_selec[2]) ++ " : " ++ show(maq_selec[3]) ++
  "\t total_cost: " ++ show(result)] 
  ++
  ["\n Maquina 1: tem custo " ++ show(fix(custo[1, A])) ++ " escolheu a tarefa " ++ show(A)++
   "\n Maquina 2: tem custo " ++ show(fix(custo[2, B])) ++ " escolheu a tarefa " ++ show(B)++
   "\n Maquina 3: tem custo " ++ show(fix(custo[3, C])) ++ " escolheu a tarefa " ++ show(C)
  ]
 ++ ["\n"];


/*
  FUTURO
  [" Maquina : " ++ show(i) ++ show(maq_selec[i]) ++ 
  " custo da tarefa " ++
   show( custo[ maq_selec[i] , tar_selec[j] ] ) ++  "\n"
  | i in 1..maquinas, j in 1..tarefas where j <= i
  ] ++ ["\n"];

 */