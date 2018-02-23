% ALUNOS: FERNANDA SALES BITTENCOURT DE LEMOS
%         RAFAEL GIORDANO VIEIRA

% LOGICA APLICADA A PROGRAMACAO POR RESTRICOES - 2014/2
% LISTA DE EXERCICIOS NUMERO 6
% DATA:   27/11/2014

% Questao 1. Explicando a Combinatoria dos Caminhos

% Recentemente o prof. Claudio se defrontou de um simples e antigo problema de caminhos.
% Mas, o que chama atencao eh que ele tem uma natureza de explicar o que uma combinatoria.
% Veja a figura 1 como um exemplo de entrada. 
% Inicialmente dado um quadrado n x n dispostos como os dois primeiros exemplos da figura 2. 
% Considerando sempre o mesmo ponto de partida (p) e o de chegada (c). A proposta eh
% encontrar quantos caminhos possiveis, sem repeticoes entre nos e arcos, existem entre estes 2
% pontos. Para os exemplos da figura 2, o numero de caminhos esta indicado sob a figura.
% Experimentem implementar algum algoritmo que resolva este problema com os recursos
% vistos ate o momento, e depois partam para restricoes mais especificas e dirigidas a este fim.
% Exemplo: restricao circuit e a biblioteca library(graph algorithms) do Eclipse. Esta observacao
% vale para o proximo problema.

%------------------------------------------------------%

include "globals.mzn";

%int : src = 1; int : dst = 5; int : n = 8;
%array[1..n, 1..n] of 0..1 : G = [|
%  1, 1, 0, 0, 0, 0, 0, 1 |
%  1, 1, 1, 0, 0, 0, 0, 0 |
%  0, 1, 1, 1, 0, 0, 0, 0 |
%  0, 0, 1, 1, 1, 0, 0, 0 |
%  0, 0, 0, 1, 1, 1, 0, 0 |
%  0, 0, 0, 0, 1, 1, 1, 0 |
%  0, 0, 0, 0, 0, 1, 1, 1 |
%  1, 0, 0, 0, 0, 0, 1, 1 |];

% int : src = 1; int : dst = 6; int : n = 6;
% array[1..n, 1..n] of 0..1 : G = [|
%   1, 1, 0, 1, 0, 0 |
%   1, 1, 1, 0, 1, 0 |
%   0, 1, 1, 0, 0, 1 |
%   1, 0, 0, 1, 1, 0 |
%   0, 1, 0, 1, 1, 1 |
%   0, 0, 1, 0, 1, 1 |];

 int : src = 1; int : dst = 9; int : n = 9;
 array[1..n, 1..n] of 0..1 : G = [|
   1, 1, 0, 1, 0, 0, 0, 0, 0 |
   1, 1, 1, 0, 1, 0, 0, 0, 0 |
   0, 1, 1, 0, 0, 1, 0, 0, 0 |
   1, 0, 0, 1, 1, 0, 1, 0, 0 |
   0, 1, 0, 1, 1, 1, 0, 1, 0 |  
   0, 0, 1, 0, 1, 1, 0, 0, 1 |
   0, 0, 0, 1, 0, 0, 1, 1, 0 |
   0, 0, 0, 0, 1, 0, 1, 1, 1 |
   0, 0, 0, 0, 0, 1, 0, 1, 1 |];

% grafo que representa o resultado
array[1..n, 1..n] of var 0..1 : r; 

% aceita somente arcos da grade no resultado
constraint forall(i,j in 1..n where i != dst)(G[i,j]==0 -> r[i,j]==0) /\ r[dst,src]=1;

% as arestas do grafo devem ser unidirecionais, entao se A leva a B, B nao pode levar a A
constraint forall(i,j in 1..n)(r[i,j] == 1 -> r[j,i] == 0);

% O grafo deve ser um circuito.
constraint forall(i in 1..n)(sum([r[j, i] | j in 1..n]) = sum([r[i, j] | j in 1..n]));

% um no pode ter no maximo uma aresta
constraint forall(i in 1..n)(sum([r[i, j] | j in 1..n]) < 2);

% deve existir uma aresta de src para algum no
constraint exists(i in 1..n)(r[src,i] == 1 /\ i != src);

solve satisfy;

% peguei o codigo do output do Hakank (veja MODELAGEM para as URLs).
output [show(r[i,j]) ++ if j = n then "\n" else " " endif | i in 1..n, j in 1..n];

