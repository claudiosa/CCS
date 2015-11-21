%% in lab 07/05

% data
n = 11;
%%include "globals.mzn";

int: n;
array[1..n] of var 1..n: queens;
% Matriz de pesos 
array [1 .. n, 1 .. n] of var int : pesos;
% Primeiro benchmark proposto
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

% Variavel que soma todos os pesos respectivos as posições das rainhas
var int : somaTotal;

% solve satisfy;
%%constraint all_different(queens);

constraint
/*
 HAKAN -- version
    forall(i, j in 1..n where i < j) (
         (queens[i]  != queens[j]) /\
         (queens[i]  != queens[j] + j-i) /\
         (queens[i]  != queens[j] - j+i) 
    ) 
 ;
*/
/* RAFAEL and CC */
  forall(i , j in 1..n where i < j) (
         (queens[i]  != queens[j]) /\
         (queens[i]  != queens[j] + abs(j-i)) /\
         (queens[i]  != queens[j] - abs(i-j)) 
    ) 
 ;

% Calcula o peso total das rainhas selecionadas
constraint
  somaTotal = sum(i in 1 .. n) (pesos[i, queens[i]]);

/* EXPLORE IT   ++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

solve :: int_search(
        queens++[somaTotal], 
        first_fail, 
        indomain_min, 
        complete) maximize somaTotal; %%minimize somaTotal;



/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

output 
 [show(queens) ++ "\n"]++
  ["Para  " ++show(n)++ "  rainhas .....  temos:\n"]  ++
	[	if fix( queens[i] ) = j then "R " else ". " endif ++
	 	if j = n then "\n" else "" endif
	|	i, j in 1..n
	]++
   ["Soma dos pesos: " ++ show(somaTotal)]
  ;



/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
