:- module(test_tcltk, [main/0], [assertions]).

:- use_module(library(format)).
:- use_module(canvas).

% :- test main.

main:-
    canvas:test,
    !.
