p( aaa ; bbb ; ccc).
q( 777 ).

%%% p(X) eh LOCAL e q eh LIVRE
2 {r(X,Y) : p(X)} 7 :- q(Y).
%% de 2 a 7 conjuntos por resposta
%% O CONTRARIO
%1 {r(X,Y) : q(Y)} 1 :- p(X).
% OUTRA NOTACAO neste caso 1...1
%% {r(X,Y) : q(Y)} = 1 :- p(X).

% :- {r(X,Y) : p(X) , q(Y)} = 1 .
#show r/2.
