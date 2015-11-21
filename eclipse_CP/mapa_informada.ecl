mapa2([ RS, SC, PR, SP, MS ]) :-
    member(RS, [ 1, 2, 3, 4 ]),
    member(SC, [ 2, 3, 4, 1 ]),
    member(PR, [ 3, 4, 1, 2 ]),
    member(SP, [ 4, 1, 2, 3 ]),
    member(MS, [ 1, 2, 3, 4 ]),
    RS \= SC,
    SC \= PR,
    PR \= SP,
    PR \= MS,
    SP \= MS.
