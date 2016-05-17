include "alldifferent.mzn";
%%% Finished in 887msec  100 solutions
/*
    S E N D
    M O S T
----------------
  M O N E Y
          +
          10*C1

*/
%%% VARIAVEIS
var 1..9 : S;
var 1..9 : E;
var 1..9 : N;
var 1..9 : D;

var 1..9 : M;
var 1..9 : O;
var 1..9 : T;

var 1..9 : Y;

var 0..1 : C1;
var 0..1 : C2;
var 0..1 : C3;
var 0..1 : C4;

%% F objetivo
var int : f_soma;

constraint 
      alldifferent([S, E, N, D, M, O, T, Y])   ;

constraint 
    D + T = Y + C1*10;       %% 1a coluna

constraint 
    N + S + C1 = E + C2*10; %% 2a coluna

constraint 
    E + O + C2 = N + C3*10; %% 3a coluna

constraint 
    S + M + C3 = O + C4*10; %% 4a coluna

constraint 
    C4 = 1;

constraint 
  f_soma = S+ E + N + D + M + O + T+ Y;

%solve satisfy;
solve maximize f_soma;

output [
      "\tS: " ++ show(S) ++
    "\tE: " ++ show(E) ++
    "\tN: " ++ show(N) ++
    "\tD: " ++ show(D) ++        

    "\n\tM: " ++ show(M) ++
    "\tO: " ++ show(O) ++
    "\tS: " ++ show(S) ++
    "\tT: " ++ show(T) ++
    "\n-----------------------------------------------"++    
    "\nM: " ++ show(M) ++
    "\tO: " ++ show(O) ++
    "\tN: " ++ show(N) ++
    "\tE: " ++ show(E) ++
    "\tY: " ++ show(Y) ++
    "\n\n: SOMA " ++ show(f_soma) ++
    "\nC1: " ++ show(C1) ++"\tC2: " ++ show(C2) ++ "\tC3: " ++ show(C3) ++ "\tC4: " ++    show(C4)
];

/*
    S E N D
    M O S T
----------------
  M O N E Y
*/
