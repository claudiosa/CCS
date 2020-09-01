/*
?- ['tail_recursive_examples.pl'].
true.

?- tail_fat(4, F).

 The fatorial of: 4  is: 24
F = 24.

?- tail_s(4, S).

 The sum from 0 up to: 4  is: 10
S = 10.

?- 

*/
tail_s(N, S) :- s(N,0, S),
format('\n The sum from 0 up to: ~w  is: ~w', 
    [N, S]).


%%%%%%% tail recursive
s(0,S,S) :- !. %% to finish this sum
s(N, Temp, S) :- 
    N >= 1,	
	ACC is (N + Temp),
	N_new is (N-1),
	s(N_new, ACC, S).
	

tail_fat(N, F) :- fat(N,1, F),
format('\n The fatorial of: ~w  is: ~w',  [N, F]).

%%%%%%% tail recursive
fat(0,F,F) :- !. %% to finish this sum
fat(N, Temp, S) :- 
    N >= 1,	
	ACC is (N * Temp),
	N_new is (N-1),
	fat(N_new, ACC, S).

/********* MARCELO RODRIGUES - UFU - BR ************/
fib(0, 0) :- !.
fib(1, 1) :- !.
fib(N,F) :-
	N>1,
	fib2(N,0,1,F).
 

% fib2(0,A,_,A):-!.
% fib2(1,A,_,A):-!.
fib2(2,A,B,C):- C is (A+B),!.
fib2(N,A,B,F) :-
	 NA is A+B,
	 NN is N-1,
	 fib2(NN,NA,A,F).


/*********** LIVRO .... *****************/
fib_book( N, F):- fibonacci( N , _ ,  F).
fibonacci(0,_ ,0 ):-!.
fibonacci(1,_ ,1) :-!.
fibonacci(2, 1 , 1) :-!.
fibonacci( N, F1, F) :-
	 N > 2, 
	 N1 is (N-1),
	 fibonacci( N1, F2, F1),
	 F is F1+ F2, !.

/* it is not tail recursive */