%% by CCS
include "alldifferent.mzn";
/*
    V I O L I N
-     C E L L O             
----------------
    C O R N E T
.......................
*/
%%% VARIAVEIS .... e dominios de 0 a 9
var 0..9 : V;  var 0..9 : I;  var 0..9 : O;   var 0..9 : L;  var 0..9 : N;  
var 0..9 : C;  var 0..9 : E;  
var 0..9 : R;  var 0..9 : T;  

%%% EMPRESTA UM
var 0..1 : C1;  var 0..1 : C2;  var 0..1 : C3;  
var 0..1 : C4;  var 0..1 : C5;

%% Funcao  objetivo maximizar a palavra LOVE
var int : f_MAXIMIZACAO;

constraint 
      alldifferent([ V, I, O, L, N, C, E, R, T ]);
/*
    V I O L I N
-     C E L L O             
----------------
    C O R N E T
*/
constraint 
  (N + C1*10) - O == T ;       %% 1a coluna

constraint 
  ((I-C1) + C2*10) - L == E;  %% 2a coluna

constraint 
  ((L-C2) + C3*10) - L ==  N;  %% 3a coluna

constraint 
  ((O-C3) + C4*10) - E ==  R;  %% 4a coluna

constraint 
  ((I-C4) + C5*10) - C ==  O;  %% 5a coluna
    
constraint 
  V - C5 == C;  %% 6a coluna    

%%% maximizar o valor   "L + O + V + E"
constraint 
  f_MAXIMIZACAO = L + O + V + E;

%solve satisfy;
solve maximize f_MAXIMIZACAO;

output [
      
    "V: " ++ show(V) ++
    "\tI: " ++ show(I) ++
    "\tO: " ++ show(O) ++
    "\tL: " ++ show(L) ++
    "\tI: " ++ show(I) ++
    "\tN: " ++ show(N) ++        

    "\n\tC: " ++ show(C) ++
    "\tE: " ++ show(E) ++
    "\tL: " ++ show(L) ++
    "\tL: " ++ show(L) ++
    "\tO: " ++ show(O) ++
    "\n--------------------------------------------------"++    
    "\nC: " ++ show(C) ++
    "\tO: " ++ show(O) ++
    "\tR: " ++ show(R) ++
    "\tN: " ++ show(N) ++        
    "\tE: " ++ show(E) ++
    "\tT: " ++ show(T) ++
    
    "\n\n f MAXIMIMIZACAO: " ++ show(f_MAXIMIZACAO) ++
    "\nC1: "++show(C1)++"\tC2: "++show(C2) ++
    "\tC3: " ++show(C3)++"\tC4: "++show(C4)
    ++"\tC5: "++show(C5)
    ];

