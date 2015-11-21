% 
% QUEENS, a classic combinatorial optimization problem
%
% The Queens Problem is to place as many queens as possible on the 8x8
% (or more generally, nxn) chess board in a way that they do not fight
% each other. This problem is probably as old as the chess game itself,
% and thus its origin is not known, but it is known that Gauss studied
% this problem.
% """
% 
% This MiniZinc model was created by Hakan Kjellerstrand, hakank@bonetmail.com
% See also my MiniZinc page: http://www.hakank.org/minizinc
%

% size of the chess board 
%int: n = 5;
int: n = 11;
% Matriz de pesos 
array [1 .. n, 1 .. n] of var int : pesos;
% Primeiro benchmark proposto
%%n=5
/*
pesos =[| 0, 2, 4, 6, 0, 
        | 4, 6, 8, 10, 1,
        | 8, 10, 1, 3, 5,
        | 1, 3, 5,  7, 9,
        | 8, 10, 1, 3, 5, 
        |];

*/
pesos =[| 0, 2, 4, 6, 8, 10, 1, 3, 5, 7, 9
        | 4, 6, 8, 10, 1, 3, 5, 7, 9, 0, 2
        | 8, 10, 1, 3, 5, 7, 9, 0, 2, 4, 6
        | 1, 3, 5, 7, 9, 0, 2, 4, 6, 8, 10
        | 5, 7, 9, 0, 2, 4, 6, 8, 10, 1, 3
        | 9, 0, 2, 4, 6, 8, 10, 1, 3, 5, 7
        | 2, 4, 6, 8, 10, 1, 3, 5, 7, 9, 0
        | 6, 8, 10, 1, 3, 5, 7, 9, 0, 2, 4
        | 10, 1, 3, 5, 7, 9, 0, 2, 4, 6, 8
        | 3, 5, 7, 9, 0, 2, 4, 6, 8, 10, 1
        | 7, 9, 0, 2, 4, 6, 8, 10, 1, 3, 5
        |];

% x[i,j] = 1 means that a queen is placed in square [i,j] 
array[1..n,1..n] of var 0..1: x;

% Variavel que soma todos os pesos respectivos as posições das rainhas
var int : somaTotal;

constraint

   % at most one queen can be placed in each row 
   forall(i in 1..n) (
        sum(j in 1..n) (x[i,j]) = 1
   )
   /\
   % at most one queen can be placed in each column 
   forall(j in 1..n) (
     sum(i in 1..n) (x[i,j]) = 1
   );

/************** ESTAS PROXIMAS RESTRICOES DEVERIAM SER REPENSADAS ***********/
constraint  
   % at most one queen can be placed in each "\"-diagonal 
   forall(k in 2-n..n-2) (
        sum(i,j in 1..n where i-j == k) (x[i,j]) <= 1
   )
   /\
   % at most one queen can be placed in each "/"-diagonal 
   forall(k in 3..n+n-1) (
     sum(i,j in 1..n where i+j == k) (x[i,j]) <= 1
   )
   ;

% ********* Aguardando algum estudante para REPENSAR as linhas das diagonais ***** 

/* *********************************************************************** */
% Calcula o peso total das rainhas selecionadas

 somaTotal = sum(i,j in 1..n) ( x[i,j] * pesos[i,j] );

/* *********************************************************************** */
solve :: int_search(
    [x[i,j] | i,j in 1..n] ++
    [ somaTotal ],
    first_fail, % "occurrence",
    indomain_min,
    complete
    )
     maximize  somaTotal;
/* *********************************************************************** */
output 
  [ "\n TOTAL DE RAINHAS: " ++ show( n )++ "\n\n" ] 
  ++
  [ if fix( x[i,j] ) = 1 then "R " else ". " endif ++
	 	if j = n then "\n" else "" endif
	|	i, j in 1..n]
   ++ 
  ["\nSoma dos pesos no TABULEIRO: " ++ show(somaTotal)]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/* OU Imprimindo em 0/1 ... use a sequencia abaixo
if j = 1 then "\n" else " " endif ++
    show(x[i,j])
  | i,j in 1..n] 
*/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%