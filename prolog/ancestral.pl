

pai(hommer, bart).
pai(hommer, lisa).
pai(abe, hommer).
pai(abe, gertrude).
pai(matusalem, abe).

/* pai do pai */
avo(X,Y) :- pai(X,Z), pai(Z,Y). 

/* GENERALIZACAO de ANCESTRAL */
ancestral(X,Y) :- pai(X,Y).
ancestral(X,Y) :- pai(X,Z) , ancestral(Z,Y).
/** REUSANDO o codigo **/
descendente(X,Y) :- ancestral(Y,X).

listar_todos :-
   ancestral(X,Y), 
   write(X),  write('  -->   '), write(Y),
    nl, 
    fail.

listar_todos :- true.
 
