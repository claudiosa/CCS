% $ clingo 01_exercise.lp 0


s(b).
% s(d). %% TEST
- s(c). %%% c is not s
r(a).

p(a) | p(b) .
q(X) :- p(X), r(X), not s(X).

% k(1..10). %% TEST
#show s/1 .
#show r/1.
#show p/1.

