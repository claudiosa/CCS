

/*  FILHO , PAI    */
pai( joao, pedro).
pai( jose, pedro).
pai( pedro, antonio).
pai( firmino, antonio).
pai( antonio, petrucio).

l_a :- pai(X,Y), write(X), write(' .... ' ), write(Y), nl, fail.
l_a.

/*
?- pai(X,Y), write(X), write(' .... ' ), write(Y), nl, fail.
joao .... pedro
jose .... pedro
pedro .... antonio
firmino .... antonio
antonio .... petrucio
false.

?- 
*/
anc(X,Y) :- pai(X,Y).
anc(X,Y) :- pai(X,Z), anc(Z,Y).

im(claudio, diego).
im(diego, cleiton).
im(cleiton, julio).
im(julio, tatiana).

suc(X,Y) :- im(X,Y).
suc(X,Y) :- im(X,Z), suc(Z,Y).



