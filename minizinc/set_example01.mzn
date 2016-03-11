%int: n=10;
%int: m=5;

set of int : set_1 = {1,2,3,4,5,6} ;
set of int : set_2 = { 3,4,5 } ;

%%
var set of int : var_SET;

%constraint .... embora seja uma variavel
%% ISTO UMA OPERACAO de CONJUNTO e não uma função
%% para ter uma constraint
  
var_SET = set_1 intersect set_2;


solve satisfy;

output["\n Cardinal: "++show(card(var_SET))++
       "\n Intersec: "++show(var_SET)++
       "\n set_1: "++show(set_1)++
       "\n set_2: "++show(set_2)
       ];



