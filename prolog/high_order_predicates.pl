
/* High order predicates */
plus(X,Y,Z) :- Z is X+Y.  %%% Consider it for the examples below

%%% applying summ between two lists
map1(_, [], [], []) :- !.
map1(_, [], _, []) :- !.
map1(_, _, [], []) :- !.
map1(Pred_3, [B|Bs], [A|As], [C|Cs]) :-
        call(Pred_3, A, B, C),
        map1(Pred_3, As, Bs, Cs).
/*
?- map1(plus,[22,33,44], [1,2,3], L).
L = [23, 35, 47].
*/



%%% applying sum between an X value and a  lists
map2(_, _, [], []) :- !.
map2(Pred_3, X, [A|As], [C|Cs]) :-
        call(Pred_3, X, A, C),
        map2(Pred_3, X, As, Cs).
/*
?- map2(plus,3,[1,2,3], L).
L = [4, 5, 6].

*/

%%% to use something like: %%map3(plus(3,Y,Z),[1,2,3], L)
map3(_, [], []) :- !.
map3(Term_F, [A|L_A], [C|L_C]) :-
        functor(Term_F, Name, Arity), %%% SEE THE MANUAL
        arg(1, Term_F, X),            %%% SEE THE MANUAL
        call(Name , X, A, C),         %%% SEE THE MANUAL
        map3(Term_F, L_A, L_C).

/*
?- map3(plus(3,Y,Z),[1,2,3], L).
L = [4, 5, 6].

?- 
*/
