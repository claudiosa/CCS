genitor(pam,bob).
genitor(tom,bob).
genitor(tom,liz).
genitor(bob,ann).
genitor(bob,pat).
genitor(pat,jim).
mulher(pam).
mulher(liz).
mulher(pat).
mulher(ann).
homem(tom).
homem(bob).
homem(jim).

prole(Y,X) :- genitor(X,Y).
mae(X,Y) :- genitor(X,Y), mulher(X). 
avos(X,Z) :- genitor(X,Y), genitor(Y,Z). 
irma(X,Y) :- genitor(Z,X), genitor(Z,Y), mulher(X). 
descendente(X,Z) :- genitor(X, Z).

descendente(X,Z) :- genitor(X,Y), descendente(Y,Z)