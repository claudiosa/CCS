:- lib(ic).

ac(Vars) :-
    Vars = [X, Y],
    Vars #= 0..5,
    
    X % 2 #= 0,
    X + Y #= 4,
    
    labeling(Vars).
