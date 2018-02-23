:- lib(ic).

sendmore(Digits) :-
    Digits = [S,E,N,D,M,O,R,Y],
    Digits #:: [0..9],
    
    Carries = [C1,C2,C3,C4],
    Carries #:: [0..1],
    alldifferent(Digits),
    
    S #\= 0, M #\= 0,
    
            C1 #= M,
    C2 + S + M #= O + 10*C1,
    C3 + E + O #= N + 10*C2,
    C4 + N + R #= E + 10*C3,
         D + E #= Y + 10*C4,

    labeling(Carries),
    labeling(Digits).
