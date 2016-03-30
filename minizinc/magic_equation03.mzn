include "alldifferent.mzn";
%% Finished in 536msec ... 100 solutions ... A MAIS VELOZ
var 1..9 : A;
var 1..9 : B;
var 1..9 : C;

var 1..9 : D;
var 1..9 : E;
var 1..9 : F;

var 1..9 : G;
var 1..9 : H;
var 1..9 : I;

constraint alldifferent([A, B, C, D, E, F, G, H, I]);

constraint 
%%  A*(E*F*H*I) + D*(B*C*H*I) + G*(B*C*E*F) == B*C*E*F*H*I;
    E*F*(A*H*I + G*B*C) ==  (B*C*H*I)*(E*F - 1);

constraint 
     (B*C) > A /\ (E*F) > D /\ (H*I) > G ;
%% Finished in 368msec

solve satisfy;

output [
      "A: " ++ show(A) ++
    "\tB: " ++ show(B) ++
    "\tC: " ++ show(C) ++
        
    "\nD: " ++ show(D) ++
    "\tE: " ++ show(E) ++
    "\tF: " ++ show(F) ++
        
    "\nG: " ++ show(G) ++
    "\tH: " ++ show(H) ++
    "\tI: " ++ show(I)
];