/*********************
% PRIMEIRO CASO DE TESTE (2 CAMINHOS)
0 1 0 0 0 0 0 0
0 0 1 0 0 0 0 0
0 0 0 1 0 0 0 0
0 0 0 0 1 0 0 0
1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
----------
0 0 0 0 0 0 0 1
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 0 0 0 0 0 0 0
0 0 0 0 1 0 0 0
0 0 0 0 0 1 0 0
0 0 0 0 0 0 1 0
----------
==========

% SEGUNDO CASO DE TESTE (4 CAMINHOS)
0 1 0 0 0 0
0 0 1 0 0 0
0 0 0 0 0 1
0 0 0 0 0 0
0 0 0 0 0 0
1 0 0 0 0 0
----------
0 0 0 1 0 0
0 0 1 0 0 0
0 0 0 0 0 1
0 0 0 0 1 0
0 1 0 0 0 0
1 0 0 0 0 0
----------
0 1 0 0 0 0
0 0 0 0 1 0
0 0 0 0 0 0
0 0 0 0 0 0
0 0 0 0 0 1
1 0 0 0 0 0
----------
0 0 0 1 0 0
0 0 0 0 0 0
0 0 0 0 0 0
0 0 0 0 1 0
0 0 0 0 0 1
1 0 0 0 0 0
----------
==========

% TERCEIRO CASO DE TESTE (16 CAMINHOS)

0 1 0 0 0 0 0 0 0
0 0 1 0 0 0 0 0 0
0 0 0 0 0 1 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 1
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0
1 0 0 0 0 0 0 0 0
----------
0 0 0 1 0 0 0 0 0
0 0 1 0 0 0 0 0 0
0 0 0 0 0 1 0 0 0
0 0 0 0 1 0 0 0 0
0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 1
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0
1 0 0 0 0 0 0 0 0
----------
0 1 0 0 0 0 0 0 0
0 0 0 0 1 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 1 0 0 0
0 0 0 0 0 0 0 0 1
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0
1 0 0 0 0 0 0 0 0
----------
0 0 0 1 0 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 1 0 0 0 0
0 0 0 0 0 1 0 0 0
0 0 0 0 0 0 0 0 1
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0
1 0 0 0 0 0 0 0 0
----------
0 0 0 1 0 0 0 0 0
0 0 1 0 0 0 0 0 0
0 0 0 0 0 1 0 0 0
0 0 0 0 0 0 1 0 0
0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 1
0 0 0 0 0 0 0 1 0
0 0 0 0 1 0 0 0 0
1 0 0 0 0 0 0 0 0
----------
0 1 0 0 0 0 0 0 0
0 0 1 0 0 0 0 0 0
0 0 0 0 0 1 0 0 0
0 0 0 0 0 0 1 0 0
0 0 0 1 0 0 0 0 0
0 0 0 0 0 0 0 0 1
0 0 0 0 0 0 0 1 0
0 0 0 0 1 0 0 0 0
1 0 0 0 0 0 0 0 0
----------
0 0 0 1 0 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 1 0 0
0 0 0 0 0 1 0 0 0
0 0 0 0 0 0 0 0 1
0 0 0 0 0 0 0 1 0
0 0 0 0 1 0 0 0 0
1 0 0 0 0 0 0 0 0
----------
0 1 0 0 0 0 0 0 0
0 0 1 0 0 0 0 0 0
0 0 0 0 0 1 0 0 0
0 0 0 0 1 0 0 0 0
0 0 0 0 0 0 0 1 0
0 0 0 0 0 0 0 0 1
0 0 0 1 0 0 0 0 0
0 0 0 0 0 0 1 0 0
1 0 0 0 0 0 0 0 0
----------
0 1 0 0 0 0 0 0 0
0 0 0 0 1 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 1 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 1
1 0 0 0 0 0 0 0 0
----------
0 0 0 1 0 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 1 0 0 0 0
0 0 0 0 0 0 0 1 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 1
1 0 0 0 0 0 0 0 0
----------
0 0 0 1 0 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 1 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 1 0
0 0 0 0 0 0 0 0 1
1 0 0 0 0 0 0 0 0
----------
0 1 0 0 0 0 0 0 0
0 0 0 0 1 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 1 0 0
0 0 0 1 0 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 1 0
0 0 0 0 0 0 0 0 1
1 0 0 0 0 0 0 0 0
----------
0 1 0 0 0 0 0 0 0
0 0 1 0 0 0 0 0 0
0 0 0 0 0 1 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 1 0
0 0 0 0 1 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 1
1 0 0 0 0 0 0 0 0
----------
0 0 0 1 0 0 0 0 0
0 0 1 0 0 0 0 0 0
0 0 0 0 0 1 0 0 0
0 0 0 0 0 0 1 0 0
0 1 0 0 0 0 0 0 0
0 0 0 0 1 0 0 0 0
0 0 0 0 0 0 0 1 0
0 0 0 0 0 0 0 0 1
1 0 0 0 0 0 0 0 0
----------
0 1 0 0 0 0 0 0 0
0 0 1 0 0 0 0 0 0
0 0 0 0 0 1 0 0 0
0 0 0 0 0 0 1 0 0
0 0 0 1 0 0 0 0 0
0 0 0 0 1 0 0 0 0
0 0 0 0 0 0 0 1 0
0 0 0 0 0 0 0 0 1
1 0 0 0 0 0 0 0 0
----------
0 0 0 1 0 0 0 0 0
0 0 0 0 1 0 0 0 0
0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 1 0 0
0 0 0 0 0 1 0 0 0
0 0 1 0 0 0 0 0 0
0 0 0 0 0 0 0 1 0
0 0 0 0 0 0 0 0 1
1 0 0 0 0 0 0 0 0
----------
==========