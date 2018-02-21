
 
/****************************************************************************/
% questão 1   
/*
serie = 1*2 - 3*4 + 5*6 - 7*8 +
?- serie(4,X).
X = -36 
Yes
?- serie(5,X).
X = 54 
*/
serie(1,2).
serie(N,X) :- 
      N_1 is ((2*N)-1),
      N_2 is (2*N), 
      Ant is (N-1),
      serie(Ant, X1),
      sinal(N,Sinal),
      X is X1 + Sinal*(N_1 * N_2).
 
sinal(N, -1) :-
     Temp is (N mod 2),
     Temp == 0 , !.
sinal(_, 1). 

/****************************************************************************/
% questão 2
%% reuse a questao 1...

imp_c(_,0).
imp_c(C,N) :-
	write(C),
	Ant is (N-1),
	imp_c(C,Ant).


dois_c(_,_,0).
dois_c(X,Y,N):-
    imp_c(X,N),
    imp_c(Y,N),
	Ant is (N-1),
	dois_c(X,Y,Ant).
/****************************************************************************/

% questão 3
quad(X,Y,N) :- quad_aux(X,Y,N,N).
quad_aux(_,_,0, _).
quad_aux(X,Y,Linhas, Colunas) :-
	Lm1 is Linhas-1,
	imp_c(X,Colunas),
	imp_c(Y,Colunas),
	write('\n'),
	quad_aux(X,Y,Lm1, Colunas).

/****************************************************************************/

% questão 4
g_fat(N) :- N>0, gera_cresc(0,N), !.
g_fat(N) :- fat(N,Fat), 
            format('\n~w', [Fat]), 
	        !.

gera_cresc(N,N)  :- fat(N,Fat),
	                format('\n~w! = ~w', [N, Fat]),
	                !.
gera_cresc(Aux, N) :-
	Prox is (Aux+1),
	fat(Aux,Fat),
	format('\n~w! = ~w', [Aux, Fat]),
	gera_cresc(Prox,N).
	

fat(X, 'Fat Negativo') :- X <0.
fat(0, 1).
	
fat(X, Ret) :-
	Xm1 is X-1,
	fat(Xm1, Ret2),
	Ret is (X * Ret2).
/***********************************************/
% 5a. questao
imp_div(0) :- format('\n Numero Zero'), !.
imp_div(X) :- X<0, format('\n Numero Negativo'), !.
imp_div(N) :- N > 0, aux_div(1,N).

aux_div(N,N) :- format(' ~w', [N]), !.
aux_div(X,N) :- Temp is (N mod X),
                Temp == 0, 
                format(' ~w', [X]),
                Prox is (X + 1),
                aux_div(Prox, N).
aux_div(X,N) :- Prox is (X + 1),
                aux_div(Prox, N).                
/***********************************************/
%% questao 6
/*
f(n) = 
se n>100 então (n-10)  ou
 n =< 100 f(f(n+1)
*/   
   
f_91(N,F):- N > 100, F is (N-10), !.
f_91(N,F):- N =< 100, New is (N+11), 
            f_91( New , F_new), 
            f_91(F_new, F).   
/***********************************************/
