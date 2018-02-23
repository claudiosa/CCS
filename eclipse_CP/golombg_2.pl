:- use_module(library(bounds)).
golomb2(N,Lista):-
	statistics(cputime,Time1),
	length(Lista,N),
	gera(N,B),
	Lista in 0..B,
	all_different(Lista),	
	restricao(Lista),
	restricao2(Lista,Lista2,Lista3),
	ultimo(Ul,Lista3),
	restricao3(Lista3,Ul),
	all_different(Lista3),
	label(Lista), 
	statistics(cputime,Time2),
	Time is Time2 - Time1, nl, 
	write('Tempo:===> '),
	write(Time).

restricao([H | Nlista])  :-
	menor(H, Nlista).

menor(_, []).
menor(H, [Y | Nlista]) :- 
	H #< Y,
	menor(Y, Nlista).

restricao2([],Lista3,Lista3).
restricao2([H|Nlista],Lista2, Lista3) :-	
	dif2(H,Nlista,P1,P2),
	conc(P2,Lista2,NovaL),
	restricao2(Nlista,NovaL, Lista3).

dif2(_,[],P2,P2).
dif2(H, [Y|Nlist], P1,P2) :-
	K #= abs(H-Y),	
	dif2(H, Nlist, [K|P1], P2).

restricao3([H|Nlista3],Ul) :-
	H #< Ul.

add(A,B,[A|B]).

ultimo(X,[X]).
ultimo(X,[_|R]):- ultimo(X, R).

conc([],L,L).
conc([X|L1],L2,[X|L3]) :- conc(L1,L2,L3).

gera(0, 0).
gera(1, 1).
gera(2, 1).
gera(3, 3).
gera(4, 6).
gera(5, 11).
gera(6, 17).
gera(7, 25).

