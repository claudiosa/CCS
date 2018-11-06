


homen(adao).

%%% unico_erro (oi).
/*
?- X is (7 + 7), write(X).
14
X = 14.

?- write(X), nl, X is (7 + 7), write(X).
_G558
14
X = 14.

?- write(X), nl,  (7 + 7) is X , write(X).
_G558
ERROR: is/2: Arguments are not sufficiently instantiated
?- write(X), nl,  is(X, (7 + 7)) , write(X).
_G203
14
X = 14


?- a(a(4,7)) = a(X).
X = a(4, 7).

?- a(a(4,7)) == a(X).
false.

?- help(=).
true.


*/

%%% arvore geneologica

pai(cc, ac).
pai(jc, ac).
pai(ac, joao).

%%%%% filho(ac,cc).
filho(X,Y) :- pai(Y, X).

irmao(X,Y) :- pai(X,Z), pai(Y,Z),
				X \== Y.
				
				
avo(X, Y) :- pai(Z , X), pai(Y,Z).				


word(abalone,a,b,a,l,o,n,e).
word(abandon,a,b,a,n,d,o,n).
word(enhance,e,n,h,a,n,c,e).
word(anagram,a,n,a,g,r,a,m).
word(connect,c,o,n,n,e,c,t).
word(elegant,e,l,e,g,a,n,t).


/*
crowss6(P_V1, P_V2, P_V3, P_H1, P_H2, P_H3 ) :-
        word(P_V1,_,V12,_,V14, _, V16,_),
        word(P_V2,_,V22,_,V24, _, V26,_),
        word(P_V3,_,V32,_,V34, _, V36,_),
        word(P_H1,_,H12,_,H14, _, H16,_),
        word(P_V2,_,H22,_,H24, _, H26,_),
        word(P_V3,_,H32,_,H34, _, H36,_),
        H12 == V12,
        .....
        H36 == V36.

*/
        






