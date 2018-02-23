:- use_module(library(clpfd)). 

balada([A,B,C,D]) :-
    Vars = [A,B,C,D],
	Vars ins 1 .. 711,
	A+B+C+D #= 711,
	A*B #= T1,
    C*D #= T2,
    T1*T2 #= 711*100*100*100.
    
saida :- balada([A,B,C,D]), labeling([ff], [A,B,C,D]),  format('\n Os valores são ~f ~f ~f ~f', [A/100,B/100,C/100,D/100] ).
/*
?- saida.
 Os valores são 1.200000 1.250000 1.500000 3.160000
*/
