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

/**** ORIGINAL IDEA: MARCELO RODRIGUES - BR ***********
fib(0, 0) :- !.
fib(1, 1) :- !.
fib(N,F) :-
	N>1,
	fib2(N,0,1,F).

fib2(2,A,B,C):- C is (A+B),!.
fib2(N,A,B,F) :-
	 NA is A+B,
	 NN is N-1,
	 fib2(NN,NA,A,F).

I did not test it ... exaustively -- none warranty
*/


/* Based in that idea ... by CCS */
/* Just to avoid misunderstandis in fib_up */
% fib(0, 0) :- !.
% fib(1, 1) :- !.
fib(N,F) :-
	%N>1,
	%fib_up(2,N,1,0,F).
	N>=0,
	fib_up(2,N,1,0,F).
    % fib2(2: ground_counter, N , Fib(n-1), Fib(n-2), F)   

fib_up(_,0,_,_,0):- !.  
fib_up(_,1,_,_,1):- !.  
fib_up(N,N,A,B,C):-  C is (A+B), !.
fib_up(Cont, N, Acc1, Acc2, F) :-
	 ACC is (Acc1+Acc2), %%% TEMP
	 New_Acc1 is ACC,   %%% could be ommitted ==> just to become clear
 	 New_Acc2 is Acc1,   %%% could be ommitted ==> just to become clear
	 New_Cont is (Cont+1),
	 fib_up(New_Cont, N,  New_Acc1, New_Acc2, F).
/* tail recursive -- Truely*/

/*********** from a book .... *****************/
fib_book( N, F):- fibonacci( N , _ ,  F).
fibonacci(0,_ ,0 ):-!. %% fixed
fibonacci(1,_ ,1) :-!.
fibonacci(2, 1 , 1) :-!. %% fixed
fibonacci( N, F1, F) :-
	 N > 2, 
	 N1 is (N-1),
	 fibonacci( N1, F2, F1),
	 F is F1 + F2, !.

/* it is not tail recursive --- ALMOST tail recursive*/
%%% Example ?- do_serie(10).
do_serie(X) :- serie(0,X).
serie(N,N) :-
	fib(N, Fib) , %%% change HERE ... for other fibs
	format("\n N:~w\t FIB: ~w",[N,Fib]),
	format("\n End of Serie ...."), ! .

serie(N, ACC) :-
		fib(N, Fib) ,
		format("\n N:~w\t FIB: ~w",[N, Fib]),
		Aux is (N +1) ,
		serie(Aux, ACC).