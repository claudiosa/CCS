
/*

>From New Scientist, 17 October 1998, No 2156, p51

---------------------------------------------------
Enigma 1001: What the hex? - by Susan Denham
---------------------------------------------------

IN THIS hexagon of circles I've written some digits:

           1   8   7

         0           1

       9               4

         9           2

           7   2   5   

Reading the six sides, clockwise, as three-figure numbers you get 187,
714, 425, 527, 799, and 901, all of which are multiples of 17. Your
task today is to write a new collection of non-zero digits in the
circles, with no two adjacent digits the same, so that the six
three-figure numbers are all different multiples of some particular
two-figure number, the number in the top row being twice that
two-figure number.

Please send in your hexagon.

*/

% File:         enigma1001.pl
% Author(s):    Vassilis Liatsos <vl@icparc.ic.ac.uk>
%
% Description:  Solution for "Enigma 1001: What the hex?" 
%               in the ECLiPSe constraint programming language
%               Enigma 1001 appeared in:
%               "New Scientist, 17 October 1998, No 2156, p51"
%               See description above
%
% Use:          start eclipse:  eclipse
%               load file by:   [enigma1001].
%               get solution:   solve(Enigma).
%
% Date:         15 October 1998
% Copyright     IC-Parc, Imperial College, UK



:- lib(ic).

solve(List):-
	List=[X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12],
	List::1..9,
	Divisor :: 10..99,
	Multipliers = [M1,M2,M3,M4,M5,M6],
	Multipliers::1..99,
	Number1 #= 100*X1+10*X2+X3,
	Number2 #= 100*X3+10*X4+X5,
	Number3 #= 100*X5+10*X6+X7,
	Number4 #= 100*X7+10*X8+X9,
	Number5 #= 100*X9+10*X10+X11,
	Number6 #= 100*X11+10*X12+X1,
	% Multipler of number in top row is 2 
	M1 = 2,
	Number1 #= M1*Divisor,
	Number2 #= M2*Divisor,
	Number3 #= M3*Divisor,
	Number4 #= M4*Divisor,
	Number5 #= M5*Divisor,
	Number6 #= M6*Divisor,
	alldifferent(Multipliers),
	X1 #\= X2,
	X2 #\= X3,
	X3 #\= X4,
	X4 #\= X5,
	X5 #\= X6,
	X6 #\= X7,
	X7 #\= X8,
	X8 #\= X9,
	X9 #\= X10,
	X10 #\= X11,
	X11 #\= X12,
	X12 #\= X1,
	labeling(List),	labeling(Multipliers),
	write("Hexagon numbers are: "),
	write(Number1),write(', '),
	write(Number2),write(', '),
	write(Number3),write(', '),
	write(Number4),write(', '),
	write(Number5),write(', '),
	writeln(Number6),
	pretty_print(List).

pretty_print([X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12]):-
	printf("     %w   %w   %w\n\n",[X1,X2,X3]),
        printf("   %w            %w\n\n",[X12,X4]),
        printf(" %w                %w\n\n",[X11,X5]),
        printf("   %w            %w\n\n",[X10,X6]),
        printf("     %w   %w   %w\n\n",[X9,X8,X7]).

