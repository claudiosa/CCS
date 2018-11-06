% questão 1
conv_seg(Segs) :-
	Mins is (Segs//60),
	Horas is (Mins//60),
	Dias is (Horas//24),
	
	XX is Dias,
	YY is Horas - (Dias*24),
	ZZ is Mins - (Horas*60),
	WW is Segs - (Mins*60),
	
	format('~w dias\n~w horas\n~w minutos\n~w segundos', [XX,YY,ZZ,WW]).



% Retorno: An = n-ésimo termo
q2(1, An) :-
	sqrt(6, An).
	
q2(N, An) :-
	Ant is (N-1),
	q2(Ant, AnM1),
	An is sqrt(6 + AnM1).
	

	
% questão 3 (a)
ancestral(Y, DeX) :- pai(Y, DeX).
ancestral(Y, X) :- ancestral(Y, Z), pai(Z, X).


% questão 3 (b)
fala(Voce, Alguem) :- conhece(Voce, Alguem); conhece(Voce, X), fala(X, Alguem).


% questão 3 (c)
s(0).
s(N) :- Ant is (N-1), s(Ant).
s(s(s(s(s(s(s(0))))))).



% questão 4
gera_cresc(0).
gera_cresc(N) :-
	Ant is (N-1),
	gera_cresc(Ant),
	format('~w\n', [N]).
gera_cresc(99).



% questão 5
gera_cresc(N, N).
gera_cresc(N1, N2) :-
	Ant is (N2-1),
	gera_cresc(N1, Ant),
	format('~w\n', [N2]).
	


% questão 6
% soma os múlts de 7 até N, inclusive
gera_soma7(N, Soma) :-
	Ant is (N//7),
	gera_soma7_aux(Ant, Soma).

gera_soma7_aux(0, Soma) :-
	Soma is 0.
gera_soma7_aux(K, Soma) :-
	AntK is (K-1),
	gera_soma7_aux(AntK, Sm2),
	Soma is (Sm2 + 7*K).
	


% questão 7
gera_soma(N, N, Soma) :-
	Soma is N.
% soma os números entre N1 e N2, inclusive
gera_soma(N1, N2, Soma) :-
	Ant is (N2-1),
	gera_soma(N1, Ant, Sm2),
	Soma is (Sm2 + N2).


% questão 8
ast(0).
ast(N) :-
	write('*'),
	Ant is (N-1),
	ast(Ant).


% questão 9
triang(0).
triang(N) :-
	ast(N),
	write('\n'),
	Ant is N-1,
	triang(Ant).



% questão 10

spaces(0).
spaces(N) :-
	write(' '),
	Ant is N-1,
	spaces(Ant).
astWord(NAsts, NTotal) :-
	ast(NAsts),
	TmA is NTotal-NAsts,
	spaces(TmA).

astsInRow(_, _, 0).
astsInRow(NAsts, NTotal, 1) :-
	astWord(NAsts, NTotal),
	write('\n').
astsInRow(NAsts, NTotal, NTimes) :-
	astWord(NAsts, NTotal),
	write(' '),
	Tm1 is NTimes-1,
	astsInRow(NAsts, NTotal, Tm1).

nSmallTriangInRow(0, _, _).
nSmallTriangInRow(NLinesRem, NCols, NTimesInRow) :-
	astsInRow(NLinesRem, NCols, NTimesInRow),
	Rm1 is NLinesRem-1,
	nSmallTriangInRow(Rm1, NCols, NTimesInRow).

% finalmente...
nTriang(NTimes) :-
	nTriang_aux(NTimes, NTimes).
nTriang_aux(0, _).
nTriang_aux(NBigRowsRem, NBigRows) :-
	nSmallTriangInRow(NBigRows, NBigRows, NBigRowsRem),
	Rm1 is NBigRowsRem-1,
	nTriang_aux(Rm1, NBigRows).

% aí é só chamar nTriang(3).



% questão 11
quad(N) :- quad_aux(N,N).

quad_aux(0, _).
quad_aux(Linhas, Colunas) :-
	Lm1 is Linhas-1,
	ast(Colunas),
	write('\n'),
	quad_aux(Lm1, Colunas).



% questão 12
hash(0).
hash(NTimes) :-
	Nm1 is NTimes-1,
	hash(Nm1),
	write('#').

alterna_1(N) :- alt1a_aux(N,N).

alt1a_aux(0, _).
alt1a_aux(Linhas, Colunas) :-
	Lm1 is Linhas-1,
	ast(Colunas),
	write('\n'),
	alt1b_aux(Lm1, Colunas).

alt1b_aux(0, _).
alt1b_aux(Linhas, Colunas) :-
	Lm1 is Linhas-1,
	hash(Colunas),
	write('\n'),
	alt1a_aux(Lm1, Colunas).



% questão 13
hash_ast(0).
hash_ast(1) :-
	write('#').
hash_ast(N) :-
	write('#*'),
	Nm2 is N-2,
	hash_ast(Nm2).

ast_hash(0).
ast_hash(1) :-
	write('*').
ast_hash(N) :-
	write('*#'),
	Nm2 is N-2,
	ast_hash(Nm2).

alterna_2(N) :-
	alt2_aux(N,N).

alt2_aux(0, _).
alt2_aux(1, Cols) :-
	ast_hash(Cols).
alt2_aux(Lines, Cols) :-
	ast_hash(Cols),
	write('\n'),
	hash_ast(Cols),
	write('\n'),
	Lm2 is Lines-2,
	alt2_aux(Lm2, Cols).



% questão 14
fib(X, Ret) :-
	X =< 2,
	Ret is 1.
fib(X, Ret) :-
	Xm1 is X-1,
	Xm2 is X-2,
	fib(Xm1, R1),
	fib(Xm2, R2),
	Ret is R1+R2.



% questão 15
mdc(X, 0, Max_div) :-
	Max_div is X.
mdc(X, Y, Max_div) :-
	XmY is X mod Y,
	mdc(Y, XmY, Max_div).



% questão 16
eh_primo(X) :-
	X >= 2,
	Xm1 is X-1,
	nodivs(X, Xm1).

nodivs(_, 1).
nodivs(X, Divisor) :-
	not(0 is X mod Divisor),
	Dm1 is Divisor-1,
	nodivs(X, Dm1).


% questão 17
primos(Ateh, Ateh).
primos(De, Ateh) :-
	((eh_primo(De), format('~w ', De)); true), % if...
	DeM1 is De+1,
	primos(DeM1, Ateh).



% questão 18
q18(2, Soma) :-
	Soma is 2/3.
q18(N, Soma) :-
	Nm2 is N-2,
	q18(Nm2, Sm2),
	Div is N/(N+1),
	Soma is Sm2+Div.



% questão 19 -> NÃO FEITA



% questão 20
hanoi(0, _, _, _).
hanoi(N, From, To, Other) :-
	Nm1 is N-1,
	hanoi(Nm1, From, Other, To),
	format('Move ~w from ~w to ~w.\n', [N, From, To]),
	hanoi(Nm1, Other, To, From).



% questão 21
q21(X, F_de_X) :-  % cuidado: recursão INFINITA!  (ex: q21(100,_))
	X > 100, F_de_X is X-10;  (Xp1 is X+1, q21(Xp1,FD1), q21(FD1,F_de_X)).
% impossível calcular f(x) para todo x entre 0 e 101



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


% questão 23 (=q15)
q23(A, B, Ret) :-
	mdc(A, B, Ret).



% questão 24
fat(0, Ret) :-
	Ret is 1.
	
fat(X, Ret) :-
	Xm1 is X-1,
	fat(Xm1, Ret2),
	Ret is (X * Ret2).
