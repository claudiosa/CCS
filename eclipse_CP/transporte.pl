 /* Exercicio dos transportes */

/*percurso(valor,rota,ordem)*/
/*:- use_module(library(bounds)).*/
:- use_module(library(clpfd)).
/*:- use_module(library(clpq)).*/



percurso(6,[a,d,g],1).
percurso(4,[f,b,i],2).
percurso(7,[h,e,c],3).
percurso(5,[b,e,c],4).
percurso(4,[a,f,h],5).
percurso(6,[d,b,e],6).
percurso(5,[g,i,c],7).
percurso(3,[d,g,f],8).
percurso(7,[a,b,c],9).
percurso(6,[i,b,h],10).

encomenda(Val,Per) :- 
	statistics(cputime,Time1),
	pegaper(Val,Per,Time1).

pegaper(Val,Per,Time1) :-
	percurso(V1,X,Pa),
	percurso(V2,Y,Pb),
	teste(X,Y),
	Pa#<Pb,
	conc(X,Y,K),
	percurso(V3,Z,Pc),
	teste(Z,K),
	Pb#<Pc,
	conc(K,Z,Per),
	Val is V1+V2+V3,
	/*minimize(Val),*/
	statistics(cputime,Time2),
	Time is Time2 - Time1, nl, 
	write('Tempo:===> '),
	write(Time).
	

teste([],_).
teste([X|Z],Y) :-
	not(member(X,Y)),
	teste(Z,Y).

conc([],L,L):-!.
conc([X|L1],L2,[X|L3]) :-
	conc(L1,L2,L3).
