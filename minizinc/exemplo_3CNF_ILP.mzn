/*
VEJA COMO ESTAO CONVERTIDA a formula abaixo em PLI
 (x \/ not(y) \/ z) /\  (x \/ not(y) \/ not(z)) 

%%% UMA DAS RESPOSTAS A SEREM ENCONTRADAS PARA ESTE EXEMPLO DEVE SER
%x = true; ==> 1
%y = true; ==> 1
%z = false; ==> 0
*/
%%% Validando uma formula 3CNF-SAT
%% SEJAM AS VARS
var  0..1 : x;
var  0..1 : y;
var  0..1 : z;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% (x \/ not(y) \/ z) /\ 
%% (x \/ not(y) \/ not(z)) 
constraint
        x + (1-y) + z >= 1;

constraint
        x + (1-y) + (1-z) >= 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
solve satisfy;

output
     [" EXEMPLIFIICANDO ....",
      "\n  X = ", show(x) , 
      "\n  Y = ", show(y) ,
      "\n  Z = ", show(z) ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
TODAS AS RESPOSTAS abaixo satisfazem
(x \/ not(y) \/ z) /\  (x \/ not(y) \/ not(z)) 
CONFIRA
EXEMPLIFIICANDO ....
  X = 0
  Y = 0
  Z = 0
----------
 EXEMPLIFIICANDO ....
  X = 1
  Y = 0
  Z = 0
----------
 EXEMPLIFIICANDO ....
  X = 1
  Y = 1
  Z = 0
----------
 EXEMPLIFIICANDO ....
  X = 0
  Y = 0
  Z = 1
----------
 EXEMPLIFIICANDO ....
  X = 1
  Y = 0
  Z = 1
----------
 EXEMPLIFIICANDO ....
  X = 1
  Y = 1
  Z = 1
----------
==========
*/