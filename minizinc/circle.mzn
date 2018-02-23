%
% Non linear programming in Minizinc
% 
% From the ECLiPSe book, page 259
%
% The following ECLiPSe predicate was translated to Minizinc. 
% circle(X,Y):-
% 
%        4 $= X^2 + Y^2,
%        4 $= (X-1)^2 + (Y-1)^2,
%        squash([X,Y], 1e-5, lin).
%$ mzn-gecode circle.mzn
% Model created by Hakan Kjellerstrand, hakank@bonetmail.com
% See also my MiniZinc page: http://www.hakank.org/minizinc
%% MODIFIED CCS

var float: X;
var float: Y;
var float: z;

% solve satisfy;
% solve maximize x - exp(x);

solve :: float_search([X,Y], 0.001, input_order, indomain_split, complete) 
 maximize z ;
 %satisfy;

constraint
   % X >= 0.0 /\ Y >= 0.0 /\
   %16.0 = X*X + Y*Y /\
   16.0 = pow(X,2) +  pow(Y,2) /\
   16.0 = (X-2.0)*(X-2.0) + (Y-2.0)*(Y-2.0)
   ;

constraint
% z  =  X - Y ;    
 z  = X - pow(X,2);
%  z =  X  + Y ;    abs e exp NO



output
[
  "X: " ++ show_float(6,2,X) ++ " " ++ "Y: " ++ show_float(6,2,Y) ++  show_float(6,2,z)++ "\n"
];