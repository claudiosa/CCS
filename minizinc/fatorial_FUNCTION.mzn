%
% Factorial in MiniZinc.
% Made by CCS
% ADAPTED from Hakan
% Since the prod() don't work yet, this is an alternative
% version of calculating factorial.
%
% Model created by Hakan Kjellerstrand, hakank@bonetmail.com
% See also my MiniZinc page: http://www.hakank.org/minizinc

% include "globals.mzn";

int: n = 10;
var int: z;

/*
function var int:  factorial(int: n) =
   let {

       array[1..n] of var int: x;
   
       constraint
         x[1] = 1
         /\
         forall(i in 2..n) 
         (
         x[i] = x[i-1]*i
         )
   }
    in  x[n]  %%% quem desejas retornar ....
;
*/
/* RECURSION .... ....*/

function var int:  factorial_1(int: n) =
     if( n == 1) 
       then
        1
       else
        n * factorial_1(n-1)
     endif
       ;


function var int : factorial_alirio (array [int] of  int: a) =
  if length (a) == 0 then
    1
  else
    length (a) * factorial_alirio (1 .. length (a) - 1)
  endif;
  


solve satisfy;

constraint
 z =    factorial_alirio(1..n);

output [
  "n: ", show(n),"\n",
  "z: ", show(z), "\n",
];
