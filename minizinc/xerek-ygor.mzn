%%%  minizinc -a xerek-ygor.mzn 

%% Declara variaveis de restricoes
var 1  .. 11 : X;
var 1  .. 7 : Y;

%% As restricoes     
constraint
   Y >  2    /\  
   Y <  5 ; 
  
constraint
   X >  3    /\  
   X <  9 ; 

%%% A busca
solve :: int_search([X,Y], input_order, indomain_min, complete) satisfy;
%% indomain_max
%% testar  a busca abaixo
%solve :: int_search([X,Y], smallest, indomain_max, complete) satisfy;
%% e conclua???

%% As saidas
output [    "   X: "  ,  show(X),"     Y: ", show(Y) ,   "\n" ];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
