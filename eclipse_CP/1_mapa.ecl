:- lib(ic).

mapa(UFs) :-
    UFs = [ RS, SC, PR, SP, MS ],
    UFs #:: 1..4,

    RS #\= SC,
    SC #\= PR,
    PR #\= SP,
    PR #\= MS,
    SP #\= MS,
    writeln([ RS, SC, PR, SP, MS]), 
    labeling(UFs).

%% INEFICIENTE: contrario a tudo da PR
i(X):-  map_nativo(X), writeln(X).

map_nativo([ RS, SC, PR, SP, MS ]) :-
    member(RS, [1,2,3,4]), 
    member(SC, [1,2,3,4]),
    member(PR, [1,2,3,4]),
    member(SP, [1,2,3,4]),
    member(MS, [1,2,3,4]),
    %% avalie os backtracking aqui
    writeln([ RS, SC, PR, SP, MS]), 
    RS \== SC,
    SC \== PR,
    PR \== SP,
    PR \== MS,
    SP \== MS.
    
