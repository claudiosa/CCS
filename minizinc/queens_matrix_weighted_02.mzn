%% in lab 07/05
include "alldifferent.mzn";

% data
n = 11;

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

constraint all_different(queens);

constraint   /* RAFAEL and CC */
  forall(i , j in 1..n where i < j) (
         (queens[i]  != queens[j]) /\
         (queens[i]  != queens[j] + abs(j-i)) /\
         (queens[i]  != queens[j] - abs(i-j)) 
    ) 
 ;

% Calcula o peso total das rainhas selecionadas
constraint
  somaTotal = sum(i in 1 .. n) (pesos[i, queens[i]]);


%%% Anotacao de codigo ou procedimento
ann : search_EXPLORE;
solve :: search_EXPLORE  maximize somaTotal;
%%% solve :: search_EXPLORE satisfy; %%% se apenas satisfy

%%%% DEVE ESTAR em um outro arquivo de dados 
%search_EXPLORE = int_search(queens++[somaTotal], first_fail, indomain_min, complete);
search_EXPLORE = int_search(queens++[somaTotal], anti_first_fail, indomain_max, complete); 

/* EXPLORE IT   ++++++++++++++++++++++++++++++++++++++++++++++++++++++
solve :: seq_search([
        %%% combinando esta estrategia para queens
        int_search(queens, 
        first_fail, 
        indomain_min, 
        complete)
        ,
        %%% com esta para outra variavel 
        int_search([somaTotal], 
        anti_first_fail, 
        indomain_max, 
        complete)
        ])
        maximize somaTotal;
*/
/*
The sequential search constructor first undertakes the search given by th
e first annotation in its list, when all variables in this annotation are fixed it undertakes the second search annotation, etc until
all search annotations are complete.

No caso acima fica mais lenta .... do que em um BRANCH unico
solve :: int_search(
        queens++[somaTotal], 
        first_fail, 
        indomain_min, 
        complete) maximize somaTotal; %%minimize somaTotal;
*/
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
/*
For bool_search and int_search only the following parameters (where applicable) will be used:

    variable choice:
        input_order
        first_fail (variable with smallest domain size)
        anti_first_fail (variable with largest domain size)
        smallest (variable with smallest minimal value)
        largest (variable with largest maximum value) 
    value choice: [examples for domain {1,3,4,18}]
        indomain_min (x <= 1; x > 1)
        indomain_max (x >= 18; x < 18)
        indomain_median (x = 3 ; x != 3)
        indomain_split (x <= (1+18)/2 ; x > (1+18)/2 )
        indomain_reverse_split (x > (1+18)/2 ; x <= (1+18)/2 ) 
    search style
        complete 

*/