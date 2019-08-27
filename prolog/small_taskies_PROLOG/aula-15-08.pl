
r(a).
r(b).
r(c).
s(1).
s(2).
t(d).
t(e).

p(X,Y,Z) :- r(X), s(Y), t(Z).

x :- p(X,Y,Z), format(' X: ~w \t Y: ~w \t Z: ~w ', [X,Y,Z]), nl.
