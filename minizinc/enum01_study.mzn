%% Study 01
%% enum type and sets

par int: size = 3; %%% new versions of Minizinc

enum Letters = {a,b,c,d,e};

%%var set of Letters: var_X;

array[1..size] of var Letters: var_X; %%% one array withe size fixed

var set of Letters : set_1; %%% VARIABLE size


constraint
  card(set_1) <= size;



% set of int : set_1 = {1,2,3,4,5,6} ;
% set of int : set_2 = { 3,4,5 } ;

% %%
% var set of int : var_SET;

% %constraint .... embora seja uma variavel
% %% ISTO UMA OPERACAO de CONJUNTO e não uma função
% %% para ter uma constraint
  
% var_SET = set_1 intersect set_2;


solve satisfy;

output[
        %"\n Cardinal: "++show(card(var_SET))++
       "\n X_letters: "++show(var_X)++
       "\n set_1: "++show(set_1)
       %"\n set_2: "++show(set_2)
       ];



