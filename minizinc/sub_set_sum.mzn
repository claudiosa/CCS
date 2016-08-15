int: n = 7; % total de elementos do vetor
int: K = 15; %% Soma do sub-set

array[1..n] of var 0..1 : x_decision;

array[1..n] of int : v_valores;
v_valores = [3, 4, 5, 7, 9, 10, 1];

var int: total_VALOR;

constraint
  total_VALOR = sum( i in 1..n ) (x_decision[i]* v_valores[i]);

constraint
  total_VALOR == K;

% minimize or maximize something
solve satisfy; 

output ["Total_VALOR: " ++ show(total_VALOR) ++"\n"++
        "Seleciona:" ++ show( x_decision ) ++ "\n\t  " , 
        show( v_valores ) ];

