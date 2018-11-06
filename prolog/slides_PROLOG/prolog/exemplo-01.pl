dados(X,Y,Z) :-
	nome(X),
	idade(Y),
	altura(Z).

nome(marcia).
nome(antonio).
nome(fabricia).

idade(18).
idade(20).

altura(1.71).
altura(1.85).

pessoas :-
    dados(X,Y,Z),
    format('\n X: ~w  \t Y: ~d \t  Z: ~f ',[X,Y,Z]),
    fail.

pessoas:-
     format('\n Nao hah mais dados !!!!!\n', []).
/* ******************************************* */
