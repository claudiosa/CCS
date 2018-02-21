:- lib(ic). 

dois(Letras) :-
    /* VARIAVEIS E DOMINIOS */
    Letras   = [D, O, I, S, T, R, E, C, N] ,
    Carry    = [C1, C2, C3],
    Letras #:: [0 .. 9],
    Carry  #:: [0 .. 1],
    
    /* POSTANDO AS RESTRICOES */
    alldifferent([D, O, I, S, T, R, E, C, N]),
                    
                    C #= 1,
    D + T + C3  #=  I + 10*C,
    O + R + C2  #=  N + 10*C3,
    I + E + C1  #=  C + 10*C2,
    S + S       #=  O + 10*C1,
    
    /* PROPAGACAO E RAMIFICACAO */    
    labeling([C1, C2, C3, D, O, I, S, T, R, E, C, N]).
    
