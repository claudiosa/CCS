% Autor:
% Data: 9/4/2008
/*:- use_module('c:/temp/bounds.pl').*/
%%:- use_module(library(clpfd)). 
:- use_module(library(bounds)). 

fac(0,1).
fac(N,N*F) :- N #>= 1, fac(N-1, F).
/*   s(1,1) :- true.
  s(N, S) :-
      N > 1,
     Aux is (N-1),
    s(Aux, Parcial),
    S is (N + Parcial).
  */

s(1,1).                         /* regra #1 */
s(N, S) :-
     N #>= 1,                        /* regra #2 */
     N #=< S,
     s(N-1, S-N).
    /*,
    S is (N + Parcial).
      */
