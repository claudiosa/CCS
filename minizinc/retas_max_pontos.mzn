
%%% EXEMPLO AD-HOC ... apenas ilustra a notacao
%%

%% Constantes declaration
int : DX = 50;
int : DY = 50; %%% havia trocado aqui ...

%% Var declaration :: capacidade da PLANTA
var 0 .. DX : x;
var 0 .. DY : y;
var int : custo;


constraint %% RETA 1
    2*y - x + 2 >= 0;

constraint %% RETA 2
    5*y - 4*x - 10 >= 0;

constraint %% RETA 3
    3*y + 2*x - 12 >= 0;

constraint %% RETA 4
    1*y + 2*x + 30 >= 0;

constraint
    custo =  x + y;


constraint
    custo <= 20;

%%% SEARCH ... it is a strong point of CP
%solve satisfy;
%solve maximize custo;

solve :: int_search([x,y], 
%                    anti_first_fail, indomain_max, complete ) 
                     max_regret, indomain_max, complete ) 
%                    first_fail, indomain_max, complete ) 
                     maximize custo;

%%solve :: int_search([LIST OF VARS], SELECT_VAR, SELECT_DOMAIN, complete) minimize   COST_FUNCTION;
%% SELECT_VAR_INT={input_order, anti_first_fail, first_fail, smallest, largest, max_regret}
%% DOMAIN_VAR_INT={indomain, indomain_split, indomain_random, indomain_median, indomain_max, indomain_min}
%% DETAILS in http://www.minizinc.org/g12_www/zinc/doc-2.0/html/zinc-manual.html#htoc17
%%%% OUTPUT
output [
"x: " ++ show(x) ++ " \t"++"y: "++show(y)
      ];
