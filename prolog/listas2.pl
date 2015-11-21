
uniao([],X,X).
uniao([X|L1],L2,[X|L3]) :- uniao( L1, L2, L3).



/*  JORGE.PL
    Shelved on the 21st of December 1987
*/


/*
List processing predicates Contributed by
J.G. Forero @ Reading University Computer Science Dept.

*/


/*  marka( In, Elem, X, Out) iff input list In will change to output list Out
    marked with an X after Elem.
    Fails if In does not contain Elem.
*/
marka( [Elem|T], Elem, X, [Elem,X|T] ).

marka( [H|T], Elem, X, [H|T1] ) :-
    marka( T, Elem, X, T1 ).


/*  normal( In, Out) iff Out is the flattened version of In: i.e.
    [ [a], [b,c], [[d],e] ] => [a,b,c,d,e] .
    In must be instantiated.
*/
normal( In, Out ) :-
    normal( In, [], Out ).


normal( [], L, L ).

normal( A, L, [A|L] ) :-
    var( A ), !.

normal( A, L, [A|L] ) :-
   not( islist(A) ), !.

normal( [H|T], Sofar, Result ) :-
    normal( T, Sofar, Sofar1 ),
    normal( H, Sofar1, Result ), !.


/*  doubl( In, Out) iff Out is the same as In after replacing two adjacent
    occurrences
    of any element by one occurrence of that element.
*/
doubl( [], []).

doubl( [ Elem, Elem| X], [ Elem| Y]) :-
   doubl( X, Y).

doubl( [ X| R1], [ X| R2]) :-
   doubl( R1, R2).


/*  Aux. predicates taken from NBS/ICST Prolog Utility Library vers 11.25.86
    member_rest( Elem, List, Rest) iff Elem is a member
    of List and Rest is the rest of the list following Elem.
*/
member_rest( Elem, [ Elem| Rest], Rest).

member_rest( Elem, [ _| Rest], Rest_rest) :-
   member_rest( Elem, Rest, Rest_rest).


/*  sublist(List, Start, End, Sublist) iff Sublist is a contiguous
    sub-list within List, starting at position Start, and ending at
    position End.
    [] is a valid sublist of any list.
    At least one of List and Sublist must be instantiated.          
*/
sublist(List, 1, End, Sublist) :-
  prefix(Sublist, List),
  length(Sublist, End).

sublist([Elem | Rest], Start, End, Sublist) :-
  sublist(Rest, Startx, Endx, Sublist),
  Start is Startx + 1,
  End is Endx + 1.


/*  prefix( Part, Whole ) iff Part is a leading sub-list of Whole.
    If Part is uninstantiated and Whole instantiated, 'prefix' generates
    a new prefix into Part on each resatisfaction, starting with [].
    At least one of Part and Whole must be instantiated.
*/
prefix([], _).

prefix([Elem|Reso],[Elem|Resto]) :-
   prefix(Reso,Resto).


/*  position(List, Elem, Number) iff Elem is in position Number
    in the List.  List must be instantiated, as must at least one of
    Elem and Number.
*/
position([ Elem | Rest ], Elem, 1 ).

position([ _ | Rest ], Elem, Number ) :-
    var(Number),
    !,
    position(Rest, Elem, N_minus),
    Number is N_minus + 1.

position([ _ | Rest ], Elem, Number ) :-
    N_minus is Number - 1,
    position(Rest, Elem, N_minus).


/*  islist(List) iff List is a List. (Really just checks for [] and
    that the main functor is '.')
*/
islist( [] ) :- !.
islist( [_|_] ).
