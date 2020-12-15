

/* The Sucessor Axiom */
suc(n(0)).
suc(n(X)) :- suc(X).
/*
?- suc(X).
X = n(0) ;
X = n(n(0)) ;
X = n(n(n(0))) ;
X = n(n(n(n(0)))) ;
X = n(n(n(n(n(0))))) ;
X = n(n(n(n(n(n(0)))))) ;
X = n(n(n(n(n(n(n(0)))))))
?- suc(n(n(n(n(n(n(n(0)))))))).
true ;
false.

*/


suc2(n(-1), 0) :- !.
suc2(n(X), N ) :- suc2(X, N1),
                  N is (N1 + 1),
                  format("\n The  sequence ~w means the number: ~w",[X,N1]).

/*
?- suc2(n(n(n(n(n(n(n(-1))))))), N).
 The  sequence n(-1) means the number: 0
 The  sequence n(n(-1)) means the number: 1
 The  sequence n(n(n(-1))) means the number: 2
 The  sequence n(n(n(n(-1)))) means the number: 3
 The  sequence n(n(n(n(n(-1))))) means the number: 4
 The  sequence n(n(n(n(n(n(-1)))))) means the number: 5
N = 6.
*/


/*** For Planning extend this idea: */
/*

do(result(Action,S_new ), Situation_2):-
    do(S1, Situation_1),
    move(S1, Situation_1, result(Action, S_new) ).


*/


