:-lib(ic).
:-lib(branch_and_bound).

most(Vals, Money) :-
    Vals = [S,E,N,D,M,O,T,Y],
    Vals :: 0..9,
    
    alldifferent(Vals),
    M #\= 0,
    S #\= 0,
    
    Send  #= 1000 * S + 100 * E + 10 * N + D,
    Most  #= 1000 * M + 100 * O + 10 * S + T,
    Money #= Send + Most,
    Money #= 10000 * M + 1000 * O + 100 * N + 10 * E + Y,
    
    Cost  #= -Money,
    bb_min( labeling(Vals), Cost, bb_options{} ).
