% Problema dos nadadores
%% Autores Marcos e Gabriela
% Ideia da solução: Criar um vetor com o numero de posicoes igual ao de colunas
%		    da matriz. Cada elemento deste vetor indica qual é a linha
%		    escolhida na matriz para aquela coluna. O objetivo é minimizar
%		    a soma das posicoes escolhidas.

/*
  Assignment problem from Winston "Operations Research.
  The swimming team example, page 398:
  """
  Doc Councillman is putting together a relay team for
  the 400-meter relay. Each swimmer must swin 100 meter
  of breaststroke, backstroke, butterfly or freestyle.
  Doc believes that each swimmer will attain the times
  given in table 51. To minimize the team's time for the race,
  which swimmer should swim which stroke.
  """
*/

include "alldifferent.mzn";

array[1..4] of var 1..4: vetDecisao; %% Decision Vector
var int: valorTotal;

array[1..4,1..4] of int: matValores = array2d(1..4,1..4,
                                              [54,54,51,53, 
                                               51,57,52,52,
                                               50,53,54,56,  
                                               56,54,55,53]);

constraint alldifferent(vetDecisao);

% constraint valorTotal = sum(i in 1..4) ( matValores[ vetDecisao[i] , i]   ); %%% OR
constraint valorTotal = sum(i in 1..4) ( matValores[ i, vetDecisao[i] ]   );

solve minimize valorTotal;

output[" Atribuição realizada (vetDecisao): ", show(vetDecisao), 
      "\n Valor total: ", show(valorTotal) ]  ++ 
      ["\n"] ++
     %%% [show([ decid[i,j] * vet[i,j] |  i in 1..4,   j in 1..4 ] ++
			[if ( j == 4 ) %% if collun == last ...
          then 
              if(fix(vetDecisao[ j ]) == i)  
                 then  " 1 \n"
                 else " 0 \n" endif  
          else   
              if  (fix(vetDecisao[ j ]) == i)  
                  then  " 1 "
                  else " 0 " 
                  endif
			    endif | i in 1..4,   j in 1..4 %%% ENUMERATOR
       ];  

/*
 Atribuição realizada (vetDecisao): [3, 4, 1, 2]
 Valor total: 207
 0  0  1  0 
 0  0  0  1 
 1  0  0  0 
 0  1  0  0 
----------
*/
