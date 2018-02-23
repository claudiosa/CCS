%%%%%%%%%%%%%% Exemplo do problema da mochila: 
%% CCS:to show set uses
int: n;
n = 3; %% Total de elementos disponiveis
int: K = 10; %% Capacidade da Mochila

set of int : Set_Usage = 1..n; %%% to show set uses

array[Set_Usage] of var 0..1 : x_decision;
array[Set_Usage] of int : peso;
array[Set_Usage] of int : valor;

peso = [5, 8, 3];
valor = [45, 48, 35];

var int: total_PESO;
var int: total_VALOR;

constraint
  total_PESO = sum( i in Set_Usage ) (x_decision[i]*peso[i]);

constraint
  total_VALOR = sum( i in Set_Usage ) (x_decision[i]*valor[i] );

constraint
          total_PESO <= K;

% minimize total_cost
solve maximize total_VALOR;

output [
  "Total_VALOR: " ++ show(total_VALOR) ++"\n"++
  "Total_PESO : " ++ show(total_PESO ) ++"\n"++
  "Vetor Decisao: " ++ show( x_decision ) ++ "\n" ];

/* ******************************************* */