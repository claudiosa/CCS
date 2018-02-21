/*
?- 4 > 5 -> write('xxxx'); write('yyy').
yyy
true.

?- 6 > 5 -> write('xxxx'); write('yyy').
xxxx
true
*/
/*
bad_soma(X,S) :-
         ((X > 0) ->  X1 is X -1, bad_soma(X1, S1), S is S1 + X;
         0).
*/


maior(X,Y) :- (X > Y -> write(X) ; write(Y)).

certo(X,Y) :- X > Y , write(X),!.
certo(_,Y) :- write(Y).
