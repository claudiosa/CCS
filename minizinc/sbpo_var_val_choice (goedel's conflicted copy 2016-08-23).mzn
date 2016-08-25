include "globals.mzn";
int : N = 4;
array[1..N] of var 1..7 : x;

constraint 
      alldifferent(x) /\ increasing (x);
constraint 
      sum(x) == 13;

ann: Selec_VAR;   %% CRIANDO TIPOS - ann
ann: Selec_DOM;

solve :: int_search(x, Selec_VAR, Selec_DOM, complete)
         satisfy;

%%%% Vah modificando AQUI
Selec_VAR = dom_w_deg; %% dom_w_deg, first_fail, largest
Selec_DOM = indomain_min; %%