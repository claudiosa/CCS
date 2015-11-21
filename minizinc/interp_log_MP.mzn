/*   Logic Interpretation Phi */   
var bool : x;
var bool : y;
var bool : Phi01;
var bool : Phi02;

constraint
%% MODUS PONENS
      ((x /\ 
      (x -> y)) -> y) 
      <-> Phi01 ;

constraint
%% MODUS TOLLENS
      ((not y /\ 
      (x -> y)) -> not x) 
      <-> Phi02 ;


solve satisfy;

output [" X: "++show(x)++"   Y: "++ show(y) ++"  MP:Phi01: "++ show(Phi01)++ "\n" ]++
       [" X: "++show(x)++"   Y: "++ show(y) ++"  MT:Phi02: "++ show(Phi02)++ "\n" ];

/*

Compiling interp_log_MP.mzn
Running interp_log_MP.mzn
 X: false   Y: false  MP:Phi01: true
 X: false   Y: false  MT:Phi02: true
----------
 X: true   Y: false  MP:Phi01: true
 X: true   Y: false  MT:Phi02: true
----------
 X: false   Y: true  MP:Phi01: true
 X: false   Y: true  MT:Phi02: true
----------
 X: true   Y: true  MP:Phi01: true
 X: true   Y: true  MT:Phi02: true
----------
==========
Finished in 335msec



*/