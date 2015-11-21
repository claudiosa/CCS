/*
    Enigma 994 by Colin Singleton (New Scientist 29/8/98)

	George is contemplating buying a farm which is a very strange
	shape, comprising a large triangular lake with a square field
	on each side.  The area of the lake is exactly seven acres,
	and the area of each field is an exact whole number of acres. 
	Given that information, what is the smallest possible total
	area of the three fields?

    ECLiPSe solution by Joachim Schimpf, IC-Parc
*/

:- lib(ic).				% Using interval solver


solve :-
	[A,B,C] :: 0.0..inf,		% The 3 sides of the lake
	triangle_area(A, B, C, 7),	% The lake area is 7

	[F,FA,FB,FC] :: 1..inf,		% The square areas are integral
	square_area(A, FA),
	square_area(B, FB),
	square_area(C, FC),
	F $= FA+FB+FC,

	FA $>= FB, FB $>= FC,		% Avoid symmetric solutions

	indomain(F),			% find solution
	locate([A,B,C], 0.01),

	printf("F=%mw (FA=%mw, FB=%mw, FC=%mw)%n%b", [F,FA,FB,FC]).


triangle_area(A, B, C, Area) :-
	S $>= 0,
	S $= (A+B+C)/2,
	Area $= sqrt(S*(S-A)*(S-B)*(S-C)).

square_area(A, Area) :-
	Area $= sqr(A).
