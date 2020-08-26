% questão 14
fib(X, 1) :-
	X =< 2,
	!.

fib(X, Ret) :-
	Xm1 is X-1,
	Xm2 is X-2,
	fib(Xm1, R1),
	fib(Xm2, R2),
	Ret is R1+R2.


% questão 22
fibo(X, Ret) :-
	fibo_aux(X, Ret, _).

fibo_aux(0, 1, 0).
fibo_aux(1, 1, 0).
fibo_aux(X, Ret, RetM1) :-
	Xm1 is X-1,
	fibo_aux(Xm1, A, B),
	Ret is A+B,
	RetM1 is A.


fib(N,R) :- fib_PD(N, 0, R, []).

fib_PD(0, _, X, Tab) :- X is 1,  Tab is [1]. 
	
fib_PD(1, _, X, Tab) :- X is 1,  Tab is [1,1].

fib_PD(N, Up, R, Tab) :-

	consulta tabela na Up posicao
	
        
	fib_PD(N, R, Tab) 
	R is Xn1 + Xn2.	
