%%%%%%% ilustra functores
carros :-
	pertence(X,Y,Z),
	format('\n X: ~w  \t Y: ~w \t  Z: ~w ', [X,Y,Z]),
	fail.
carros :- format('\n Nao hah mais dados !!!!!\n', []).

pertence( fred, carro( fabricante(toyota , japao)), ano_cor(2014,azul)).
pertence( romi, carro( fabricante(bmw , alemanha)), ano_cor(2015,vermelho)).
pertence( claudio, carro( fabricante(vw , brasil)), ano_cor(2012,prata)).

/*
?-  pertence(X,Y,ano_cor(A,C)) , A > 2014.

X = romi,
Y = carro(fabricante(bmw, alemanha)),
A = 2015,
C = vermelho .


?- pertence(X,Y,ano_cor(A,C)) , A =< 2014.
X = fred,
Y = carro(fabricante(toyota, japao)),
A = 2014,
C = azul ;

X = claudio,
Y = carro(fabricante(vw, brasil)),
A = 2012,
C = prata.

?-
*/
