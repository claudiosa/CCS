%% CTES
int : a = 4 ;
int : b = 5 ;

%% VARs
var bool  : Reify_Var;
var bool  : x;
var bool  : y;
%% Default values for x and y: false

%% Remember: = or == it is the same
constraint
    Reify_Var = x \/ y;   %% two boolean constraints x or y

constraint
    (a > b) -> (x = true /\ y = false);
               
constraint
    (a <= b) -> (x = false /\ y = true);
     

solve satisfy;

output [
    "\n Reify_Var: "++show( Reify_Var )++
     "\n X: "++show(x)++"\t Y: "++show(y)++"\n"
];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
Compiling reify_example.mzn
Running reify_example.mzn

 Reify_Var: false
 X: false	 Y: true
*/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
