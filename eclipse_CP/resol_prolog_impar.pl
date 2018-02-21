
/*  QX (impar(X) -> impar(s(s(X))) */
impar(s(0)).
impar(s(s(X))) :- impar(X).



/* 
LPO
I) QXY ( bebe(Y) ^ genitor(X,Y) -> orgulhoso(X) )
II) QXY ( pai(X,Y) -> genitor(X,Y) )
III) QXY ( mae(X,Y) -> genitor(X,Y) )
IV) pai(adam,maria)
V) bebe(maria)
*/
 
/*orgulhoso(X) :- bebe(Y) , genitor(X,Y).*/
orgulhoso(X) :-  genitor(X,Y), bebe(Y) .
genitor(X,Y) :- pai(X,Y).
genitor(X,Y) :- mae(X,Y).
pai(adam,maria).
bebe(maria).
