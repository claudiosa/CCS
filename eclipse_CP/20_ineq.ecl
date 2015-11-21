:- lib(ic).
:- lib(branch_and_bound).

ineq(Coef) :-
    Coef = [X, Y],
    Coef :: -10.0..10.0,
    X + Y $= 8,
    X^2 $> 9,
    squash(Coef, 1e-6, lin).
