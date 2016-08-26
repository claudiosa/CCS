include "alldifferent.mzn";
int : N = 4;

%% Vetor de decisao de 1 a N
array[1..N] of var 1..N: vetDecisao; %% VETOR 1D
var int: T_min;

array[1..N,1..N] of int: tempo_NADADORES;

tempo_NADADORES = array2d(1..N, 1..N,
                         [54,54,51,53, 
                         51,57,52,52,
                         50,53,54,56,  
                         56,54,55,53]);

constraint alldifferent(vetDecisao);

constraint 
%% T_min = sum(i in 1..N)(tempo_NADADORES[i, vetDecisao[i]]); OU
   T_min = sum([tempo_NADADORES[i, vetDecisao[i]] | i in 1..N]);

solve minimize T_min;

output[" Menor tempo: ", show(T_min) ,"\n",
       " Atribuicao (vetDecisao): ", 
         show(vetDecisao), "\n UM ITERADOR EM SEGUIDA \n "] ++

      [show(i) ++ ":" ++ 
       show(vetDecisao[i]) ++ "-> " ++
       show(tempo_NADADORES[ i, vetDecisao[i] ]) ++ 
           "\n " | i in 1..N
      ] ;  %UM ITERADOR
