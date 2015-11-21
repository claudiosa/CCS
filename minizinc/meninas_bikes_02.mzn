%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Classical Assignment Problem in Minizinc
%% MODEL CREATED by CCS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
include "alldifferent.mzn";

int: rows;
int: cols;

rows = 4;
cols = 4;

% Meninas -- LINHAS 
%       B1 B2 B3  B4     
cost = [|7, 6, 4, 9,
        |6, 4, 3, 7,
        |5, 8, 1, 8,
        |9, 2, 12, 10
        |]
        ;

array[1..rows] of var 1..4 : x; %%% DECISION OTHER DOMAINS
array[1..rows, 1..cols] of int:  cost;
var int: total_cost;

constraint  
      alldifferent(x);

constraint
  total_cost = sum(i in 1..rows) ( cost[i,x[i]] );

% minimize total_cost
solve minimize total_cost;

output [  
       "Menina "++ show(i) ++ " = "++  show(x[i]) ++ "\n"
        | i in 1..rows]
       ++ [ "CUSTO FINAL: " ++ show(total_cost) ++ "\n" ] ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
