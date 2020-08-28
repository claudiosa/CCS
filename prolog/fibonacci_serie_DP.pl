% Fibonnaci Dynamic Programming (PD in PORTUGESE)
/*
MOTIVATION:

Recursive version:
?- time(fib(40,X)).
% 496,740,420 inferences, 49.201 CPU in 49.364 seconds (100% CPU, 10096048 Lips)
X = 102334155.

PD version:
?- time(fib_PD(40,X)).
% 400 inferences, 0.000 CPU in 0.000 seconds (98% CPU, 2007780 Lips)
X = 102334155.

?-

Fibo Serie starts in ZERO is 0:
0,1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, ... 
 
Pela convenção moderna a sequência inicial começa por F0 = 0.
 No livro Liber Abaci (veja Seção Origens) esta começava com F1 = 1, 
 omitindo-se o zero inicial.
*/
:- dynamic(table_FIB/2) .
:- initialization(clean).


clean :-
	retract(table_FIB(X,Y)),
	% abolish(tab_FIB, 2),
	format("\n N:~w\t FIB: ~w",[X,Y]),
	fail.
clean :-  format("\n PD TABLE clean -- OK").

fib(0, 0) :- !.
fib(1, 1) :- !.
fib(X, Ret) :-
	Xm1 is X-1,
	Xm2 is X-2,
	fib(Xm1, R1),
	fib(Xm2, R2),
	Ret is (R1+R2).

/* FIB with Dynamic Programming */
fib_PD(0, Tab) :-
	table_FIB(0, Tab), !   % if already is in Table
	;
	asserta(table_FIB(0, 0)),
	Tab is 0, !.

fib_PD(1, Tab) :-
	table_FIB(1, Tab), !
	;
	asserta(table_FIB(1, 1)),
	Tab is 1, !.	

fib_PD(N, Tab) :-
	table_FIB(N, Tab),! %%% if N is already in Tab
	;
	Prev_1 is (N-1),
	Prev_2 is (N-2), 
	search_in_TAB(Prev_1, V1),
	search_in_TAB(Prev_2, V2),
	%table_FIB(Prev, V1),
	%table_FIB(Prev_2, V2),
	Tab is (V1+V2),
	asserta(table_FIB(N,Tab)).    
	
search_in_TAB(N, Tab):-
	table_FIB(N, Tab),! %%% if N is already in Tab
	;
	fib_PD(N, Tab). %% New instance for N 

/****************** just to print a serie **********************/
pd_fib(X) :- serie(0,X).

serie(N,N) :-
	fib_PD(N, Fib) ,
	format("\n N:~w\t FIB: ~w",[N,Fib]),
	format("\n End of Serie ...."), ! .

serie(N, ACC) :-
		fib_PD(N, Fib) ,
		format("\n N:~w\t FIB: ~w",[N, Fib]),
		Aux is (N +1) ,
		serie(Aux, ACC).
/**************************************************************/	
