var 0..107 : x;
var 0..1007 : y;

constraint 
   ((x > 1) /\ 
   (x < 4) /\
   (y > 1) /\ 
   (y < 4))
   \/
   ((x > 104) /\ 
   (x < 107) /\
   (y > 1004) /\ 
   (y < 1007));



% Por fim, resolve-se o problema atraves do seg1inte comando
%solve satisfy;



%solve :: int_search( [], first_fail, indomain_min, complete) satisfy;   
%solve :: int_search( [], anti_first_fail, indomain_min, complete) satisfy; 
solve :: int_search([], largest ,  indomain_max ,  complete ) satisfy;   
% O resultado e mostrado a seguir:
/*
QUANTO A VARIABLE SELECTION:
"first_fail": which chooses the (undecided) variable with the smallest
domain;
"anti_first_fail": which chooses the variable with the largest domain;
"smallest": which chooses the variable with the smallest lower bound;
"largest": which chooses the variable with the largest upper bound; and
"input_order": which chooses variables in the order specified in the array.
bound
*/


output["[",show(x),", ",show(y),"]"];

% Possiveis solucoes

