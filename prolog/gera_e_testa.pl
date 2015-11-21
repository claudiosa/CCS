%  =================================================================
%  ==                                                             ==
%  ==          An Introduction to ARTIFICIAL INTELLIGENCE         ==
%  ==                  Janet Finlay and Alan Dix                  ==
%  ==                       UCL Press, 1996                       ==
%  ==                                                             ==
%  =================================================================
%  ==                                                             ==
%  ==          chapter 3, pages 49-50:  generate and test         ==
%  ==                                                             ==
%  ==            Prolog example, Alan Dix, August 1996            ==
%  ==                                                             ==
%  =================================================================


%  This is a generate and test solution of the magic square puzzle.
%  By its nature it can take a VERY long time to run, so it gives
%  you a running commentry of its progress!

%  First problem - how to represent the square.
%  I have used a simple list of numbers, taken to read from the
%  top left corner, back and forth across the square.
%  That is, the list [1,5,9,8,3,4,7,8,9]
%  represents the square:
%                  +---+---+---+
%                  | 1 | 5 | 9 |
%                  +---+---+---+
%                  | 8 | 3 | 4 |
%                  +---+---+---+
%                  | 6 | 7 | 2 |
%                  +---+---+---+

%  The form of such a prohram in Prolog is REALLY simple
%  as Prolog¹s backtracking does all the work:

gen_test(Magic,Sum) :-
        generate_magic(Magic),
        write('trying '), write(Magic), nl,
        test_magic(Magic,Sum),
        write('YES!'), nl.

%  The generate predicate simply chooses the numbers in
%  each square from the remaining list of digits.

generate_magic([N11,N12,N13,N21,N22,N23,N31,N32,N33]) :-
        choose_list(N11,[1,2,3,4,5,6,7,8,9],Rest11),
        choose_list(N12,Rest11,Rest12),
        choose_list(N13,Rest12,Rest13),
        choose_list(N21,Rest13,Rest21),
        choose_list(N22,Rest21,Rest22),
        choose_list(N23,Rest22,Rest23),
        choose_list(N31,Rest23,Rest31),
        choose_list(N32,Rest31,Rest32),
        choose_list(N33,Rest32,[]).

%  The choose_list predicate chooses one number from a list and
%  its third argument is the remaining numbers of the list.

choose_list(N,[N|Rest],Rest).
choose_list(N,[M|Rest],[M|R2]) :- choose_list(N,Rest,R2).

%  The test predicate, works out the row, column and diagonal
%  sums which must all be identical.

test_magic([N11,N12,N13,N21,N22,N23,N31,N32,N33],Sum) :-
        Sum is N11+N12+N13,  % rows
        Sum is N21+N22+N23,
        Sum is N31+N32+N33,
        Sum is N11+N21+N31,  % columns
        Sum is N12+N22+N32,
        Sum is N13+N23+N33,
        Sum is N11+N22+N33,  % diagonals
        Sum is N13+N22+N31.

%  RUNNING THIS CODE
%
%  simply type:  gen_test(Magic,Sum).
%  and wait ...
%


