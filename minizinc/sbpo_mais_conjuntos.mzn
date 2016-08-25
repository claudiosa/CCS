include "globals.mzn";
int : K = 7;
int: num_sets = 4; %% 
set of int : U = 0..10;  %% UNIVERSO
%% N conjuntos em y_sub[1] ate y_sub[N]
array[1 .. num_sets] of var set of U : y_sub; 

%% BY HAKAN
predicate set_sum(var set of int: s, var int: the_sum) =
   the_sum = sum(i in ub(s)) (bool2int(i in s) * i);

function var int: sum_SET(var set of int: SET) = 
    %sum(i in ub(s)) ( bool2int(i in s) * i);   %%% OU
    sum([bool2int(i in SET) * i | i in ub(SET)]); % 1 * i

constraint
 forall(i in 2..num_sets) (
     card(y_sub[i]) == card(y_sub[i-1]) /\ %%card(y[i]) <= 4 /\ 
     K == sum_SET(y_sub[i-1]) /\ 
     set_sum(y_sub[i], K) );

constraint
     alldifferent(y_sub); %% POLIMORFISMO

solve :: set_search(y_sub, Selec_VAR, Selec_DOM, complete)
         satisfy;

ann: Selec_VAR;   %% CRIANDO TIPOS - ann
ann: Selec_DOM;

%%%% Modificando AQUI 
Selec_VAR =  first_fail;
Selec_DOM = indomain_min;
