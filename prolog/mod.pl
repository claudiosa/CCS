
mult(X,Y):- Z is mod(X,Y), Z == 0, write('sim'), !.
mult(_,_):- write('nao').
