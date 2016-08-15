var bool : x;
var bool : y;
var bool : Phi01;
var bool : Phi02;

constraint             %% MODUS PONENS
      ((x /\ 
      (x -> y)) -> y) 
      <-> Phi01 ;

constraint 		          %% MODUS TOLLENS
      ((not y /\ 
      (x -> y)) -> not x) 
      <-> Phi02 ;

solve satisfy;

output
[" X: "++show(x)++"   Y: "++ show(y) ++"  MP:Phi01: "++ show(Phi01)++ "\n" ]++
[" X: "++show(x)++"   Y: "++ show(y) ++"  MT:Phi02: "++ show(Phi02)++ "\n" ];
