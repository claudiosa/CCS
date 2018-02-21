include "alldifferent.mzn";

%% FENCE  ... mas n itens a serem escolhidos e repetidos
int: n = 5; %% sides of polygon
int: m = 14 ; %% fences availble

array[1..m] of int : fences; %% availble or allowed fences
array[1..n] of int : polygon; %% to be covered
array[1..n] of var 1..m : x_solution;
%%:array[1..n] of var 0..ub_array(qt_item) : x_decision;

fences = [18, 7, 2, 3, 19, 15, 4, 14, 6, 6, 6, 7, 10, 6];
polygon = [8, 9, 5, 4, 6];


var int: total_lenght;
var int: perimeter;

%% Different fences to choose
constraint
  alldifferent (  x_solution  );

constraint
    perimeter = sum( j in 1..n ) (  polygon[ j ]  );

constraint
    total_lenght = sum( j in 1..n ) (  fences[x_solution[ j ] ]  );


/* %%% one of the most important ... but overestimated */
constraint
       exists(j in 1 .. m) 
        ( forall(i in 1 .. n) 
         ((fences[j] > polygon[i]) -> (x_solution [ i ] ==  j))  
        );

       
%% for each polygon's side there is a fence
constraint
     forall(i in 1.. n)
     (polygon[ i ] < fences[ x_solution [ i ] ]);  %% there' s one lesser


% minimize total_cost
 %%solve  satisfy;
solve minimize total_lenght;
%%%maximize total_VALOR;

output ["Availble Fences: " ++ show( fences ) ++ "\n" ++
         "Polygon Sides: " ++ show(polygon) ++"\n" ++
         "Perimeter: " ++ show(perimeter)++"\n" ++
         "X_decision from fences array: " ++ show( x_solution ) ++ "\n" ++
         "Total Lenght: " ++ show(total_lenght)]
         ++ ["\n"] 
         ++ [show(i) ++ ":  side " ++ show(polygon[i]) ++
             " covered by " ++ 
             show( fences[ fix( x_solution[i] ) ] )++"\n"
             | i in 1 .. n ];
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%
/*
$ python fences.py 
([(4, 6), (5, 6), (6, 7), (8, 10), (9, 14)], 43)
ccs@gerzat~/Dropbox/pesquisa/curso_ALL/minizinc$ minizinc fence_sum.mzn 
Availble Fences: [18, 7, 2, 3, 19, 15, 4, 14, 6, 6, 6, 7, 10, 6]
Polygon Sides: [8, 9, 5, 4, 6]
Perimeter: 32
X_decision from fences array: [13, 8, 10, 9, 2]
Total Lenght: 43
1:  side 8 covered by 10
2:  side 9 covered by 14
3:  side 5 covered by 6
4:  side 4 covered by 6
5:  side 6 covered by 7
----------
==========
ccs@gerzat~/Dropbox/pesquisa/curso_ALL/minizinc$ 
*/