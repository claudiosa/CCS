%%%$ clingo 06_lesson.lp
%% try something ...

p(X) :- X=1 .. 50, X\5 = 0. %% only multiples of 5
q(X):-  X=100 .. 120, not p(X).
r(X):-  X=1 .. 50, not p(X).

#show p/1.
#show q/1.
#show r/1.

Only multiples of 5 .... 1 up to 50
%%%%#show X : X=1..50, X\5 = 0.


%%% only the values ... in acchording P(X)
#show X :  X=1 .. 50, p(X).

