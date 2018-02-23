:- use_module(library(clpfd)).

percurso2([a,d,g],1).
percurso2([f,b,i],2).
percurso2([h,e,c],3).
percurso2([b,e,c],4).
percurso2([a,f,h],5).
percurso2([d,b,e],6).
percurso2([g,i,c],7).
percurso2([d,g,f],8).
percurso2([a,b,c],9).
percurso2([i,b,h],10).

encomenda2(Val, [A,B,C]) :-
	Variaveis = [A,B,C],
	Variaveis ins 1 .. 10, 
	all_different(Variaveis),
	tuples_in([[A, T1]],[[1, 6],[2,4],[3,7],[4,5],[5,4],[6,6],[7,5],[8,3],[9,7],[10,6]]), 
	tuples_in([[B, T2]],[[1, 6],[2,4],[3,7],[4,5],[5,4],[6,6],[7,5],[8,3],[9,7],[10,6]]), 
	tuples_in([[C, T3]],[[1, 6],[2,4],[3,7],[4,5],[5,4],[6,6],[7,5],[8,3],[9,7],[10,6]]), 
	percurso2(X,A),
	percurso2(Y,B),
	A #< B,
	teste(X,Y),
	conc(X,Y,K),
	percurso2(Z,C),
	B #< C,
	teste(Z,K),
	labeling([min(T1 + T2 + T3)],  [A,B,C]),
	Val #= T1 + T2 + T3. 
	

teste([],_).
teste([X|Z],Y) :-
	not(member(X,Y)),
	teste(Z,Y).

conc([],L,L):-!.
conc([X|L1],L2,[X|L3]) :-
	conc(L1,L2,L3).