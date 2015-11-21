%-----------------------------------------------------------------------------
%  Puzzle from Khayri Ali, SICS
%
%  Using ECLiPSe finite domain variables.
%  Written by Andre Veron and Liang-liang Li, ECRC.
% 
%  The numbers 1 to 19 are going to be placed in the following Variables,
% 
%                 A,B,C
%                D,E,F,G
%               H,I,J,K,L,
%                M,N,O,P,
%                 Q,R,S
% 
%  so that the sums in all the diagonals are equal.
%  A+B+C = D+E+F+G = ... = Q+R+S = 38
%  A+D+H = B+E+I+M = ... = L+P+S = 38
%  C+G+L = B+F+K+P = ... = H+M+Q = 38
% 

include "alldifferent.mzn" ;

% Model
%% ONE ALTERNATIVE
%% array[0..19] of var 1..19: letters;    OR ... take from other MODEL from ECLIPSE

%% variables constraints ....
var 1 .. 19 : A; var 1 .. 19 : B; var 1 .. 19 : C;
var 1 .. 19 : D;  var 1 .. 19 : E;  var 1 .. 19 : F; var 1 .. 19 : G; 
var 1 .. 19 : H;  var 1 .. 19 : I; var 1 .. 19 : J;   var 1 .. 19 : K;    var 1 .. 19 : L;
var 1 .. 19 : M;  var 1 .. 19 : N;  var 1 .. 19 : O; var 1 .. 19 : P;
var 1 .. 19 : Q;  var 1 .. 19 : R;  var 1 .. 19 : S;

constraint
		alldifferent([ A,B,C,
		  D,E,F,G,
		 H,I,J,K,L,
		  M,N,O,P,
		   Q,R,S ]);

constraint
         A+B+C = 38  /\   A+D+H = 38   /\    H+M+Q = 38  /\
         D+E+F+G = 38  /\   B+E+I+M = 38  /\   D+I+N+R = 38  /\
         H+I+J+K+L = 38  /\ C+F+J+N+Q = 38  /\  A+E+J+O+S = 38 /\
         M+N+O+P = 38  /\    G+K+O+R = 38 /\   B+F+K+P = 38 /\
         Q+R+S = 38    /\  L+P+S = 38   /\      C+G+L = 38;

% symmetry breaking
constraint
% Forbid rotated solutions: require A to be the smallest corner
	A < C  /\  A < H  /\  A < L /\  A < S /\ A < Q 
	% Forbid solutions mirrored on the A-S diagonal
	/\ C < H;

solve satisfy;

output [    "      "  ,  show(A),"  ", show(B), "  " , show(C) ,   "\n",
		 "      "  ,  show(D),"  ", show(E), "  " , show(F) , "  " , show(G) ,   "\n" ,
		 "      "  ,  show(H),"  ", show(I), "  " , show(J) , "  " , show(K) , "  " ,  show(L)  ,  "\n" ,
		 "      "  ,  show(M),"  ", show(N), "  " , show(O) , "  " , show(P) ,   "\n" ,
		 "      "  ,  show(Q),"  ", show(R),  "  " ,  show(S),    "\n" 
            ];

/*
ccs@gerzat:~/Dropbox/pesquisa/curso_ALL/pgms_slides$ minizinc hexagono_38.mzn 
      15  14  9
      13  8  6  11
      10  4  5  1  18
      12  2  7  17
      16  19  3
----------

with breakings of simmetries ....
ccs@gerzat:~/Dropbox/pesquisa/curso_ALL/pgms_slides$ minizinc hexagono_38.mzn 
      3  19  16
      17  7  2  12
      18  1  5  4  10
      11  6  8  13
      9  14  15
----------


*/
