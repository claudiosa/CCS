
x :-
    p(B),
    A = B,
    q(A), %%% se falhar ha backtracking
    
    Z = (A+B),
    writeln( the_SUM :Z :A :B).

y :-
    p(B),
    A is B,
    q(A), %%% idem aqui backtracking
    
    Z is (A+B),
    writeln( the_SUM :Z :A :B).


p(2).
%%% p(3). ===> se remover este ....  falso 
q(3).
    
