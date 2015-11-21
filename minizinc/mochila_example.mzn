%%%%%%%%%%%%%% Exemplo do problema da mochila
%% CCS
int: n;
n = 3; %% Total de elementos disponiveis
int: K = 10; %% Capacidade da Mochila

array[1..n] of var 0..1 : x_decision;
array[1..n] of int : peso;
array[1..n] of int : valor;

peso = [5, 8, 3];
valor = [45, 48, 35];

var int: total_PESO;
var int: total_VALOR;

constraint
  total_PESO = sum( i in 1..n ) (x_decision[i]*peso[i]);

constraint
  total_VALOR = sum( i in 1..n ) (x_decision[i]*valor[i] );

constraint
          total_PESO <= K;

% minimize total_cost
solve maximize total_VALOR;

output [
  "Total_VALOR: " ++ show(total_VALOR) ++"\n"++
  "Total_PESO : " ++ show(total_PESO ) ++"\n"++
  "Vetor Decisao: " ++ show( x_decision ) ++ "\n" ];

/* **************************************************
Compiling mochila_example.mzn
Running mochila_example.mzn
Total_VALOR: 0
Total_PESO : 0
Vetor Decisao: [0, 0, 0]
----------
Total_VALOR: 45
Total_PESO : 5
Vetor Decisao: [1, 0, 0]
----------
Total_VALOR: 48
Total_PESO : 8
Vetor Decisao: [0, 1, 0]
----------
Total_VALOR: 80
Total_PESO : 8
Vetor Decisao: [1, 0, 1]
----------
==========
*************************************************** */