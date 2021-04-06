:- module(canvas,[test/0,main/0]).

:- use_module(library(tcltk)). 
:- use_module(library(aggregates)).
:- use_module(library(system)).
:- use_module(library(lists), [append/3]).

% :- export(test_aux/1).

% Example to probe that the returning values to prolog is correct in the third argument of the predicate tcl_eval.

% TODO: This is a visual test (tcltk); add a non-visual test and
%   connect it with 'ciao test'.

main:- test.

test:-
    tcl_new(Interp),
    test_aux(Interp),
    tcl_delete(Interp),
    !.

test_aux(Interp):-
    tcl_eval(Interp,[canvas, '.c -height 300 -width 300 -background white'],_),
    tcl_eval(Interp,[pack, '.c'],_),
    tcl_eval(Interp,['.c', 'create oval 7 7 133 133 -outline black -fill gray80 -width 2'],_ID),
    tcl_eval(Interp,['.c', 'create oval 39 49 53 63 -outline black -fill black'],_ID1),
    tcl_eval(Interp,['.c', 'create oval 102 63 88 49 -outline black -fill black'],ID2),
    tcl_eval(Interp,['.c', 'create polygon 70 67 74 81 69 77 67 81  -fill black'],_ID3 ),
    tcl_eval(Interp,['.c', 'create arc 21 21 119 119 -start 225 -extent 95 -style arc -outline black -width 3'],_ID4),
    pause(2),
    move_it(5, Interp, ID2).

move_it(0, _, _).
move_it(N, Interp, Id):-
    N > 0,
    N1 is N - 1,
    tcl_eval(Interp,['.c','move', Id,10,10],_),
    pause(1),
    move_it(N1, Interp, Id).
