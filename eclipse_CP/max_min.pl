
%%:- use_module(library(bounds)).  
%%:- use_module(library(clp_distinct)).
:- use_module(library(clpfd)). 
%%%:- use_module(library(simplex)).

teste_1([X,Y,Z]):-
	X in 1 .. 8,
	Z in 1 .. 20,
	Y in 1 .. 10,
    X #=< 3, Y #=< 2, X #> 0, Y #> 0, X + Y #< 6, Z #= X + Y.

saida:- teste_1([Z,X,Y]), 
        labeling( [ max(X+Y+Z) ], [Z,X,Y] ), 
        format('\n X: ~d Y: ~d Z: ~d', [X,Y,Z]).

teste_2([X,Y,Z]):-
	X in 1 .. 8,
	Z in 1 .. 20,
	Y in 1 .. 10,
        X #=< 3, Y #=< 2, X #> 0, Y #> 0, X + Y #< 6, Z #= X + Y,
/*	maximize(labeling([ff],[X,Y,Z]), write([X,Y,Z]), Z  ).*/
	minimize([X,Y,Z]).
/*
maximize(+Expression)
    Maximizes  Expression within the current constraint store.   This is
    the  same as computing the  supremum and equating the expression  to
    that supremum.

maximize(+Objective, +S0, -S)
    Maximizes   the   objective   function,   stated   as  a   list   of
    "Coefficient*Variable"   terms  that  represents  the  sum   of  its
    elements, with respect  to the linear program corresponding to state
    S0.   S  is unified  with an internal  representation of the  solved
    instance.


*/
