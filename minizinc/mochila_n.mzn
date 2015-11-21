
%% UMA MOCHILA ... mas n itens a serem escolhidos e repetidos
int: n;
n = 5; %% total de elementos
int: K = 15; %% Capacidade da Mochila


array[1..n] of int : peso;
array[1..n] of int : valor;
array[1..n] of int : qt_item; %%

peso = [5, 7, 9, 10, 1];
valor = [15, 77, 9, 100, 1];
qt_item = [1, 3, 2, 4, 2]; 

%% aqui seleciona nenhum ao maximo a qtdade de cada item
array[1..n] of var 0..ub_array(qt_item) : x_decision;
%% da variavel qt_item pegou o maior valor 

var int: total_PESO;
var int: total_VALOR;

constraint
  total_PESO = sum( i in 1..n ) (x_decision[i]*peso[i]);

%%% IMPORTANTE esta ....
constraint
     forall(i in 1..n)
           ( 
             x_decision[i] <= qt_item[i]
           );

constraint
  total_PESO <= K;

constraint
  total_VALOR = sum( i in 1..n ) (x_decision[i]*valor[i] );

% minimize total_cost
solve maximize total_VALOR;

output [
  "Total_VALOR: " ++ show(total_VALOR) ++"\n"++
  "Total_PESO : " ++ show(total_PESO ) ++"\n"++
  "x_decision: " ++ show( x_decision ) ++ "\n" ];


/*
Resposta:
Total_Valor: 115
total_PESO : 15
x_decision: [1, 0, 0, 1, 0]
*/