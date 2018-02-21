%%% EDITOR DE PROGRAMA

	pai(adao, abel)   .
%%%	----- pai (adao....
	pai(adao, caim)   .
	pai(caim, sebastiao)   .
	pai(caim, maria )   .
	pai(a, b).
	pai(a, c).
	pai(d, e).
	pai(e, f).
	pai(f, g).
<<<<<<< HEAD:pais02.pl
	pai(joao). %%% este fato eh diferente dos demais
=======
	pai(joao).
>>>>>>> af0b73fb800ab6386aa580200fbc475d25d88eb4:2610_15.txt
	
%%% REGRA
    irmao(X,Z) :- pai(Y,X), pai(Y,Z) , \==( X, Z).	
	
/*
           Adao, tu es pai de alguem X?	
	   ou Quem sao os filhos de Adao?
	?- pai(adao, X).

        pai( X, abel).
	Quem é o pai de Abel?
	?- pai(X, maria), pai(Y,X), pai(Y,Z) , Z \== X.
	pai(Y,X), pai(Y,Z) , \==( X, Z).
	


*/
%%	%%% YOUR FAMILY is HERE


x :- pai(X,Y),
     nl,
     write(X),
     write('     '),
     write(Y),
     fail.

x :- true.



%%	AVO
%%	BISAVO
%%	IRMAO
%%	ANCESTRAL  e TESTEM COM CUIDADO
%%	PARA IMPLEMENTAR
/*
FACAM
avo(X,Y) :-
tio(X,Y) :-
bisavo(X,Y) :-
irmao(X,Y) :-
ancestral(X,Y)  :-
*/
<<<<<<< HEAD:pais02.pl
=======

>>>>>>> af0b73fb800ab6386aa580200fbc475d25d88eb4:2610_15.txt
