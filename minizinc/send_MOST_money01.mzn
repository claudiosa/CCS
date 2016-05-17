%% by CCS em 17/05/16
include "alldifferent.mzn";
/*
    S E N D
    M O S T
----------------
  M O N E Y
          +
          10*C1
.......................
*/
%%% VARIAVEIS .... e dominios de 0 a 9
var 0..9 : S;  var 0..9 : E;  var 0..9 : N;  var 0..9 : D;
var 0..9 : M;  var 0..9 : O;  var 0..9 : T;  var 0..9 : Y;

var 0..1 : C1;  var 0..1 : C2;  var 0..1 : C3;  var 0..1 : C4;

%% Funcao  objetivo maximizar a palavra MOST
var int : F_MOST;

constraint 
      alldifferent([S, E, N, D, M, O, T, Y]);

constraint     %%% original formulation
     S > 0 /\
     M > 0;

constraint 
     C4 == M; %%% verifique a coluna que faltava  ....

constraint 
    D + T = Y + C1*10;       %% 1a coluna

constraint 
    N + S + C1 = E + C2*10;  %% 2a coluna

constraint 
    E + O + C2 = N + C3*10;  %% 3a coluna

constraint 
    S + M + C3 = O + C4*10;  %% 4a coluna


constraint 
%%% maximizar o valor   "M O S T"
  F_MOST = M*1000 + O*100 + S*10 + T;

%solve satisfy;
solve maximize F_MOST;

output [
      "\tS: " ++ show(S) ++
    "\tE: " ++ show(E) ++
    "\tN: " ++ show(N) ++
    "\tD: " ++ show(D) ++        

    "\n\tM: " ++ show(M) ++
    "\tO: " ++ show(O) ++
    "\tS: " ++ show(S) ++
    "\tT: " ++ show(T) ++
    "\n-----------------------------------------"++    
    "\nM: " ++ show(M) ++
    "\tO: " ++ show(O) ++
    "\tN: " ++ show(N) ++
    "\tE: " ++ show(E) ++
    "\tY: " ++ show(Y) ++
    "\n\n => SOMA do MOST: " ++ show(F_MOST) ++
    "\nC1: "++show(C1)++"\tC2: "++show(C2) ++
    "\tC3: " ++show(C3)++"\tC4: "++show(C4)
    ];

/*
    S E N D
    M O S T
----------------
  M O N E Y
*/
