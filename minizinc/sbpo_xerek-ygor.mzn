%% Declara constantes
int: UM = 1; int: DOIS = 2; int:  CINCO = 5;
%% Declara variaveis
var UM  .. 11 : X; %% segue o dominio 1..11
var UM  .. 7 : Y; 

%% As restricoes     
constraint
   Y >  DOIS  /\   Y <  CINCO ; 
  
constraint
   X >  3    /\     X <  9 ; 

%%% A busca : MUITAS OPCOES ....
solve::int_search([X,Y],input_order,indomain_min,complete) satisfy;
%% SAIDAS
output ["   X: ", show(X), "     Y: ", show(Y), "\n"];