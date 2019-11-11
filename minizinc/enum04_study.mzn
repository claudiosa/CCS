%% Study 03
%% enum type and sets
include "globals.mzn";

par int: size = 10; %%% new versions of Minizinc

%%% IT IS NOT ALLOWED .... with SETS
%par int: ROW = 5;
%par int: COL = 2;

%%% FOR INDEX IN ARRAY  -- SETS
set of int: ROW = 1..5;
set of int: COL = 1..2;

enum Letters = {a, b, c, d, e};
%enum Some_Num = {'11', '22', '33', '44', '55'};
enum Some_Num = { ONE , TWO, THREE, FOUR, FIVE};

set of int: Some_N = 1..100 ;
%set of int: Some_N = {1,2,3,4,5,6,7,8,9,0} ;
%var set of Letters : set_1; %%% VARIABLE size

%%%%%%%%%%%%%%% 
array[1..size] of var set of Letters: var_X; %%% one array withe size fixed
array[ROW,COL] of var set of Some_N : var_Y; %%% one array wthe size fixed



%%%%%%%%%%% function to sum a set ... inspired in predicate from HAKAN
function var int: sum_SET(var set of int: SET) = 
    %sum(i in ub(s)) ( bool2int(i in s) * i);   %%% OR
    sum( [bool2int(i in SET) * i | i in ub(SET)] ); % 1 * i


constraint
  alldifferent(var_Y);


constraint
   forall(i in ROW )
     (
      card( var_Y[i,1]) = 2
                /\
      card( var_Y[i,2]) = 4                
         /\
       var_Y[i,1] != var_Y[i,2]
     );  

%%% a special function to sum all the elements of a SET
constraint
   forall(i in ROW )
     (
      sum_SET( var_Y[i,1] )  =  (sum_SET( var_Y[i,2] ) + 10)
     )  
  ;


/*
 forall(i in 1..(size-1) )
       (
%       var_X[i] = set_1
%        /\
        var_X[i] != var_X[i+1]
%      card(set_1) = i
       )
*/       
       
            
 

% %%
% var set of int : var_SET;

% %constraint .... embora seja uma variavel
% %% ISTO UMA OPERACAO de CONJUNTO e não uma função
% %% para ter uma constraint
  
% var_SET = set_1 intersect set_2;


solve satisfy;


%output ["var_X \(i): " ++ show(var_X[i]) ++ "\n" | i in 1..size];

output[
        %"\n Cardinal: "++show(card(var_SET))++
        "\n Var_Y: "++show2d(var_Y)
%       "\n set_1: "++show(set_1) ++
%        "\n set_2: "++show(set_2) 
  %     ++
  %     "\n var_Y: "++show(var_Y)
       ];

