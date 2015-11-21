mapa1([ RS, SC, PR, SP, MS ]) :-
    Cores = [ 1, 2, 3, 4 ],
    member(RS, Cores),  % Gerar
    member(SC, Cores),
    member(PR, Cores),
    member(SP, Cores),
    member(MS, Cores),
    RS \== SC,   % Testar
    SC \== PR,
    PR \== SP,
    PR \== MS,
    SP \== MS.
