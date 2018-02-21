:- lib(ic).
:- lib(ic_edge_finder3).
:- lib(branch_and_bound).

cumu(Start) :-
    Start = [A,B,C,D,E,F],
    Start #:: 0..20,
    Dur   = [3,4,2,3,2,3],
    Usage = [2,2,2,1,2,1],
    Limit = 4,
    
    % precedencias
    A #< C,
    C #< E,
    B #< F,
    B #< D,
    
    % sobreposicoes limitadas
    cumulative(Start, Dur, Usage, Limit),
    
    % minimizar a soma dos tempos
    Cost #= sum(Start),               
    minimize(labeling(Start), Cost).
