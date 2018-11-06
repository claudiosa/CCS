r(a). 
r(b). 
r(c). 
s(1).
s(2).
t(d).
t(e).
p(X,Y,Z) :- r(X), s(Y), t(Z).
saida :- p(X, Y, Z), 
         format('X: ~w \t Y: ~w \t Z: ~w', [X, Y, Z]) .
/*
?- saida.
X: a 	 Y: 1 	 Z: d
true ;
X: a 	 Y: 1 	 Z: e
......................
X: c 	 Y: 2 	 Z: d
true ;
X: c 	 Y: 2 	 Z: e
true.
*/
