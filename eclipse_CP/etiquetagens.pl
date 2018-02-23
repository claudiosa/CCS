
etiqueta_1([], _) :- !.
etiqueta_1( [X|R], L):-
       member(X,L),
       etiqueta_1( R , L).       
       
/*       
?- etiqueta_1([A,B],[77,88,99]).
A = 77,
B = 77 ;
A = 77,
B = 88 ;
A = 77,
B = 99 ;
.....
?- etiqueta_1([A,B],[77]).
A = 77,
B = 77 ;
fail.

?- etiqueta_1([A,B],[]).
fail.

?- etiqueta_1([],[]).
true.

*/

todos_dif([], _) :- !.
todos_dif( [X|R], L):-
       member(X,L),
       remove(X,L,L1),
       todos_dif( R , L1). 
       
remove(X,L,L1) :- delete(L,X,L1).             

/*
?- todos_dif([A,B,C],[77,88,99,66,44]).
A = 77,
B = 88,
C = 99 ;
A = 77,
B = 88,
C = 66 ;
A = 77,
B = 88,
C = 44 ;
....................
bem como:
?- todos_dif([A,B,C],[77,88]).
fail.
*/
