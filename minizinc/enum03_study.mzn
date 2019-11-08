%% Study 03
%% enum type and sets
include "globals.mzn"; %% for alldiferent

par int: size = 10; %%% new versions of Minizinc

enum Letters = {a, b, c, d, e};

%%var set of Letters: var_X;

var set of Letters : set_1; %%% VARIABLE size
array[1..size] of var set of Letters: var_X; %%% one array withe size fixed


 
%array[1..n_workers] of var set of 1..n_tasks: worker_tasks;
%array[1..n_tasks] of var 1..n_workers: task_worker; 


constraint
  alldifferent(var_X)

/*
 forall(i in 1..(size-1) )
       (
%       var_X[i] = set_1
%        /\
        var_X[i] != var_X[i+1]
%      card(set_1) = i
       )
*/       
       ;
             
 



% set of int : set_1 = {1,2,3,4,5,6} ;
% set of int : set_2 = { 3,4,5 } ;

% %%
% var set of int : var_SET;

% %constraint .... embora seja uma variavel
% %% ISTO UMA OPERACAO de CONJUNTO e não uma função
% %% para ter uma constraint
  
% var_SET = set_1 intersect set_2;


solve satisfy;


output ["var_X \(i): " ++ show(var_X[i]) ++ "\n" | i in 1..size];
/*
output[
        %"\n Cardinal: "++show(card(var_SET))++
        "\n X_letters: "++show(var_X)
%       "\n set_1: "++show(set_1) ++
        "\n set_2: "++show(set_2) 
  %     ++
  %     "\n var_Y: "++show(var_Y)
       ];
*/


