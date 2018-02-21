%
%  Puzzle from Khayri Ali, SICS
%
%  Using ECLiPSe finite domain variables.
%  Written by Andre Veron and Liang-liang Li, ECRC.
% 
%  The numbers 1 to 19 are going to be placed in the following pattern,
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

:- lib(ic).

go :-
	cputime(T0),
        ( puzzle(Solution), writeln(Solution), fail ; true ),
     cputime(T1),   
     T is (T1 - T0),
	%%T is cputime - T0,
        writeln([T, 'seconds']).

puzzle(Pattern) :-
        Pattern = [
		   A,B,C,
		  D,E,F,G,
		 H,I,J,K,L,
		  M,N,O,P,
		   Q,R,S
		  ],
	Pattern :: 1 .. 19,

	% Problem constraints
	alldifferent(Pattern),
          A+B+C #= 38,     A+D+H #= 38,     H+M+Q #= 38,
         D+E+F+G #= 38,   B+E+I+M #= 38,   D+I+N+R #= 38,
        H+I+J+K+L #= 38, C+F+J+N+Q #= 38, A+E+J+O+S #= 38,
         M+N+O+P #= 38,   G+K+O+R #= 38,   B+F+K+P #= 38,
          Q+R+S #= 38,     L+P+S #= 38,     C+G+L #= 38,

	% Optional anti-symmetry constraints
	% Forbid rotated solutions: require A to be the smallest corner
	A #< C, A #< H, A #< L, A #< S, A #< Q,
	% Forbid solutions mirrored on the A-S diagonal
	C #< H,

%	Choice=input_order,		% slowest
	Choice=first_fail,		% fastest
%	Choice=most_constrained,	% medium
	search(Pattern, 0, Choice, indomain, complete, []).

