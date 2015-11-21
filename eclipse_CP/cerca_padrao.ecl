cor(lilaz).
cor(vermelho).
cor(azul).

p :- padrao(X,Y,Z), writef(" - %w,%w,%w\n", [X,Y,Z]), fail.
p.

padrao(X,Y,Z):-cor(X),cor(Y),cor(Z),\==(X,Y),\==(X,Z),\==(Y,Z).
