:- lib(ic).
:- lib(ic_edge_finder3).
:- lib(branch_and_bound).

dis(Start) :-
    Start = [A,B,C],
    Start #:: 0..10,
    Dur   = [4,4,2],
    
    % precedencias
    A #< B,
    B #< C,              
    
    % sem sobreposicao
    disjunctive(Start, Dur),
    
    % minimizar a soma dos tempos
    Cost #= sum(Start),              
    minimize(labeling(Start), Cost).
