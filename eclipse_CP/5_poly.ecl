:- lib(ic).
:- lib(branch_and_bound).

poly(Coef, Obj) :-
    Coef = [X, Y, Z],
    Coef #:: [0..1000],
    
    X*X*X + Y*Y - Z*Z*Z #= 0,
    Obj #= -(2*X*Y - Z),
    bb_min( labeling(Coef), Obj, bb_options{strategy:continue, from: (-500000), to: 0} ).
