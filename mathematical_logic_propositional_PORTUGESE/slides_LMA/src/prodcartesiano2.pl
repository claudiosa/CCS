a(1).
a(2).
a(3).
b(1).
b(3).
b(5).
c(X,Y) :- a(Y),b(X).
predicado(X,Y) :- a(X),b(Y),c(X,Y).
