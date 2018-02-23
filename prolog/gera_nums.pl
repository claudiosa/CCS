num(0).
num(1).
num(2).
num(3).
num(4).
num(5).


combinar(N1,N2,N3,N4)  :-
   num(N1),
   num(N2),
   num(N3),
   num(N4),

/* as restricoes... */
    N1 \== N2,
    N1 \== N3,
    N1 \== N4,
    N2 \== N1,
    N2 \== N3,
    N2 \== N4,
    N3 \== N1,
    N3 \== N2,
    N3 \== N4,
    N4 \== N1,
    N4 \== N2,
    N4 \== N3.

x1 :- combinar(N1,N2,N3,N4) , write(N1), write(' '),
    write(N2), write(' '),write(N3), write(' '),write(N4), 
    write(' '), nl, fail.
