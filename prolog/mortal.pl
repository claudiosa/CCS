%:-op(1150, xfy, <-).

:- op(1150, xfx, '<-').
:- op(255, fx, ':-').

homem( platao )  .
homem( socrates )  .
mulher(maria).
w <- morre( X,Y ) , write(X), nl, write(Y).
morre( X,Y )  <- homem( X ) , mulher(Y) .
