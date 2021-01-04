p(3..7).
q(5..9).
s(X) :- X = 1..10, p(X), not q(X).

#show s/1.
%#show p/1.
%#show q/1.
