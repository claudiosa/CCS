%
% Classical Assignment Problem in Minizinc
% 
% Model created by Hakan Kjellerstrand, hakank@bonetmail.com
% Adapted  by CCS
%

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

array[1..rows, 1..cols] of var 0..1: x;
array[1..rows, 1..cols] of int:  cost;
var int: total_cost;


%
% exacly one assignment per row, all rows must be assigned
%
constraint  
 forall(i in 1..rows) (
        sum(j in 1..cols) (x[i,j]) = 1
 )
;

% zero or one assignments per column
constraint 
  forall(j in 1..cols) (
        sum(i in 1..rows) (x[i,j]) <= 1
  )
;

constraint
total_cost = sum(i in 1..rows, j in 1..cols) (x[i,j]*cost[i,j]);


% minimize total_cost
solve minimize total_cost;

output [
  if i = 1 /\ j = 1 then
    "CUSTO FINAL: " ++ show(total_cost) 
  else " " endif ++
  if j = 1 then "\n" else " " endif ++
  show(x[i,j])++ ":" ++ show(cost[i,j])
  | i in 1..rows, j in 1..cols] 
  ++ ["\n"];
/*
 ++ 
   [ if j = 1 then "\n" else " " endif ++
   show(cost[i,j])
   | i in 1..rows, j in 1..cols
   ];
*/