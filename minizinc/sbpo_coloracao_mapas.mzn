int: n=8; %% REGIOES
int: c=4; %% CORES 

array [1..n, 1..n] of int : Adj; %% Matriz Adjacencia
array [1..n] of var 1..c : Col;  %% Saida

constraint 
  forall (i in 1..n, j in i+1..n)
     (if Adj[i,j] == 1 then Col[i] != Col[j] else true endif);

solve satisfy;

output [show(Col)];

Adj = [|0,1,0,0,0,0,0,0
       |1,0,1,1,1,0,0,0
       |0,1,0,1,0,0,0,0
       |0,1,1,0,1,1,0,0
       |0,1,0,1,0,1,1,0
       |0,0,0,1,1,0,1,1
       |0,0,0,0,1,1,0,0
       |0,0,0,0,0,1,0,0|];

%% Regioes da Italia
% 1 Friuli Venezia Giulia
% 2 Veneto
% 3 Trentino Alto Adige
% 4 Lombardy
% 5 Emilia-Romagna
% 6 Piedmont
% 7 Liguria
% 8 Aosta Valley
%%% CONEXOES
