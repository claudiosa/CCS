%% Especificação do PROBLEMA:
/*
Problem Formulation 

Powerco has three electric power plants that supply the needs of four cities.† Each power plant can supply the following numbers of kilowatt-hours (kwh) of electricity: plant 1—35 million; plant 2—50 million; plant 3—40 million (see Table 1). The peak power demands in these cities, which occur at the same time (2 P.M.), are as follows (in kwh): city 1—45 million; city 2—20 million; city 3—30 million; city 4—30 million. The costs of sending 1 million kwh of electricity from plant to city depend on the distance the electricity must travel. Formulate an LP to minimize the cost of meeting each city’s peak power demand.


Solution: To formulate Powerco’s problem as an LP, we begin by defining a variable for each decision that Powerco must make. Because Powerco must determine how much power is sent from each plant to each city, we define (for i  1, 2, 3 and j  1, 2, 3, 4)

xij:  number of (million) kwh produced at plant i and sent to city j



 http://www.producao.ufrgs.br/arquivos/disciplinas/382_winston_cap_7_transportation.pdf

*/

%% Constantes declaration
int : C1 = 35;
int : C2 = 50; %%% havia trocado aqui ...
int : C3 = 40; %%% OK 

%% Var declaration :: capacidade da PLANTA
var 0 .. C1 : x11;
var 0 .. C1 : x12;
var 0 .. C1 : x13;
var 0 .. C1 : x14;
var 0 .. C2 : x21; 
var 0 .. C2 : x22;
var 0 .. C2 : x23;
var 0 .. C2 : x24;
var 0 .. C3 : x31;
var 0 .. C3 : x32;
var 0 .. C3 : x33;
var 0 .. C3 : x34;
var int : custo;


%constraint %% to break symmetries
% x13 >= 5 /\ x23 >= 5 /\ x33 >= 5; 

constraint
x11 + x12 + x13 + x14 <= C1; %(Plant 1 supply constraint)
constraint
%/\
x21 + x22 + x23 + x24 <= C2; %(Plant 2 supply constraint)
constraint
x31 + x32 + x33 + x34 <= C3; %(Plant 3 supply constraint)

%%(City  demand constraint --  ver enunciado:: tabela dos slides)
constraint
x11 + x21 + x31 >= 45    /\
x12 + x22 + x32 >= 20    /\
x13 + x23 + x33 >= 30    /\ 
x14 + x24 + x34 >= 30     ;

constraint
custo =  
  8*x11 +  6*x12 + 10*x13 + 9*x14 +
  9*x21 +  12*x22 + 13*x23 + 7*x24+
  14*x31 + 9*x32 + 16*x33 + 5*x34;

%%% SEARCH ... it is a strong point of CP
%solve satisfy;
%%solve minimize custo;
solve :: int_search([x11,x12,x13,x14, 
                     x21,x22,x23,x24, 
                     x31,x32,x33,x34], 
%                    anti_first_fail, indomain_max, complete ) 
                     max_regret, indomain_max, complete ) 
%                    first_fail, indomain_max, complete ) 
                     minimize custo;

%%solve :: int_search([LIST OF VARS], SELECT_VAR, SELECT_DOMAIN, complete) minimize   COST_FUNCTION;
%% SELECT_VAR_INT={input_order, anti_first_fail, first_fail, smallest, largest, max_regret}
%% DOMAIN_VAR_INT={indomain, indomain_split, indomain_random, indomain_median, indomain_max, indomain_min}
%% DETAILS in http://www.minizinc.org/g12_www/zinc/doc-2.0/html/zinc-manual.html#htoc17
%%%% OUTPUT
output [
"x1 .. 4: "++show(x11)++" "++show(x12)++" "++show(x13)++" "++show(x14)++"\n"++ 
"x2 .. 4: "++show(x21)++" "++show(x22)++" "++show(x23)++" "++show(x24)++"\n"++
"x3 .. 4: "++show(x31)++" "++show(x32)++" "++show(x33)++" "++show(x34)
      ];

/*
Finished in 1m 49s
Compiling planta_energia_Powerco.mzn
Running planta_energia_Powerco.mzn
x1 .. 4: 0 10 25 0
x2 .. 4: 45 0 5 0
x3 .. 4: 0 10 0 30
----------
==========
Finished in 78msec


SOLVER MIP
Compiling planta_energia_Powerco.mzn
Running planta_energia_Powerco.mzn
x1 .. 4: 0 10 25 0
x2 .. 4: 45 0 5 0
x3 .. 4: 0 10 0 30
----------
==========
Finished in 384msec

Solver: fd
Compiling planta_energia_Powerco.mzn
Running planta_energia_Powerco.mzn
x1 .. 4: 0 10 25 0
x2 .. 4: 45 0 5 0
x3 .. 4: 0 10 0 30
----------
==========
Finished in 5m 26s
*/
