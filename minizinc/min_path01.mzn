% ALUNOS: FERNANDA SALES BITTENCOURT DE LEMOS 
% RAFAEL GIORDANO VIEIRA 
% Modificacoes: CCS
%  PROGRAMACAO POR RESTRICOES - 2014/2
%
% 
% Problema do Caminho Minimo
%
%
/*
 Seja o grafo da figura 4 tomado como exemplo. 
 Implemente um algoritmo para um caminho  minimo entre dois pontos. 
 
 Teste o algoritmo com varios pontos de partida e chegada, 
 incluindo as excecoes. 
 Funcionando, assuma um exemplo mais complexo como o da figura 5.
*/
%------------------------------------------------------%

include "globals.mzn";

% PROBLEMA: Figura 4
% int : n = 7;
% int : src = 1; int : dst = 7;  %% A - G
% array[1..n, 1..n] of 0..10 : G = [|
%   A  B  C  D  E  F  G
%   0, 5, 0, 3, 0, 0, 0 |   % A
%   0, 0, 5, 0, 0, 0, 0 |   % B
%   3, 0, 0, 2, 4, 0, 0 |   % C
%   0, 0, 0, 0, 2, 6, 0 |   % D
%   0, 1, 0, 0, 0, 0, 1 |   % E
%   0, 0, 0, 0, 0, 0, 9 |   % F
%   0, 0, 0, 0, 0, 0, 0 |]; % G

% PROBLEMA: Figura 5
%% TOTAL DE NOS
int : n = 10;

var int : custo;
int : src = 1; 
int : dst = 10; %% 0 -> 9

array[1..n, 1..n] of int : G = [|
% 00, 01, 02, 03, 04, 05, 06, 07, 08, 09
   0, 16, 10,  0,  0,  0,  0,  8,  0,  0 |   %% 00
  16,  0,  0, 18,  0, 50,  0,  0,  0, 42 |   %% 01
  10,  0,  0, 50,  0,  0,  0, 20,  0,  0 |   %% 02
   0, 18, 50,  0,  0,  0,  0, 30, 15,  0 |   %% 03
   0,  0,  0,  0,  0,  9,  3,  0, 30,  0 |   %% 04
   0, 50,  0,  0,  9,  0, 10,  0, 16, 10 |   %% 05
   0,  0,  0,  0,  3, 10,  0,  0,  0,  0 |   %% 06
   8,  0, 20, 30,  0,  0,  0,  0,  0,  0 |   %% 07
   0,  0,  0, 15, 30, 16,  0,  0,  0,  8 |   %% 08
   0, 42,  0,  0,  0, 10,  0,  0,  8,  0 |]; %% 09

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% grafo de DECISAO que representa o resultado dos nos escolhidos
array[1..n, 1..n] of var 0..1 : r;

% aceita somente arcos como resultados válidos aqueles existentes no GRAFO ORIGINAL
constraint 
         forall(i,j in 1..n where  j != dst ) %% i/j
         (G[i,j] == 0 -> r[i,j] == 0); 
%%       nao havendo conexao ...
%         /\ %%% REMOVIDO POR CCS
%        r[dst,src] == 1 ; %%% REMOVIDO POR CCS
        %% heuristica dos autores:: destino alcancavel no minimo?
          
% as arestas do grafo devem ser unidirecionais, 
% entao se A leva a B, B nao pode levar a A
constraint 
         forall(i,j in 1..n)
         (r[i,j] == 1 -> r[j,i] == 0); %% sem ciclos

% Para todos nos do grafo, o número de conexões saindo do nó deve ser igual
% ao número de conexões chegando a ele.ex: 3 -> 4 logo 4 -> 3
constraint 
        forall(i in 1..n)
        (sum([r[j, i] | j in 1..n]) = sum([r[i, j] | j in 1..n]));
         
% um noh pode ter no maximo UMA aresta .. ex: 3 -> 4
constraint 
        forall(i in 1..n)
        (sum([r[i, j] | j in 1..n]) < 2);

% deve existir uma aresta de src para algum no
% ou seja, src, a origem eh um noh com no minimo uma
% aresta escolhida
constraint 
        exists(i in 1..n)
        (r[src,i] == 1 /\ i != src);

constraint %% CONSTRAINT ADICIONADA por CCS
        exists(i in 1..n)
        (r[i,dst] == 1 /\ i != dst);

% calculo do custo.
constraint 
       custo = sum([ r[i,j] * G[i,j] | i , j in 1..n ]);
%%% - G[dst,src]; %%% REMOVIDO POR CCS

solve minimize custo;

% Codigo do output do Hakank ...OK
% 
output [
 if i == 1 /\ j = 1 then
  "custo=" ++ show(custo) ++ "\n"
 else "" endif ++
 if j == 1 then show(i) ++ " : " else "" endif ++
       show(r[j,i]) ++ if j = n then "\n" else " " endif
       | i in 1..n, j in 1..n
];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
