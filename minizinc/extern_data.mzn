
%%% CONSTRAINTS VARs
var float : Var1;
var int : Var2;
var bool : Var3;
%
% in  DATA-EXTERN.dzn
% Var1 = 3.9999999;
% Var2 = 4;
%
%% TOY CONSTRAINT
constraint 
     (Var1 > Var2) -> Var3 = true;

solve satisfy;

output
[
 "\n VAR1:" ++ show(Var1)  ++ "\t" ++
 "VAR2:" ++ show(Var2)  ++ "\t" ++
 "VAR3:" ++ show(Var3)  
];
/*
Compiling extern_data.mzn with data DATA-EXTERN.dzn
Running extern_data.mzn

 VAR1:3.9999999000000002	VAR2:4	VAR3:false
----------
Finished in 11msec
*/

