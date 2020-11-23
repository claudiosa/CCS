p(1).
p(2).

t:- p(1) ; p(2).

%%% the constraint
:- not p(2).
