% 
% Feito por: CCS
% 
% 
% TSP, Traveling Salesman Problem
%
% The Traveling Salesman Problem (TSP) is stated as follows.
% Let a directed graph G = (V, E) be given, where V = {1, ..., n} is
% a set of nodes, E <= V x V is a set of arcs. Let also each arc
% e = (i,j) be assigned a number c[i,j], which is the length of the
% arc e. The problem is to find a closed path of minimal length going
% through each node of G exactly once.
% """
% 
% This MiniZinc model was created by CCS
%

%------------------------------------------------------%

include "globals.mzn";

%% TSP simetrico -- contudo generico
%%% Exemplo RETIRADO DE UM EXCELENTE LIVRO -- EXAMPLE
/*
array[1..n, 1..n] of int : G = [|
    %   1   2   3   4   5   6  
        0,  11, 7,  6,  8,  14 |   % 1
        11, 0,  7,  9,  12, 13 |   % 2
        7,  7,  0,  3,  7,  8  |   % 3
        6,  9,  3,  0,  4,  8  |   % 4
        8,  12, 7,  4,  0,  10 |   % 5
        14, 13, 8,  8,  10, 0  |]; % 6
    

% INSTANCIA DO PROBLEMA:
int : n = 6;
var int : custo; %% custo total
*/
%Exemplo 2
int : n = 10;
var int : custo; %% custo total

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

%% to store ONE TRIP -- sequencia da viagem
array[1..n] of var 1..n : x_TOUR;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% grafo de DECISAO que representa o resultado dos nos escolhidos
array[1..n, 1..n] of var 0..1 : x_DECISION;

% aceitar somente arcos como resultados válidos aqueles existentes no GRAFO ORIGINAL
%% If any arc=0, means any connection
% Similar IDEA from assignment problems
constraint 
         forall(i,j in 1..n )
         (G[i,j] == 0 -> x_DECISION[i,j] == 0); 
          
% Todo noh tem um proximo no, ou UMA aresta .. ex: 3 -> 4
% All node follow to the next
constraint 
        forall(i in 1..n )
        (sum([x_DECISION[i, j] | j in 1..n where i != j]) == 1);


% TODO noh destino de algum outro no .. ex: 5 -> 3  ... mas nao podera 4 -> 3
% All node is a destination
constraint 
        forall(j in 1..n)
        (sum([x_DECISION[i, j] | i in 1..n where i != j]) == 1);


%%% STUDIES ON SUB-TOUR
/*
 x_DECISION[1, 2] + x_DECISION[2, 1] <= 1 /\
 x_DECISION[1, 5] + x_DECISION[5, 1] <= 1;
 where i != j

%%% Sub-tour de 2 cidades
constraint
      forall(i,j in 1..n where i < j) (
         ( x_DECISION[j, i] + x_DECISION[i, j] ) <= 1
        );

%%% 3 CIDADES ... sub-tour de 3 cidades
constraint
      forall(i, j, k in 1..n where i < j /\ j < k) (
         (x_DECISION[i,j] + x_DECISION[j,k] + x_DECISION[k,i] ) <= 2
        );
%%% How to generalize this idea ??????

*/

%%% The first city equal the last
%     x_TOUR[1] == x_TOUR[n];
%%% HOW TO RELATE it with x_DECISION?
%constraint
%     x_TOUR[1] == 1; %%% STARTING POINT
%%% HOW TO RELATE it with x_DECISION?

%% It's  working but not as I wished
constraint
    alldifferent(x_TOUR)
    /\
    forall(i,j in 1..n) % where i < j) 
      (
       if x_DECISION[i, j] == 1 then x_TOUR[i] = j else true endif
      % OR
      %(x_DECISION[i, j] == 1) <-> x_TOUR[i] = j

      )
     /\
    %subcircuit(x_TOUR) %% it is work but not avoid sub-tours
    %%% HOW TO AVOID subcircuit uses? Anszer: use circuit --- a global constraint
    circuit(x_TOUR) %%%%
      %%% Constraints the elements of x to define a circuit where x[i] = j   mean that j is the successor of i.
   %% I will working in other stractegy for these days....
   %% this global constraint must be changed in next versions
 ;


% deve existir uma aresta de src para algum no
% ou seja, src, a origem eh um noh com no minimo uma
% aresta escolhida

% calculo do custo.
% A distância total é a soma das distâncias dos arcos escolhidos como caminhosotal é a soma das distâncias dos arcos escolhidos como caminhos
constraint 
       custo = sum([ x_DECISION[i,j] * G[i,j] | i , j in 1..n ]);

%%% EXPLORE HERE
solve minimize custo;

% Output from Hakank ...OK
% to be improved
output [
 if i == 1 /\ j = 1 then
  "custo=" ++ show(custo) ++ "\n"
 else "" endif ++
 if j == 1 then show(i) ++ " : " else "" endif ++
       show(x_DECISION[i,j]) ++ if j = n then " .... goes to -> " ++ show(x_TOUR[i]) ++ "\n" else " " endif
       | i in 1..n, j in 1..n
]++[" \n "] ++ [ show(x_TOUR) ];

%% OTHER SOLUTION : 1 -> 2 -> 3 -> 6 -> 5 -> 4 -> 1
%% [4, 1, 2, 5, 6, 3] OK also
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
Ex1
custo=46
1 : 0 0 0 0 1 0 .... goes to -> 5
2 : 1 0 0 0 0 0 .... goes to -> 1
3 : 0 1 0 0 0 0 .... goes to -> 2
4 : 0 0 0 0 0 1 .... goes to -> 6
5 : 0 0 0 1 0 0 .... goes to -> 4
6 : 0 0 1 0 0 0 .... goes to -> 3
 
 [5, 1, 2, 6, 4, 3]

Ex2
custo=186
1 : 0 0 1 0 0 0 0 0 0 0 .... goes to -> 3
2 : 1 0 0 0 0 0 0 0 0 0 .... goes to -> 1
3 : 0 0 0 0 0 0 0 1 0 0 .... goes to -> 8
4 : 0 0 0 0 0 0 0 0 1 0 .... goes to -> 9
5 : 0 0 0 0 0 0 1 0 0 0 .... goes to -> 7
6 : 0 0 0 0 0 0 0 0 0 1 .... goes to -> 10
7 : 0 0 0 0 0 1 0 0 0 0 .... goes to -> 6
8 : 0 0 0 1 0 0 0 0 0 0 .... goes to -> 4
9 : 0 0 0 0 1 0 0 0 0 0 .... goes to -> 5
10 : 0 1 0 0 0 0 0 0 0 0 .... goes to -> 2
 
 [3, 1, 8, 9, 7, 10, 6, 4, 5, 2]
*/
