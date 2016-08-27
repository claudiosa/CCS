int: n = 7; % total de elementos do vetor
int: K = 15; %% Soma do sub-set

array[1..n] of var 0..1 : X_DEC;

array[1..n] of int : V_Valores;
V_Valores = [3, 4, 5, 7, 9, 10, 1];

var int: total_VALOR;

constraint
  total_VALOR = sum([X_DEC[i] * V_Valores[i]| i in 1..n ]) ;
  % OU          sum( i in 1..n ) (X_DEC[i]* V_Valores[i]);

constraint      total_VALOR == K;

solve satisfy;    %%%% minimize ou maximize algo

output ["Total_VALOR: " ++ show(total_VALOR) ++"\n"++
        "Seleciona:" ++ show( X_DEC ) ++ "\n\t  " , 
         show( V_Valores ) ];
