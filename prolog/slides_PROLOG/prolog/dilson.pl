%Dúvida 1

%% proximo(i,i,o)
proximo(X, [Y|L], Y):- ultimo(L,X), !. %% se X for o ultimo de [Y|L], então pegue o primeiro que é Y
proximo(X , [X,Y],Y). % caso tenha dois na lista ... volta Y
proximo(X , [X , Y | _],Y).  % idem exceto que tem a lista...
proximo(X, [Z | L], Y) :- X =\=Z , proximo(X, L, Y).  %% caso este não seja cabeça

%ultimo(i,o)
ultimo([X],X).
ultimo([_|L], Z) :- ultimo(L,Z).
/*
?- ultimo([4,5],X).
X = 5
Yes
?-
?- proximo(6,[3,4,5,6],X).
X = 3
Yes
?- proximo(3,[3,4,5,6],X).
X = 4
Yes
?- 
*/  

%%Duvida 2 
%% ver até vazio
retorno_X(f_r(_,_/Y),  L_tab_corr  , L2) :- casando_1(f_r(_,_/Y),  L_tab_corr  , L2).
retorno_Y(f_r(_,X/_),  L_tab_corr  , L2) :- casando_1(f_r(_,X/_),  L_tab_corr  , L2).

x :- retorno_X(f_r(_, _/5), [f_r(a,1/1), f_r(b,7/5), f_r(c,7/1), f_r(d,12/5)], Lsaida), write(Lsaida).
y :- retorno_X(f_r(_, 7/_), [f_r(a,1/1), f_r(b,7/5), f_r(c,7/1), f_r(d,12/5)], Lsaida), write(Lsaida).

casando_1(f_r(_,_/_), [], [] ).
%% casando um X
casando_1(f_r(_,X/Y), [f_r(A,X/K) | L1 ] , [f_r(A, X/K) | L2]):- 
                            casando_1( f_r(_,X/Y) , L1 ,  L2).
%% casando um Y
casando_1(f_r(_,X/Y), [f_r(A, K/Y)|L1], [f_r(A, K/Y) | L2] ):- 
                            casando_1(f_r(_,X/Y) , L1 ,  L2).
%% Não casando nada
casando_1(f_r(_,X/Y), [ f_r(_,X1/Y1) | L1 ] , L2 ):- 
                 (X \== X1 ,  Y \== Y1 ) , %%% dispensável...
                 casando_1(f_r(_,X/Y), L1 ,  L2).
			    
casando_1( _, _ ,_) :- write(" algum problema... casando_1.").  %%% também dispensável...

/* seu exemplo OK...
?- casando_1(f_r(_, 5/5), [f_r(a,1/1), f_r(b,7/5), f_r(c,7/1), f_r(d,12/5)], Lsaida).
Lsaida = [f_r(b, 7/5), f_r(d, 12/5)] 
Yes
?-
*/
