
%%% Validando uma formula 3CNF-SAT
%% SEJAM AS VARS
bool : x;
bool : y;
bool : z;

%% RESPOSTAS DAS AVALIACOES
var bool : interpretacao_1;
var bool : interpretacao_2;
var bool : interpretacao_3;

%%% Valores vindo de uma redução ... CALCULADOS POR OUTRO ALGORITMO
x = true;   %%%% isto eh not(x) = false 
y = true;
z = false;  %%%% isto eh not(z) = true 

constraint
 (x \/ not(y) \/ z) /\  (x \/ not(y) \/ not(z)) = interpretacao_1;


constraint
 (x \/ not(y) \/ z) /\  (z \/ not(y) \/ not(x)) = interpretacao_2;

constraint
interpretacao_1 /\ interpretacao_2 = interpretacao_3;

solve satisfy;

output
     [" EXEMPLIFIICANDO ....",
      "\n  Aval1 = ", show(interpretacao_1) , 
      "\n  Aval2 = ", show(interpretacao_2) ,
      "\n  Aval3 = ", show(interpretacao_3) ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
