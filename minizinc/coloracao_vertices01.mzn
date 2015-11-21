%% Aula de CP na Italia ...
int: n=8;
int: c=4;

array [1..n,1..n] of int: E;

array [1..n] of var 1..c: Col;

constraint 
  forall (i in 1..n, j in i+1..n)
     (if E[i,j] = 1 then Col[i] != Col[j] else true endif);

solve satisfy;

output [show(Col)];

%N = 8;
%C = 3;

%% CIDADES ....
% 1 Friuli Venezia Giulia
% 2 Veneto
% 3 Trentino Alto Adige
% 4 Lombardy
% 5 Emilia-Romagna
% 6 Piedmont
% 7 Liguria
% 8 Aosta Valley
%%% CONEXOES
E = [|0,1,0,0,0,0,0,0
     |1,0,1,1,1,0,0,0
     |0,1,0,1,0,0,0,0
     |0,1,1,0,1,1,0,0
     |0,1,0,1,0,1,1,0
     |0,0,0,1,1,0,1,1
     |0,0,0,0,1,1,0,0
     |0,0,0,0,0,1,0,0|];
/*
SAIDA
Compiling coloracao_vertices01.mzn
Running coloracao_vertices01.mzn
[1, 2, 3, 1, 3, 2, 1, 1]
-------------------
[3, 2, 3, 1, 3, 2, 1, 1]
.......
*/

