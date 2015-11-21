/*** Alirio + ccs *********/

int: n = 6;
var int: z;
array[0 .. n] of var int : array_fib; 

%%% FUNCAO ... 
function var int:  fibo(int: n) =
      if( n == 0) then
          0
       else
           (
            if( n == 1) then
              1
            else
              fibo(n-1) + fibo(n-2)
            endif         
            )
       endif
       ;

constraint
     forall(i in 0 .. n) 
      (
       array_fib [ i ] == fibo(i)
      ); 
        

solve satisfy;

/*
constraint
   z =    fibo(n);

output [
  "n: ", show(n),"\n",
  "z: ", show(z), "\n",
];
*/
output [ "Array de Fibs: "] ++ ["\n"]  ++
       [  show(i) ++ " seu FIB eh: " ++
          show( array_fib[i]  ) ++ "\n"
          | i in 0 .. n ];

